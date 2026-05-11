-- Kingbase Oracle 兼容模式 SQL
-- 转换自: Oracle/single/sys_Function.sql
-- 转换时间: 2026-05-11 10:50:30
-- 使用方法: 在 Kingbase 数据库的 Oracle 兼容模式下执行
-- 注意: 请确保数据库已创建为 Oracle 兼容模式

--


--
--

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Function';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE Function (
  id NUMBER(19) NOT NULL,
  userId NUMBER(19) NOT NULL ,
  name VARCHAR2(50) NOT NULL ,
  arguments VARCHAR2(100) DEFAULT NULL ,
  demo json NOT NULL ,
  detail VARCHAR2(1000) NOT NULL ,
  type VARCHAR2(50) DEFAULT 'Object' NOT NULL ,
  version NUMBER(3) DEFAULT '0' NOT NULL ,
  tag VARCHAR2(20) DEFAULT NULL ,
  methods VARCHAR2(50) DEFAULT NULL ,
  date TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP NOT NULL ,
  back VARCHAR2(45) DEFAULT NULL ,
  PRIMARY KEY (id)
)   ;

COMMENT ON TABLE Function IS '远程函数。强制在启动时校验所有demo是否能正常运行通过'

-- Generate ID using sequence and trigger
CREATE SEQUENCE Function_seq START WITH 17 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER Function_seq_tr
 BEFORE INSERT ON Function FOR EACH ROW
 WHEN (NEW.id IS NULL)
BEGIN
 SELECT Function_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

--
--

LOCK TABLES Function WRITE;
INSERT INTO Function  SELECT 3,0,'countArray','array','{"array": [1, 2, 3]}','获取数组长度。没写调用键值对，会自动补全 "result()": "countArray(array)"','Object',0,NULL,NULL,'2018-10-13 08:23:23',NULL FROM dual UNION ALL  SELECT 4,0,'countObject','object','{"object": {"key0": 1, "key1": 2}}','获取对象长度。','Object',0,NULL,NULL,'2018-10-13 08:23:23',NULL FROM dual UNION ALL  SELECT 5,0,'isContain','array,value','{"array": [1, 2, 3], "value": 2}','判断是否数组包含值。','Object',0,NULL,NULL,'2018-10-13 08:23:23',NULL FROM dual UNION ALL  SELECT 6,0,'isContainKey','object,key','{"key": "id", "object": {"id": 1}}','判断是否对象包含键。','Object',0,NULL,NULL,'2018-10-13 08:30:31',NULL FROM dual UNION ALL  SELECT 7,0,'isContainValue','object,value','{"value": 1, "object": {"id": 1}}','判断是否对象包含值。','Object',0,NULL,NULL,'2018-10-13 08:30:31',NULL FROM dual UNION ALL  SELECT 8,0,'getFromArray','array,position','{"array": [1, 2, 3], "result()": "getFromArray(array,1)"}','根据下标获取数组里的值。position 传数字时直接作为值，而不是从所在对象 request 中取值','Object',0,NULL,NULL,'2018-10-13 08:30:31',NULL FROM dual UNION ALL  SELECT 9,0,'getFromObject','object,key','{"key": "id", "object": {"id": 1}}','根据键获取对象里的值。','Object',0,NULL,NULL,'2018-10-13 08:30:31',NULL FROM dual UNION ALL  SELECT 10,0,'deleteCommentOfMoment','momentId','{"momentId": 1}','根据动态 id 删除它的所有评论','Object',0,'Moment','DELETE','2019-08-17 18:46:56',NULL FROM dual UNION ALL  SELECT 11,0,'verifyIdList','array','{"array": [1, 2, 3], "result()": "verifyIdList(array)"}','校验类型为 id 列表','Object',0,NULL,NULL,'2019-08-17 19:58:33',NULL FROM dual UNION ALL  SELECT 12,0,'verifyURLList','array','{"array": ["http://123.com/1.jpg", "http://123.com/a.png", "http://www.abc.com/test.gif"], "result()": "verifyURLList(array)"}','校验类型为 URL 列表','Object',0,NULL,NULL,'2019-08-17 19:58:33',NULL FROM dual UNION ALL  SELECT 13,0,'getWithDefault','value,defaultValue','{"value": null, "defaultValue": 1}','如果 value 为 null，则返回 defaultValue','Object',0,NULL,NULL,'2019-08-20 15:26:36',NULL FROM dual UNION ALL  SELECT 14,0,'removeKey','key','{"key": "s", "key2": 2}','从对象里移除 key','Object',0,NULL,NULL,'2019-08-20 15:26:36',NULL FROM dual UNION ALL  SELECT 15,0,'getFunctionDemo',NULL,'{}','获取远程函数的 Demo','Object',0,NULL,NULL,'2019-08-20 15:26:36',NULL FROM dual UNION ALL  SELECT 16,0,'getFunctionDetail',NULL,'{}','获取远程函数的详情','Object',0,NULL,NULL,'2019-08-20 15:26:36',NULL FROM dual;
UNLOCK TABLES;


