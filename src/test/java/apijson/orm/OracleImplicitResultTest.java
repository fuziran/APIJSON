package apijson.orm;

import java.lang.reflect.Proxy;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import org.junit.Test;
import static org.junit.Assert.*;

public class OracleImplicitResultTest {
    private final AbstractSQLExecutor<Long, Map<String, Object>, List<Object>> executor =
            new AbstractSQLExecutor<Long, Map<String, Object>, List<Object>>() {};

    @Test public void anonymousBlockReadsItsFirstImplicitResult() throws Exception {
        AtomicBoolean advanced = new AtomicBoolean();
        ResultSet expected = (ResultSet) Proxy.newProxyInstance(getClass().getClassLoader(),
                new Class<?>[]{ResultSet.class}, (p, m, a) -> null);
        Statement statement = statement(advanced, expected);
        assertSame(expected, executor.execute(statement, "BEGIN test_comments(); END;"));
        assertTrue(advanced.get());
    }

    @Test public void ordinaryUpdateDoesNotAdvanceAndLoseItsUpdateCount() throws Exception {
        AtomicBoolean advanced = new AtomicBoolean();
        assertNull(executor.execute(statement(advanced, null), "UPDATE test_table SET n=1"));
        assertFalse(advanced.get());
    }

    private Statement statement(AtomicBoolean advanced, ResultSet result) {
        return (Statement) Proxy.newProxyInstance(getClass().getClassLoader(),
                new Class<?>[]{Statement.class}, (proxy, method, args) -> {
                    if (method.getName().equals("execute")) return false;
                    if (method.getName().equals("getResultSet")) { if (!advanced.get()) throw new java.sql.SQLException("ORA-17283: No result set available"); return result; }
                    if (method.getName().equals("getMoreResults")) { advanced.set(true); return true; }
                    throw new AssertionError("Unexpected JDBC call: " + method.getName());
                });
    }
}
