-- Kingbase SQL Server 兼容模式 SQL
-- 转换自: SQLServer/single/sys_TestRecord.sql
-- 转换时间: 2026-05-11 10:50:57
-- 使用方法: 在 Kingbase 数据库的 SQL Server 兼容模式下执行
-- 注意: 请确保数据库已创建为 SQL Server 兼容模式

--


--
--

DROP TABLE IF EXISTS "TestRecord";
CREATE TABLE TestRecord (
  "id" bigint NOT NULL ,
  "userId" bigint NOT NULL ,
  "testAccountId" bigint NOT NULL DEFAULT '0',
  "documentId" bigint NOT NULL ,
  "randomId" bigint NOT NULL DEFAULT '0' ,
  "host" varchar(1000) DEFAULT NULL,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  "duration" bigint DEFAULT NULL ,
  "minDuration" bigint DEFAULT NULL ,
  "maxDuration" bigint DEFAULT NULL ,
  "response" varchar(max) NOT NULL ,
  "compare" varchar(max) ,
  "standard" varchar(max) ,
  PRIMARY KEY ("id")
)  ;

--
--




