-- ----------------------------
-- Table structure for Function
-- ----------------------------
DROP TABLE IF EXISTS "Function" CASCADE;
CREATE TABLE "Function" (
  "id" NUMBER(20) NOT NULL,
  "userId" NUMBER(20) NOT NULL,
  "name" NVARCHAR2(50) NOT NULL,
  "arguments" NVARCHAR2(100),
  "demo" CLOB NOT NULL,
  "detail" NVARCHAR2(1000) NOT NULL,
  "returnType" NVARCHAR2(50),
  "version" NUMBER(4) NOT NULL,
  "tag" NVARCHAR2(20),
  "methods" NVARCHAR2(50),
  "date" DATE NOT NULL,
  "back" NVARCHAR2(45)
)
;
COMMENT ON COLUMN "Function"."userId" IS '管理员用户Id';
COMMENT ON COLUMN "Function"."name" IS '方法名';
COMMENT ON COLUMN "Function"."arguments" IS '参数列表，每个参数的类型都是 String。
用 , 分割的字符串 比 [JSONArray] 更好，例如 array,item ，更直观，还方便拼接函数。';
COMMENT ON COLUMN "Function"."demo" IS '可用的示例。
TODO 改成 call，和返回值示例 back 对应。';
COMMENT ON COLUMN "Function"."detail" IS '详细描述';
COMMENT ON COLUMN "Function"."returnType" IS '返回值类型。TODO RemoteFunction 校验 returnType 和 back';
COMMENT ON COLUMN "Function"."version" IS '允许的最低版本号，只限于GET,HEAD外的操作方法。
TODO 使用 requestIdList 替代 version,tag,methods';
COMMENT ON COLUMN "Function"."tag" IS '允许的标签.
null - 允许全部
TODO 使用 requestIdList 替代 version,tag,methods';
COMMENT ON COLUMN "Function"."methods" IS '允许的操作方法。
null - 允许全部
TODO 使用 requestIdList 替代 version,tag,methods';
COMMENT ON COLUMN "Function"."date" IS '创建时间';
COMMENT ON COLUMN "Function"."back" IS '返回值示例';
COMMENT ON TABLE "Function" IS '远程函数。强制在启动时校验所有demo是否能正常运行通过';

-- ----------------------------
-- Records of Function
-- ----------------------------
INSERT INTO "Function" VALUES ('3', '0', 'countArray', 'array', '{"array": [1, 2, 3]}', '获取数组长度。没写调用键值对，会自动补全 "result()": "countArray(array)"', 'int', '0', NULL, NULL, TO_DATE('2018-10-13 16:23:23', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('4', '0', 'countObject', 'object', '{"object": {"key0": 1, "key1": 2}}', '获取对象长度。', 'int', '0', NULL, NULL, TO_DATE('2018-10-13 16:23:23', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('5', '0', 'isContain', 'array,value', '{"array": [1, 2, 3], "value": 2}', '判断是否数组包含值。', 'boolean', '0', NULL, NULL, TO_DATE('2018-10-13 16:23:23', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('6', '0', 'isContainKey', 'object,key', '{"key": "id", "object": {"id": 1}}', '判断是否对象包含键。', 'boolean', '0', NULL, NULL, TO_DATE('2018-10-13 16:30:31', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('7', '0', 'isContainValue', 'object,value', '{"value": 1, "object": {"id": 1}}', '判断是否对象包含值。', 'boolean', '0', NULL, NULL, TO_DATE('2018-10-13 16:30:31', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('8', '0', 'getFromArray', 'array,position', '{"array": [1, 2, 3], "result()": "getFromArray(array,1)"}', '根据下标获取数组里的值。position 传数字时直接作为值，而不是从所在对象 request 中取值', 'Object', '0', NULL, NULL, TO_DATE('2018-10-13 16:30:31', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('9', '0', 'getFromObject', 'object,key', '{"key": "id", "object": {"id": 1}}', '根据键获取对象里的值。', 'Object', '0', NULL, NULL, TO_DATE('2018-10-13 16:30:31', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('10', '0', 'deleteCommentOfMoment', 'momentId', '{"momentId": 1}', '根据动态 id 删除它的所有评论', 'int', '0', 'Moment', 'DELETE', TO_DATE('2019-08-18 02:46:56', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('11', '0', 'verifyIdList', 'array', '{"array": [1, 2, 3], "result()": "verifyIdList(array)"}', '校验类型为 id 列表', NULL, '0', NULL, NULL, TO_DATE('2019-08-18 03:58:33', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('12', '0', 'verifyURLList', 'array', '{"array": ["http://123.com/1.jpg", "http://123.com/a.png", "http://www.abc.com/test.gif"], "result()": "verifyURLList(array)"}', '校验类型为 URL 列表', NULL, '0', NULL, NULL, TO_DATE('2019-08-18 03:58:33', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('13', '0', 'getWithDefault', 'value,defaultValue', '{"value": null, "defaultValue": 1}', '如果 value 为 null，则返回 defaultValue', 'Object', '0', NULL, NULL, TO_DATE('2019-08-20 23:26:36', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('14', '0', 'removeKey', 'key', '{"key": "s", "key2": 2}', '从对象里移除 key', 'Object', '0', NULL, NULL, TO_DATE('2019-08-20 23:26:36', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('15', '0', 'getFunctionDemo', NULL, '{}', '获取远程函数的 Demo', 'JSONObject', '0', NULL, NULL, TO_DATE('2019-08-20 23:26:36', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Function" VALUES ('16', '0', 'getFunctionDetail', NULL, '{}', '获取远程函数的详情', 'String', '0', NULL, NULL, TO_DATE('2019-08-20 23:26:36', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
