package apijson.orm;

import apijson.JSON;
import apijson.JSONParser;
import apijson.Log;
import apijson.RequestMethod;
import java.lang.reflect.Proxy;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.*;
import java.util.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

/** Zero/one result IN calls through the real ORM path, with a strict JDBC contract. */
public class KingbaseProcedureTest {
	private static final List<String> MODES = Arrays.asList("KINGBASE_MYSQL", "KINGBASE_ORACLE", "KINGBASE_SQLSERVER");
	private JSONParser<?, ?> previousParser;
	private boolean previousDebug;

	@Before public void setup() {
		previousParser = JSON.DEFAULT_JSON_PARSER;
		previousDebug = Log.DEBUG;
		KingbaseCompatibilityTest.installJsonParser();
		Log.DEBUG = false;
	}
	@After public void restore() {
		JSON.DEFAULT_JSON_PARSER = previousParser;
		Log.DEBUG = previousDebug;
	}

	private static AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config(String mode) {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c = KingbaseSemanticsRegressionTest.config(mode);
		c.setSchema("app");
		return c;
	}

	private static String callSQL(String mode, String invocation) {
		String call = ("KINGBASE_MYSQL".equals(mode) ? "`app`." : "\"app\".") + invocation;
		return "KINGBASE_ORACLE".equals(mode) ? "BEGIN " + call + "; END;" : "CALL " + call;
	}

	@Test public void jsonEntryBindsAllScalarValuesAndDoesNotStopAtNull() throws Exception {
		for (String mode : MODES) {
			Map<String, Object> input = new LinkedHashMap<>();
			input.put("text", "中文 O'Reilly,\nline");
			input.put("empty", "");
			input.put("nothing", null);
			input.put("big", new BigInteger("9007199254740993"));
			input.put("decimal", new BigDecimal("1234567890.123456789"));
			input.put("enabled", true);
			input.put("last", "null");
			Call object = new Call(config(mode), input, null);
			object.invoke("app.p(text,empty,nothing,big,decimal,enabled,last)");
			assertEquals(callSQL(mode, "p(?,?,?,?,?,?,?)"), object.sql);
			assertEquals(new ArrayList<>(input.values()), object.values);
			assertEquals(1, object.configCreations);
			assertEquals(1, object.executions);
		}
	}

	@Test public void nullMayAppearAtEveryPositionAndNumericLiteralsKeepPrecision() throws Exception {
		for (String mode : MODES) {
			Call call = new Call(config(mode), new LinkedHashMap<>(), null);
			call.invoke("p(null,9007199254740993,null,1.234567890123456789,true,false,null)");
			assertEquals(Arrays.asList(null, new BigInteger("9007199254740993"), null,
					new BigDecimal("1.234567890123456789"), true, false, null), call.values);
		}
	}

