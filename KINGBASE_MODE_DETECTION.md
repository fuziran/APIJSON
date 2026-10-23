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

仅 KINGBASE_SQLSERVER 的普通单表分页查询，在已有排序不包含标识字段、
且简单字段投影明确包含 SQLConfig.getIdKey() 时，才使用该字段补充排序。
通配投影或未选出标识字段时，不凭默认名称假定物理表存在 id；稳定顺序由调用方显式指定。
原生 SQL Server 保留上游的排序行为。
已有主键排序（包括升序和降序）不会重复追加。
DISTINCT、分组、HAVING、关联、FROM 子查询和表达式或原始投影不会自动补充主键；
这些场景应显式提供适用于结果集的排序，需要稳定分页时应包含足以确定顺序的列。
name 字段与其他字段一样遵循数据库或字段本身的排序规则，ORM 不强制指定排序规则。

KINGBASE_MYSQL 当前不支持 MySQL MATCH ... AGAINST 的等价转换，生成 SQL 时会明确抛出
UnsupportedOperationException。金仓全文检索的分词、匹配与相关性评分不能保证和 MySQL 一致，
因此该能力不计入兼容通过范围。依赖全文检索的业务应使用共同的搜索实现或单独定义数据库接口契约。
三种兼容模式适配不表示完全覆盖原生数据库的全部功能。

## 请求语义与回归验证

- APP JOIN 优先复用精确相等的目标键；只有两端都是 Java Number 时才按数值比较。
  字符串键 `01`、`1`、`1.0` 不会因可解析为数字而合并；字符串与数值仅在文本完全相同时复用。
- KINGBASE_MYSQL 的投影别名 HAVING 支持数值比较及算术表达式，例如 `n>1`、`(n+1)>=2`。
  多个条件使用现有 `@having` / `@combine` 组合。别名条件在派生表外筛选，排序和分页也在外层执行。
  `@order` 可使用投影名或已重命名的原字段（`id:n` 配合 `id+` 会转换为 `n ASC`）。
  排序字段必须出现在 `@column` 中；无法映射的字段及未支持的表达式会明确报错。
- KINGBASE_SQLSERVER 继续使用 `~` / `~*` 区分大小写匹配；原生 SQL Server 保持上游路径，
  不在本次适配中新增 LIKE 转换、固定排序规则或 REGEXP_LIKE 版本依赖。
- 仅 KINGBASE_SQLSERVER 的 DATE_FORMAT 接受常量格式转换，支持
  `%Y`、`%y`、`%m`、`%d`、`%H`、`%h`、`%I`、`%i`、`%s`、`%S`、`%f`、`%p`、`%%`。
  `%i` 是分钟，`%m` 始终是月份；`%f` 输出六位微秒。普通文字按文字输出，格式通过参数绑定。
  其他格式符、末尾孤立的 `%` 和动态格式列会明确报错，不静默生成错误格式。
  所有原生数据库的 DATE_FORMAT 保持上游 SQL 和参数处理。
- KINGBASE_MYSQL 的 JSON_LENGTH 保留原函数，覆盖对象成员数、数组元素数、标量长度和可选路径；
  不再替换为仅支持数组的 JSON_ARRAY_LENGTH。部署数据库须提供 `mysql_json` 的 JSON_LENGTH 能力，
  并确保其所在 schema 可被业务连接解析。扩展由管理员按目标版本安装和验证，ORM 不自动安装。
  缺少能力属于部署前置条件未满足，应修复环境，不能用数组函数降低功能语义。

常规回归：`mvn -Pkingbase-driver-tests test`。驱动测试配置只验证驱动对象，不证明真实服务端通过。
新增 `KingbaseSemanticsRegressionTest` 覆盖上述缺陷及原生路径；
`KingbaseSemanticsLiveTest` 是可选的只读服务端测试，不创建表、修改数据或安装扩展。
未配置连接 URL 时，服务端测试会明确跳过，不能计为兼容通过。

运行只读服务端测试：`mvn -Pkingbase-driver-tests -Dtest=KingbaseSemanticsLiveTest test`。
分别通过环境变量提供 `KINGBASE_MYSQL_URL`、`KINGBASE_SQLSERVER_URL`，
以及对应前缀的 `_USERNAME` / `_PASSWORD`。金仓账号还可使用通用的
`KINGBASE_USERNAME` / `KINGBASE_PASSWORD`。
URL 已配置但认证、模式或函数能力不满足时，测试失败而不是跳过。

只读测试覆盖 JSON 空值、对象、数组、标量、存在与缺失路径、别名筛选及分页、
金仓 SQL Server 带微秒的日期格式。完整 HTTP 响应对比、写操作及修改前后的原生数据库回归
仍须使用等价 schema、数据和配置执行；这些只读测试不能替代完整验收。

## 原生数据库隔离与验收基线

本次隔离以社区 main `59c3a150c0fae26383cecac5a09e295cb30e8151` 的公开源码为基线。
原生 MySQL、Oracle、SQL Server、DB2、PostgreSQL 不使用本次新增的金仓排序、
元数据标识、JSON 条件、日期函数、JOIN 投影归属和隐式结果推进规则。
原生 Oracle 保留 ROWNUM 分页及其原有输出；原生存储过程调用保持上游 CALL 生成方式。
这表示适配不顺带修复原生数据库的已知缺陷，不表示这些原有功能均在目标服务端可用。
原生方言完善和公共缺陷修复应单独提交，提供版本范围、行为变化和真实数据库验证。

金仓的模式识别、类型读写、APP JOIN 键处理、别名 HAVING、微秒日期格式和
Request/Response TEXT/CLOB 规则解码继续保留；上述规则解码仅对金仓启用。
原生 Statement 执行入口保持原有调用方式，金仓的预编译执行及隐式结果通过
`AbstractSQLExecutor.executeKingbase` 处理；需要自定义这一路径的执行器可覆盖该方法。
社区 main 已有的 issue #824 多表 JOIN 计数补列修复及测试一并保留。

`NativeDatabaseBaselineTest` 对照 600 组从未修改的上述 main 编译结果采集的行为，
覆盖五种原生数据库、四个版本字符串、SQL、绑定值、异常类型、自然主键分页、
元数据标识、JOIN 排序、读写、计数和存储过程。
四个版本字符串用于离线条件覆盖，不代表已经连接相应版本的真实数据库。
预期结果保存在 `src/test/resources/native-main-59c3a150.tsv`，
不能使用待验收分支重新生成来消除测试差异。
`NativeDatabaseIsolationTest` 另检查原生 JDBC 读取与执行路径、JOIN 入口隔离，
以及原生和金仓自然主键分页不会凭空补 id。

执行离线回归：`mvn test`；启用已有金仓驱动对象验证：`mvn -Pkingbase-driver-tests test`。
真实服务端测试因缺少 URL 而跳过时，不计为通过。离线验证不能替代真实数据库的
HTTP 响应、写入结果、事务行为与性能回归。

官方资料：
- JDBC 连接：https://help.kingbase.com.cn/v9/development/client-interfaces/jdbc/jdbc-2.html
- SHOW database_mode 示例：https://help.kingbase.com.cn/v9/faq/faq-new/sql.html
- 系统视图差异：https://help.kingbase.com.cn/v9.3.11/development/application-develop-guide/internal_views/overview.html
- JSON_LENGTH 与 mysql_json：https://help.kingbase.com.cn/v9.3.11/development/application-develop-guide/reference/mysql/functions_operators/json.html
