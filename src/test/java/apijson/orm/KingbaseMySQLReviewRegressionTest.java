package apijson.orm;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.*;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/** Counterexamples from the compatibility review, including projection reuse. */
public class KingbaseMySQLReviewRegressionTest {
	@BeforeClass
	public static void parser() { KingbaseCompatibilityTest.installJsonParser(); }

	@Test
	public void dateArithmeticKeepsFunctionsBindingsAndResponseLabels() throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c =
				KingbaseSemanticsRegressionTest.config("KINGBASE_MYSQL");
		c.setRaw(Collections.singletonList("@column"));
		c.setColumn(Arrays.asList("date_add(d,INTERVAL 1 MONTH)", "date_sub('2026-01-31',INTERVAL -1 DAY):next"));
		String sql = c.gainSQL(true);
		assertTrue(sql, sql.contains("date_add(`d`,INTERVAL '1 MONTH')"));
		assertTrue(sql, sql.contains("AS `date_add(``d``,INTERVAL 1 MONTH)`"));
		assertTrue(sql, sql.contains("date_sub(?,INTERVAL '-1 DAY') AS `next`"));
		assertEquals(Collections.singletonList("2026-01-31"), c.getPreparedValueList());
		assertEquals(sql, c.gainSQL(true));
		assertEquals(Collections.singletonList("2026-01-31"), c.getPreparedValueList());
		c.setColumn(Collections.singletonList("date_sub(d,INTERVAL -1 DAY)"));
		assertTrue(c.gainSQL(false).contains("date_sub(`d`,INTERVAL '-1 DAY')"));
	}

	@Test
	public void expressionStateBelongsToTheCurrentProjection() throws Exception {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c =
				KingbaseSemanticsRegressionTest.config("KINGBASE_MYSQL");
		AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> e = new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() {};
		c.setColumn(Arrays.asList("date_add(d,INTERVAL 1 DAY):v", "sum(id):n"));
		c.gainSQL(true);
		Timestamp timestamp = Timestamp.valueOf("2026-01-31 12:34:56.123456");
		assertEquals("2026-01-31T12:34:56.123456", e.mapResultValue(c, timestamp, Types.TIMESTAMP, "datetime", "v"));
		assertEquals("3", e.mapResultValue(c, 3L, Types.BIGINT, "int8", "n"));
		assertEquals(3L, e.mapResultValue(c, 3L, Types.BIGINT, "int8", "ordinary"));
		assertEquals(3.5, e.mapResultValue(c, 3.5, Types.DOUBLE, "float8", "n"));
		assertEquals("3.50", e.mapResultValue(c, new BigDecimal("3.50"), Types.NUMERIC, "numeric", "n"));
		assertNull(e.mapResultValue(c, null, Types.NUMERIC, "numeric", "n"));
		c.setColumn(Arrays.asList("d:v", "id:n"));
		c.gainSQL(true);
		assertEquals(timestamp.toString(), e.mapResultValue(c, timestamp, Types.TIMESTAMP, "datetime", "v"));
		assertEquals(3L, e.mapResultValue(c, 3L, Types.BIGINT, "int8", "n"));
	}

	@Test
	public void groupedHavingDoesNotEnterTheScalarAliasGrammar() throws Exception {
		for (String db : Arrays.asList("MYSQL", "KINGBASE_MYSQL")) {
			AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c = KingbaseSemanticsRegressionTest.config(db);
			c.setColumn(Collections.singletonList("id:id"));
			c.setGroup("id");
			c.setHaving(Collections.<String, Object>singletonMap("h", "count(id)>0"));
			String sql = c.gainSQL(true);
			assertTrue(sql, sql.contains(" HAVING (count(`id`)>0)"));
			assertFalse(sql, sql.contains("_apijson_having"));
		}
	}

	@Test
	public void jsonPathsStayBoundAndDistinguishKeysFromArraySubscripts() {
		AbstractSQLConfig<Long, Map<String, Object>, List<Object>> c = KingbaseSemanticsRegressionTest.config("KINGBASE_MYSQL");
		c.setPrepared(true);
		Map<String, Object> item = new LinkedHashMap<>();
		item.put("path", "$.items[0].\"a.b\"");
		item.put("value", "Alice\"\\");
		String sql = c.gainContainString("payload", "payload", new Object[]{item}, Logic.TYPE_OR);
		assertEquals(Arrays.asList("strict $.items", "lax $[0]", "strict $.\"a.b\"", "Alice\"\\"), c.getPreparedValueList());
		assertTrue(sql, sql.contains("to_jsonb(CAST(? AS varchar))"));
		assertFalse(sql, sql.contains("Alice"));
		assertEquals(Arrays.asList("lax $[last-1]"), KingbaseMySQLJsonPath.steps("$[last-1]"));
		for (String path : Arrays.asList("$.items[*]", "$**.id", "$[0 to 1]", "$.x;SELECT", "$.\"unterminated")) {
			assertThrows(IllegalArgumentException.class, () -> KingbaseMySQLJsonPath.steps(path));
		}
	}
}
