DROP TABLE IF EXISTS "Access" CASCADE;
CREATE TABLE "Access" (
  "id" BIGINT NOT NULL,
  "debug" SMALLINT NOT NULL DEFAULT 0,
  "schema" VARCHAR(100) DEFAULT NULL,
  "name" VARCHAR(50) NOT NULL,
  "alias" VARCHAR(20) DEFAULT NULL,
  "get" VARCHAR(100) NOT NULL DEFAULT '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]',
  "head" VARCHAR(100) NOT NULL DEFAULT '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]',
  "gets" VARCHAR(100) NOT NULL DEFAULT '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]',
  "heads" VARCHAR(100) NOT NULL DEFAULT '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]',
  "post" VARCHAR(100) NOT NULL DEFAULT '["OWNER", "ADMIN"]',
  "put" VARCHAR(100) NOT NULL DEFAULT '["OWNER", "ADMIN"]',
  "delete" VARCHAR(100) NOT NULL DEFAULT '["OWNER", "ADMIN"]',
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "detail" VARCHAR(1000) DEFAULT NULL,
  CONSTRAINT "pk_Access" PRIMARY KEY ("id")
);

INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (1, 0, 'Access', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2019-07-21 20:21:36.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (2, 1, 'Table', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2018-11-29 00:38:14.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (3, 1, 'Column', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2018-11-29 00:38:14.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (4, 0, 'Function', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2018-11-29 00:38:15.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (5, 0, 'Request', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2018-11-29 00:38:14.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (6, 0, 'Response', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2018-11-29 00:38:15.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (7, 1, 'Document', null, '""LOGIN", "ADMIN""', '""LOGIN", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""OWNER", "ADMIN""', '""LOGIN", "ADMIN""', '""OWNER", "ADMIN""', '2018-11-29 00:38:15.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (8, 1, 'TestRecord', null, '""LOGIN", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""OWNER", "ADMIN""', '""OWNER", "ADMIN""', '""OWNER", "ADMIN""', '2018-11-29 00:38:15.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (9, 0, 'Test', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2018-11-29 00:38:15.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (10, 1, 'PgAttribute', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2018-11-29 00:38:14.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (11, 1, 'PgClass', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2018-11-29 00:38:14.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (12, 0, 'Login', null, '""', '""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '" "ADMIN""', '" "ADMIN""', '""ADMIN""', '2018-11-29 00:29:48.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (13, 0, 'Verify', null, '""', '""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '" "ADMIN""', '""ADMIN""', '2018-11-29 00:29:48.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (14, 0, 'apijson_user', 'User', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN","LOGIN","OWNER", "ADMIN""', '""OWNER", "ADMIN""', '""ADMIN""', '2018-11-29 00:28:53.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (15, 0, 'apijson_privacy', 'Privacy', '""', '""', '""OWNER", "ADMIN""', '""OWNER", "ADMIN""', '""UNKNOWN","LOGIN","OWNER", "ADMIN""', '""OWNER", "ADMIN""', '""ADMIN""', '2018-11-29 00:29:48.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (16, 0, 'Moment', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""OWNER", "ADMIN""', '2018-11-29 00:29:19.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (17, 0, 'Comment', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""OWNER", "ADMIN""', '""OWNER", "ADMIN""', '""OWNER", "ADMIN""', '2018-11-29 00:29:19.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (19, 1, 'SysTable', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2019-10-04 09:01:20.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (20, 1, 'SysColumn', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2019-10-04 09:01:20.000');
INSERT INTO "Access" (id, debug, name, alias, get, head, gets, heads, post, put, "delete", date) VALUES (21, 1, 'ExtendedProperty', null, '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""', '""', '""', '""', '2019-10-04 09:33:45.000');
INSERT INTO "Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES
  (22, 1, NULL, 'Random', NULL, '["LOGIN", "ADMIN"]', '["LOGIN", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2019-12-01 23:13:13', NULL),
  (24, 1, NULL, 'Method', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["LOGIN", "ADMIN"]', '["OWNER", "ADMIN"]', '2018-11-29 00:38:15', NULL),
  (38, 0, NULL, 'Script', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2022-12-05 17:45:34', NULL);

-- Auto-filled INSERT data from Kingbase MySQL/Oracle sources.

INSERT INTO "Access" ("id", "debug", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES ('23', '0', 'Swagger', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', '2018-11-29 00:38:15', NULL);
INSERT INTO "Access" ("id", "debug", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES ('25', '1', 'Input', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2020-01-10 15:12:49', NULL);
INSERT INTO "Access" ("id", "debug", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES ('26', '1', 'Device', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2020-01-10 15:12:49', NULL);
INSERT INTO "Access" ("id", "debug", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES ('27', '1', 'System', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2020-01-10 15:12:49', NULL);
INSERT INTO "Access" ("id", "debug", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES ('28', '1', 'Flow', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2020-01-10 15:12:49', NULL);
INSERT INTO "Access" ("id", "debug", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES ('29', '1', 'Output', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2020-01-10 15:12:49', NULL);
INSERT INTO "Access" ("id", "debug", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES ('30', '0', 'ViewTable', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2021-01-20 22:51:43', 'MySQL View 支持多张表合并为一张表，这个示例 View 的创建 SQL 为 CREATE VIEW sys.`ViewTable` AS SELECT C.id as `commentId`, C.toId, C.momentId, C.content,  U.* FROM sys.Comment AS C INNER JOIN sys.apijson_user AS U ON U.id = C.userId; 初测正则匹配等条件单表查询、与其它表关联查询、与其它表 JOIN 都和普通的表用起来没有大的区别，目前发现的问题两个是： 1.作为 ViewTable 的表中有同名字段的话要把部分字段取别名，例如 Comment 和 apijson_user 都有 id，这里就用 C.id as `commentId` 取了别名避免冲突；2.APIAuto 不能显示 ViewTable 的表注释和字段注释');
INSERT INTO "Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES (31, 1, NULL, 'ALL_TABLES', 'AllTable', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2022-10-09 11:39:55', NULL);
INSERT INTO "Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES (32, 1, NULL, 'ALL_TAB_COLUMNS', 'AllColumn', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2022-10-09 11:39:55', NULL);
INSERT INTO "Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES (33, 1, NULL, 'ALL_TAB_COMMENTS', 'AllTableComment', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2022-10-09 07:07:04', NULL);
INSERT INTO "Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES (34, 1, NULL, 'ALL_COL_COMMENTS', 'AllColumnComment', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2022-10-09 07:07:04', NULL);
INSERT INTO "Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES (35, 0, NULL, 'Activity', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2022-12-05 17:45:34', NULL);
INSERT INTO "Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES (36, 0, NULL, 'Fragment', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2022-12-05 17:45:34', NULL);
INSERT INTO "Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES (37, 0, NULL, 'View', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2022-12-05 17:45:34', NULL);
INSERT INTO "Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES (39, 0, NULL, 'Chain', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2022-12-05 17:45:34', NULL);
INSERT INTO "Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES (40, 0, NULL, 'Praise', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2018-11-28 16:29:19', NULL);

-- Normalize converted permission strings to JSON arrays for ACCESS_MAP.
UPDATE "Access"
SET
  "get" = CASE
    WHEN "get" = '""' THEN '[]'
    WHEN "get" = '" "ADMIN""' THEN '["ADMIN"]'
    WHEN "get" = '""ADMIN""' THEN '["ADMIN"]'
    WHEN "get" = '""LOGIN", "ADMIN""' THEN '["LOGIN", "ADMIN"]'
    WHEN "get" = '""OWNER", "ADMIN""' THEN '["OWNER", "ADMIN"]'
    WHEN "get" = '""UNKNOWN","LOGIN","OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]'
    WHEN "get" = '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    WHEN "get" = '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    ELSE "get"
  END,
  "head" = CASE
    WHEN "head" = '""' THEN '[]'
    WHEN "head" = '" "ADMIN""' THEN '["ADMIN"]'
    WHEN "head" = '""ADMIN""' THEN '["ADMIN"]'
    WHEN "head" = '""LOGIN", "ADMIN""' THEN '["LOGIN", "ADMIN"]'
    WHEN "head" = '""OWNER", "ADMIN""' THEN '["OWNER", "ADMIN"]'
    WHEN "head" = '""UNKNOWN","LOGIN","OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]'
    WHEN "head" = '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    WHEN "head" = '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    ELSE "head"
  END,
  "gets" = CASE
    WHEN "gets" = '""' THEN '[]'
    WHEN "gets" = '" "ADMIN""' THEN '["ADMIN"]'
    WHEN "gets" = '""ADMIN""' THEN '["ADMIN"]'
    WHEN "gets" = '""LOGIN", "ADMIN""' THEN '["LOGIN", "ADMIN"]'
    WHEN "gets" = '""OWNER", "ADMIN""' THEN '["OWNER", "ADMIN"]'
    WHEN "gets" = '""UNKNOWN","LOGIN","OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]'
    WHEN "gets" = '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    WHEN "gets" = '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    ELSE "gets"
  END,
  "heads" = CASE
    WHEN "heads" = '""' THEN '[]'
    WHEN "heads" = '" "ADMIN""' THEN '["ADMIN"]'
    WHEN "heads" = '""ADMIN""' THEN '["ADMIN"]'
    WHEN "heads" = '""LOGIN", "ADMIN""' THEN '["LOGIN", "ADMIN"]'
    WHEN "heads" = '""OWNER", "ADMIN""' THEN '["OWNER", "ADMIN"]'
    WHEN "heads" = '""UNKNOWN","LOGIN","OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]'
    WHEN "heads" = '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    WHEN "heads" = '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    ELSE "heads"
  END,
  "post" = CASE
    WHEN "post" = '""' THEN '[]'
    WHEN "post" = '" "ADMIN""' THEN '["ADMIN"]'
    WHEN "post" = '""ADMIN""' THEN '["ADMIN"]'
    WHEN "post" = '""LOGIN", "ADMIN""' THEN '["LOGIN", "ADMIN"]'
    WHEN "post" = '""OWNER", "ADMIN""' THEN '["OWNER", "ADMIN"]'
    WHEN "post" = '""UNKNOWN","LOGIN","OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]'
    WHEN "post" = '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    WHEN "post" = '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    ELSE "post"
  END,
  "put" = CASE
    WHEN "put" = '""' THEN '[]'
    WHEN "put" = '" "ADMIN""' THEN '["ADMIN"]'
    WHEN "put" = '""ADMIN""' THEN '["ADMIN"]'
    WHEN "put" = '""LOGIN", "ADMIN""' THEN '["LOGIN", "ADMIN"]'
    WHEN "put" = '""OWNER", "ADMIN""' THEN '["OWNER", "ADMIN"]'
    WHEN "put" = '""UNKNOWN","LOGIN","OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]'
    WHEN "put" = '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    WHEN "put" = '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    ELSE "put"
  END,
  "delete" = CASE
    WHEN "delete" = '""' THEN '[]'
    WHEN "delete" = '" "ADMIN""' THEN '["ADMIN"]'
    WHEN "delete" = '""ADMIN""' THEN '["ADMIN"]'
    WHEN "delete" = '""LOGIN", "ADMIN""' THEN '["LOGIN", "ADMIN"]'
    WHEN "delete" = '""OWNER", "ADMIN""' THEN '["OWNER", "ADMIN"]'
    WHEN "delete" = '""UNKNOWN","LOGIN","OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]'
    WHEN "delete" = '""LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    WHEN "delete" = '""UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN""' THEN '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]'
    ELSE "delete"
  END;
