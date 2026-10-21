# 金仓连接配置与兼容模式自动识别

不需要固定服务端兼容模式时，推荐上层使用 KINGBASE_AUTO，仅提供金仓 JDBC 连接信息或连接池。
KINGBASE_AUTO 是框架的自动识别入口，不是服务端的一种兼容模式。
需要明确指定模式时，配置 KINGBASE_MYSQL、KINGBASE_ORACLE 或 KINGBASE_SQLSERVER；
框架会核对服务端实际模式，不一致即报错，不会改用另一种方言执行请求。
服务端必须已经按目标 KingbaseES 版本完成初始化。

## 连接和方言

1. 应用根据数据源名称选择连接目标。
2. 框架借用该目标的专用连接执行 SHOW database_mode。
3. 实际模式映射到内部 KINGBASE_MYSQL、KINGBASE_ORACLE、KINGBASE_SQLSERVER 方言；明确配置的模式必须与之匹配。
4. 使用原数据源执行 SQL；不切换连接池或改用原生 MySQL/Oracle/SQLServer 驱动。

getDatabase() 保留原始路由配置（未显式设置时可为 null）。
gainSQLDatabase() 返回实际方言。默认数据库配置和请求中的 @database 均支持 KINGBASE_AUTO。
isKingBase() 只判断金仓产品，不触发探测。
SQL 生成、参数绑定、结果映射均使用探测后的具体模式。

KINGBASE_MYSQL、KINGBASE_ORACLE、KINGBASE_SQLSERVER 入口也会探测，用于确认连接目标符合用户配置。
例如配置 KINGBASE_MYSQL 却连接 Oracle 兼容模式实例，框架会报告模式不匹配；不会生成 Oracle 方言 SQL 或执行该业务请求。
新部署可使用 KINGBASE_AUTO 自动选择方言，也可使用明确的模式名称固定预期模式。
后端的预期模式约束适用于需要在部署侧额外限定模式的场景，包括 KINGBASE_AUTO 入口。
旧 KINGBASE 保持 LEGACY 行为，不自动探测。非金仓数据库不受影响。

## 连接来源

默认使用 DriverManager.getConnection(gainDBUri(), gainDBAccount(), gainDBPassword())。
使用连接池的 SQLConfig 子类应覆盖：

    @Override
    protected java.sql.Connection openKingbaseModeConnection() throws java.sql.SQLException {
        return dataSource.getConnection();
    }

    @Override
    protected Object gainKingbaseModeCacheKey() {
        return dataSource;
    }

连接由探测器关闭并归还连接池，不要返回业务事务正在使用的连接。
连接配置和缓存键不能依赖尚待探测的具体方言判断；递归调用会明确报错。
业务连接与探测连接必须使用相同目标、路由上下文及必要的连接初始化配置。

## 共享缓存和启动检查

应用启动时可使用同一个解析器预热：

    AbstractSQLConfig.KINGBASE_MODE_RESOLVER.resolve(dataSource, dataSource::getConnection);

SQLConfig 必须返回同一个缓存键，才能与启动检查共享结果。
成功结果按键缓存，同键并发合并一次探测；失败不缓存，可重试。
默认键包含 SQLConfig 实现类、URI、账号、datasource、namespace、catalog。
动态租户或其他路由上下文需要扩展缓存键，不要将密码加入键或日志。

目标切换时使用 invalidate(config)、invalidateKey(key) 或 clear()。
缓存不自动过期，应用移除数据源时应清理；正在执行的调用可能仍持有旧结果，
因此还须协调业务连接池的替换，不能仅清理模式缓存。

## 可选的部署模式约束

KINGBASE_AUTO 默认接受任意已支持的实际模式；三个明确的模式入口自动要求服务端与配置一致。
如果业务还要求在部署侧固定模式，可通过后端配置覆盖：

    @Override
    protected String gainKingbaseExpectedDatabase() {
        return DATABASE_KINGBASE_ORACLE;
    }

配置的明确模式或后端预期模式与实际模式不一致，都会在方言解析时抛出包含预期和实际模式的异常。
后端预期值不能来自请求。配置模式校验和后端预期校验在每次解析（包括缓存命中）后执行，不污染实际模式缓存。
启动预热后可用 KingbaseModeResolver.requireExpectedMode(actual, expected) 执行相同断言。

## 支持范围和验证

mysql、oracle、sqlserver 忽略首尾空白与大小写。
保留 sql_server、mssql 返回别名的兼容解析；目标版本实际返回值须以实测为准。
PG、未知值、空值、空结果和连接失败均明确报错，不猜测方言。

探测语句超时 5 秒；连接建立和网络超时由 JDBC 或连接池负责。
本次自动模式改造以模拟 JDBC 和现有回归测试验证，不能替代目标服务端与驱动的集成测试。
模式识别不保证所有版本、扩展或会话参数下的 SQL 语义完全一致。

## 分页排序与已知能力限制

KINGBASE_SQLSERVER 与原生 SQL Server 的普通单表分页查询，在已有排序不包含主键时，
使用 SQLConfig.getIdKey() 配置的实际主键补充排序，不假定主键名称为 id。
已有主键排序（包括升序和降序）不会重复追加。
DISTINCT、分组、HAVING、关联、FROM 子查询和表达式或原始投影不会自动补充主键；
这些场景应显式提供适用于结果集的排序，需要稳定分页时应包含足以确定顺序的列。
name 字段与其他字段一样遵循数据库或字段本身的排序规则，ORM 不强制指定排序规则。

KINGBASE_MYSQL 当前不支持 MySQL MATCH ... AGAINST 的等价转换，生成 SQL 时会明确抛出
UnsupportedOperationException。金仓全文检索的分词、匹配与相关性评分不能保证和 MySQL 一致，
因此该能力不计入兼容通过范围。依赖全文检索的业务应使用共同的搜索实现或单独定义数据库接口契约。
三种兼容模式适配不表示完全覆盖原生数据库的全部功能。

官方资料：
- JDBC 连接：https://help.kingbase.com.cn/v9/development/client-interfaces/jdbc/jdbc-2.html
- SHOW database_mode 示例：https://help.kingbase.com.cn/v9/faq/faq-new/sql.html
- 系统视图差异：https://help.kingbase.com.cn/v9.3.11/development/application-develop-guide/internal_views/overview.html
