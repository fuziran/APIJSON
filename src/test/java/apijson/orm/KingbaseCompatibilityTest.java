package apijson.orm;

import apijson.RequestMethod;
import apijson.JSON;
import apijson.JSONParser;
import org.junit.BeforeClass;
import org.junit.Test;

import java.math.BigDecimal;
import java.lang.reflect.Proxy;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.Year;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialClob;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class KingbaseCompatibilityTest {
	@BeforeClass
	public static void installJsonParser() {
		JSON.DEFAULT_JSON_PARSER = new JSONParser<Map<String, Object>, List<Object>>() {
			@Override
			public Map<String, Object> createJSONObject() {
				return new LinkedHashMap<>();
			}

			@Override
			public List<Object> createJSONArray() {
				return new ArrayList<>();
			}

			@Override
			public Object parse(Object json) {
				if ("{\"enabled\":true}".equals(json)) {
					Map<String, Object> result = createJSONObject();
					result.put("enabled", true);
					return result;
				}
				return json;
			}

			@Override
			public Map<String, Object> parseObject(Object json) {
				return (Map<String, Object>) parse(json);
			}

			@Override
			public <T> T parseObject(Object json, Class<T> clazz) {
				return clazz.cast(parse(json));
			}

			@Override
			public List<Object> parseArray(Object json) {
				return (List<Object>) parse(json);
			}

			@Override
			public <T> List<T> parseArray(Object json, Class<T> clazz) {
				return (List<T>) parse(json);
			}

			@Override
			public String toJSONString(Object obj, boolean format) {
				return String.valueOf(obj);
			}
		};
	}

	private AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config(String database) {
		return config(database, "User");
	}

	private AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config(
			String database, String table) {
		return config(database, table, null);
	}

	private AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config(
			String database, String table, String idKey) {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config =
				new AbstractSQLConfig<Long, Map<String, Object>, List<Object>>(
						RequestMethod.GET, table) {
					@Override
					public String getIdKey() {
						return idKey == null ? super.getIdKey() : idKey;
					}

					@Override
					protected Object gainKingbaseModeCacheKey() {
						return Arrays.asList(getClass(), getDatabase());
					}

					@Override
					protected Connection openKingbaseModeConnection() throws SQLException {
						KingbaseModeResolverTest.Config stub =
								new KingbaseModeResolverTest.Config();
						stub.mode = getDatabase().substring("KINGBASE_".length());
						return stub.openKingbaseModeConnection();
					}

					@Override
					public String gainDBVersion() {
						return "9.0.0";
					}

					@Override
					public String gainDBUri() {
						return "jdbc:kingbase8://localhost/test";
					}

					@Override
					public String gainDBAccount() {
						return "test";
					}

					@Override
					public String gainDBPassword() {
						return "test";
					}

					@Override
					protected void onGainCrossJoinString(
							Join<Long, Map<String, Object>, List<Object>> join) {
						// Enable CROSS JOIN in this test configuration, as DemoSQLConfig does.
					}
				};
		config.setDatabase(database);
		return config;
	}

	private String crossJoinSql(String database, boolean withOn) throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> main =
				config(database, "Comment");
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> moment =
				config(database, "Moment");

		Join<Long, Map<String, Object>, List<Object>> join = new Join<>();
		join.setJoinType("*");
		join.setTable("Moment");
		join.setPath("/Moment/id@");
		join.setJoinConfig(moment);
		if (withOn) {
			Join.On on = new Join.On();
			on.setKey("id");
			on.setTargetTable("Comment");
			on.setTargetKey("momentId");
			join.setOnList(Arrays.asList(on));
		}
		main.setJoinList(Arrays.asList(join));
		return main.gainJoinString();
	}

	private AbstractSQLConfig.SimpleCallback<Long, Map<String, Object>, List<Object>> callback() {
		return new AbstractSQLConfig.SimpleCallback<Long, Map<String, Object>, List<Object>>() {
			@Override
			public SQLConfig<Long, Map<String, Object>, List<Object>> getSQLConfig(
					RequestMethod method,
					String database,
					String datasource,
					String namespace,
					String catalog,
					String schema,
					String table) {
				return KingbaseCompatibilityTest.this.config(database, table).setMethod(method);
			}
		};
	}

	private AbstractSQLConfig<Long, Map<String, Object>, List<Object>> jsonLengthHavingConfig(
			String database) {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config =
				config(database, "Moment");
		config.setColumn(Arrays.asList("userId", "pictureList"));
		config.putWhere("userId", 82002L, false);
		Map<String, Object> having = new LinkedHashMap<>();
		having.put("having0", "json_length(pictureList)>0");
		config.setHaving(having);
		config.setCount(3);
		return config;
	}

	private static Object primitiveDefault(Class<?> type) {
		if (!type.isPrimitive()) return null;
		if (type == boolean.class) return false;
		if (type == byte.class) return (byte) 0;
		if (type == short.class) return (short) 0;
		if (type == int.class) return 0;
		if (type == long.class) return 0L;
		if (type == float.class) return 0F;
		if (type == double.class) return 0D;
		if (type == char.class) return '\0';
		return null;
	}

	@Test
	public void kingbaseSqlServerOrdersUnpagedLeftJoinAtOuterQueryOnly() throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> main =
				config(SQLConfig.DATABASE_KINGBASE_SQLSERVER, "Moment");
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> comment =
				config(SQLConfig.DATABASE_KINGBASE_SQLSERVER, "Comment");
		comment.setOrder("id+");
		Join<Long, Map<String, Object>, List<Object>> join = new Join<>();
		join.setJoinType("<");
		join.setTable("Comment");
		join.setPath("/Comment/momentId@");
		join.setJoinConfig(comment);
		Join.On on = new Join.On();
		on.setKey("momentId");
		on.setTargetTable("Moment");
		on.setTargetKey("id");
		join.setOnList(Arrays.asList(on));
		main.setJoinList(Arrays.asList(join));
		String joinSql = main.gainJoinString();
		assertFalse(joinSql, joinSql.contains("ORDER BY"));
		assertEquals("id+", comment.getOrder());
		assertTrue(main.gainOrderString(true).contains("\"Comment\".\"id\" ASC"));
	}

	@Test
	public void usesInnerJoinForKingbaseMySQLCrossJoinWithOnOnly() throws Exception {
		String kingbaseWithOn = crossJoinSql(SQLConfig.DATABASE_KINGBASE_MYSQL, true);
		assertTrue(kingbaseWithOn, kingbaseWithOn.contains(" INNER JOIN ("));
		assertTrue(
				kingbaseWithOn,
				kingbaseWithOn.contains(" ON `Moment`.`id` = `Comment`.`momentId`"));
		assertFalse(kingbaseWithOn, kingbaseWithOn.contains(" CROSS JOIN ("));

		String kingbaseCartesian = crossJoinSql(SQLConfig.DATABASE_KINGBASE_MYSQL, false);
		assertTrue(kingbaseCartesian, kingbaseCartesian.contains(" CROSS JOIN ("));
		assertFalse(kingbaseCartesian, kingbaseCartesian.contains(" INNER JOIN ("));

		for (String database :
				Arrays.asList(
						SQLConfig.DATABASE_MYSQL,
						SQLConfig.DATABASE_POSTGRESQL,
						SQLConfig.DATABASE_ORACLE,
						SQLConfig.DATABASE_SQLSERVER,
						SQLConfig.DATABASE_KINGBASE_ORACLE,
						SQLConfig.DATABASE_KINGBASE_SQLSERVER)) {
			String sql = crossJoinSql(database, true);
			assertTrue(database + ": " + sql, sql.contains(" CROSS JOIN ("));
			assertFalse(database + ": " + sql, sql.contains(" INNER JOIN ("));
		}
	}

	@Test
	public void recognizesAllCompatibilityModes() {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> mysql = config(SQLConfig.DATABASE_KINGBASE_MYSQL);
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> oracle = config(SQLConfig.DATABASE_KINGBASE_ORACLE);
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> sqlServer = config(SQLConfig.DATABASE_KINGBASE_SQLSERVER);

		assertTrue(mysql.isKingBase() && mysql.isKingBaseMySQL() && mysql.isMSQL());
		assertTrue(oracle.isKingBase() && oracle.isKingBaseOracle() && oracle.isTSQL());
		assertTrue(sqlServer.isKingBase() && sqlServer.isKingBaseSQLServer() && sqlServer.isTSQL());
		assertEquals("`", mysql.getQuote());
		assertEquals(" ", oracle.gainAs());
		assertEquals("\"", sqlServer.getQuote());
		assertEquals(KingbaseSQLDialect.MYSQL, KingbaseSQLDialect.from(SQLConfig.DATABASE_KINGBASE_MYSQL));
		assertTrue(KingbaseSQLDialect.MYSQL.supportsDmlLimit());
		assertEquals(KingbaseSQLDialect.ORACLE, KingbaseSQLDialect.from(SQLConfig.DATABASE_KINGBASE_ORACLE));
		assertTrue(KingbaseSQLDialect.ORACLE.isOracle());
		assertFalse(KingbaseSQLDialect.ORACLE.supportsDmlLimit());
	}

	@Test
	public void generatesKingbaseMySQLCrudDialect() throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> select = config(SQLConfig.DATABASE_KINGBASE_MYSQL);
		select.setColumn(Arrays.asList("id", "name"));
		select.putWhere("id", 7L, false);
		select.setCount(10).setPage(2);
		String selectSql = select.gainSQL(true);
		assertTrue(selectSql, selectSql.startsWith("SELECT `id`,`name` FROM `sys`.`User`"));
		assertTrue(selectSql, selectSql.endsWith(" LIMIT 10 OFFSET 20"));
		assertEquals(Arrays.asList(7L), select.getPreparedValueList());

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> insert = config(SQLConfig.DATABASE_KINGBASE_MYSQL);
		insert.setMethod(RequestMethod.POST).setColumn(Arrays.asList("id", "name"));
		insert.setValues(Arrays.asList(Arrays.<Object>asList(7L, "Kingbase")));
		String insertSql = insert.gainSQL(true);
		assertTrue(insertSql, insertSql.startsWith("INSERT INTO `sys`.`User`(`id`,`name`) VALUES"));
		assertEquals(Arrays.<Object>asList(7L, "Kingbase"), insert.getPreparedValueList());

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> update = config(SQLConfig.DATABASE_KINGBASE_MYSQL);
		Map<String, Object> content = new LinkedHashMap<>();
		content.put("name", "KES");
		update.setMethod(RequestMethod.PUT).setContent(content).putWhere("id", 7L, false);
		update.setCount(1);
		String updateSql = update.gainSQL(true);
		assertTrue(updateSql, updateSql.startsWith("UPDATE `sys`.`User` SET `name` = ? WHERE"));
		assertTrue(updateSql, updateSql.endsWith(" LIMIT 1"));

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> delete = config(SQLConfig.DATABASE_KINGBASE_MYSQL);
		delete.setMethod(RequestMethod.DELETE).putWhere("id", 7L, false);
		delete.setCount(1);
		String deleteSql = delete.gainSQL(true);
		assertTrue(deleteSql, deleteSql.startsWith("DELETE FROM `sys`.`User` WHERE"));
		assertTrue(deleteSql, deleteSql.endsWith(" LIMIT 1"));
	}

	@Test
	public void preservesJsonLengthInsteadOfNarrowingToArrayLength() throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> kingbaseMySQL =
				config(SQLConfig.DATABASE_KINGBASE_MYSQL, "Moment");
		kingbaseMySQL.setColumn(Arrays.asList("json_length(pictureList):pictureCount"));
		String kingbaseSql = kingbaseMySQL.gainSQL(true);
		assertTrue(
				kingbaseSql, kingbaseSql.contains("json_length(`pictureList`) AS `pictureCount`"));
		assertEquals(
				"json_length(`pictureList`)>0",
				kingbaseMySQL.gainHavingItem(
						"`", "Moment", null, "", "json_length(pictureList)>0", false));
		assertEquals("json_length(`pictureList`)", kingbaseMySQL.gainKey("pictureList{"));

		for (String database :
				Arrays.asList(
						SQLConfig.DATABASE_MYSQL,
						SQLConfig.DATABASE_POSTGRESQL,
						SQLConfig.DATABASE_ORACLE,
						SQLConfig.DATABASE_SQLSERVER,
						SQLConfig.DATABASE_KINGBASE_ORACLE,
						SQLConfig.DATABASE_KINGBASE_SQLSERVER)) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> unchanged =
					config(database, "Moment");
			unchanged.setColumn(Arrays.asList("json_length(pictureList):pictureCount"));
			String sql = unchanged.gainSQL(true);
			assertTrue(database + ": " + sql, sql.contains("json_length("));
			assertFalse(database + ": " + sql, sql.contains("json_array_length("));
			assertEquals(
					database,
					"json_length(" + unchanged.gainSQLKey("pictureList") + ")",
					unchanged.gainKey("pictureList{"));
		}
	}

	@Test
	public void rejectsNonEquivalentMySqlFullTextForKingbaseMySQL() throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> kingbase =
				config(SQLConfig.DATABASE_KINGBASE_MYSQL);
		kingbase.setColumn(
				Arrays.asList("match(name,tag)AGAINST('tom*' IN NATURAL LANGUAGE MODE):match"));

		try {
			kingbase.gainSQL(true);
		} catch (UnsupportedOperationException e) {
			assertTrue(e.getMessage().contains("response-equivalent semantics"));
			return;
		}
		throw new AssertionError(
				"KINGBASE_MYSQL must reject non-equivalent MATCH ... AGAINST translation");
	}

	@Test
	public void movesScalarJsonLengthHavingForCompatibleDialects() throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> kingbaseMySQL =
				jsonLengthHavingConfig(SQLConfig.DATABASE_KINGBASE_MYSQL);
		String kingbaseSql = kingbaseMySQL.gainSQL(true);
		assertTrue(
				kingbaseSql,
				kingbaseSql.contains(
						"WHERE  (  (`userId` = ?)  )  AND ((json_length(`pictureList`)>0))"));
		assertFalse(kingbaseSql, kingbaseSql.contains(" HAVING "));
		String nativeSqlServer = jsonLengthHavingConfig(SQLConfig.DATABASE_SQLSERVER).gainSQL(true);
		assertFalse(nativeSqlServer, nativeSqlServer.contains("OPENJSON("));
		assertTrue(nativeSqlServer, nativeSqlServer.contains(" HAVING (json_length("));
		String kingbaseSqlServer =
				jsonLengthHavingConfig(SQLConfig.DATABASE_KINGBASE_SQLSERVER).gainSQL(true);
		assertTrue(kingbaseSqlServer, kingbaseSqlServer.contains("json_length("));
		assertFalse(kingbaseSqlServer, kingbaseSqlServer.contains(" HAVING "));

		for (String database :
				Arrays.asList(
						SQLConfig.DATABASE_MYSQL,
						SQLConfig.DATABASE_POSTGRESQL,
						SQLConfig.DATABASE_ORACLE,
						SQLConfig.DATABASE_KINGBASE_ORACLE)) {
			String sql = jsonLengthHavingConfig(database).gainSQL(true);
			assertTrue(database + ": " + sql, sql.contains(" HAVING "));
		}

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> aggregate =
				config(SQLConfig.DATABASE_KINGBASE_MYSQL, "Moment");
		aggregate.setColumn(Arrays.asList("userId"));
		Map<String, Object> aggregateHaving = new LinkedHashMap<>();
		aggregateHaving.put("having0", "count(id)>0");
		aggregate.setHaving(aggregateHaving);
		String aggregateSql = aggregate.gainSQL(true);
		assertTrue(aggregateSql, aggregateSql.contains(" HAVING (count(`id`)>0)"));
	}

	@Test
	public void generatesModeSpecificRegularExpressions() {
		String mysql =
				config(SQLConfig.DATABASE_MYSQL).gainRegExpString("name", "name", "A.*", true);
		String nativeSQLServer =
				config(SQLConfig.DATABASE_SQLSERVER).gainRegExpString("name", "name", "A.*", true);
		String kingbaseMySQL =
				config(SQLConfig.DATABASE_KINGBASE_MYSQL)
						.gainRegExpString("name", "name", "A.*", true);
		String oracle = config(SQLConfig.DATABASE_KINGBASE_ORACLE).gainRegExpString("name", "name", "A.*", true);
		String sqlServer = config(SQLConfig.DATABASE_KINGBASE_SQLSERVER).gainRegExpString("name", "name", "A.*", true);

		assertFalse(mysql.startsWith("(CASE WHEN"));
		assertTrue(nativeSQLServer, nativeSQLServer.startsWith("\"name\" REGEXP "));
		assertFalse(nativeSQLServer, nativeSQLServer.contains("REGEXP_LIKE"));
		assertTrue(
				kingbaseMySQL.startsWith("(CASE WHEN `name` IS NULL THEN NULL ELSE regexp_like("));
		assertTrue(kingbaseMySQL.endsWith(" END)"));
		assertTrue(oracle.startsWith("(CASE WHEN \"name\" IS NULL THEN NULL ELSE regexp_like("));
		assertTrue(oracle.endsWith(" END)"));
		assertTrue(sqlServer.contains(" ~* "));
	}

	@Test
	public void sqlServerGroupedPaginationOrdersByGroupedColumn() throws Exception {
		for (String database : Arrays.asList(SQLConfig.DATABASE_KINGBASE_SQLSERVER)) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> grouped =
					config(database, "Comment");
			grouped.setColumn(Arrays.asList("momentId", "count(userId)"));
			grouped.setGroup("momentId");
			grouped.setCount(10);
			String sql = grouped.gainSQL(true);
			assertTrue(sql, sql.contains("ORDER BY \"momentId\""));
			assertFalse(sql, sql.contains("ORDER BY \"id\""));
		}
	}

	@Test
	public void sqlServerSubqueryPaginationUsesProjectedColumn() {
		for (String database : Arrays.asList(SQLConfig.DATABASE_KINGBASE_SQLSERVER)) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> source =
					config(database, "Comment");
			source.setColumn(Arrays.asList("userId"));
			Subquery<Long, Map<String, Object>, List<Object>> from = new Subquery<>();
			from.setConfig(source);
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> outer =
					config(database, "Comment");
			outer.setFrom(from).setCount(10);
			assertTrue(
					outer.gainOrderString(true),
					outer.gainOrderString(true).contains("\"userId\""));
			assertFalse(
					outer.gainOrderString(true), outer.gainOrderString(true).contains("\"id\""));
		}
	}

	@Test
	public void sqlServerPaginationBreaksEqualDateTiesById() {
		for (String database : Arrays.asList(SQLConfig.DATABASE_KINGBASE_SQLSERVER)) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config =
					config(database, "Moment");
			config.setColumn(Arrays.asList("date", "id"));
			config.setOrder("date+").setCount(5);
			String order = config.gainOrderString(true);
			assertTrue(order, order.contains("\"date\" ASC"));
			assertTrue(order, order.contains("\"id\" ASC"));
		}
	}

	@Test
	public void sqlServerNameOrderingPreservesDatabaseCollation() {
		for (String database :
				Arrays.asList(
						SQLConfig.DATABASE_SQLSERVER, SQLConfig.DATABASE_KINGBASE_SQLSERVER)) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config =
					config(database, "User");
			config.setOrder("name-,id").setCount(10);
			assertEquals(" ORDER BY \"name\" DESC ,\"id\"", config.gainOrderString(true));
		}
	}

	@Test
	public void sqlServerPaginationUsesConfiguredPrimaryKeyWithoutDuplicatingIt() throws Exception {
		for (String database : Arrays.asList(SQLConfig.DATABASE_KINGBASE_SQLSERVER)) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config =
					config(database, "CustomKeyTable", "uuid");
			config.setColumn(Arrays.asList("date", "uuid"));
			config.setOrder("date+").setCount(5);
			assertEquals(" ORDER BY \"date\" ASC ,\"uuid\" ASC ", config.gainOrderString(true));
			for (String order : Arrays.asList("uuid", "uuid+", "uuid-")) {
				config.setOrder(order);
				String sql = config.gainSQL(true);
				assertFalse(sql, sql.contains("\"id\""));
				String ordering = config.gainOrderString(true);
				assertEquals(
						ordering, ordering.indexOf("\"uuid\""), ordering.lastIndexOf("\"uuid\""));
			}
			config.setOrder((String) null);
			assertEquals(" ORDER BY \"uuid\"", config.gainOrderString(true));
		}
	}

	@Test
	public void sqlServerDistinctAndGroupedPaginationKeepExplicitOrder() throws Exception {
		for (String database :
				Arrays.asList(
						SQLConfig.DATABASE_SQLSERVER, SQLConfig.DATABASE_KINGBASE_SQLSERVER)) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> distinct =
					config(database, "User");
			distinct.setColumn(Arrays.asList("name"))
					.setDistinct(true)
					.setOrder("name+")
					.setCount(5);
			String sql = distinct.gainSQL(true);
			assertTrue(sql, sql.contains("SELECT DISTINCT \"name\""));
			assertEquals(" ORDER BY \"name\" ASC ", distinct.gainOrderString(true));
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> grouped =
					config(database, "Comment");
			grouped.setColumn(Arrays.asList("momentId", "count(userId)"));
			grouped.setGroup("momentId").setOrder("momentId-").setCount(5);
			assertEquals(" ORDER BY \"momentId\" DESC ", grouped.gainOrderString(true));
		}
	}

	@Test
	public void sqlServerSubqueryAndAggregatePaginationDoNotAppendUnavailablePrimaryKey() {
		for (String database :
				Arrays.asList(
						SQLConfig.DATABASE_SQLSERVER, SQLConfig.DATABASE_KINGBASE_SQLSERVER)) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> source =
					config(database, "Comment");
			source.setColumn(Arrays.asList("userId"));
			Subquery<Long, Map<String, Object>, List<Object>> from = new Subquery<>();
			from.setConfig(source);
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> outer =
					config(database, "Comment");
			outer.setFrom(from).setOrder("userId+").setCount(5);
			assertEquals(" ORDER BY \"userId\" ASC ", outer.gainOrderString(true));
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> aggregate =
					config(database, "Comment");
			aggregate
					.setColumn(Arrays.asList("count(userId):total"))
					.setOrder("total-")
					.setCount(5);
			assertEquals(" ORDER BY \"total\" DESC ", aggregate.gainOrderString(true));
		}
	}

	@Test
	public void translatesLegacyDateFormatOnlyForKingbaseSqlServer() throws Exception {
		for (String database : Arrays.asList(SQLConfig.DATABASE_KINGBASE_SQLSERVER)) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config =
					config(database, "Moment");
			config.setColumn(Arrays.asList("id", "date_format(date,%Y-%m-%d %H:%i)"));
			String sql = config.gainSQL(true);
			assertFalse(sql, sql.contains("date_format("));
			assertTrue(sql, sql.contains("to_char(to_timestamp(CAST(\"date\" AS varchar)"));
			assertEquals(
					Arrays.asList("YYYY\"-\"MM\"-\"DD\" \"HH24\":\"MI"),
					config.getPreparedValueList());
		}
	}

	@Test
	public void generatesKingbaseOracleCrudDialect() throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> select = config(SQLConfig.DATABASE_KINGBASE_ORACLE);
		select.setAlias("u").setColumn(Arrays.asList("id", "name"));
		select.putWhere("id", 7L, false).setCount(10).setPage(2);
		String selectSql = select.gainSQL(true);
		assertTrue(selectSql, selectSql.startsWith("SELECT * FROM (SELECT \"User__u\".*, ROWNUM \"RN\" FROM (SELECT"));
		assertTrue(selectSql, selectSql.contains("FROM \"sys\".\"User\" WHERE"));
		assertTrue(selectSql, selectSql.endsWith("WHERE \"RN\" > 20"));
		assertFalse(selectSql, selectSql.contains(" AS \"u\""));
		assertEquals(Arrays.asList(7L), select.getPreparedValueList());

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> insert = config(SQLConfig.DATABASE_KINGBASE_ORACLE);
		insert.setMethod(RequestMethod.POST).setColumn(Arrays.asList("id", "name"));
		insert.setValues(Arrays.asList(Arrays.<Object>asList(7L, "Kingbase")));
		String insertSql = insert.gainSQL(true);
		assertTrue(insertSql, insertSql.startsWith("INSERT INTO \"sys\".\"User\"(\"id\",\"name\") VALUES"));
		assertEquals(Arrays.<Object>asList(7L, "Kingbase"), insert.getPreparedValueList());

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> update = config(SQLConfig.DATABASE_KINGBASE_ORACLE);
		Map<String, Object> content = new LinkedHashMap<>();
		content.put("name", "KES");
		update.setMethod(RequestMethod.PUT).setContent(content).putWhere("id", 7L, false).setCount(1);
		String updateSql = update.gainSQL(true);
		assertTrue(updateSql, updateSql.startsWith("UPDATE \"sys\".\"User\" SET \"name\" = ? WHERE"));
		assertFalse(updateSql, updateSql.contains(" LIMIT "));

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> delete = config(SQLConfig.DATABASE_KINGBASE_ORACLE);
		delete.setMethod(RequestMethod.DELETE).putWhere("id", 7L, false).setCount(1);
		String deleteSql = delete.gainSQL(true);
		assertTrue(deleteSql, deleteSql.startsWith("DELETE FROM \"sys\".\"User\" WHERE"));
		assertFalse(deleteSql, deleteSql.contains(" LIMIT "));

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> explain = config(SQLConfig.DATABASE_KINGBASE_ORACLE);
		explain.setExplain(true);
		assertTrue(explain.gainSQL(true).startsWith("EXPLAIN (FORMAT TEXT) SELECT"));
	}

	@Test
	public void generatesKingbaseSQLServerCrudDialect() throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> select = config(SQLConfig.DATABASE_KINGBASE_SQLSERVER);
		select.setAlias("u").setColumn(Arrays.asList("id", "name"));
		select.putWhere("id", 7L, false).setCount(10).setPage(2);
		String selectSql = select.gainSQL(true);
		assertTrue(selectSql, selectSql.startsWith("SELECT \"id\",\"name\" FROM \"sys\".\"User\""));
		assertTrue(selectSql, selectSql.contains(" ORDER BY \"id\""));
		assertTrue(selectSql, selectSql.endsWith(" OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY"));
		assertEquals(Arrays.asList(7L), select.getPreparedValueList());

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> insert = config(SQLConfig.DATABASE_KINGBASE_SQLSERVER);
		insert.setMethod(RequestMethod.POST).setColumn(Arrays.asList("id", "name"));
		insert.setValues(Arrays.asList(Arrays.<Object>asList(7L, "Kingbase")));
		String insertSql = insert.gainSQL(true);
		assertTrue(insertSql, insertSql.startsWith("INSERT INTO \"sys\".\"User\"(\"id\",\"name\") VALUES"));
		assertFalse(insertSql, insertSql.contains(" RETURNING "));
		assertEquals(Arrays.<Object>asList(7L, "Kingbase"), insert.getPreparedValueList());

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> update = config(SQLConfig.DATABASE_KINGBASE_SQLSERVER);
		Map<String, Object> content = new LinkedHashMap<>();
		content.put("name", "KES");
		update.setMethod(RequestMethod.PUT).setContent(content).putWhere("id", 7L, false).setCount(1);
		String updateSql = update.gainSQL(true);
		assertTrue(updateSql, updateSql.startsWith("UPDATE \"sys\".\"User\" SET \"name\" = ? WHERE"));
		assertFalse(updateSql, updateSql.contains(" LIMIT "));

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> delete = config(SQLConfig.DATABASE_KINGBASE_SQLSERVER);
		delete.setMethod(RequestMethod.DELETE).putWhere("id", 7L, false).setCount(1);
		String deleteSql = delete.gainSQL(true);
		assertTrue(deleteSql, deleteSql.startsWith("DELETE FROM \"sys\".\"User\" WHERE"));
		assertFalse(deleteSql, deleteSql.contains(" LIMIT "));

		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> explain = config(SQLConfig.DATABASE_KINGBASE_SQLSERVER);
		explain.setExplain(true);
		assertTrue(explain.gainSQL(true).startsWith("EXPLAIN SELECT"));
	}

	@Test
	public void restoresMissingMetadataTableMappingsForKingbaseSQLServerAndOracle() {
		Map<String, String> original = new HashMap<>(AbstractSQLConfig.TABLE_KEY_MAP);
		try {
			AbstractSQLConfig.TABLE_KEY_MAP.remove("Table");
			AbstractSQLConfig.TABLE_KEY_MAP.remove("Column");
			AbstractSQLConfig.TABLE_KEY_MAP.remove("PgClass");
			AbstractSQLConfig.TABLE_KEY_MAP.remove("PgAttribute");

			assertEquals(
					"tables",
					config(SQLConfig.DATABASE_KINGBASE_SQLSERVER, "Table").gainSQLTable());
			assertEquals(
					"columns",
					config(SQLConfig.DATABASE_KINGBASE_SQLSERVER, "Column").gainSQLTable());
			assertEquals(
					"pg_class",
					config(SQLConfig.DATABASE_KINGBASE_SQLSERVER, "PgClass").gainSQLTable());
			assertEquals(
					"pg_attribute",
					config(SQLConfig.DATABASE_KINGBASE_SQLSERVER, "PgAttribute").gainSQLTable());

			assertEquals(
					"tables", config(SQLConfig.DATABASE_KINGBASE_ORACLE, "Table").gainSQLTable());
			assertEquals(
					"columns", config(SQLConfig.DATABASE_KINGBASE_ORACLE, "Column").gainSQLTable());
			assertEquals(
					"pg_class",
					config(SQLConfig.DATABASE_KINGBASE_ORACLE, "PgClass").gainSQLTable());
			assertEquals(
					"pg_attribute",
					config(SQLConfig.DATABASE_KINGBASE_ORACLE, "PgAttribute").gainSQLTable());

			assertEquals(
					"Table", config(SQLConfig.DATABASE_KINGBASE_MYSQL, "Table").gainSQLTable());

			AbstractSQLConfig.TABLE_KEY_MAP.put("Table", "Table");
			assertEquals(
					"tables",
					config(SQLConfig.DATABASE_KINGBASE_SQLSERVER, "Table").gainSQLTable());
			assertEquals(
					"tables", config(SQLConfig.DATABASE_KINGBASE_ORACLE, "Table").gainSQLTable());

			AbstractSQLConfig.TABLE_KEY_MAP.put("Table", "custom_tables");
			assertEquals(
					"custom_tables",
					config(SQLConfig.DATABASE_KINGBASE_SQLSERVER, "Table").gainSQLTable());
			assertEquals(
					"custom_tables",
					config(SQLConfig.DATABASE_KINGBASE_ORACLE, "Table").gainSQLTable());
		} finally {
			AbstractSQLConfig.TABLE_KEY_MAP.clear();
			AbstractSQLConfig.TABLE_KEY_MAP.putAll(original);
		}
	}

	@Test
	public void usesMetadataIdsForKingbaseSqlServerPagination() throws Exception {
		AbstractSQLConfig.SimpleCallback<Long, Map<String, Object>, List<Object>> callback =
				callback();
		String[][] metadataIds = {
			{"Table", "table_name"},
			{"Column", "ordinal_position"},
			{"PgClass", "oid"},
			{"PgAttribute", "attnum"}
		};

		for (String[] metadataId : metadataIds) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config =
					config(SQLConfig.DATABASE_KINGBASE_SQLSERVER, metadataId[0]);
			config.setCount(10);
			String sql = config.gainSQL(false);

			assertEquals(metadataId[1], config.getIdKey());
			assertEquals(
					metadataId[1],
					callback.getIdKey(
							SQLConfig.DATABASE_KINGBASE_SQLSERVER,
							null,
							null,
							null,
							null,
							metadataId[0]));
			assertTrue(sql, sql.contains("ORDER BY \"" + metadataId[1] + "\""));
			assertFalse(sql, sql.contains("ORDER BY \"id\""));
		}

		assertEquals(
				"id",
				callback.getIdKey(
						SQLConfig.DATABASE_KINGBASE_SQLSERVER, null, null, null, null, "User"));
	}

	@Test
	public void ignoresUnavailableColumnCommentMetadataFilterForKingbaseSQLServerAndOracle()
			throws Exception {
		for (String database :
				Arrays.asList(
						SQLConfig.DATABASE_KINGBASE_SQLSERVER,
						SQLConfig.DATABASE_KINGBASE_ORACLE)) {
			Map<String, Object> request = new LinkedHashMap<>();
			request.put("@database", database);
			request.put("table_name", "Moment");
			request.put("column_comment[>", 2);
			request.put("@column", "column_name");

			SQLConfig<Long, Map<String, Object>, List<Object>> config =
					AbstractSQLConfig.newSQLConfig(
							RequestMethod.GET, "Column", null, request, null, false, callback());
			config.setCount(50);
			String sql = config.gainSQL(false);

			assertTrue(sql, sql.contains("\"table_name\" = 'Moment'"));
			assertFalse(sql, sql.toLowerCase().contains("column_comment"));
		}
	}

	@Test
	public void generatesModeSpecificJsonContainment() {
		String nativeSQLServer =
				config(SQLConfig.DATABASE_SQLSERVER)
						.gainContainString("get<>", "get", new Object[] {38710}, Logic.TYPE_OR);
		assertTrue(nativeSQLServer, nativeSQLServer.contains("json_contains(\"get\","));
		assertFalse(nativeSQLServer, nativeSQLServer.contains("OPENJSON"));
		for (String database : new String[] {
				SQLConfig.DATABASE_KINGBASE_MYSQL,
				SQLConfig.DATABASE_KINGBASE_SQLSERVER
		}) {
			String sql = config(database).gainContainString("get<>", "get", new Object[] {"UNKNOWN"}, Logic.TYPE_OR);
			assertTrue(sql, sql.contains("::jsonb @>"));
			assertTrue(sql, !sql.contains("json_contains("));
			assertTrue(sql, !sql.contains("json_textcontains("));
		}

		String oracleSql = config(SQLConfig.DATABASE_KINGBASE_ORACLE)
				.gainContainString("get<>", "get", new Object[] {"UNKNOWN"}, Logic.TYPE_OR);
		assertTrue(oracleSql, oracleSql.contains("json_textcontains("));
		assertFalse(oracleSql, oracleSql.contains("::jsonb"));
	}

	@Test
	public void preservesNativeSqlServerProcedureCall() throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> sqlServer =
				config(SQLConfig.DATABASE_SQLSERVER, "User");
		sqlServer.setProcedure("getCommentByUserId(82001,10,0)");
		assertEquals("CALL \"sys\".getCommentByUserId(82001,10,0)", sqlServer.gainSQL(false));
	}

	@Test
	public void mapsJdbcValuesToJsonSafeValues() throws Exception {
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() { };
		SQLConfig<Long, Map<String, Object>, List<Object>> config = config(SQLConfig.DATABASE_KINGBASE_MYSQL);

		Object json = executor.mapResultValue(config, "{\"enabled\":true}", Types.OTHER, "jsonb", "settings");
		Object array = executor.mapResultValue(config, new Object[] {1, "two"}, Types.ARRAY, "varchar[]", "tags");

		assertTrue(json instanceof Map);
		assertEquals("true", String.valueOf(((Map<?, ?>) json).get("enabled")));
		assertEquals("1234567890.123456789", executor.mapResultValue(config,
				new BigDecimal("1234567890.123456789"), Types.NUMERIC, "numeric", "amount"));
		assertTrue(array instanceof List);
		assertEquals(2, ((List<?>) array).size());
		assertEquals(Base64.getEncoder().encodeToString("binary".getBytes("UTF-8")),
				executor.mapResultValue(config, "binary".getBytes("UTF-8"), Types.VARBINARY, "varbinary", "payload"));
		assertEquals(Base64.getEncoder().encodeToString("blob".getBytes("UTF-8")),
				executor.mapResultValue(config, new SerialBlob("blob".getBytes("UTF-8")), Types.BLOB, "blob", "payload"));
		assertEquals("ordinary text", executor.mapResultValue(config,
				new SerialClob("ordinary text".toCharArray()), Types.CLOB, "longtext", "description"));
		assertEquals("2026-07-19T10:20", executor.mapResultValue(config,
				LocalDateTime.of(2026, 7, 19, 10, 20), Types.TIMESTAMP, "datetime", "createdAt"));
		assertEquals(2026, executor.mapResultValue(config, Year.of(2026), Types.SMALLINT, "year", "year"));
		assertEquals("not json", executor.mapResultValue(config, "not json", Types.OTHER,
				"business_json_status", "status"));
		assertEquals(true, executor.mapResultValue(config, "1", Types.BOOLEAN, "bool", "enabled"));
		assertEquals("NaN", executor.mapResultValue(config, Double.NaN, Types.DOUBLE, "double", "score"));
	}

	@Test
	public void reusesOriginalAppJoinValueOnlyForKingbaseMySQLCacheKey() {
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() {};
		Long originalValue = 82001L;
		List<Object> targetValues = Arrays.<Object>asList(originalValue, 93793L);

		Object kingbaseValue =
				executor.getAppJoinCacheKeyValue(
						config(SQLConfig.DATABASE_KINGBASE_MYSQL),
						new BigDecimal("82001.000"),
						targetValues);
		assertTrue(kingbaseValue == originalValue);

		Object nativeValue =
				executor.getAppJoinCacheKeyValue(
						config(SQLConfig.DATABASE_MYSQL),
						new BigDecimal("82001.000"),
						targetValues);
		assertEquals(new BigDecimal("82001.000"), nativeValue);

		assertEquals(
				"12345",
				executor.getAppJoinCacheKeyValue(
						config(SQLConfig.DATABASE_KINGBASE_MYSQL), "12345", targetValues));
	}

	@Test
	public void mapsKingbaseOracleValuesToJsonSafeValues() throws Exception {
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() { };
		SQLConfig<Long, Map<String, Object>, List<Object>> config = config(SQLConfig.DATABASE_KINGBASE_ORACLE);

		Object json = executor.mapResultValue(config, "{\"enabled\":true}", Types.OTHER, "JSON", "settings");
		assertTrue(json instanceof Map);
		assertEquals("1234567890.123456789", executor.mapResultValue(config,
				new BigDecimal("1234567890.123456789"), Types.NUMERIC, "NUMBER", "amount"));
		assertEquals(Base64.getEncoder().encodeToString("raw".getBytes("UTF-8")),
				executor.mapResultValue(config, "raw".getBytes("UTF-8"), Types.VARBINARY, "RAW", "payload"));
		assertEquals(Base64.getEncoder().encodeToString("blob".getBytes("UTF-8")),
				executor.mapResultValue(config, new SerialBlob("blob".getBytes("UTF-8")), Types.BLOB, "BLOB", "payload"));
		assertEquals("ordinary text", executor.mapResultValue(config,
				new SerialClob("ordinary text".toCharArray()), Types.CLOB, "CLOB", "description"));
		assertEquals("2026-07-19 10:20:00.0", executor.mapResultValue(config,
				Timestamp.valueOf("2026-07-19 10:20:00"), Types.TIMESTAMP, "TIMESTAMP", "createdAt"));
		assertEquals(true, executor.mapResultValue(config, "1", Types.BOOLEAN, "BOOLEAN", "enabled"));
	}

	@Test
	public void mapsKingbaseSQLServerValuesToJsonSafeValues() throws Exception {
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() { };
		SQLConfig<Long, Map<String, Object>, List<Object>> config = config(SQLConfig.DATABASE_KINGBASE_SQLSERVER);

		Object json = executor.mapResultValue(config, "{\"enabled\":true}", Types.OTHER, "JSONB", "settings");
		assertTrue(json instanceof Map);
		assertEquals("1234567890.123456789", executor.mapResultValue(config,
				new BigDecimal("1234567890.123456789"), Types.DECIMAL, "MONEY", "amount"));
		assertEquals(Short.valueOf((short) 255), executor.mapResultValue(config,
				Short.valueOf((short) 255), Types.TINYINT, "TINYINT", "level"));
		assertEquals("9007199254740992", executor.mapResultValue(config,
				9007199254740992L, Types.BIGINT, "BIGINT", "externalId"));
		assertEquals(Base64.getEncoder().encodeToString("row-version".getBytes("UTF-8")),
				executor.mapResultValue(config, "row-version".getBytes("UTF-8"), Types.BINARY, "ROWVERSION", "version"));
		assertEquals(Base64.getEncoder().encodeToString("image".getBytes("UTF-8")),
				executor.mapResultValue(config, "image".getBytes("UTF-8"), Types.LONGVARBINARY, "IMAGE", "picture"));
		assertEquals("ordinary text", executor.mapResultValue(config,
				new SerialClob("ordinary text".toCharArray()), Types.CLOB, "NTEXT", "description"));
		assertEquals("line 1\nline 2", executor.mapResultValue(config,
				new SerialClob("line 1\nline 2".toCharArray()), Types.CLOB, "NTEXT", "multiline"));
		assertEquals("2026-07-19 10:20:00.0", executor.mapResultValue(config,
				Timestamp.valueOf("2026-07-19 10:20:00"), Types.TIMESTAMP, "DATETIME2", "createdAt"));
		assertEquals(true, executor.mapResultValue(config, "1", Types.BIT, "BIT", "enabled"));
		assertEquals("NaN", executor.mapResultValue(config, Double.NaN, Types.DOUBLE, "FLOAT", "score"));
		assertEquals("123e4567-e89b-12d3-a456-426614174000", executor.mapResultValue(config,
				java.util.UUID.fromString("123e4567-e89b-12d3-a456-426614174000"), Types.OTHER,
				"UNIQUEIDENTIFIER", "requestId"));
	}

	@Test
	public void bindsKingbaseMySQLValuesUsingParameterMetadata() throws Exception {
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() { };
		SQLConfig<Long, Map<String, Object>, List<Object>> config = config(SQLConfig.DATABASE_KINGBASE_MYSQL);
		AtomicReference<String> call = new AtomicReference<>();
		AtomicReference<Object[]> arguments = new AtomicReference<>();

		ParameterMetaData metadata = (ParameterMetaData) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {ParameterMetaData.class}, (proxy, method, args) -> {
					if ("getParameterType".equals(method.getName())) return Types.OTHER;
					if ("getParameterTypeName".equals(method.getName())) return "jsonb";
					return primitiveDefault(method.getReturnType());
				});
		PreparedStatement statement = (PreparedStatement) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {PreparedStatement.class}, (proxy, method, args) -> {
					if ("getParameterMetaData".equals(method.getName())) return metadata;
					if (method.getName().startsWith("set")) {
						call.set(method.getName());
						arguments.set(args);
					}
					return primitiveDefault(method.getReturnType());
				});

		executor.setArgument(config, statement, 0, new LinkedHashMap<String, Object>());
		assertEquals("setObject", call.get());
		assertEquals(Types.OTHER, arguments.get()[2]);

		executor.setArgument(config, statement, 0, new byte[] {1, 2});
		assertEquals("setBytes", call.get());
	}

	@Test
	public void bindsKingbaseOracleValuesUsingParameterMetadata() throws Exception {
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() { };
		SQLConfig<Long, Map<String, Object>, List<Object>> config = config(SQLConfig.DATABASE_KINGBASE_ORACLE);
		AtomicReference<String> call = new AtomicReference<>();
		AtomicReference<Object[]> arguments = new AtomicReference<>();
		AtomicInteger jdbcType = new AtomicInteger(Types.OTHER);
		AtomicReference<String> typeName = new AtomicReference<>("JSON");

		ParameterMetaData metadata = (ParameterMetaData) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {ParameterMetaData.class}, (proxy, method, args) -> {
					if ("getParameterType".equals(method.getName())) return jdbcType.get();
					if ("getParameterTypeName".equals(method.getName())) return typeName.get();
					return primitiveDefault(method.getReturnType());
				});
		PreparedStatement statement = (PreparedStatement) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {PreparedStatement.class}, (proxy, method, args) -> {
					if ("getParameterMetaData".equals(method.getName())) return metadata;
					if (method.getName().startsWith("set")) {
						call.set(method.getName());
						arguments.set(args);
					}
					return primitiveDefault(method.getReturnType());
				});

		executor.setArgument(config, statement, 0, new LinkedHashMap<String, Object>());
		assertEquals("setObject", call.get());
		assertEquals(Types.OTHER, arguments.get()[2]);

		executor.setArgument(config, statement, 0, new byte[] {1, 2});
		assertEquals("setBytes", call.get());

		jdbcType.set(Types.NUMERIC);
		typeName.set("NUMBER");
		executor.setArgument(config, statement, 0, null);
		assertEquals("setNull", call.get());
		assertEquals(Types.NUMERIC, arguments.get()[1]);

		executor.setArgument(config, statement, 0, new java.util.Date(0));
		assertEquals("setTimestamp", call.get());
	}

	@Test
	public void bindsKingbaseSQLServerValuesUsingParameterMetadata() throws Exception {
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() { };
		SQLConfig<Long, Map<String, Object>, List<Object>> config = config(SQLConfig.DATABASE_KINGBASE_SQLSERVER);
		AtomicReference<String> call = new AtomicReference<>();
		AtomicReference<Object[]> arguments = new AtomicReference<>();
		AtomicInteger jdbcType = new AtomicInteger(Types.OTHER);
		AtomicReference<String> typeName = new AtomicReference<>("JSONB");

		ParameterMetaData metadata = (ParameterMetaData) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {ParameterMetaData.class}, (proxy, method, args) -> {
					if ("getParameterType".equals(method.getName())) return jdbcType.get();
					if ("getParameterTypeName".equals(method.getName())) return typeName.get();
					return primitiveDefault(method.getReturnType());
				});
		PreparedStatement statement = (PreparedStatement) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {PreparedStatement.class}, (proxy, method, args) -> {
					if ("getParameterMetaData".equals(method.getName())) return metadata;
					if (method.getName().startsWith("set")) {
						call.set(method.getName());
						arguments.set(args);
					}
					return primitiveDefault(method.getReturnType());
				});

		executor.setArgument(config, statement, 0, new LinkedHashMap<String, Object>());
		assertEquals("setObject", call.get());
		assertEquals(Types.OTHER, arguments.get()[2]);

		executor.setArgument(config, statement, 0, new byte[] {1, 2});
		assertEquals("setBytes", call.get());

		jdbcType.set(Types.NVARCHAR);
		typeName.set("NVARCHAR");
		executor.setArgument(config, statement, 0, null);
		assertEquals("setNull", call.get());
		assertEquals(Types.NVARCHAR, arguments.get()[1]);

		executor.setArgument(config, statement, 0, new java.util.Date(0));
		assertEquals("setTimestamp", call.get());

		executor.setArgument(config, statement, 0, Arrays.asList("中文", "text"));
		assertEquals("setNString", call.get());

		executor.setArgument(config, statement, 0, java.util.UUID.fromString("123e4567-e89b-12d3-a456-426614174000"));
		assertEquals("setObject", call.get());
	}

	@Test
	public void readsKingbaseSQLServerGeneratedKey() throws Exception {
		ResultSet generatedKeys = (ResultSet) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {ResultSet.class}, (proxy, method, args) -> {
					if ("next".equals(method.getName())) return true;
					if ("getLong".equals(method.getName())) return 42L;
					return primitiveDefault(method.getReturnType());
				});
		PreparedStatement statement = (PreparedStatement) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {PreparedStatement.class}, (proxy, method, args) -> {
					if ("execute".equals(method.getName())) return true;
					if ("getUpdateCount".equals(method.getName())) return -1;
					if ("getResultSet".equals(method.getName())) return generatedKeys;
					return primitiveDefault(method.getReturnType());
				});
		Connection mockConnection = (Connection) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {Connection.class}, (proxy, method, args) -> {
					if ("prepareStatement".equals(method.getName())) return statement;
					return primitiveDefault(method.getReturnType());
				});
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() {
					@Override
					public Connection getConnection(SQLConfig<Long, Map<String, Object>, List<Object>> config) {
						return mockConnection;
					}
				};
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> insert = config(SQLConfig.DATABASE_KINGBASE_SQLSERVER);
		insert.setMethod(RequestMethod.POST).setPrepared(false).setId(null);
		insert.setColumn(Arrays.asList("name")).setValues(Arrays.asList(Arrays.<Object>asList("Kingbase")));

		assertEquals(1, executor.executeUpdate(insert, null));
		assertEquals(Long.valueOf(42L), insert.getId());
	}

	@Test
	public void requestsKingbaseGeneratedKeyByColumnName() throws Exception {
		AtomicReference<Object[]> prepareArguments = new AtomicReference<>();
		PreparedStatement expected = (PreparedStatement) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {PreparedStatement.class}, (proxy, method, args) -> primitiveDefault(method.getReturnType()));
		Connection mockConnection = (Connection) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {Connection.class}, (proxy, method, args) -> {
					if ("prepareStatement".equals(method.getName())) {
						prepareArguments.set(args);
						return expected;
					}
					return primitiveDefault(method.getReturnType());
				});
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() {
					@Override
					public Connection getConnection(SQLConfig<Long, Map<String, Object>, List<Object>> config) {
						return mockConnection;
					}
				};
		for (String database : Arrays.asList(SQLConfig.DATABASE_KINGBASE_MYSQL,
				SQLConfig.DATABASE_KINGBASE_ORACLE, SQLConfig.DATABASE_KINGBASE_SQLSERVER)) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> insert = config(database);
			insert.setMethod(RequestMethod.POST).setId(null);

			assertTrue(expected == executor.getStatement(insert, "INSERT INTO User(name) VALUES(?)"));
			assertFalse(String.valueOf(prepareArguments.get()[0]).contains(" RETURNING "));
			assertTrue(prepareArguments.get()[1] instanceof String[]);
			assertEquals("id", ((String[]) prepareArguments.get()[1])[0]);
		}
	}

	@Test
	public void fallsBackToForwardOnlyKingbaseCursor() throws Exception {
		AtomicInteger calls = new AtomicInteger();
		PreparedStatement expected = (PreparedStatement) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {PreparedStatement.class}, (proxy, method, args) -> primitiveDefault(method.getReturnType()));
		Connection mockConnection = (Connection) Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class<?>[] {Connection.class}, (proxy, method, args) -> {
					if ("prepareStatement".equals(method.getName()) && args != null && args.length == 3) {
						if (calls.getAndIncrement() == 0) throw new SQLFeatureNotSupportedException("scroll cursor");
						assertEquals(ResultSet.TYPE_FORWARD_ONLY, args[1]);
						assertEquals(ResultSet.CONCUR_READ_ONLY, args[2]);
						return expected;
					}
					return primitiveDefault(method.getReturnType());
				});
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() {
					@Override
					public Connection getConnection(SQLConfig<Long, Map<String, Object>, List<Object>> config) {
						return mockConnection;
					}
				};

		assertTrue(expected == executor.getStatement(config(SQLConfig.DATABASE_KINGBASE_ORACLE), "SELECT 1"));
		assertEquals(2, calls.get());
	}

	@Test
	public void removesOnlyApiGeneratedIdForIdentityColumn() throws Exception {
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() {
					@Override
					protected boolean isAutoGeneratedIdColumn(SQLConfig<Long, Map<String, Object>, List<Object>> config,
							Connection conn) {
						return true;
					}
				};
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> config = config(SQLConfig.DATABASE_KINGBASE_SQLSERVER);
		config.setMethod(RequestMethod.POST).setId(123L).setIdGeneratedByAPIJSON(true);
		config.setColumn(new ArrayList<>(Arrays.asList("id", "name")));
		config.setValues(new ArrayList<>(Arrays.asList(new ArrayList<Object>(Arrays.asList(123L, "test")))));

		assertTrue(executor.prepareDatabaseGeneratedId(config, null));
		assertEquals(Arrays.asList("name"), config.getColumn());
		assertEquals(Arrays.asList("test"), config.getValues().get(0));
		assertEquals(null, config.getId());
	}

	@Test
	public void hidesOnlyFinalOraclePaginationRowNumber() throws Exception {
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
				new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() { };
		SQLConfig<Long, Map<String, Object>, List<Object>> config = config(SQLConfig.DATABASE_KINGBASE_ORACLE).setCount(10);
		ResultSetMetaData metadata = (ResultSetMetaData) Proxy.newProxyInstance(
				getClass().getClassLoader(), new Class<?>[] {ResultSetMetaData.class}, (proxy, method, args) -> {
					if ("getColumnCount".equals(method.getName())) return 3;
					if ("getColumnName".equals(method.getName())) return ((Integer) args[0]) == 3 ? "rn" : "name";
					return null;
				});

		assertFalse(executor.isHideColumn(config, (ResultSet) null, metadata, 0, new LinkedHashMap<>(), 2, null, null));
		assertTrue(executor.isHideColumn(config, (ResultSet) null, metadata, 0, new LinkedHashMap<>(), 3, null, null));
	}

}
