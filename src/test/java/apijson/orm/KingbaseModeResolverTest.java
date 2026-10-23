package apijson.orm;

import apijson.RequestMethod;
import org.junit.Before;
import org.junit.Test;
import java.lang.reflect.Proxy;
import java.sql.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;
import static org.junit.Assert.*;

public class KingbaseModeResolverTest {
	static class Config extends AbstractSQLConfig<Long, Map<String, Object>, List<Object>> {
		String mode = "mysql";
		boolean empty;
		boolean fail;
		final AtomicInteger opened = new AtomicInteger();
		final AtomicInteger closed = new AtomicInteger();
		final AtomicInteger statementsClosed = new AtomicInteger();
		final AtomicInteger resultsClosed = new AtomicInteger();

		Config() {
			super(RequestMethod.GET, "User");
			setDatabase(DATABASE_KINGBASE_MYSQL);
			setSchema("public");
		}

		public String gainDBVersion() {
			return "9.0.0";
		}

		public String gainDBUri() {
			return "jdbc:kingbase8://localhost/test";
		}

		public String gainDBAccount() {
			return "test";
		}

		public String gainDBPassword() {
			return "unused";
		}

		protected Connection openKingbaseModeConnection() throws SQLException {
			opened.incrementAndGet();
			if (fail) {
				throw new SQLException("unavailable");
			}
			AtomicInteger rows = new AtomicInteger();
			ResultSet result =
					(ResultSet)
							Proxy.newProxyInstance(
									getClass().getClassLoader(),
									new Class<?>[] {ResultSet.class},
									(p, m, a) -> {
										switch (m.getName()) {
											case "next":
												return !empty && rows.getAndIncrement() == 0;
											case "getString":
												assertEquals(1, a[0]);
												return mode;
											case "close":
												resultsClosed.incrementAndGet();
												return null;
											default:
												throw new AssertionError(m.getName());
										}
									});
			Statement statement =
					(Statement)
							Proxy.newProxyInstance(
									getClass().getClassLoader(),
									new Class<?>[] {Statement.class},
									(p, m, a) -> {
										switch (m.getName()) {
											case "setQueryTimeout":
												assertEquals(5, a[0]);
												return null;
											case "executeQuery":
												assertEquals("SHOW database_mode", a[0]);
												return result;
											case "close":
												statementsClosed.incrementAndGet();
												return null;
											default:
												throw new AssertionError(m.getName());
										}
									});
			return (Connection)
					Proxy.newProxyInstance(
							getClass().getClassLoader(),
							new Class<?>[] {Connection.class},
							(p, m, a) -> {
								switch (m.getName()) {
									case "createStatement":
										return statement;
									case "close":
										closed.incrementAndGet();
										return null;
									default:
										throw new AssertionError(m.getName());
								}
							});
		}
	}

	@Before
	public void reset() {
		AbstractSQLConfig.KINGBASE_MODE_RESOLVER.clear();
		KingbaseCompatibilityTest.installJsonParser();
	}

	@Test
	public void optionalExpectationIsCheckedEvenOnSharedCacheHit() {
		Config auto = new Config();
		auto.setDatabase("KINGBASE_AUTO");
		auto.mode = "oracle";
		assertEquals("KINGBASE_ORACLE", auto.gainSQLDatabase());
		Config strict =
				new Config() {
					@Override
					protected Object gainKingbaseModeCacheKey() {
						return auto.gainKingbaseModeCacheKey();
					}

					@Override
					protected String gainKingbaseExpectedDatabase() {
						return "KINGBASE_MYSQL";
					}
				};
		strict.setDatabase("KINGBASE_AUTO");
		IllegalStateException error =
				assertThrows(IllegalStateException.class, strict::gainSQLDatabase);
		assertTrue(error.getMessage().contains("expected KINGBASE_MYSQL"));
		assertTrue(error.getMessage().contains("KINGBASE_ORACLE"));
		assertEquals(0, strict.opened.get());
		assertEquals("KINGBASE_ORACLE", auto.gainSQLDatabase());
		assertEquals(1, auto.opened.get());
	}

	@Test
	public void startupApiAndConfigShareCacheAndInvalidation() {
		Config c = new Config();
		c.setDatabase("KINGBASE_AUTO");
		Object key = c.gainKingbaseModeCacheKey();
		assertEquals(
				"KINGBASE_MYSQL",
				AbstractSQLConfig.KINGBASE_MODE_RESOLVER.resolve(
						key, c::openKingbaseModeConnection));
		assertEquals("KINGBASE_MYSQL", c.gainSQLDatabase());
		assertEquals(1, c.opened.get());
		c.mode = "oracle";
		AbstractSQLConfig.KINGBASE_MODE_RESOLVER.invalidateKey(key);
		assertEquals("KINGBASE_ORACLE", c.gainSQLDatabase());
		assertEquals(2, c.opened.get());
	}

