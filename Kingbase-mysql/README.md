# Kingbase MySQL 兼容模式 SQL 转换说明

## 概述

本项目已成功将 MySQL 目录下的所有 SQL 文件转换为 Kingbase-MySQL 兼容格式。转换后的文件保存在 `Kingbase` 目录中。

## 转换内容

### 转换的文件列表

共转换了 **24 个 SQL 文件**，包括：

#### 核心配置表
- `Kingbase/single/sys_Access.sql` - 权限配置表
- `Kingbase/single/sys_Function.sql` - 远程函数配置表
- `Kingbase/single/sys_Request.sql` - 请求参数校验配置表
- `Kingbase/single/sys_Document.sql` - 文档表

#### Demo 示例表
- `Kingbase/single/Demo/sys_Comment.sql` - 评论表
- `Kingbase/single/Demo/sys_Moment.sql` - 动态表
- `Kingbase/single/Demo/sys_Login.sql` - 登录表
- `Kingbase/single/Demo/sys_Verify.sql` - 验证表
- `Kingbase/single/Demo/sys_Praise.sql` - 点赞表
- `Kingbase/single/Demo/sys__Visit.sql` - 访问记录表
- `Kingbase/single/Demo/sys_apijson_user.sql` - 用户表
- `Kingbase/single/Demo/sys_apijson_privacy.sql` - 隐私表
- `Kingbase/single/Demo/sys_routines.sql` - 存储过程

#### 自动化测试相关表
- `Kingbase/single/Auto/sys_TestRecord.sql` - 测试记录表
- `Kingbase/single/Auto/sys_Chain.sql` - 链路表
- `Kingbase/single/Auto/sys_Script.sql` - 脚本表
- `Kingbase/single/Auto/sys_Random.sql` - 随机数据表

##### UnitAuto
- `Kingbase/single/Auto/UnitAuto/sys_Method.sql` - 方法测试表

##### UIGO
- `Kingbase/single/Auto/UIGO/sys_Device.sql` - 设备表
- `Kingbase/single/Auto/UIGO/sys_Flow.sql` - 流程表
- `Kingbase/single/Auto/UIGO/sys_Input.sql` - 输入表
- `Kingbase/single/Auto/UIGO/sys_Output.sql` - 输出表
- `Kingbase/single/Auto/UIGO/sys_System.sql` - 系统表

#### 完整数据库
- `Kingbase/sys.sql` - 完整的 sys 数据库导出文件

## 主要转换内容

根据 KingbaseES 的 MySQL 兼容模式，转换脚本执行了以下操作：

### 1. 移除 MySQL 特定注释
- 删除 MySQL dump 工具的注释（`-- MySQL dump`）
- 删除 MySQL 版本信息注释
- 移除 MySQL 特定的条件执行注释（`/*!40xxx */`, `/*!50xxx */`）

### 2. 字符集转换
- `utf8mb3` → `utf8`
- `utf8mb4` → `utf8`
- 保持 `DEFAULT CHARSET=utf8`

### 3. 保留兼容的语法
- ✅ `AUTO_INCREMENT` - Kingbase MySQL 模式支持
- ✅ `tinyint` 类型 - Kingbase MySQL 模式支持
- ✅ `bigint` 类型 - Kingbase MySQL 模式支持
- ✅ `varchar` 类型 - Kingbase MySQL 模式支持
- ✅ `timestamp` 类型 - Kingbase MySQL 模式支持（默认精度为 0）
- ✅ `json` 类型 - Kingbase MySQL 模式支持 JSON 类型
- ✅ `CURRENT_TIMESTAMP` - Kingbase MySQL 模式支持
- ✅ `ENGINE=InnoDB` - Kingbase MySQL 模式支持
- ✅ `LOCK TABLES` / `UNLOCK TABLES` - Kingbase MySQL 模式支持

### 4. 添加转换标识
每个转换后的文件开头都添加了以下信息：
```sql
-- Kingbase MySQL 兼容模式 SQL
-- 转换自: [原始文件路径]
-- 转换时间: [转换时间]
-- 使用方法: 在 Kingbase 数据库的 MySQL 兼容模式下执行
```

## 使用方法

### 前提条件

1. **确保 Kingbase 数据库已启用 MySQL 兼容模式**

   在创建数据库时指定兼容模式：
   ```sql
   CREATE DATABASE your_database WITH COMPATIBILITY_MODE = 'mysql';
   ```

