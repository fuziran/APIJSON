-- Kingbase SQL Server 兼容模式 SQL
-- 转换自: SQLServer/single/sys_Function.sql
-- 转换时间: 2026-05-11 10:50:57
-- 使用方法: 在 Kingbase 数据库的 SQL Server 兼容模式下执行
-- 注意: 请确保数据库已创建为 SQL Server 兼容模式

--


--
--

DROP TABLE IF EXISTS "Function";
CREATE TABLE "Function" (
  "id" bigint NOT NULL,
  "userId" bigint NOT NULL ,
  "name" varchar(50) NOT NULL ,
  "arguments" varchar(100) DEFAULT NULL ,
  "demo" TEXT NOT NULL ,
  "detail" varchar(1000) NOT NULL ,
  "type" varchar(50) NOT NULL DEFAULT 'Object' ,
  "version" smallint NOT NULL DEFAULT '0' ,
  "tag" varchar(20) DEFAULT NULL ,
  "methods" varchar(50) DEFAULT NULL ,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  "back" varchar(45) DEFAULT NULL ,
  PRIMARY KEY ("id")
)   ;

--
--

INSERT INTO "Function" VALUES (3,0,'countArray','array','{"array": "1, 2, 3"}','获取数组长度。没写调用键值对，会自动补全 "result()": "countArray(array)"','Object',0,NULL,NULL,'2018-10-13 08:23:23',NULL),(4,0,'countObject','object','{"object": {"key0": 1, "key1": 2}}','获取对象长度。','Object',0,NULL,NULL,'2018-10-13 08:23:23',NULL),(5,0,'isContain','array,value','{"array": "1, 2, 3", "value": 2}','判断是否数组包含值。','Object',0,NULL,NULL,'2018-10-13 08:23:23',NULL),(6,0,'isContainKey','object,key','{"key": "id", "object": {"id": 1}}','判断是否对象包含键。','Object',0,NULL,NULL,'2018-10-13 08:30:31',NULL),(7,0,'isContainValue','object,value','{"value": 1, "object": {"id": 1}}','判断是否对象包含值。','Object',0,NULL,NULL,'2018-10-13 08:30:31',NULL),(8,0,'getFromArray','array,position','{"array": "1, 2, 3", "result()": "getFromArray(array,1)"}','根据下标获取数组里的值。position 传数字时直接作为值，而不是从所在对象 request 中取值','Object',0,NULL,NULL,'2018-10-13 08:30:31',NULL),(9,0,'getFromObject','object,key','{"key": "id", "object": {"id": 1}}','根据键获取对象里的值。','Object',0,NULL,NULL,'2018-10-13 08:30:31',NULL),(10,0,'deleteCommentOfMoment','momentId','{"momentId": 1}','根据动态 id 删除它的所有评论','Object',0,'Moment','DELETE','2019-08-17 18:46:56',NULL),(11,0,'verifyIdList','array','{"array": "1, 2, 3", "result()": "verifyIdList(array)"}','校验类型为 id 列表','Object',0,NULL,NULL,'2019-08-17 19:58:33',NULL),(12,0,'verifyURLList','array','{"array": ""http://123.com/1.jpg", "http://123.com/a.png", "http://www.abc.com/test.gif"", "result()": "verifyURLList(array)"}','校验类型为 URL 列表','Object',0,NULL,NULL,'2019-08-17 19:58:33',NULL),(13,0,'getWithDefault','value,defaultValue','{"value": null, "defaultValue": 1}','如果 value 为 null，则返回 defaultValue','Object',0,NULL,NULL,'2019-08-20 15:26:36',NULL),(14,0,'removeKey','key','{"key": "s", "key2": 2}','从对象里移除 key','Object',0,NULL,NULL,'2019-08-20 15:26:36',NULL),(15,0,'getFunctionDemo',NULL,'{}','获取远程函数的 Demo','Object',0,NULL,NULL,'2019-08-20 15:26:36',NULL),(16,0,'getFunctionDetail',NULL,'{}','获取远程函数的详情','Object',0,NULL,NULL,'2019-08-20 15:26:36',NULL);

-- Auto-filled INSERT data from Kingbase MySQL/Oracle sources.

INSERT INTO "Function" ("id", "userId", "name", "arguments", "demo", "detail", "version", "tag", "methods", "date") VALUES (17, 0, 'getMethodArguments', 'methodArgs', '{"methodArgs": "methodArgs"}', '获取远程函数的参数', 0, NULL, NULL, '2021-07-29 09:32:22');
INSERT INTO "Function" ("id", "userId", "name", "arguments", "demo", "detail", "version", "tag", "methods", "date") VALUES (18, 0, 'getMethodDefinition', 'method,arguments,type,exceptions,language', '{"method": "method"}', '获取远程函数的签名定义', 0, NULL, NULL, '2021-07-29 09:34:37');
INSERT INTO "Function" ("id", "userId", "name", "arguments", "demo", "detail", "version", "tag", "methods", "date") VALUES (19, 0, 'getMethodRequest', NULL, '{}', '获取远程函数的请求', 0, NULL, NULL, '2021-07-29 09:35:37');
INSERT INTO "Function" ("id", "userId", "name", "arguments", "demo", "detail", "version", "tag", "methods", "date") VALUES (20, 0, 'deleteChildComment', 'commentId', '{}', '删除评论的子评论', 0, NULL, NULL, '2021-09-10 06:53:24');
INSERT INTO "Function" ("id", "userId", "name", "arguments", "demo", "detail", "version", "tag", "methods", "date") VALUES (21, 0, 'getCurrentUserId', NULL, '{}', '获取当前登录用户 id', 0, NULL, NULL, '2022-02-19 17:27:41');
INSERT INTO "Function" ("id", "userId", "name", "arguments", "demo", "detail", "version", "tag", "methods", "date") VALUES (22, 0, 'getCurrentUserIdAsList', NULL, '{}', '获取当前登录用户 id 列表，只包含一个 id，只是为了前端方便构造某些请求', 0, NULL, NULL, '2022-02-19 17:27:41');
INSERT INTO "Function" ("id", "userId", "name", "arguments", "demo", "detail", "version", "tag", "methods", "date") VALUES (24, 0, 'getCurrentUser', NULL, '{}', '获取当前登录用户公开信息', 0, NULL, NULL, '2022-02-19 17:34:58');
INSERT INTO "Function" ("id", "userId", "name", "arguments", "demo", "detail", "version", "tag", "methods", "date") VALUES (26, 0, 'getCurrentContactIdList', NULL, '{}', '获取当前登录用户的联系人 id 列表', 0, NULL, NULL, '2022-02-19 17:37:35');
