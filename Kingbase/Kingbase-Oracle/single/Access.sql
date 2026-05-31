-- ----------------------------
-- Table structure for Access
-- ----------------------------
DROP TABLE IF EXISTS "Access" CASCADE;
CREATE TABLE "Access" (
  "id" NUMBER(20) NOT NULL,
  "debug" NUMBER(4) NOT NULL,
  "name" NVARCHAR2(50) NOT NULL,
  "alias" NVARCHAR2(20),
  "get" NVARCHAR2(100) NOT NULL,
  "head" NVARCHAR2(100) NOT NULL,
  "gets" NVARCHAR2(100) NOT NULL,
  "heads" NVARCHAR2(100) NOT NULL,
  "post" NVARCHAR2(100) NOT NULL,
  "put" NVARCHAR2(100) NOT NULL,
  "delete" NVARCHAR2(100) NOT NULL,
  "date" DATE NOT NULL,
  "detail" NVARCHAR2(1000)
)
;
COMMENT ON COLUMN "Access"."debug" IS '是否为调试表，只允许在开发环境使用，测试和线上环境禁用';
COMMENT ON COLUMN "Access"."name" IS '实际表名，例如 apijson_user';
COMMENT ON COLUMN "Access"."alias" IS '外部调用的表别名，例如 User';
COMMENT ON COLUMN "Access"."get" IS '允许 get 的角色列表，例如 ["LOGIN", "CONTACT", "CIRCLE", "OWNER"]
用 JSON 类型不能设置默认值，反正权限对应的需求是明确的，也不需要自动转 JSONArray。
TODO: 直接 LOGIN,CONTACT,CIRCLE,OWNER 更简单，反正是开发内部用，不需要复杂查询。';
COMMENT ON COLUMN "Access"."head" IS '允许 head 的角色列表，例如 ["LOGIN", "CONTACT", "CIRCLE", "OWNER"]';
COMMENT ON COLUMN "Access"."gets" IS '允许 gets 的角色列表，例如 ["LOGIN", "CONTACT", "CIRCLE", "OWNER"]';
COMMENT ON COLUMN "Access"."heads" IS '允许 heads 的角色列表，例如 ["LOGIN", "CONTACT", "CIRCLE", "OWNER"]';
COMMENT ON COLUMN "Access"."post" IS '允许 post 的角色列表，例如 ["LOGIN", "CONTACT", "CIRCLE", "OWNER"]';
COMMENT ON COLUMN "Access"."put" IS '允许 put 的角色列表，例如 ["LOGIN", "CONTACT", "CIRCLE", "OWNER"]';
COMMENT ON COLUMN "Access"."delete" IS '允许 delete 的角色列表，例如 ["LOGIN", "CONTACT", "CIRCLE", "OWNER"]';
COMMENT ON COLUMN "Access"."date" IS '创建时间';
COMMENT ON TABLE "Access" IS '权限配置(必须)';

-- ----------------------------
-- Records of Access
-- ----------------------------
INSERT INTO "Access" VALUES ('1', '0', 'Access', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2019-07-21 20:21:36', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('2', '1', 'Table', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2018-11-29 00:38:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('3', '1', 'Column', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2018-11-29 00:38:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('4', '0', 'Function', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2018-11-29 00:38:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('5', '0', 'Request', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2018-11-29 00:38:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('6', '0', 'Response', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2018-11-29 00:38:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('7', '1', 'Document', NULL, '["LOGIN", "ADMIN"]', '["LOGIN", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["LOGIN", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2018-11-29 00:38:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('8', '1', 'TestRecord', NULL, '["LOGIN", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2018-11-29 00:38:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('9', '0', 'Test', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2018-11-29 00:38:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('10', '1', 'PgAttribute', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2018-11-29 00:38:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('11', '1', 'PgClass', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2018-11-29 00:38:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('12', '0', 'Login', NULL, '[]', '[]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[ "ADMIN"]', '[ "ADMIN"]', '["ADMIN"]', TO_DATE('2018-11-29 00:29:48', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('13', '0', 'Verify', NULL, '[]', '[]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[ "ADMIN"]', '["ADMIN"]', TO_DATE('2018-11-29 00:29:48', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('14', '0', 'apijson_user', 'User', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN","LOGIN","OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["ADMIN"]', TO_DATE('2018-11-29 00:28:53', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('15', '0', 'apijson_privacy', 'Privacy', '[]', '[]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["UNKNOWN","LOGIN","OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["ADMIN"]', TO_DATE('2018-11-29 00:29:48', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('16', '0', 'Moment', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2018-11-29 00:29:19', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('17', '0', 'Comment', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2018-11-29 00:29:19', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('19', '1', 'SysTable', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2019-10-04 09:01:20', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('20', '1', 'SysColumn', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2019-10-04 09:01:20', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('21', '1', 'ExtendedProperty', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2019-10-04 09:33:45', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('22', '1', 'Random', NULL, '["LOGIN", "ADMIN"]', '["LOGIN", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2019-12-01 23:13:13', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('23', '0', 'Swagger', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', TO_DATE('2018-11-29 00:38:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('24', '1', 'Method', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["LOGIN", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2018-11-29 00:38:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('25', '1', 'Input', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2020-01-10 15:12:49', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('26', '1', 'Device', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2020-01-10 15:12:49', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('27', '1', 'System', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2020-01-10 15:12:49', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('28', '1', 'Flow', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2020-01-10 15:12:49', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('29', '1', 'Output', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2020-01-10 15:12:49', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "Access" VALUES ('30', '0', 'ViewTable', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2021-01-20 22:51:43', 'SYYYY-MM-DD HH24:MI:SS'), 'MySQL View 支持多张表合并为一张表，这个示例 View 的创建 SQL 为 CREATE VIEW sys.`ViewTable` AS SELECT C.id as `commentId`, C.toId, C.momentId, C.content,  U.* FROM sys.Comment AS C INNER JOIN sys.apijson_user AS U ON U.id = C.userId; 初测正则匹配等条件单表查询、与其它表关联查询、与其它表 JOIN 都和普通的表用起来没有大的区别，目前发现的问题两个是： 1.作为 ViewTable 的表中有同名字段的话要把部分字段取别名，例如 Comment 和 apijson_user 都有 id，这里就用 C.id as `commentId` 取了别名避免冲突；2.APIAuto 不能显示 ViewTable 的表注释和字段注释');
INSERT INTO "Access" VALUES ('38', '0', 'Script', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', TO_DATE('2022-12-05 17:45:34', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
