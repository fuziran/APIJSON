# Kingbase Oracle 兼容模式 SQL 转换说明

## 概述

本项目已成功将 Oracle 目录下的所有 SQL 文件转换为 Kingbase-Oracle 兼容格式。转换后的文件保存在 `Kingbase-Oracle` 目录中。

## 转换内容

### 转换的文件列表

共转换了 **14 个 SQL 文件**，包括：

#### 核心配置表
- `Kingbase-Oracle/single/sys_Access.sql` - 权限配置表
- `Kingbase-Oracle/single/sys_Function.sql` - 远程函数配置表
- `Kingbase-Oracle/single/sys_Request.sql` - 请求参数校验配置表
- `Kingbase-Oracle/single/sys_Document.sql` - 文档表

#### Demo 示例表
- `Kingbase-Oracle/single/sys_Comment.sql` - 评论表
- `Kingbase-Oracle/single/sys_Moment.sql` - 动态表
- `Kingbase-Oracle/single/sys_Verify.sql` - 验证表
- `Kingbase-Oracle/single/sys_apijson_user.sql` - 用户表
- `Kingbase-Oracle/single/sys_apijson_privacy.sql` - 隐私表

#### 自动化测试相关表
- `Kingbase-Oracle/single/sys_TestRecord.sql` - 测试记录表
- `Kingbase-Oracle/single/sys_Method.sql` - 方法测试表
- `Kingbase-Oracle/single/sys_Random.sql` - 随机数据表

#### 完整数据库
- `Kingbase-Oracle/sys.sql` - 数据库初始化脚本
- `Kingbase-Oracle/初始化.sql` - 完整的数据库初始化文件

## 主要转换内容

根据 KingbaseES 的 Oracle 兼容模式，转换脚本执行了以下操作：

### 1. 清理转换工具标记
- 删除 `-- SQLINES DEMO` 注释
- 删除 `/* SQLINES DEMO */` 注释
- 移除 `-- SQLINES LICENSE FOR EVALUATION USE ONLY` 标记

### 2. 数据类型统一
- `number(19)` → `NUMBER(19)` （统一大写）
- `number(3)` → `NUMBER(3)`
- `varchar2` → `VARCHAR2` （统一大写）
- `timestamp(0)` → `TIMESTAMP(0)` （统一大写）

### 3. 时间戳函数替换
- `SYSTIMESTAMP` → `CURRENT_TIMESTAMP`

### 4. 保留的 Oracle 语法特性
KingbaseES Oracle 模式完全兼容以下 Oracle 语法：

#### 数据类型
- ✅ `NUMBER(precision, scale)` - 数值类型
- ✅ `VARCHAR2(length)` - 变长字符串
- ✅ `TIMESTAMP(precision)` - 时间戳类型
- ✅ `CLOB` - 大文本对象
- ✅ `BLOB` - 大二进制对象

#### DDL 语法
- ✅ `DROP TABLE` 与 `BEGIN...EXCEPTION...END` 块
- ✅ `CREATE TABLE` 标准语法
- ✅ `CONSTRAINT` 约束定义
- ✅ `COMMENT ON TABLE/COLUMN` - 表/列注释

#### 自增 ID 实现（Sequence + Trigger）
```sql
CREATE SEQUENCE table_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER table_seq_tr
 BEFORE INSERT ON table_name FOR EACH ROW
 WHEN (NEW.id IS NULL)
BEGIN
 SELECT table_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/
```

#### DML 语法
- ✅ `INSERT INTO ... SELECT ... FROM dual UNION ALL ...`
- ✅ `LOCK TABLES` / `UNLOCK TABLES`
- ✅ `UPDATE` / `DELETE` 标准语法

#### PL/SQL 特性
- ✅ `BEGIN...END` 块
- ✅ `EXECUTE IMMEDIATE` - 动态 SQL
- ✅ `EXCEPTION` - 异常处理
- ✅ `FOR EACH ROW` - 行级触发器
- ✅ `WHEN` 条件
- ✅ `:NEW` / `:OLD` - 触发器变量

## 使用方法

### 前提条件

1. **创建 Kingbase Oracle 兼容模式数据库**

   ```sql
   CREATE DATABASE your_database WITH COMPATIBILITY_MODE = 'oracle';
   ```

   或使用 `initdb` 命令创建：
   ```bash
   initdb -D /path/to/data --db-mode=oracle
   ```

2. **连接到 Kingbase 数据库**
   ```bash
   ksql -U username -d database
   ```

### 执行 SQL 文件

#### 方式一：在 ksql 客户端中执行
```sql
-- 连接数据库
ksql -U username -d database

-- 执行单个表
@Kingbase-Oracle/single/sys_Access.sql

-- 或执行完整初始化
@Kingbase-Oracle/初始化.sql
```

#### 方式二：使用命令行执行
```bash
# 执行单个表文件
ksql -U username -d database -f Kingbase-Oracle/single/sys_Access.sql

# 执行完整初始化
ksql -U username -d database -f Kingbase-Oracle/初始化.sql
```

