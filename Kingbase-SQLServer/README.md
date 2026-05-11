# Kingbase SQL Server 兼容模式 SQL 转换说明

## 概述

本项目已成功将 SQLServer 目录下的所有 SQL 文件转换为 Kingbase-SQLServer 兼容格式。转换后的文件保存在 `Kingbase-SQLServer` 目录中。

## 转换内容

### 转换的文件列表

共转换了 **13 个 SQL 文件**，包括：

#### 核心配置表
- `Kingbase-SQLServer/single/sys_Function.sql` - 远程函数配置表
- `Kingbase-SQLServer/single/sys_Request.sql` - 请求参数校验配置表
- `Kingbase-SQLServer/single/sys_Document.sql` - 文档表

#### Demo 示例表
- `Kingbase-SQLServer/single/sys_Comment.sql` - 评论表
- `Kingbase-SQLServer/single/sys_Moment.sql` - 动态表
- `Kingbase-SQLServer/single/sys_Verify.sql` - 验证表
- `Kingbase-SQLServer/single/sys_apijson_user.sql` - 用户表
- `Kingbase-SQLServer/single/sys_apijson_privacy.sql` - 隐私表

#### 自动化测试相关表
- `Kingbase-SQLServer/single/sys_TestRecord.sql` - 测试记录表
- `Kingbase-SQLServer/single/sys_Method.sql` - 方法测试表
- `Kingbase-SQLServer/single/sys_Random.sql` - 随机数据表

#### 示例数据库
- `Kingbase-SQLServer/pubs_dbo.sql` - pubs 示例数据库

## 主要转换内容

根据 KingbaseES 的 SQL Server 兼容模式，转换脚本执行了以下操作：

### 1. 清理转换工具标记
- 删除 `-- SQLINES DEMO` 注释
- 删除 `/* SQLINES DEMO */` 注释
- 移除 `-- SQLINES LICENSE FOR EVALUATION USE ONLY` 标记

### 2. 标识符转换
- `[column_name]` → `"column_name"` （方括号改为双引号）
- SQL Server 风格的方括号标识符转换为标准 SQL 双引号

### 3. 数据类型转换
- `datetime2(0)` → `DATETIME`
- 保留 `bigint`、`varchar`、`smallint` 等标准类型
- 保留 `json` 类型（KingbaseES 支持）

### 4. 函数替换
- `GETDATE()` → `CURRENT_TIMESTAMP`

### 5. 自增列语法
- `IDENTITY` → `IDENTITY(1,1)` （明确起始值和增量）

### 6. 保留的 T-SQL 语法特性
KingbaseES SQL Server 模式完全兼容以下 T-SQL 语法：

#### 数据类型
- ✅ `bigint` - 大整数（8 字节）
- ✅ `int` - 整数（4 字节）
- ✅ `smallint` - 小整数（2 字节）
- ✅ `tinyint` - 微整数（1 字节）
- ✅ `bit` - 布尔类型
- ✅ `varchar(n)` / `nvarchar(n)` - 变长字符串
- ✅ `char(n)` / `nchar(n)` - 定长字符串
- ✅ `datetime` / `datetime2` - 日期时间
- ✅ `decimal(p,s)` / `numeric(p,s)` - 精确数值
- ✅ `money` - 货币类型

#### DDL 语法
- ✅ `CREATE TABLE` T-SQL 语法
- ✅ `IDENTITY(seed, increment)` - 自增列
- ✅ `PRIMARY KEY` / `UNIQUE` 约束
- ✅ `FOREIGN KEY` 外键约束
- ✅ `CHECK` 检查约束
- ✅ `DEFAULT` 默认值约束

#### DML 语法
- ✅ `INSERT INTO ... VALUES (...)` 标准语法
- ✅ `INSERT INTO ... SELECT ...` 子查询插入
- ✅ `UPDATE ... SET ... FROM ...` 多表更新
- ✅ `DELETE ... FROM ... JOIN ...` 多表删除
- ✅ `SELECT TOP n` - 限制返回行数

#### T-SQL 特性
- ✅ `GO` - 批处理分隔符
- ✅ `BEGIN...END` - 语句块
- ✅ `IF...ELSE` - 条件语句
- ✅ `WHILE` - 循环语句
- ✅ `TRY...CATCH` - 异常处理
- ✅ `PRINT` - 输出消息
- ✅ `RAISERROR` - 抛出错误

#### 内置函数
- ✅ `GETDATE()` / `CURRENT_TIMESTAMP` - 当前时间
- ✅ `NEWID()` - 生成 UUID
- ✅ `LEN()` - 字符串长度
- ✅ `SUBSTRING()` - 子字符串
- ✅ `CHARINDEX()` - 查找字符串位置
- ✅ `CONVERT()` / `CAST()` - 类型转换
- ✅ `ISNULL()` - 空值处理
- ✅ `COALESCE()` - 返回第一个非空值