	@Test
	public void autoIsRecognizedWithoutOpeningConnection() {
		Config c = new Config();
		c.setDatabase("KINGBASE_AUTO");
		c.fail = true;
		assertTrue(c.isKingBase());
		assertEquals(0, c.opened.get());
		assertTrue(AbstractSQLConfig.DATABASE_LIST.contains("KINGBASE_AUTO"));
		assertThrows(IllegalStateException.class, c::gainSQLDatabase);
	}

	@Test
	public void autoUsesActualModeAndExplicitModesRequireAMatch() throws Exception {
		for (String configured :
				Arrays.asList(
						"KINGBASE_AUTO",
						"KINGBASE_MYSQL",
						"KINGBASE_ORACLE",
						"KINGBASE_SQLSERVER")) {
			for (String actual : Arrays.asList("mysql", "oracle", "sqlserver")) {
				Config detected = new Config();
				detected.setDatabase(configured);
				detected.mode = " " + actual.toUpperCase(Locale.ROOT) + " ";
				detected.setDatasource(configured + actual);
				// Offline reference deliberately freezes the pre-detection dialect.
				Config reference =
						new Config() {
							@Override
							public String gainSQLDatabase() {
								return getDatabase();
							}
						};
				String expected = "KINGBASE_" + actual.toUpperCase(Locale.ROOT);
				reference.setDatabase(expected);
				detected.setCount(10).setPage(1);
				reference.setCount(10).setPage(1);
				if ("KINGBASE_AUTO".equals(configured) || configured.equals(expected)) {
					assertEquals(expected, detected.gainSQLDatabase());
					assertEquals(reference.gainSQL(false), detected.gainSQL(false));
					assertEquals(reference.gainSQL(true), detected.gainSQL(true));
					assertEquals("mysql".equals(actual), detected.isKingBaseMySQL());
					assertEquals("oracle".equals(actual), detected.isKingBaseOracle());
					assertEquals("sqlserver".equals(actual), detected.isKingBaseSQLServer());
				} else {
					IllegalStateException mismatch =
							assertThrows(IllegalStateException.class, detected::gainSQLDatabase);
					assertTrue(mismatch.getMessage().contains("expected " + configured));
					assertTrue(mismatch.getMessage().contains(expected));
					assertThrows(IllegalStateException.class, () -> detected.gainSQL(true));
				}
				assertEquals(configured, detected.getDatabase());
				assertEquals(1, detected.opened.get());
				assertEquals(1, detected.closed.get());
				assertEquals(1, detected.statementsClosed.get());
				assertEquals(1, detected.resultsClosed.get());
				assertEquals(0, reference.opened.get());
			}
		}
	}

	@Test
	public void nonKingbaseAndLegacyModesNeverProbe() {
		for (String db : Arrays.asList("MYSQL", "ORACLE", "SQLSERVER", "KINGBASE")) {
			Config c = new Config();
			c.setDatabase(db);
			c.fail = true;
			assertEquals(db, c.gainSQLDatabase());
			assertEquals(0, c.opened.get());
		}
		assertEquals(KingbaseSQLDialect.LEGACY, KingbaseSQLDialect.from("KINGBASE"));
	}

	@Test
	public void defaultCompatibilityModeIsDetectedWithoutChangingConfiguration() {
		String previous = AbstractSQLConfig.DEFAULT_DATABASE;
		try {
			AbstractSQLConfig.DEFAULT_DATABASE = SQLConfig.DATABASE_KINGBASE_AUTO;
			Config c = new Config();
			c.setDatabase(null);
			assertTrue(c.isKingBase());
			assertEquals(0, c.opened.get());
			assertTrue(c.isKingBaseMySQL());
			assertNull(c.getDatabase());
		} finally {
			AbstractSQLConfig.DEFAULT_DATABASE = previous;
		}
	}

	@Test
	public void cacheIsSharedIsolatedAndInvalidatable() {
		Config a = new Config();
		a.setDatabase("KINGBASE_AUTO");
		a.setDatasource("a");
		Config b = new Config();
		b.setDatabase("KINGBASE_AUTO");
		b.setDatasource("b");
		b.mode = "oracle";
		Config copy = new Config();
		copy.setDatabase("KINGBASE_MYSQL");
		copy.setDatasource("a");
		copy.fail = true;
		assertEquals("KINGBASE_MYSQL", a.gainSQLDatabase());
		assertEquals("KINGBASE_MYSQL", copy.gainSQLDatabase());
		assertEquals(0, copy.opened.get());
		assertEquals("KINGBASE_ORACLE", b.gainSQLDatabase());
		a.mode = "sqlserver";
		AbstractSQLConfig.KINGBASE_MODE_RESOLVER.invalidate(a);
		assertEquals("KINGBASE_SQLSERVER", a.gainSQLDatabase());
		assertEquals(2, a.opened.get());
		a.setDatasource("b");
		assertEquals("KINGBASE_ORACLE", a.gainSQLDatabase());
	}