#### 方式三：按模块执行
```bash
# 执行核心配置表
ksql -U username -d database -f Kingbase-Oracle/single/sys_Access.sql
ksql -U username -d database -f Kingbase-Oracle/single/sys_Function.sql
ksql -U username -d database -f Kingbase-Oracle/single/sys_Request.sql

# 执行 Demo 表
for file in Kingbase-Oracle/single/sys_Comment.sql \
            Kingbase-Oracle/single/sys_Moment.sql \
            Kingbase-Oracle/single/sys_apijson_user.sql \
            Kingbase-Oracle/single/sys_apijson_privacy.sql; do
  ksql -U username -d database -f "$file"
done

# 执行测试表
ksql -U username -d database -f Kingbase-Oracle/single/sys_Method.sql
ksql -U username -d database -f Kingbase-Oracle/single/sys_TestRecord.sql
ksql -U username -d database -f Kingbase-Oracle/single/sys_Random.sql
```

## Kingbase Oracle 兼容性说明

根据 KingbaseES 官方文档，Oracle 兼容模式支持以下特性：

### 数据类型兼容
- ✅ NUMBER 类型（支持 precision 和 scale）
- ✅ VARCHAR2 类型
- ✅ CHAR 类型
- ✅ DATE 类型
- ✅ TIMESTAMP 类型（支持时区）
- ✅ CLOB / BLOB 大对象类型
- ✅ RAW / LONG RAW 二进制类型

### SQL 语法兼容
- ✅ FROM DUAL 虚拟表
- ✅ DECODE 函数
- ✅ NVL / NVL2 函数
- ✅ TO_CHAR / TO_DATE / TO_NUMBER 转换函数
- ✅ CONNECT BY 层次查询
- ✅ ROWNUM 伪列
- ✅ (+) 外连接语法

### PL/SQL 兼容
- ✅ 存储过程（PROCEDURE）
- ✅ 函数（FUNCTION）
- ✅ 包（PACKAGE）
- ✅ 触发器（TRIGGER）
- ✅ 异常处理（EXCEPTION）
- ✅ 游标（CURSOR）
- ✅ 记录类型（RECORD）
- ✅ %TYPE / %ROWTYPE 属性

### 对象管理兼容
- ✅ SEQUENCE 序列对象
- ✅ SYNONYM 同义词
- ✅ VIEW 视图
- ✅ INDEX 索引
- ✅ TABLESPACE 表空间

## 注意事项

1. **序列和触发器**：转换后的 SQL 使用 Oracle 标准的 SEQUENCE + TRIGGER 方式实现自增 ID

2. **FROM DUAL**：Oracle 特有的虚拟表语法，KingbaseES Oracle 模式完全支持

3. **PL/SQL 块**：使用 `BEGIN...EXCEPTION...END;` 块，以 `/` 结束

4. **时间戳函数**：已将 `SYSTIMESTAMP` 替换为标准的 `CURRENT_TIMESTAMP`

5. **大小写敏感**：Oracle 模式下，未加双引号的标识符会自动转为大写

6. **建议执行顺序**：
   - 先执行核心配置表（Access, Function, Request）
   - 再执行业务表（Comment, Moment, User, Privacy 等）
   - 最后执行测试表（Method, TestRecord, Random）

## 验证转换结果

执行以下 SQL 验证数据是否导入成功：

```sql
-- 查看所有表
SELECT table_name FROM user_tables;

-- 验证核心配置表
SELECT COUNT(*) FROM Access;
SELECT COUNT(*) FROM Function;
SELECT COUNT(*) FROM Request;

-- 验证序列
SELECT sequence_name, last_number FROM user_sequences;

-- 验证触发器
SELECT trigger_name, table_name, status FROM user_triggers;

-- 验证 Demo 表
SELECT COUNT(*) FROM Comment;
SELECT COUNT(*) FROM Moment;
SELECT COUNT(*) FROM apijson_user;
```

## 重新转换

如果需要重新转换，只需再次执行转换脚本：

```bash
./convert_to_kingbase_oracle.sh
```

这将覆盖 `Kingbase-Oracle` 目录中的所有文件。

## Oracle 与 KingbaseES 差异

虽然 KingbaseES Oracle 模式高度兼容 Oracle，但仍有一些细微差异：

1. **权限管理**：KingbaseES 使用 PostgreSQL 风格的角色和权限体系
2. **部分系统视图**：某些 Oracle 系统视图在 KingbaseES 中可能有不同的实现
3. **高级特性**：如 RAC、Data Guard 等企业级特性需要使用 KingbaseES 对应功能

## 参考文档

- [KingbaseES 与 Oracle 的兼容性说明](https://help.kingbase.com.cn/v8.6.7.24/PDF/KingbaseES%E4%B8%8EOracle%E7%9A%84%E5%85%BC%E5%AE%B9%E6%80%A7%E8%AF%B4%E6%98%8E.pdf)
- [KingbaseES V8R3 和 V8R6 兼容性](https://bbs.kingbase.com.cn/kingbase-doc/v8/development/develop-transfer/transplant-r3/transplant-r3-1.html)
- [KingbaseES Oracle 模式文档](https://help.kingbase.com.cn/v8/development/)

## 技术支持

如遇到问题，请参考：
1. KingbaseES 官方文档：https://help.kingbase.com.cn
2. KingbaseES 社区论坛：https://bbs.kingbase.com.cn
3. Oracle 兼容性讨论区：https://bbs.kingbase.com.cn/forum/oracle
