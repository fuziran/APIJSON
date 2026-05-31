# Kingbase-Oracle 初始化脚本

本目录用于 APIJSONBoot-MultiDataSource 连接 `KINGBASE-ORACLE` 兼容模式时初始化测试库。

## 使用脚本

- `初始化.sql`：完整功能测试脚本，派生自 `APIJSONDemo/APIJSON-Demo/Oracle/初始化.sql`。
- 建议在 Kingbase 的 `PUBLIC` schema 下执行，并保持表名、字段名的双引号大小写。
- 对应 Java 配置应使用：
  - `DEFAULT_DATABASE = DATABASE_KINGBASE_ORACLE`
  - `DEFAULT_SCHEMA = "PUBLIC"`
  - JDBC URL 示例：`jdbc:kingbase8://192.168.60.128:54322/apijson?currentSchema=PUBLIC`

## 完整功能需要的表

框架启动和权限校验必需：

- `"Access"`：权限配置，APIJSONApplication.init 会加载。
- `"Request"`：非开放接口请求结构校验。
- `"Function"`：远程函数、脚本函数配置。
- `"Document"`：接口文档和 APIAuto 文档。
- `"TestRecord"`：APIAuto 测试记录。

Demo 登录和业务接口需要：

- `"apijson_user"`：对外别名 `User`。
- `"apijson_privacy"`：对外别名 `Privacy`。
- `"Verify"`：验证码。
- `"Login"`：登录记录。
- `"Moment"`：动态。
- `"Comment"`：评论。
- `"Praise"`：点赞。
- `"_Visit"`：访问记录。

APIAuto/UnitAuto 和完整示例数据还会用到：

- `"Method"`：UnitAuto 方法元数据。
- `"Random"`：随机测试参数。
- `"Response"`：响应示例。
- `"b_stone"`：示例业务表。

## 重要说明

`KINGBASE-ORACLE` 分支会生成 Oracle 风格 SQL，例如 `"Access"`、`"apijson_user"` 这样的双引号标识符。不要用未加双引号的 Oracle 单表脚本建这些表，否则数据库会把表名折叠成大写，框架查询时会找不到对应表。
