package apijson.orm;

import java.sql.*;
import java.math.BigDecimal;
import java.util.*;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import static org.junit.Assume.assumeTrue;

/** Optional SELECT-only comparisons against native MySQL; no extensions or DDL. */
public class KingbaseMySQLReviewLiveTest {
	@BeforeClass
	public static void parser() { KingbaseCompatibilityTest.installJsonParser(); }

	private Connection connect(boolean kingbase) throws SQLException {
		String prefix = kingbase ? "KINGBASE_MYSQL" : "AUDIT_MYSQL";
		String url = System.getenv(prefix + "_URL");
		assumeTrue("Set " + prefix + "_URL for native/Kingbase comparisons", url != null && !url.trim().isEmpty());
		String user = System.getenv(kingbase ? "KINGBASE_USERNAME" : prefix + "_USERNAME");
		String password = System.getenv(kingbase ? "KINGBASE_PASSWORD" : prefix + "_PASSWORD");
		Connection c = DriverManager.getConnection(url, user, password);
		c.setReadOnly(true);
		return c;
	}

	private List<Map<String, Object>> rows(Connection connection, AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c,
			String sql, List<Object> args) throws Exception {
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor = new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() {};
		List<Map<String, Object>> rows = new ArrayList<>();
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setQueryTimeout(10);
			for (int i = 0; i < args.size(); i++) ps.setObject(i + 1, args.get(i));
			try (ResultSet rs = ps.executeQuery()) {
				ResultSetMetaData md = rs.getMetaData();
				while (rs.next()) {
					Map<String, Object> row = new LinkedHashMap<>();
					for (int i = 1; i <= md.getColumnCount(); i++) {
						String label = executor.getKey(c, rs, md, rows.size(), row, i, null, null);
						Object value = executor.getValue(c, rs, md, rows.size(), row, i, label, null, null);
						// Integer and Long are both JSON numbers; strings stay strings.
						if (value instanceof Number) value = new BigDecimal(value.toString()).stripTrailingZeros();
						row.put(label, value);
					}
					rows.add(row);
				}
			}
		}
		return rows;
	}

	private List<Map<String, Object>> project(Connection connection, String db, String expression, String fixture,
			String group, String having) throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c = KingbaseSemanticsRegressionTest.config(db);
		c.setRaw(Collections.singletonList("@column"));
		c.setColumn(Collections.singletonList(expression));
		c.setGroup(group);
		if (having != null) c.setHaving(Collections.<String, Object>singletonMap("h", having));
		String sql = c.gainSQL(true).replace(c.gainTablePath(), fixture);
		return rows(connection, c, sql, c.getPreparedValueList());
	}

	@Test
	public void dateFunctionsPreserveValuesLabelsAndTypes() throws Exception {
		String[][] cases = {
			{"date_add(d,INTERVAL 1 MONTH):v", "CAST('2026-01-31' AS DATE)"},
			{"date_add(d,INTERVAL 1 MONTH)", "CAST('2026-01-31' AS DATE)"},
			{"date_sub(d,INTERVAL 1 DAY):v", "CAST('2024-03-01' AS DATE)"},
			{"date_add(d,INTERVAL 1 HOUR):v", "CAST('2026-01-31' AS DATE)"},
			{"date_add(d,INTERVAL 1 QUARTER):v", "CAST('2026-01-31' AS DATE)"},
			{"date_add(d,INTERVAL 1 DAY):v", "CAST('2026-01-31 12:34:56.123456' AS DATETIME(6))"},
			{"date_sub(d,INTERVAL -1 DAY):v", "CAST('2026-01-31 12:34:56.123456' AS DATETIME(6))"},
			{"date_sub(d,INTERVAL -1 DAY)", "CAST('2026-01-31' AS DATE)"},
			{"date_add(d,INTERVAL 1 DAY):v", "concat('2026-01-31')"},
			{"date_add(d,INTERVAL 1 DAY):v", "concat('2026-01-31 12:34:56.123456')"},
			{"date_add('2026-01-31',INTERVAL 1 DAY):v", "1"},
			{"date_add('2026-01-31',INTERVAL 1 DAY)", "1"},
			{"date_add('not-a-date',INTERVAL 1 DAY):v", "1"},
			{"date_add(d,INTERVAL 1 DAY):v", "CAST(NULL AS DATE)"}
		};
		try (Connection mysql = connect(false); Connection kb = connect(true)) {
			for (String[] test : cases) {
				String fixture = "(SELECT " + test[1] + " AS d) AS fixture";
				assertEquals(Arrays.toString(test), project(mysql, "MYSQL", test[0], fixture, null, null),
						project(kb, "KINGBASE_MYSQL", test[0], fixture, null, null));
			}
		}
	}

	@Test
	public void jsonContainmentPreservesPathsAndScalarCandidates() throws Exception {
		Object[][] cases = {
			{"[1,2]", "", 1}, {"1", "$", 1}, {"\"Alice\"", "$", "Alice"},
			{"{\"items\":[1,2]}", "$.items", 1},
			{"{\"_items\":[1]}", "$._items", 1},
			{"{\"last\":[1]}", "$.last", 1},
			{"{\"items\":[{\"a.b\":1}]}", "$.items[0].\"a.b\"", 1},
			{"{\"items\":[1,2]}", "$.items[last-1]", 1},
			{"{\"items\":[1,2]}", "$.items[9]", 1},
			{"{\"items\":[1]}", "$.missing", 1},
			{"[{\"items\":[1]}]", "$.items", 1},
			{"1", "$[0]", 1}, {"1", "$[1]", 1},
			{"null", "$", null}, {null, "$", 1}
		};
		try (Connection mysql = connect(false); Connection kb = connect(true)) {
			for (Object[] test : cases) {
				List<List<Map<String, Object>>> results = new ArrayList<>();
				for (String db : Arrays.asList("MYSQL", "KINGBASE_MYSQL")) {
					AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c = KingbaseSemanticsRegressionTest.config(db);
					c.setPrepared(true);
					Map<String, Object> item = new LinkedHashMap<>();
					item.put("path", test[1]); item.put("value", test[2]);
					String predicate = c.gainContainString("payload", "payload", new Object[]{item}, Logic.TYPE_OR);
					List<Object> args = new ArrayList<>(); args.add(test[0]); args.addAll(c.getPreparedValueList());
					results.add(rows("MYSQL".equals(db) ? mysql : kb, c,
							"SELECT 1 AS id FROM (SELECT CAST(? AS JSON) AS payload) fixture WHERE " + predicate, args));
				}
				assertEquals(Arrays.toString(test), results.get(0), results.get(1));
			}
		}
	}

	@Test
	public void timeColumnsPreserveFractionsSignsAndDurations() throws Exception {
		try (Connection mysql = connect(false); Connection kb = connect(true)) {
			for (String value : Arrays.asList("00:00:00.000000", "12:34:56.123456", "23:59:59.999999", "-00:30:00.000000", "30:34:56.000000", null)) {
				String literal = value == null ? "NULL" : "'" + value + "'";
				String fixture = "(SELECT CAST(" + literal + " AS TIME(6)) AS d) AS fixture";
				List<Map<String, Object>> actual = project(kb, "KINGBASE_MYSQL", "d:v", fixture, null, null);
				assertEquals(value, 1, actual.size());
				assertEquals(value, value, actual.get(0).get("v"));
				String nativeResult;
				try { nativeResult = project(mysql, "MYSQL", "d:v", fixture, null, null).toString(); }
				catch (SQLException e) { nativeResult = "SQLState=" + e.getSQLState(); }
				// Observation only: driver differences must not redefine the
				// Kingbase assertion above, whose expected value is the input.
				System.out.println("TIME input=" + value + "; native=" + nativeResult + "; Kingbase=" + actual);
			}
			assertEquals("12:34:57.123456", project(kb, "KINGBASE_MYSQL", "date_add(d,INTERVAL 1 SECOND):v",
					"(SELECT CAST('12:34:56.123456' AS TIME(6)) AS d) AS fixture", null, null).get(0).get("v"));
		}
	}

	@Test
	public void groupedHavingAndSumKeepNativeResponseTypes() throws Exception {
		try (Connection mysql = connect(false); Connection kb = connect(true)) {
			String fixture = "(SELECT 1 AS id UNION ALL SELECT 2) AS fixture";
			assertEquals(project(mysql, "MYSQL", "id:id", fixture, "id", "count(id)>0"),
					project(kb, "KINGBASE_MYSQL", "id:id", fixture, "id", "count(id)>0"));
			for (String expr : Arrays.asList("sum(id):total", "sum(id)", "sum(DISTINCT id):total", "count(id):total")) {
				assertEquals(expr, project(mysql, "MYSQL", expr, fixture, null, null),
						project(kb, "KINGBASE_MYSQL", expr, fixture, null, null));
			}
			fixture = "(SELECT CAST(1.25 AS DOUBLE) AS id UNION ALL SELECT CAST(2.5 AS DOUBLE)) AS fixture";
			assertEquals(project(mysql, "MYSQL", "sum(id):total", fixture, null, null),
					project(kb, "KINGBASE_MYSQL", "sum(id):total", fixture, null, null));
		}
	}
}
