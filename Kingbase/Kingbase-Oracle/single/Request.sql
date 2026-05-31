-- ----------------------------
-- Table structure for Request
-- ----------------------------
DROP TABLE IF EXISTS "Request" CASCADE;
CREATE TABLE "Request" (
  "id" NUMBER(20) NOT NULL,
  "version" NUMBER(4) NOT NULL,
  "method" NVARCHAR2(10),
  "tag" NVARCHAR2(20) NOT NULL,
  "structure" CLOB NOT NULL,
  "detail" NCLOB,
  "date" DATE
)
;
COMMENT ON COLUMN "Request"."id" IS '唯一标识';
COMMENT ON COLUMN "Request"."version" IS 'GET,HEAD可用任意结构访问任意开放内容，不需要这个字段。
其它的操作因为写入了结构和内容，所以都需要，按照不同的version选择对应的structure。

自动化版本管理：
Request JSON最外层可以传  “version”:Integer 。
1.未传或 <= 0，用最新版。 “@order”:”version-“
2.已传且 > 0，用version以上的可用版本的最低版本。 “@order”:”version+”, “version{}”:”>={version}”';
COMMENT ON COLUMN "Request"."method" IS '只限于GET,HEAD外的操作方法。';
COMMENT ON COLUMN "Request"."tag" IS '标签';
COMMENT ON COLUMN "Request"."structure" IS '结构。
TODO 里面的 PUT 改为 UPDATE，避免和请求 PUT 搞混。';
COMMENT ON COLUMN "Request"."detail" IS '详细说明';
COMMENT ON COLUMN "Request"."date" IS '创建日期';
COMMENT ON TABLE "Request" IS '请求参数校验配置(必须)。
最好编辑完后删除主键，这样就是只读状态，不能随意更改。需要更改就重新加上主键。

每次启动服务器时加载整个表到内存。
这个表不可省略，model内注解的权限只是客户端能用的，其它可以保证即便服务端代码错误时也不会误删数据。';

