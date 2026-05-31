-- Kingbase SQLServer compatibility mode bootstrap script for APIJSON.
-- It creates the APIJSON framework tables referenced as "public"."Access" etc.
-- Run this against the apijson database used by:
-- jdbc:kingbase8://.../apijson?currentSchema=public

CREATE SCHEMA IF NOT EXISTS "public";

DROP TABLE IF EXISTS "public"."TestRecord" CASCADE;
DROP TABLE IF EXISTS "public"."Document" CASCADE;
DROP TABLE IF EXISTS "public"."Script" CASCADE;
DROP TABLE IF EXISTS "public"."Function" CASCADE;
DROP TABLE IF EXISTS "public"."Request" CASCADE;
DROP TABLE IF EXISTS "public"."Access" CASCADE;

CREATE TABLE "public"."Access" (
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

CREATE TABLE "public"."Request" (
  "id" BIGINT NOT NULL,
  "debug" SMALLINT NOT NULL DEFAULT 0,
  "version" SMALLINT NOT NULL DEFAULT 1,
  "method" VARCHAR(10) DEFAULT 'GETS',
  "tag" VARCHAR(30) NOT NULL,
  "structure" JSON NOT NULL,
  "detail" TEXT DEFAULT NULL,
  "date" DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "pk_Request" PRIMARY KEY ("id")
);

CREATE TABLE "public"."Function" (
  "id" BIGINT NOT NULL,
  "debug" SMALLINT NOT NULL DEFAULT 0,
  "userId" BIGINT NOT NULL DEFAULT 0,
  "language" VARCHAR(45) DEFAULT NULL,
  "name" VARCHAR(50) NOT NULL,
  "returnType" VARCHAR(50) DEFAULT 'Object',
  "arguments" VARCHAR(100) DEFAULT NULL,
  "demo" JSON NOT NULL,
  "detail" VARCHAR(1000) NOT NULL,
  "version" SMALLINT NOT NULL DEFAULT 0,
  "tag" VARCHAR(20) DEFAULT NULL,
  "methods" VARCHAR(50) DEFAULT NULL,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "return" VARCHAR(45) DEFAULT NULL,
  CONSTRAINT "pk_Function" PRIMARY KEY ("id")
);

CREATE TABLE "public"."Document" (
  "id" BIGINT NOT NULL,
  "debug" SMALLINT NOT NULL DEFAULT 0,
  "from" SMALLINT NOT NULL DEFAULT 0,
  "userId" BIGINT NOT NULL,
  "project" VARCHAR(100) DEFAULT 'APIJSON',
  "testAccountId" BIGINT NOT NULL DEFAULT 0,
  "version" SMALLINT NOT NULL DEFAULT 3,
  "group" VARCHAR(45) DEFAULT NULL,
  "name" VARCHAR(100) NOT NULL,
  "operation" VARCHAR(45) DEFAULT NULL,
  "method" VARCHAR(7) DEFAULT NULL,
  "type" VARCHAR(5) NOT NULL DEFAULT 'JSON',
  "url" VARCHAR(250) NOT NULL,
  "request" TEXT NOT NULL,
  "apijson" TEXT DEFAULT NULL,
  "sqlauto" TEXT DEFAULT NULL,
  "standard" TEXT DEFAULT NULL,
  "header" TEXT DEFAULT NULL,
  "date" DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  "path" VARCHAR(45) DEFAULT NULL,
  "detail" TEXT DEFAULT NULL,
  CONSTRAINT "pk_Document" PRIMARY KEY ("id")
);

CREATE INDEX "idx_Document_url" ON "public"."Document" ("url");
CREATE INDEX "idx_Document_date" ON "public"."Document" ("date");

CREATE TABLE "public"."Script" (
  "id" BIGINT NOT NULL,
  "userId" BIGINT NOT NULL DEFAULT 0,
  "testAccountId" BIGINT NOT NULL DEFAULT 0,
  "documentId" BIGINT NOT NULL DEFAULT 0,
  "simple" SMALLINT NOT NULL DEFAULT 0,
  "ahead" SMALLINT NOT NULL DEFAULT 0,
  "title" VARCHAR(100) DEFAULT NULL,
  "name" VARCHAR(100) DEFAULT NULL,
  "script" TEXT DEFAULT NULL,
  "date" DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  "detail" VARCHAR(1000) DEFAULT NULL,
  CONSTRAINT "pk_Script" PRIMARY KEY ("id")
);

CREATE INDEX "idx_Script_name" ON "public"."Script" ("name");
CREATE INDEX "idx_Script_simple" ON "public"."Script" ("simple");

CREATE TABLE "public"."TestRecord" (
  "id" BIGINT NOT NULL,
  "debug" SMALLINT NOT NULL DEFAULT 0,
  "userId" BIGINT NOT NULL,
  "testAccountId" BIGINT NOT NULL DEFAULT 0,
  "documentId" BIGINT NOT NULL,
  "randomId" BIGINT NOT NULL DEFAULT 0,
  "host" VARCHAR(1000) DEFAULT NULL,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "duration" BIGINT DEFAULT NULL,
  "minDuration" BIGINT DEFAULT NULL,
  "maxDuration" BIGINT DEFAULT NULL,
  "response" TEXT NOT NULL,
  "compare" TEXT DEFAULT NULL,
  "standard" TEXT DEFAULT NULL,
  CONSTRAINT "pk_TestRecord" PRIMARY KEY ("id")
);

INSERT INTO "public"."Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES
  (1, 0, NULL, 'Access', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', '2019-07-21 12:21:36', NULL),
  (2, 1, NULL, 'tables', 'Table', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', '2018-11-28 16:38:14', NULL),
  (3, 1, NULL, 'columns', 'Column', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', '2018-11-28 16:38:14', NULL),
  (4, 0, NULL, 'Function', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', '2018-11-28 16:38:15', NULL),
  (5, 0, NULL, 'Request', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "ADMIN"]', '[]', '[]', '2018-11-28 16:38:14', NULL),
  (7, 1, NULL, 'Document', NULL, '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2018-11-28 16:38:15', NULL),
  (8, 1, NULL, 'TestRecord', NULL, '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2018-11-28 16:38:15', NULL),
  (14, 0, NULL, 'apijson_user', 'User', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["ADMIN"]', '2018-11-28 16:28:53', NULL),
  (15, 0, NULL, 'apijson_privacy', 'Privacy', '[]', '[]', '["OWNER", "ADMIN", "CIRCLE"]', '["OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["ADMIN"]', '2018-11-28 16:29:48', NULL),
  (19, 1, NULL, 'tables', 'SysTable', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', '2019-10-04 01:01:20', NULL),
  (20, 1, NULL, 'columns', 'SysColumn', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', '2019-10-04 01:01:20', NULL),
  (21, 1, NULL, 'extended_properties', 'ExtendedProperty', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', '2019-10-04 01:33:45', NULL),
  (38, 0, NULL, 'Script', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2022-12-05 17:45:34', NULL);

INSERT INTO "public"."Request" ("id", "debug", "version", "method", "tag", "structure", "detail", "date") VALUES
  (22, 0, 1, 'GETS', 'User', '{}', 'Allow basic User list queries during bootstrap testing.', '2017-02-18 14:20:43'),
  (32, 0, 2, 'GETS', 'Privacy', '{"MUST": "id", "REFUSE": "_password,_payPassword", "UPDATE": {"@role": "OWNER"}}', NULL, '2017-06-12 16:05:51'),
  (35, 0, 2, 'POST', 'Document', '{"Document": {"MUST": "name,url,request", "INSERT": {"@role": "OWNER"}, "REFUSE": "id"}, "TestRecord": {"MUST": "response", "INSERT": {"@role": "OWNER"}, "REFUSE": "id", "UPDATE": {"documentId@": "Document/id"}}}', NULL, '2017-11-26 08:34:41'),
  (38, 0, 2, 'POST', 'TestRecord', '{"MUST": "documentId,response", "INSERT": {"@role": "OWNER"}, "REFUSE": "id"}', NULL, '2018-06-16 23:44:36'),
  (1658229984285, 0, 1, 'POST', 'Script', '{"MUST": "name,script", "INSERT": {"@role": "OWNER"}}', NULL, '2017-11-26 00:34:41'),
  (1658229984286, 0, 1, 'PUT', 'Script', '{"MUST": "id", "INSERT": {"@role": "OWNER"}}', NULL, '2017-11-26 00:34:41'),
  (1658229984287, 0, 1, 'DELETE', 'Script', '{"MUST": "id", "INSERT": {"@role": "OWNER"}}', NULL, '2017-11-26 00:34:41');

INSERT INTO "public"."Function" ("id", "debug", "userId", "language", "name", "returnType", "arguments", "demo", "detail", "version", "tag", "methods", "date", "return") VALUES
  (3, 0, 0, NULL, 'countArray', 'int', 'array', '{"array": [1, 2, 3]}', 'Get array length.', 0, NULL, NULL, '2018-10-13 08:23:23', NULL),
  (4, 0, 0, NULL, 'countObject', 'int', 'object', '{"object": {"key0": 1, "key1": 2}}', 'Get object length.', 0, NULL, NULL, '2018-10-13 08:23:23', NULL),
  (5, 0, 0, NULL, 'isContain', 'boolean', 'array,value', '{"array": [1, 2, 3], "value": 2}', 'Check whether an array contains a value.', 0, NULL, NULL, '2018-10-13 08:23:23', NULL),
  (6, 0, 0, NULL, 'isContainKey', 'boolean', 'object,key', '{"key": "id", "object": {"id": 1}}', 'Check whether an object contains a key.', 0, NULL, NULL, '2018-10-13 08:30:31', NULL),
  (7, 0, 0, NULL, 'isContainValue', 'boolean', 'object,value', '{"value": 1, "object": {"id": 1}}', 'Check whether an object contains a value.', 0, NULL, NULL, '2018-10-13 08:30:31', NULL),
  (8, 0, 0, NULL, 'getFromArray', 'Object', 'array,position', '{"array": [1, 2, 3], "result()": "getFromArray(array,1)"}', 'Get a value from an array by index.', 0, NULL, NULL, '2018-10-13 08:30:31', NULL),
  (9, 0, 0, NULL, 'getFromObject', 'Object', 'object,key', '{"key": "id", "object": {"id": 1}}', 'Get a value from an object by key.', 0, NULL, NULL, '2018-10-13 08:30:31', NULL);

INSERT INTO "public"."Function" ("id", "debug", "userId", "language", "name", "returnType", "arguments", "demo", "detail", "version", "tag", "methods", "date", "return") VALUES
  (11, 0, 0, NULL, 'verifyIdList', NULL, 'array', '{"array": [1, 2, 3], "result()": "verifyIdList(array)"}', 'Verify id list.', 0, NULL, NULL, '2019-08-17 19:58:33', NULL),
  (12, 0, 0, NULL, 'verifyURLList', NULL, 'array', '{"array": ["http://123.com/1.jpg", "http://123.com/a.png", "http://www.abc.com/test.gif"], "result()": "verifyURLList(array)"}', 'Verify URL list.', 0, NULL, NULL, '2019-08-17 19:58:33', NULL);

COMMIT;
