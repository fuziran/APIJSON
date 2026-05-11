-- Kingbase Oracle 兼容模式 SQL
-- 转换自: Oracle/single/sys_TestRecord.sql
-- 转换时间: 2026-05-11 10:50:30
-- 使用方法: 在 Kingbase 数据库的 Oracle 兼容模式下执行
-- 注意: 请确保数据库已创建为 Oracle 兼容模式

--


--
--

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE TestRecord';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE TestRecord (
  id NUMBER(19) NOT NULL ,
  userId NUMBER(19) NOT NULL ,
  testAccountId NUMBER(19) DEFAULT '0' NOT NULL,
  documentId NUMBER(19) NOT NULL ,
  randomId NUMBER(19) DEFAULT '0' NOT NULL ,
  host VARCHAR2(1000) DEFAULT NULL,
  date TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP NOT NULL ,
  duration NUMBER(19) DEFAULT NULL ,
  minDuration NUMBER(19) DEFAULT NULL ,
  maxDuration NUMBER(19) DEFAULT NULL ,
  response clob NOT NULL ,
  compare clob ,
  standard clob ,
  PRIMARY KEY (id)
)  ;

COMMENT ON TABLE TestRecord IS '测试记录(必须)n主要用于保存自动化接口回归测试。5.0.0 可能改为 Test(先废弃 Test 表) '

--
--