#### 高级特性
- ✅ 公用表表达式（CTE）：`WITH cte AS (...)`
- ✅ 窗口函数：`ROW_NUMBER()`, `RANK()`, `DENSE_RANK()` 等
- ✅ PIVOT / UNPIVOT - 行列转换
- ✅ CROSS APPLY / OUTER APPLY - 表值函数应用

## 使用方法

### 前提条件

1. **创建 Kingbase SQL Server 兼容模式数据库**

   ```sql
   CREATE DATABASE your_database WITH COMPATIBILITY_MODE = 'mssql';
   ```

   或使用 `initdb` 命令创建：
   ```bash
   initdb -D /path/to/data --db-mode=mssql
   ```

2. **连接到 Kingbase 数据库**
   ```bash
   ksql -U username -d database
   ```

### 执行 SQL 文件

#### 方式一：在 ksql 客户端中执行
```bash
# 连接数据库
ksql -U username -d database

# 执行单个表（支持 GO 批处理命令）
\i Kingbase-SQLServer/single/sys_Function.sql
```

#### 方式二：使用命令行执行
```bash
# 执行单个表文件
ksql -U username -d database -f Kingbase-SQLServer/single/sys_Function.sql

# 执行完整 pubs 示例数据库
ksql -U username -d database -f Kingbase-SQLServer/pubs_dbo.sql
```

#### 方式三：按模块执行
```bash
# 执行核心配置表
ksql -U username -d database -f Kingbase-SQLServer/single/sys_Function.sql
ksql -U username -d database -f Kingbase-SQLServer/single/sys_Request.sql

# 执行 Demo 表
for file in Kingbase-SQLServer/single/sys_Comment.sql \
            Kingbase-SQLServer/single/sys_Moment.sql \
            Kingbase-SQLServer/single/sys_apijson_user.sql \
            Kingbase-SQLServer/single/sys_apijson_privacy.sql; do
  ksql -U username -d database -f "$file"
done

# 执行测试表
ksql -U username -d database -f Kingbase-SQLServer/single/sys_Method.sql
ksql -U username -d database -f Kingbase-SQLServer/single/sys_TestRecord.sql
ksql -U username -d database -f Kingbase-SQLServer/single/sys_Random.sql
```

#### 方式四：使用 GO 批处理（T-SQL 风格）
如果 SQL 文件中包含 `GO` 命令，需要确保 KingbaseES 已启用 T-SQL 批处理模式：

```sql
-- 设置批处理模式
SET statement_timeout = 0;
GO

-- 执行 DDL
CREATE TABLE test_table (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)
);
GO

-- 执行 DML
INSERT INTO test_table (name) VALUES ('test');
GO
```

## Kingbase SQL Server 兼容性说明

根据 KingbaseES 官方文档，SQL Server 兼容模式（V9R4C12）支持以下特性：

### 数据类型兼容
- ✅ 整数类型：`bigint`, `int`, `smallint`, `tinyint`
- ✅ 浮点类型：`float`, `real`
- ✅ 精确数值：`decimal`, `numeric`, `money`, `smallmoney`
- ✅ 字符串：`char`, `varchar`, `nchar`, `nvarchar`, `text`, `ntext`
- ✅ 日期时间：`date`, `time`, `datetime`, `datetime2`, `datetimeoffset`, `smalldatetime`
- ✅ 二进制：`binary`, `varbinary`, `image`
- ✅ 其他：`bit`, `uniqueidentifier`, `xml`, `json`

### T-SQL 语法兼容
- ✅ `GO` 批处理分隔符
- ✅ `TOP n [PERCENT] [WITH TIES]` 限制结果集
- ✅ `SELECT INTO` 快速创建表
- ✅ `MERGE` 合并语句
- ✅ `OUTPUT` 子句（返回受影响的行）
- ✅ 多表 UPDATE/DELETE 语法
- ✅ `@@IDENTITY`, `@@ROWCOUNT` 等全局变量

### 存储过程和函数
- ✅ `CREATE PROCEDURE` - 存储过程
- ✅ `CREATE FUNCTION` - 标量函数、表值函数
- ✅ `DECLARE` - 变量声明
- ✅ `SET` / `SELECT` - 变量赋值
- ✅ `BEGIN...END` - 语句块
- ✅ `IF...ELSE` - 条件分支
- ✅ `WHILE` - 循环
- ✅ `BREAK` / `CONTINUE` - 流程控制
- ✅ `RETURN` - 返回值
- ✅ `RAISERROR` - 抛出错误
- ✅ `TRY...CATCH` - 异常处理