-- ----------------------------
-- Records of Request
-- ----------------------------
INSERT INTO "Request" VALUES ('1', '1', 'POST', 'register', '{"User": {"MUST": "name", "REFUSE": "id", "UPDATE": {"id@": "Privacy/id"}}, "Privacy": {"MUST": "_password,phone", "REFUSE": "id", "UNIQUE": "phone", "VERIFY": {"phone~": "PHONE"}}}', 'UNIQUE校验phone是否已存在。VERIFY校验phone是否符合手机号的格式', TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('2', '1', 'POST', 'Moment', '{"INSERT": {"@role": "OWNER", "pictureList": [], "praiseUserIdList": []}, "REFUSE": "id", "UPDATE": {"verifyIdList-()": "verifyIdList(praiseUserIdList)", "verifyURLList-()": "verifyURLList(pictureList)"}}', 'INSERT当没传pictureList和praiseUserIdList时用空数组[]补全，保证不会为null', TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('3', '1', 'POST', 'Comment', '{"MUST": "momentId,content", "REFUSE": "id", "UPDATE": {"@role": "OWNER"}}', '必须传userId,momentId,content，不允许传id', TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('4', '1', 'PUT', 'User', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "phone"}', '必须传id，不允许传phone。INSERT当没传@role时用OWNER补全', TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('5', '1', 'DELETE', 'Moment', '{"Moment": {"MUST": "id", "INSERT": {"@role": "OWNER"}, "UPDATE": {"commentCount()": "deleteCommentOfMoment(id)"}}}', NULL, TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('6', '1', 'DELETE', 'Comment', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "UPDATE": {"childCount()": "deleteChildComment(id)"}}', 'disallow没必要用于DELETE', TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('8', '1', 'PUT', 'User-phone', '{"User": {"MUST": "id,phone,_password", "INSERT": {"@role": "OWNER"}, "REFUSE": "!", "UPDATE": {"@combine": "_password"}}}', '! 表示其它所有，这里指necessary所有未包含的字段', TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('14', '1', 'POST', 'Verify', '{"MUST": "phone,verify", "REFUSE": "!"}', '必须传phone,verify，其它都不允许传', TO_DATE('2017-02-18 22:20:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('15', '1', 'GETS', 'Verify', '{"MUST": "phone"}', '必须传phone', TO_DATE('2017-02-18 22:20:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('16', '1', 'HEADS', 'Verify', '{}', '允许任意内容', TO_DATE('2017-02-18 22:20:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('17', '1', 'PUT', 'Moment', '{"MUST": "id", "REFUSE": "userId,date", "UPDATE": {"verifyIdList-()": "verifyIdList(praiseUserIdList)", "verifyURLList-()": "verifyURLList(pictureList)"}}', NULL, TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('21', '1', 'HEADS', 'Login', '{"MUST": "userId,type", "REFUSE": "!"}', NULL, TO_DATE('2017-02-18 22:20:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('22', '1', 'GETS', 'User', '{}', '允许传任何内容，除了表对象', TO_DATE('2017-02-18 22:20:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('23', '1', 'PUT', 'Privacy', '{"MUST": "id", "INSERT": {"@role": "OWNER"}}', 'INSERT当没传@role时用OWNER补全', TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('25', '1', 'PUT', 'Praise', '{"MUST": "id"}', '必须传id', TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('26', '1', 'DELETE', 'Comment[]', '{"Comment": {"MUST": "id{}", "INSERT": {"@role": "OWNER"}}}', 'DISALLOW没必要用于DELETE', TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('27', '1', 'PUT', 'Comment[]', '{"Comment": {"MUST": "id{}", "INSERT": {"@role": "OWNER"}}}', 'DISALLOW没必要用于DELETE', TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('28', '1', 'PUT', 'Comment', '{"MUST": "id", "INSERT": {"@role": "OWNER"}}', '这里省略了Comment，因为tag就是Comment，Parser.getCorrectRequest会自动补全', TO_DATE('2017-02-01 19:19:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('29', '1', 'GETS', 'login', '{"Privacy": {"MUST": "phone,_password", "REFUSE": "id"}}', NULL, TO_DATE('2017-10-15 18:04:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('30', '1', 'PUT', 'balance+', '{"Privacy": {"MUST": "id,balance+", "REFUSE": "!", "VERIFY": {"balance+&{}": ">=1,<=100000"}}}', '验证balance+对应的值是否满足>=1且<=100000', TO_DATE('2017-10-21 16:48:34', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('31', '1', 'PUT', 'balance-', '{"Privacy": {"MUST": "id,balance-,_password", "REFUSE": "!", "UPDATE": {"@combine": "_password"}, "VERIFY": {"balance-&{}": ">=1,<=10000"}}}', 'UPDATE强制把_password作为WHERE条件', TO_DATE('2017-10-21 16:48:34', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('32', '2', 'GETS', 'Privacy', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "_password,_payPassword"}', NULL, TO_DATE('2017-06-13 00:05:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('33', '2', 'GETS', 'Privacy-CIRCLE', '{"Privacy": {"MUST": "id", "REFUSE": "!", "UPDATE": {"@role": "CIRCLE", "@column": "phone"}}}', NULL, TO_DATE('2017-06-13 00:05:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('35', '2', 'POST', 'Document', '{"Document": {"MUST": "name,url,request", "INSERT": {"@role": "OWNER"}, "REFUSE": "id"}, "TestRecord": {"MUST": "response", "INSERT": {"@role": "OWNER"}, "REFUSE": "id,documentId", "UPDATE": {"documentId@": "Document/id"}}}', NULL, TO_DATE('2017-11-26 16:34:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('36', '2', 'PUT', 'Document', '{"MUST": "id", "REFUSE": "userId"}', NULL, TO_DATE('2017-11-26 16:35:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('37', '2', 'DELETE', 'Document', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "!", "UPDATE": {"Random": {"@role": "OWNER", "documentId@": "Method/id"}, "TestRecord": {"@role": "OWNER", "documentId@": "Document/id"}}}', NULL, TO_DATE('2017-11-26 08:36:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('38', '2', 'POST', 'TestRecord', '{"MUST": "documentId,response", "INSERT": {"@role": "OWNER"}, "REFUSE": "id"}', NULL, TO_DATE('2018-06-17 07:44:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('39', '2', 'POST', 'Method', '{"Method": {"MUST": "method,class,package", "INSERT": {"@role": "OWNER"}, "REFUSE": "id"}, "TestRecord": {"MUST": "response", "INSERT": {"@role": "OWNER"}, "REFUSE": "id,documentId", "UPDATE": {"documentId@": "Method/id"}}}', NULL, TO_DATE('2017-11-26 08:34:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('40', '2', 'PUT', 'Method', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "userId"}', NULL, TO_DATE('2017-11-26 08:35:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('41', '2', 'DELETE', 'Method', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "!", "UPDATE": {"Random": {"@role": "OWNER", "documentId@": "Method/id"}, "TestRecord": {"@role": "OWNER", "documentId@": "Method/id"}}}', NULL, TO_DATE('2017-11-26 00:36:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('42', '2', 'POST', 'Random', '{"INSERT": {"@role": "OWNER"}, "Random": {"MUST": "documentId,name,config"}, "TestRecord": {"UPDATE": {"randomId@": "/Random/id", "documentId@": "/Random/documentId"}}}', NULL, TO_DATE('2017-11-26 08:34:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('43', '2', 'PUT', 'Random', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "userId"}', NULL, TO_DATE('2017-11-26 08:35:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('44', '2', 'DELETE', 'Random', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "UPDATE": {"TestRecord": {"@role": "OWNER", "randomId@": "/id"}}}', NULL, TO_DATE('2017-11-26 00:36:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('45', '2', 'POST', 'Comment:[]', '{"TYPE": {"Comment[]": "OBJECT[]"}, "INSERT": {"@role": "OWNER"}, "Comment[]": []}', NULL, TO_DATE('2020-03-01 13:40:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('46', '2', 'POST', 'Moment:[]', '{"INSERT": {"@role": "OWNER"}, "Moment[]": []}', NULL, TO_DATE('2020-03-01 13:41:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('47', '2', 'PUT', 'Comment:[]', '{"INSERT": {"@role": "OWNER"}, "Comment[]": []}', NULL, TO_DATE('2020-03-01 13:40:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('48', '2', 'DELETE', 'TestRecord', '{"MUST": "id", "INSERT": {"@role": "OWNER"}}', NULL, TO_DATE('2017-11-26 00:36:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('49', '2', 'POST', 'Input', '{"MUST": "deviceId,x,y", "INSERT": {"@role": "OWNER"}, "REFUSE": "id"}', NULL, TO_DATE('2017-11-26 08:34:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('50', '2', 'POST', 'Device', '{"MUST": "brand,model", "INSERT": {"@role": "OWNER"}, "REFUSE": "id"}', NULL, TO_DATE('2017-11-26 08:34:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('51', '2', 'POST', 'System', '{"MUST": "type,versionCode,versionName", "INSERT": {"@role": "OWNER"}, "REFUSE": "id"}', NULL, TO_DATE('2017-11-26 08:34:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('52', '2', 'POST', 'Flow', '{"MUST": "deviceId,systemId,name", "INSERT": {"@role": "OWNER"}, "REFUSE": "id"}', NULL, TO_DATE('2017-11-26 08:34:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('53', '4', 'GETS', 'Privacy', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "!"}', NULL, TO_DATE('2017-06-13 00:05:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('54', '2', 'POST', 'Output', '{"MUST": "inputId", "INSERT": {"@role": "OWNER"}, "REFUSE": "id"}', NULL, TO_DATE('2018-06-17 07:44:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Request" VALUES ('55', '2', 'DELETE', 'Output', '{"MUST": "id", "INSERT": {"@role": "OWNER"}}', NULL, TO_DATE('2017-11-26 00:36:20', 'SYYYY-MM-DD HH24:MI:SS'));