2. **连接到 Kingbase 数据库**
   ```bash
   ksql -U username -d database -h hostname -p port
   ```

### 执行 SQL 文件

#### 方式一：执行单个表文件
```bash
ksql -U username -d database -f Kingbase/single/sys_Access.sql
```

#### 方式二：执行完整数据库
```bash
ksql -U username -d database -f Kingbase/sys.sql
```

#### 方式三：按模块执行
```bash
# 执行核心配置表
ksql -U username -d database -f Kingbase/single/sys_Access.sql
ksql -U username -d database -f Kingbase/single/sys_Function.sql
ksql -U username -d database -f Kingbase/single/sys_Request.sql

# 执行 Demo 表
for file in Kingbase/single/Demo/*.sql; do
  ksql -U username -d database -f "$file"
done

# 执行自动化测试表
for file in Kingbase/single/Auto/*.sql; do
  ksql -U username -d database -f "$file"
done
```

## Kingbase MySQL 兼容性说明

根据 KingbaseES 官方文档，MySQL 兼容模式支持以下特性：

### 数据类型兼容
- ✅ SIGNED/UNSIGNED 整数类型
- ✅ DATETIME 类型
- ✅ TIME 类型（范围 -838:59:59 到 838:59:59）
- ✅ TIMESTAMP 类型（默认精度 0）
- ✅ YEAR 类型
- ✅ BLOB 相关类型（TINYBLOB, MEDIUMBLOB, LONGBLOB）
- ✅ JSON 类型
- ✅ SET 类型

### 函数兼容
- ✅ 日期时间函数（CURDATE, CURTIME, NOW 等）
- ✅ 字符串函数（CONCAT, SUBSTRING 等）
- ✅ JSON 函数（通过 mysql_json 插件）
- ✅ 聚合函数（GROUP_CONCAT 等）

### 语法兼容
- ✅ CREATE TABLE 语法
- ✅ AUTO_INCREMENT
- ✅ ON UPDATE CURRENT_TIMESTAMP
- ✅ ENGINE=InnoDB
- ✅ LOCK TABLES / UNLOCK TABLES

## 注意事项

1. **字符集**：转换后统一使用 `utf8` 字符集，Kingbase MySQL 模式完全支持

2. **JSON 类型**：SQL 中使用了 `json` 类型，Kingbase MySQL 模式原生支持，无需修改

3. **时间戳默认值**：`DEFAULT CURRENT_TIMESTAMP` 在 Kingbase MySQL 模式下完全兼容

4. **自增主键**：`AUTO_INCREMENT` 在 Kingbase MySQL 模式下完全支持

5. **存储引擎**：`ENGINE=InnoDB` 语法保留，Kingbase 会使用其内部存储引擎

6. **建议执行顺序**：
   - 先执行核心配置表（Access, Function, Request）
   - 再执行业务表（Demo 目录下的表）
   - 最后执行自动化测试表（Auto 目录下的表）

## 验证转换结果

执行以下 SQL 验证数据是否导入成功：

```sql
-- 查看所有表
SHOW TABLES;

-- 验证核心配置表
SELECT COUNT(*) FROM Access;
SELECT COUNT(*) FROM Function;
SELECT COUNT(*) FROM Request;

-- 验证 Demo 表
SELECT COUNT(*) FROM Comment;
SELECT COUNT(*) FROM Moment;
SELECT COUNT(*) FROM apijson_user;
```

## 重新转换

如果需要重新转换，只需再次执行转换脚本：

```bash
./convert_to_kingbase.sh
```

这将覆盖 `Kingbase` 目录中的所有文件。

## 参考文档

- [KingbaseES MySQL 兼容模式索引](https://help.kingbase.com.cn/v8/development/sql-plsql/sql/MySQL_schema_index.html)
- [KingbaseES 与 MySQL 的兼容性说明](https://help.kingbase.com.cn/v8/PDF/KingbaseES%E4%B8%8EMySQL%E7%9A%84%E5%85%BC%E5%AE%B9%E6%80%A7%E8%AF%B4%E6%98%8E.pdf)

## 技术支持

如遇到问题，请参考：
1. KingbaseES 官方文档：https://help.kingbase.com.cn
2. KingbaseES 社区论坛：https://bbs.kingbase.com.cn