	@Test public void noArgumentCallsAndConfigReuseDoNotAccumulateOrInlineParameters() throws Exception {
		for (String mode : MODES) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c = config(mode);
			List<Object> args = new ArrayList<>(Arrays.asList("O'Reilly", null, 7));
			c.setProcedure("app.p", args);
			args.set(0, "changed");
			for (boolean prepared : new boolean[] {true, false, true}) {
				assertEquals(callSQL(mode, "p(?,?,?)"), c.gainSQL(prepared));
				assertEquals(Arrays.asList("O'Reilly", null, 7), c.getPreparedValueList());
			}
			c.setProcedure("p", Collections.emptyList());
			assertEquals(callSQL(mode, "p()"), c.gainSQL(true));
			assertTrue(c.getPreparedValueList().isEmpty());
			c.setSchema("");
			assertEquals("KINGBASE_ORACLE".equals(mode) ? "BEGIN p(); END;" : "CALL p()", c.gainSQL(true));
			c.setProcedure("p(1)");
			assertTrue(c.getPreparedValueList().isEmpty());
		}
	}

	@Test public void invalidOrComplexInputsFailBeforeExecution() throws Exception {
		for (String mode : MODES) {
			for (Object invalid : Arrays.asList(Collections.singletonMap("x", 1), Arrays.asList(1, 2),
					new byte[] {1}, Double.NaN, Double.POSITIVE_INFINITY)) {
				Map<String, Object> input = new LinkedHashMap<>();
				input.put("n", null); input.put("bad", invalid);
				Call call = new Call(config(mode), input, null);
				assertThrows(IllegalArgumentException.class, () -> call.invoke("p(n,bad)"));
				assertEquals(0, call.executions);
			}
			for (String expression : Arrays.asList("p(a,,b)", "p(a+1)", "app.package.p(a)", "p(); DROP TABLE t")) {
				Call call = new Call(config(mode), new LinkedHashMap<>(), null);
				assertThrows(mode + ": " + expression, IllegalArgumentException.class, () -> call.invoke(expression));
				assertEquals(0, call.executions);
			}
			Call raw = new Call(config(mode), Collections.singletonMap("@raw", "@out()"), null);
			assertThrows(IllegalArgumentException.class, () -> raw.invoke("p()"));
			assertEquals(0, raw.executions);
			assertThrows(IllegalArgumentException.class, () -> config(mode).setProcedure(".p", Collections.emptyList()));
		}
	}

	@Test public void nativeProcedureFormattingAndValidationOrderStayUnchanged() throws Exception {
		for (String db : Arrays.asList("MYSQL", "ORACLE", "SQLSERVER", "POSTGRESQL", "KINGBASE", "CUSTOM_DATABASE")) {
			Map<String, Object> input = new LinkedHashMap<>();
			input.put("a", "O'Reilly"); input.put("b", null); input.put("c", 42);
			Call call = new Call(config(db), input, null);
			call.invoke("p(a,b,c)");
			assertEquals("p('O'Reilly','null','null')", call.config.getProcedure());
			Call invalid = new Call(config(db), input, null);
			assertThrows(IllegalArgumentException.class, () -> invalid.invoke("invalid name()"));
			assertEquals(0, invalid.configCreations);
			assertThrows(UnsupportedOperationException.class, () -> config(db).setProcedure("p", Arrays.asList(1)));
		}
	}

	@Test public void everyRequestMethodUsesOnePlainPreparedCallEvenWhenPreparationWasDisabled() throws Exception {
		for (String mode : MODES) for (RequestMethod method : RequestMethod.values()) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c = config(mode);
			c.setMethod(method).setProcedure("p", Arrays.asList("x", null, 0));
			c.setPrepared(false).setId(7L).setIdGeneratedByAPIJSON(true).setCount(2).setPage(1);
			Jdbc jdbc = new Jdbc(mode, 0);
			Map<String, Object> response = jdbc.executor.execute(c, true);
			assertEquals(callSQL(mode, "p(?,?,?)"), jdbc.sql);
			assertEquals(Arrays.asList("x", null, 0), new ArrayList<>(jdbc.bound.values()));
			assertEquals(0, response.get("count"));
			assertEquals(true, response.get("update"));
			assertEquals(Collections.emptyList(), response.get("list"));
			assertEquals(1, jdbc.executes);
			assertTrue(jdbc.closed);
			assertEquals(1, jdbc.executor.getExecutedSQLCount());
		}
	}

	@Test public void noResultPreservesKnownOrUnknownCountWithoutInventingRows() throws Exception {
		for (String mode : MODES) for (int count : new int[] {-1, 0, 2}) {
			Jdbc jdbc = new Jdbc(mode, count);
			Map<String, Object> result = jdbc.executor.execute(config(mode).setProcedure("p", Collections.emptyList()), true);
			assertEquals(count, result.get("count"));
			assertEquals(count >= 0, result.get("update"));
			assertEquals(Collections.emptyList(), result.get("list"));
			assertEquals(1, jdbc.executes);
			assertTrue(jdbc.closed);
		}
	}

	@Test public void jsonRequestReachesThePreparedExecutionWithExplicitSchemaAndValues() throws Exception {
		for (String mode : MODES) {
			Map<String, Object> input = new LinkedHashMap<>();
			input.put("a", "O'Reilly"); input.put("b", null); input.put("c", 42);
			Jdbc jdbc = new Jdbc(mode, -1);
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c = config(mode);
			c.setTable("Column"); // Its metadata schema must not override an explicit procedure schema.
			Call call = new Call(c, input, jdbc);
			call.invoke("custom.p(a,b,c)");
			assertEquals(callSQL(mode, "p(?,?,?)").replace("app", "custom"), jdbc.sql);
			assertEquals(Arrays.asList("O'Reilly", null, 42), new ArrayList<>(jdbc.bound.values()));
			assertEquals(1, jdbc.executes);
			assertTrue(jdbc.closed);
		}
	}

	@Test public void singleAndEmptyResultsUseNormalMappingWithoutPagingHeadOrCache() throws Exception {
		for (String mode : MODES) for (boolean empty : Arrays.asList(false, true)) {
			Rows rows = new Rows(empty ? new Object[0][] : new Object[][] {{new BigDecimal("1.25"), 9}, {null, null}}, "amount", "RN");
			Jdbc jdbc = new Jdbc(mode, rows.result);
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c = config(mode);
			c.setMethod(RequestMethod.HEAD).setCount(1).setPage(7).setProcedure("p", Collections.emptyList());
			Map<String, Object> response = jdbc.executor.execute(c, true);
			List<?> result = (List<?>) response.get("list");
			assertEquals(empty ? 0 : 2, result.size());
			if (!empty) {
				Map<?, ?> row = (Map<?, ?>) result.get(0);
				assertEquals("1.25", row.get("amount"));
				assertEquals(9, row.get("RN"));
				Map<?, ?> nullRow = (Map<?, ?>) result.get(1);
				assertTrue("A row containing NULL values must not disappear", nullRow.containsKey("amount"));
				assertNull(nullRow.get("amount"));
			}
			assertTrue(rows.closed);
			assertTrue(jdbc.closed);
			assertEquals(0, jdbc.advances);
		}
	}

	@Test public void oracleImplicitAndLeadingUpdateResultsAreReadWithoutReexecutionOrSumming() throws Exception {
		for (String mode : MODES) {
			Rows rows = new Rows(new Object[][] {{"ok"}}, "value");
			Jdbc jdbc = new Jdbc(mode, 2, 3, rows.result);
			Map<String, Object> result = jdbc.executor.execute(config(mode).setProcedure("p", Collections.emptyList()), true);
			assertEquals(2, result.get("count"));
			assertEquals(1, ((List<?>) result.get("list")).size());
			assertEquals(2, jdbc.advances);
			assertEquals(1, jdbc.executes);
		}
		Rows rows = new Rows(new Object[][] {{"implicit"}}, "value");
		Jdbc oracle = new Jdbc("KINGBASE_ORACLE", -1, rows.result);
		Map<String, Object> result = oracle.executor.execute(config("KINGBASE_ORACLE").setProcedure("p", Collections.emptyList()), true);
		assertEquals(-1, result.get("count"));
		assertEquals("implicit", ((Map<?, ?>) ((List<?>) result.get("list")).get(0)).get("value"));
		assertEquals(1, oracle.advances);
	}

	@Test public void firstResultIsReturnedWithoutConsumingLaterBusinessResults() throws Exception {
		for (String mode : MODES) {
			Rows first = new Rows(new Object[][] {{"first"}}, "value");
			Rows second = new Rows(new Object[][] {{"second"}}, "value");
			Jdbc jdbc = new Jdbc(mode, first.result, second.result);
			Map<String, Object> response = jdbc.executor.execute(config(mode).setProcedure("p", Collections.emptyList()), true);
			assertEquals("first", ((Map<?, ?>) ((List<?>) response.get("list")).get(0)).get("value"));
			assertEquals(0, jdbc.advances);
			assertTrue(first.closed);
			assertTrue(jdbc.closed);
		}
	}

	@Test public void bindingExecutionAndReadingFailuresCloseStatementsWithoutRetry() throws Exception {
		for (String mode : MODES) {
			SQLException failure = new SQLException("procedure failed");
			Jdbc execute = new Jdbc(mode, -1); execute.executeFailure = failure;
			assertSame(failure, assertThrows(SQLException.class,
					() -> execute.executor.execute(config(mode).setProcedure("p", Collections.emptyList()), true)));
			assertEquals(1, execute.executes); assertTrue(execute.closed);
			Jdbc binding = new Jdbc(mode, -1); binding.bindFailure = failure;
			assertSame(failure, assertThrows(SQLException.class,
					() -> binding.executor.execute(config(mode).setProcedure("p", Arrays.asList("x")), true)));
			assertEquals(0, binding.executes); assertTrue(binding.closed);
			Rows rows = new Rows(new Object[][] {{1}}, "value"); rows.failure = failure;
			Jdbc reading = new Jdbc(mode, rows.result);
			assertSame(failure, assertThrows(SQLException.class,
					() -> reading.executor.execute(config(mode).setProcedure("p", Collections.emptyList()), true)));
			assertEquals(1, reading.executes); assertTrue(reading.closed); assertTrue(rows.closed);
		}
	}

	@Test public void explainRejectsBeforeConnectingAndTypedCallsCannotChangeToNativeDialect() {
		for (String mode : MODES) {
			Jdbc jdbc = new Jdbc(mode, -1);
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c = config(mode).setProcedure("p", Collections.emptyList());
			c.setExplain(true);
			assertThrows(UnsupportedOperationException.class, () -> jdbc.executor.execute(c, true));
			assertEquals(0, jdbc.connections); assertEquals(0, jdbc.executes);
			c.setDatabase("MYSQL");
			assertThrows(IllegalStateException.class, () -> c.gainSQL(true));
		}
	}

	interface Invocation { Object call(String method, Object[] args) throws Throwable; }
	@SuppressWarnings("unchecked") private static <T> T proxy(Class<T> type, Invocation invoke) {
		return (T) Proxy.newProxyInstance(type.getClassLoader(), new Class<?>[] {type}, (p, m, a) -> invoke.call(m.getName(), a));
	}

	private static final class Jdbc {
		final Object[] results;
		final Map<Integer, Object> bound = new LinkedHashMap<>();
		int index, executes, advances, connections;
		boolean closed;
		String sql;
		SQLException bindFailure, executeFailure;
		final PreparedStatement statement;
		final Connection connection;
		final AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor;
		Jdbc(String mode, Object... results) {
			this.results = results;
			statement = proxy(PreparedStatement.class, (name, a) -> {
				if (name.equals("setObject") || name.equals("setNull")) {
					if (bindFailure != null) throw bindFailure;
					bound.put((Integer) a[0], name.equals("setNull") ? null : a[1]); return null;
				}
				if (name.equals("getParameterMetaData")) return null;
				if (name.equals("execute")) {
					assertTrue("Prepared execution must not pass SQL again", a == null || a.length == 0);
					executes++; if (executeFailure != null) throw executeFailure;
					index = 0; return current() instanceof ResultSet;
				}
				if (name.equals("getUpdateCount")) return current() instanceof Integer ? current() : -1;
				if (name.equals("getResultSet")) return current() instanceof ResultSet ? current() : null;
				if (name.equals("getMoreResults")) {
					assertEquals(Statement.CLOSE_CURRENT_RESULT, a[0]);
					advances++; index++; return current() instanceof ResultSet;
				}
				if (name.equals("close")) { closed = true; return null; }
				throw new AssertionError("Unexpected procedure JDBC method: " + name);
			});
			connection = proxy(Connection.class, (name, a) -> {
				assertEquals("prepareStatement", name);
				assertEquals("A procedure must not request generated keys or scrolling", 1, a.length);
				sql = (String) a[0]; return statement;
			});
			executor = new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() {
				@Override public Connection getConnection(SQLConfig<Long, Map<String, Object>, List<Object>> c) { connections++; return Jdbc.this.connection; }
				@Override protected boolean prepareDatabaseGeneratedId(SQLConfig<Long, Map<String, Object>, List<Object>> c, Connection conn) {
					throw new AssertionError("Procedure must not probe INSERT identity metadata");
				}
				@Override public void putCache(String sql, List<Map<String, Object>> rows, SQLConfig<Long, Map<String, Object>, List<Object>> c) {
					throw new AssertionError("Procedure results must not be cached as ordinary queries");
				}
				@Override public Map<String, Object> getCacheItem(String sql, int position, SQLConfig<Long, Map<String, Object>, List<Object>> c) {
					throw new AssertionError("Procedure must execute rather than reuse query cache");
				}
			};
		}
		Object current() { return index < results.length ? results[index] : -1; }
	}

	private static final class Rows {
		boolean closed;
		SQLException failure;
		int position = -1;
		final ResultSet result;
		Rows(Object[][] values, String... columns) {
			ResultSetMetaData md = proxy(ResultSetMetaData.class, (name, a) -> {
				if (name.equals("getColumnCount")) return columns.length;
				if (name.equals("getColumnName") || name.equals("getColumnLabel")) return columns[(Integer) a[0] - 1];
				if (name.equals("getColumnType")) return Types.OTHER;
				if (name.equals("getColumnTypeName")) return "unknown";
				throw new AssertionError("Unexpected procedure result metadata: " + name);
			});
			result = proxy(ResultSet.class, (name, a) -> {
				if (name.equals("next")) return ++position < values.length;
				if (name.equals("getMetaData")) return md;
				if (name.equals("getObject")) {
					if (failure != null) throw failure;
					return values[position][(Integer) a[0] - 1];
				}
				if (name.equals("close")) { closed = true; return null; }
				throw new AssertionError("Unexpected procedure cursor method: " + name);
			});
		}
	}

	private static final class Call extends AbstractObjectParser<Long, Map<String, Object>, List<Object>> {
		final AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config;
		final Map<String, Object> input;
		final Jdbc jdbc;
		int configCreations, executions;
		String sql;
		List<Object> values;
		Call(AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config, Map<String, Object> input, Jdbc jdbc) throws Exception {
			super(new LinkedHashMap<>(input), "", null, false, true, false);
			this.config = config; this.input = input; this.jdbc = jdbc;
			response = new LinkedHashMap<>(); setParser(new ParserStub());
		}
		void invoke(String function) throws Exception { parseFunction("@out()", "@out", function, "", "Probe", input, false); }
		@Override public SQLConfig<Long, Map<String, Object>, List<Object>> newSQLConfig(boolean procedure) {
			assertTrue(procedure); configCreations++; return config;
		}
		@Override public Map<String, Object> parseResponse(SQLConfig<Long, Map<String, Object>, List<Object>> c, boolean procedure) throws Exception {
			assertTrue(procedure); executions++; sql = c.gainSQL(true); values = new ArrayList<>(c.getPreparedValueList());
			return jdbc == null ? new LinkedHashMap<>() : jdbc.executor.execute(c, true);
		}
		@Override public SQLConfig<Long, Map<String, Object>, List<Object>> newSQLConfig(RequestMethod m, String t, String a,
				Map<String, Object> r, List<Join<Long, Map<String, Object>, List<Object>>> j, boolean p) { throw new AssertionError(); }
	}

	private static final class ParserStub extends AbstractParser<Long, Map<String, Object>, List<Object>> {
		ParserStub() { super(RequestMethod.GET, false); }
		@Override public Object onFunctionParse(String key, String function, String parentPath, String currentName,
				Map<String, Object> currentObject, boolean raw) { throw new AssertionError("Unexpected Java function call"); }
		@Override public void putQueryResult(String path, Object result) {}
		@Override public Parser<Long, Map<String, Object>, List<Object>> createParser() { return this; }
		@Override public FunctionParser<Long, Map<String, Object>, List<Object>> createFunctionParser() { return null; }
		@Override public Verifier<Long, Map<String, Object>, List<Object>> createVerifier() { return null; }
		@Override public SQLConfig<Long, Map<String, Object>, List<Object>> createSQLConfig() { return null; }
		@Override public SQLExecutor<Long, Map<String, Object>, List<Object>> createSQLExecutor() { return null; }
		@Override public ObjectParser<Long, Map<String, Object>, List<Object>> createObjectParser(Map<String, Object> r,
				String p, SQLConfig<Long, Map<String, Object>, List<Object>> a, boolean s, boolean t, boolean m) { return null; }
	}
}