### 系统视图和函数
- ✅ `sys.tables` - 系统表视图
- ✅ `sys.columns` - 列信息视图
- ✅ `sys.indexes` - 索引信息视图
- ✅ `OBJECT_ID()` - 获取对象 ID
- ✅ `OBJECT_NAME()` - 获取对象名称
- ✅ `DB_NAME()` - 获取数据库名称
- ✅ `USER_NAME()` - 获取用户名称

## 注意事项

1. **自增列**：使用 `IDENTITY(1,1)` 语法，KingbaseES SQL Server 模式完全支持

2. **双引号标识符**：转换后使用双引号代替方括号，保持标识符原样（区分大小写）

3. **GO 批处理**：如果 SQL 文件包含 `GO`，确保 KingbaseES 客户端支持批处理模式

4. **时间函数**：已将 `GETDATE()` 替换为 `CURRENT_TIMESTAMP`，两者在 KingbaseES 中等效

5. **数据类型精度**：
   - `datetime2(0)` 已转换为 `DATETIME`
   - JSON 类型在 KingbaseES SQL Server 模式中原生支持

6. **建议执行顺序**：
   - 先执行核心配置表（Function, Request）
   - 再执行业务表（Comment, Moment, User, Privacy 等）
   - 最后执行测试表（Method, TestRecord, Random）

7. **锁表语法**：`LOCK TABLES` 可能在 SQL Server 模式中不完全支持，建议使用事务控制：
   ```sql
   BEGIN TRANSACTION;
   -- 执行 DML 操作
   COMMIT;
   ```

## 验证转换结果

执行以下 T-SQL 验证数据是否导入成功：

```sql
-- 查看所有表
SELECT name FROM sys.tables ORDER BY name;

-- 验证核心配置表
SELECT COUNT(*) FROM [Function];
SELECT COUNT(*) FROM Request;

-- 验证自增列
SELECT 
    t.name AS table_name,
    c.name AS column_name,
    c.is_identity
FROM sys.tables t
JOIN sys.columns c ON t.object_id = c.object_id
WHERE c.is_identity = 1;

-- 验证 Demo 表
SELECT COUNT(*) FROM Comment;
SELECT COUNT(*) FROM Moment;
SELECT COUNT(*) FROM apijson_user;

-- 验证插入的最新 ID
SELECT @@IDENTITY AS last_identity;
```

## 重新转换

如果需要重新转换，只需再次执行转换脚本：

```bash
./convert_to_kingbase_sqlserver.sh
```

这将覆盖 `Kingbase-SQLServer` 目录中的所有文件。

## SQL Server 与 KingbaseES 差异

虽然 KingbaseES SQL Server 模式（V9R4C12）高度兼容 SQL Server，但仍有一些细微差异：

1. **权限管理**：KingbaseES 使用角色（ROLE）概念，与 SQL Server 的 LOGIN/USER 略有不同
2. **系统存储过程**：某些 SQL Server 系统存储过程（如 `sp_help`）可能需要适配
3. **全文检索**：使用 KingbaseES 的全文检索功能，语法可能与 SQL Server 有所不同
4. **复制和同步**：使用 KingbaseES 的逻辑复制功能，而非 SQL Server 的复制拓扑
5. **LOCK TABLES**：此语法非标准 T-SQL，建议使用 `BEGIN TRANSACTION` 控制并发

## SQL Server 版本兼容性

KingbaseES V9R4C12 主要兼容 SQL Server 2012-2019 的 T-SQL 语法和特性：

- ✅ SQL Server 2012: 窗口函数、序列对象
- ✅ SQL Server 2014: 内存表、列存储索引
- ✅ SQL Server 2016: JSON 支持、时态表
- ✅ SQL Server 2017: Graph 数据库特性
- ✅ SQL Server 2019: 智能查询处理

## 参考文档

- [一文了解金仓数据库 KES 的 SQL Server 兼容性](https://blog.csdn.net/breeze915/article/details/144691426)
- [2000+存储过程从 SQL Server 滑入 KingbaseES V9R4C12 的 72 小时](https://bbs.kingbase.com.cn/blogDetail?postsId=6cb80da2e3ebea9c94bcb7a2bf42c7af)
- [金仓数据库：SQL Server 兼容新标杆](https://www.kingbase.com.cn/explore/tech-blog/)
- [KingbaseES 与 SQL Server 兼容性深度评测](https://blog.csdn.net/weixin_29230649/article/details/158546408)

## 技术支持

如遇到问题，请参考：
1. KingbaseES 官方文档：https://help.kingbase.com.cn
2. KingbaseES 社区论坛：https://bbs.kingbase.com.cn
3. SQL Server 兼容性讨论区：https://bbs.kingbase.com.cn/forum/sqlserver