	@Test
	public void explicitModeMismatchFailsOnSharedCacheHit() {
		Config auto = new Config();
		auto.setDatabase("KINGBASE_AUTO");
		auto.mode = "oracle";
		assertEquals("KINGBASE_ORACLE", auto.gainSQLDatabase());

		Config mysql = new Config();
		mysql.setDatabase("KINGBASE_MYSQL");
		mysql.fail = true;
		IllegalStateException mismatch =
				assertThrows(IllegalStateException.class, mysql::gainSQLDatabase);
		assertTrue(mismatch.getMessage().contains("expected KINGBASE_MYSQL"));
		assertTrue(mismatch.getMessage().contains("KINGBASE_ORACLE"));
		assertEquals(0, mysql.opened.get());
	}

	@Test
	public void failuresAreNotCachedAndUnknownModesNeverGuess() {
		Config c = new Config();
		c.fail = true;
		assertThrows(IllegalStateException.class, c::gainSQLDatabase);
		c.fail = false;
		c.mode = "pg";
		assertThrows(IllegalStateException.class, c::gainSQLDatabase);
		assertEquals(1, c.closed.get());
		assertEquals(1, c.resultsClosed.get());
		c.mode = null;
		assertThrows(IllegalStateException.class, c::gainSQLDatabase);
		c.empty = true;
		assertThrows(IllegalStateException.class, c::gainSQLDatabase);
		c.empty = false;
		c.mode = "mysql";
		assertEquals("KINGBASE_MYSQL", c.gainSQLDatabase());
		assertEquals(5, c.opened.get());
	}

	@Test
	public void concurrentRequestsProbeOnlyOnce() throws Exception {
		Config c = new Config();
		ExecutorService pool = Executors.newFixedThreadPool(8);
		CountDownLatch start = new CountDownLatch(1);
		try {
			List<Future<String>> results = new ArrayList<>();
			for (int i = 0; i < 16; i++)
				results.add(
						pool.submit(
								() -> {
									start.await();
									return c.gainSQLDatabase();
								}));
			start.countDown();
			for (Future<String> result : results)
				assertEquals("KINGBASE_MYSQL", result.get(5, TimeUnit.SECONDS));
			assertEquals(1, c.opened.get());
		} finally {
			pool.shutdownNow();
		}
	}

	@Test
	public void recursiveConnectionRoutingFailsClearly() {
		Config c =
				new Config() {
					@Override
					public String gainDBUri() {
						return isKingBaseMySQL() ? "mysql" : "other";
					}
				};
		IllegalStateException failure =
				assertThrows(IllegalStateException.class, c::gainSQLDatabase);
		assertTrue(failure.getMessage().contains("must not depend"));
		assertEquals(0, c.opened.get());
	}

	@Test
	public void requestConfigurationUsesDetectionBeforeSQLGeneration() throws Exception {
		Config c = new Config();
		Map<String, Object> request = new LinkedHashMap<>();
		request.put("@database", "KINGBASE_AUTO");
		request.put("@column", "id,name");
		request.put("id", 1);
		SQLConfig<Long, Map<String, Object>, List<Object>> result =
				AbstractSQLConfig.newSQLConfig(
						RequestMethod.GET,
						"User",
						null,
						request,
						null,
						false,
						new AbstractSQLConfig.SimpleCallback<
								Long, Map<String, Object>, List<Object>>() {
							public SQLConfig<Long, Map<String, Object>, List<Object>> getSQLConfig(
									RequestMethod method,
									String database,
									String datasource,
									String namespace,
									String catalog,
									String schema,
									String table) {
								return c;
							}
						});
		assertTrue(result.gainSQL(false).contains("`id`"));
		assertEquals(1, c.opened.get());
	}

	@Test
	public void joinConfigurationsResolveTheirOwnDataSources() throws Exception {
		Config main = new Config();
		main.setDatasource("a");
		Config vice = new Config();
		vice.setDatasource("a");
		vice.setTable("Comment");
		Join<Long, Map<String, Object>, List<Object>> join = new Join<>();
		join.setJoinType("<");
		join.setTable("Comment");
		join.setJoinConfig(vice);
		Join.On on = new Join.On();
		on.setKey("userId");
		on.setTargetTable("User");
		on.setTargetKey("id");
		join.setOnList(Arrays.asList(on));
		main.setJoinList(Arrays.asList(join));
		assertTrue(main.gainSQL(false).contains("`Comment`"));
		assertEquals(1, main.opened.get() + vice.opened.get());
		vice.setDatasource("b");
		vice.setDatabase("KINGBASE_ORACLE");
		vice.mode = "oracle";
		assertTrue(vice.isKingBaseOracle());
	}
}
