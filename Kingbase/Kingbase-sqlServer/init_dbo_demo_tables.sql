-- Kingbase SQLServer compatibility mode demo tables for APIJSON.
-- Run after init_dbo_apijson.sql against the apijson database:
-- jdbc:kingbase8://.../apijson?currentSchema=dbo

CREATE SCHEMA IF NOT EXISTS "dbo";

CREATE TABLE IF NOT EXISTS "dbo"."_Visit" (
  "model" VARCHAR(15) NOT NULL,
  "id" BIGINT NOT NULL,
  "operate" SMALLINT NOT NULL,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "dbo"."apijson_user" (
  "id" BIGINT NOT NULL,
  "sex" SMALLINT NOT NULL DEFAULT 0,
  "name" VARCHAR(20) NOT NULL,
  "tag" VARCHAR(45) DEFAULT NULL,
  "head" VARCHAR(300) DEFAULT 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png',
  "contactIdList" JSON DEFAULT NULL,
  "pictureList" JSON DEFAULT NULL,
  "date" DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "pk_apijson_user" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "dbo"."apijson_privacy" (
  "id" BIGINT NOT NULL,
  "certified" SMALLINT NOT NULL DEFAULT 0,
  "phone" BIGINT NOT NULL,
  "balance" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  "_password" VARCHAR(20) NOT NULL,
  "_payPassword" INT NOT NULL DEFAULT 123456,
  CONSTRAINT "pk_apijson_privacy" PRIMARY KEY ("id"),
  CONSTRAINT "uk_apijson_privacy_phone" UNIQUE ("phone")
);

CREATE TABLE IF NOT EXISTS "dbo"."Moment" (
  "id" BIGINT NOT NULL,
  "userId" BIGINT NOT NULL,
  "date" DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  "content" VARCHAR(300) DEFAULT NULL,
  "praiseUserIdList" JSON NOT NULL,
  "pictureList" JSON NOT NULL,
  CONSTRAINT "pk_Moment" PRIMARY KEY ("id")
);

CREATE INDEX IF NOT EXISTS "idx_Moment_userId_date" ON "dbo"."Moment" ("userId", "date");

CREATE TABLE IF NOT EXISTS "dbo"."Comment" (
  "id" BIGINT NOT NULL,
  "toId" BIGINT NOT NULL DEFAULT 0,
  "userId" BIGINT NOT NULL,
  "momentId" BIGINT NOT NULL,
  "date" DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  "content" VARCHAR(1000) NOT NULL,
  CONSTRAINT "pk_Comment" PRIMARY KEY ("id")
);

CREATE INDEX IF NOT EXISTS "idx_Comment_userId" ON "dbo"."Comment" ("userId");
CREATE INDEX IF NOT EXISTS "idx_Comment_momentId" ON "dbo"."Comment" ("momentId");
CREATE INDEX IF NOT EXISTS "idx_Comment_toId" ON "dbo"."Comment" ("toId");

CREATE TABLE IF NOT EXISTS "dbo"."Verify" (
  "id" BIGINT NOT NULL,
  "type" INT NOT NULL DEFAULT 0,
  "phone" BIGINT NOT NULL,
  "verify" INT NOT NULL,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "pk_Verify" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "dbo"."Login" (
  "id" BIGINT NOT NULL,
  "userId" BIGINT NOT NULL,
  "type" INT NOT NULL DEFAULT 0,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "pk_Login" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "dbo"."Praise" (
  "id" BIGINT NOT NULL,
  "userId" BIGINT NOT NULL,
  "momentId" BIGINT NOT NULL,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "pk_Praise" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "dbo"."Response" (
  "id" BIGINT NOT NULL,
  "method" VARCHAR(10) NOT NULL DEFAULT 'GET',
  "model" VARCHAR(30) NOT NULL,
  "structure" JSON NOT NULL,
  "detail" TEXT DEFAULT NULL,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "pk_Response" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "dbo"."Random" (
  "id" BIGINT NOT NULL,
  "toId" BIGINT NOT NULL DEFAULT 0,
  "userId" BIGINT NOT NULL,
  "documentId" BIGINT NOT NULL,
  "count" INT NOT NULL DEFAULT 1,
  "name" VARCHAR(100) NOT NULL,
  "config" VARCHAR(5000) NOT NULL,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "pk_Random" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "dbo"."Method" (
  "id" BIGINT NOT NULL,
  "userId" BIGINT NOT NULL,
  "package" VARCHAR(500) NOT NULL DEFAULT 'apijson.demo.server',
  "class" VARCHAR(50) NOT NULL DEFAULT 'DemoFunction',
  "classArgs" TEXT DEFAULT NULL,
  "genericClassArgs" TEXT DEFAULT NULL,
  "method" VARCHAR(50) NOT NULL,
  "methodArgs" TEXT DEFAULT NULL,
  "genericMethodArgs" TEXT DEFAULT NULL,
  "exceptions" VARCHAR(500) DEFAULT NULL,
  "genericExceptions" VARCHAR(500) DEFAULT NULL,
  "type" VARCHAR(50) DEFAULT NULL,
  "genericType" VARCHAR(50) DEFAULT NULL,
  "static" SMALLINT NOT NULL DEFAULT 0,
  "ui" SMALLINT NOT NULL DEFAULT 0,
  "request" TEXT DEFAULT NULL,
  "demo" JSON DEFAULT NULL,
  "detail" VARCHAR(1000) NOT NULL,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "pk_Method" PRIMARY KEY ("id")
);

DELETE FROM "dbo"."Access" WHERE "id" IN (6, 12, 13, 16, 17, 22, 24);
INSERT INTO "dbo"."Access" ("id", "debug", "schema", "name", "alias", "get", "head", "gets", "heads", "post", "put", "delete", "date", "detail") VALUES
  (6, 0, NULL, 'Response', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '[]', '[]', '[]', '2018-11-29 00:38:15', NULL),
  (12, 0, NULL, 'Login', NULL, '[]', '[]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["ADMIN"]', '["ADMIN"]', '["ADMIN"]', '2018-11-29 00:29:48', NULL),
  (13, 0, NULL, 'Verify', NULL, '[]', '[]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["ADMIN"]', '["ADMIN"]', '2018-11-29 00:29:48', NULL),
  (16, 0, NULL, 'Moment', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2018-11-29 00:29:19', NULL),
  (17, 0, NULL, 'Comment', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2018-11-29 00:29:19', NULL),
  (22, 1, NULL, 'Random', NULL, '["LOGIN", "ADMIN"]', '["LOGIN", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["LOGIN", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '2019-12-01 23:13:13', NULL),
  (24, 1, NULL, 'Method', NULL, '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]', '["OWNER", "ADMIN"]', '["LOGIN", "ADMIN"]', '["OWNER", "ADMIN"]', '2018-11-29 00:38:15', NULL);

DELETE FROM "dbo"."Request" WHERE "id" IN (1, 2, 3, 4, 5, 6, 14, 15, 16, 17, 21, 23, 25, 28, 29, 30, 31, 36, 37, 39, 40, 41, 42, 43, 44);
INSERT INTO "dbo"."Request" ("id", "debug", "version", "method", "tag", "structure", "detail", "date") VALUES
  (1, 0, 1, 'POST', 'register', '{"User": {"MUST": "name", "REFUSE": "id", "UPDATE": {"id@": "Privacy/id"}}, "Privacy": {"MUST": "_password,phone", "REFUSE": "id", "UNIQUE": "phone", "VERIFY": {"phone~": "PHONE"}}}', 'Register demo account.', '2017-02-01 11:19:51'),
  (2, 0, 1, 'POST', 'Moment', '{"INSERT": {"@role": "OWNER", "pictureList": [], "praiseUserIdList": []}, "REFUSE": "id", "UPDATE": {"verifyIdList-()": "verifyIdList(praiseUserIdList)", "verifyURLList-()": "verifyURLList(pictureList)"}}', 'Create Moment.', '2017-02-01 11:19:51'),
  (3, 0, 1, 'POST', 'Comment', '{"MUST": "momentId,content", "REFUSE": "id", "UPDATE": {"@role": "OWNER"}}', 'Create Comment.', '2017-02-01 11:19:51'),
  (4, 0, 1, 'PUT', 'User', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "phone"}', 'Update User.', '2017-02-01 11:19:51'),
  (5, 0, 1, 'DELETE', 'Moment', '{"Moment": {"MUST": "id", "INSERT": {"@role": "OWNER"}, "UPDATE": {"commentCount()": "deleteCommentOfMoment(id)"}}}', 'Delete Moment.', '2017-02-01 11:19:51'),
  (6, 0, 1, 'DELETE', 'Comment', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "UPDATE": {"childCount()": "deleteChildComment(id)"}}', 'Delete Comment.', '2017-02-01 11:19:51'),
  (14, 0, 1, 'POST', 'Verify', '{"MUST": "phone,verify", "REFUSE": "!"}', 'Create Verify.', '2017-02-18 14:20:43'),
  (15, 0, 1, 'GETS', 'Verify', '{"MUST": "phone"}', 'Query Verify.', '2017-02-18 14:20:43'),
  (16, 0, 1, 'HEADS', 'Verify', '{}', 'Count Verify.', '2017-02-18 14:20:43'),
  (17, 0, 1, 'PUT', 'Moment', '{"MUST": "id", "REFUSE": "userId,date", "UPDATE": {"verifyIdList-()": "verifyIdList(praiseUserIdList)", "verifyURLList-()": "verifyURLList(pictureList)"}}', 'Update Moment.', '2017-02-01 11:19:51'),
  (21, 0, 1, 'HEADS', 'Login', '{"MUST": "userId,type", "REFUSE": "!"}', 'Count Login.', '2017-02-18 14:20:43'),
  (23, 0, 1, 'PUT', 'Privacy', '{"MUST": "id", "INSERT": {"@role": "OWNER"}}', 'Update Privacy.', '2017-02-01 11:19:51'),
  (25, 0, 1, 'PUT', 'Praise', '{"MUST": "id"}', 'Update Praise.', '2017-02-01 11:19:51'),
  (28, 0, 1, 'PUT', 'Comment', '{"MUST": "id", "INSERT": {"@role": "OWNER"}}', 'Update Comment.', '2017-02-01 11:19:51'),
  (29, 0, 1, 'GETS', 'login', '{"Privacy": {"MUST": "phone,_password", "REFUSE": "id"}}', 'Login.', '2017-10-15 10:04:52'),
  (30, 0, 1, 'PUT', 'balance+', '{"Privacy": {"MUST": "id,balance+", "REFUSE": "!", "VERIFY": {"balance+&{}": ">=1,<=100000"}}}', 'Increase balance.', '2017-10-21 08:48:34'),
  (31, 0, 1, 'PUT', 'balance-', '{"Privacy": {"MUST": "id,balance-,_password", "REFUSE": "!", "UPDATE": {"@combine": "_password"}, "VERIFY": {"balance-&{}": ">=1,<=10000"}}}', 'Decrease balance.', '2017-10-21 08:48:34'),
  (36, 0, 2, 'PUT', 'Document', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "userId"}', 'Update Document.', '2017-11-26 08:35:15'),
  (37, 0, 2, 'DELETE', 'Document', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "!", "UPDATE": {"Random": {"@role": "OWNER", "documentId@": "Method/id"}, "TestRecord": {"@role": "OWNER", "documentId@": "Document/id"}}}', 'Delete Document.', '2017-11-26 00:36:20'),
  (39, 0, 2, 'POST', 'Method', '{"Method": {"MUST": "method,class,package", "INSERT": {"@role": "OWNER"}, "REFUSE": "id"}, "TestRecord": {"MUST": "response", "INSERT": {"@role": "OWNER"}, "REFUSE": "id,documentId", "UPDATE": {"documentId@": "Method/id"}}}', 'Create Method.', '2017-11-26 00:34:41'),
  (40, 0, 2, 'PUT', 'Method', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "userId"}', 'Update Method.', '2017-11-26 00:35:15'),
  (41, 0, 2, 'DELETE', 'Method', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "!", "UPDATE": {"Random": {"@role": "OWNER", "documentId@": "Method/id"}, "TestRecord": {"@role": "OWNER", "documentId@": "Method/id"}}}', 'Delete Method.', '2017-11-25 16:36:20'),
  (42, 0, 2, 'POST', 'Random', '{"INSERT": {"@role": "OWNER"}, "Random": {"MUST": "documentId,name,config"}, "TestRecord": {"UPDATE": {"randomId@": "/Random/id", "documentId@": "/Random/documentId"}}}', 'Create Random.', '2017-11-26 00:34:41'),
  (43, 0, 2, 'PUT', 'Random', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "REFUSE": "userId"}', 'Update Random.', '2017-11-26 00:35:15'),
  (44, 0, 2, 'DELETE', 'Random', '{"MUST": "id", "INSERT": {"@role": "OWNER"}, "UPDATE": {"TestRecord": {"@role": "OWNER", "randomId@": "/id"}}}', 'Delete Random.', '2017-11-25 16:36:20');

DELETE FROM "dbo"."Function" WHERE "id" IN (10, 11, 12);
INSERT INTO "dbo"."Function" ("id", "debug", "userId", "language", "name", "returnType", "arguments", "demo", "detail", "version", "tag", "methods", "date", "return") VALUES
  (10, 0, 0, NULL, 'deleteCommentOfMoment', 'int', 'momentId', '{"momentId": 1}', 'Delete comments by Moment id.', 0, 'Moment', 'DELETE', '2019-08-17 18:46:56', NULL),
  (11, 0, 0, NULL, 'verifyIdList', 'Object', 'array', '{"array": [1, 2, 3], "result()": "verifyIdList(array)"}', 'Verify id list.', 0, NULL, NULL, '2019-08-17 19:58:33', NULL),
  (12, 0, 0, NULL, 'verifyURLList', 'Object', 'array', '{"array": ["http://example.com/1.jpg"], "result()": "verifyURLList(array)"}', 'Verify URL list.', 0, NULL, NULL, '2019-08-17 19:58:33', NULL);

DELETE FROM "dbo"."apijson_user" WHERE "id" IN (38710, 70793, 82001, 82002, 82003, 93793);
INSERT INTO "dbo"."apijson_user" ("id", "sex", "name", "tag", "head", "contactIdList", "pictureList", "date") VALUES
  (38710, 0, 'TommyLemon', 'Android&Java', 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82001,82002,82003]', '[]', '2017-02-01 11:21:50'),
  (70793, 0, 'Strong', 'Demo', 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82001]', '[]', '2017-02-01 11:21:50'),
  (82001, 0, 'TestAccount', 'Dev', 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82002,38710]', '[]', '2017-02-01 11:21:50'),
  (82002, 1, 'Happy', 'iOS', 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82001,38710]', '[]', '2017-02-01 11:21:50'),
  (82003, 0, 'Wechat', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82001,93793]', '[]', '2017-02-01 11:21:50'),
  (93793, 0, 'Mike', 'Demo', 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', '2017-02-01 11:21:50');

DELETE FROM "dbo"."apijson_privacy" WHERE "id" IN (38710, 70793, 82001, 82002, 82003, 93793);
INSERT INTO "dbo"."apijson_privacy" ("id", "certified", "phone", "balance", "_password", "_payPassword") VALUES
  (38710, 1, 13000038710, 33376.00, 'apijson', 123456),
  (70793, 0, 13000070793, 56000.00, 'apijson', 123456),
  (82001, 1, 13000082001, 99867.38, '123456', 123456),
  (82002, 1, 13000082002, 6917.38, '123456', 123456),
  (82003, 1, 13000082003, 6900.20, '123456', 123456),
  (93793, 1, 13000093793, 3000.00, 'apijson', 123456);

DELETE FROM "dbo"."Moment" WHERE "id" IN (12, 15, 58, 170, 235, 301, 371, 470);
INSERT INTO "dbo"."Moment" ("id", "userId", "date", "content", "praiseUserIdList", "pictureList") VALUES
  (12, 70793, '2017-02-08 08:06:11', 'APIJSON lets interfaces and documents go to hell.', '[70793,93793,38710,82002,82001]', '["https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png"]'),
  (15, 70793, '2017-02-08 08:06:11', 'APIJSON is a JSON Transmission Structure Protocol.', '[82002,70793,38710,93793]', '["https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png"]'),
  (58, 82001, '2017-02-01 11:14:31', 'This is a demo Moment 58.', '[38710,82003,93793,82001]', '[]'),
  (170, 70793, '2017-02-01 11:14:31', 'This is a demo Moment 170.', '[82002,82001]', '[]'),
  (235, 38710, '2017-02-08 08:06:11', 'This is a demo Moment 235.', '[82001]', '[]'),
  (301, 93793, '2017-02-01 11:14:31', 'This is a demo Moment 301.', '[38710,93793,82003,82001]', '[]'),
  (371, 82002, '2017-02-01 11:14:31', 'This is a demo Moment 371.', '[93793,82003,82002,82001]', '[]'),
  (470, 38710, '2017-02-01 11:14:31', 'This is a demo Moment 470.', '[]', '[]');

DELETE FROM "dbo"."Comment" WHERE "id" IN (4, 13, 22, 167, 176);
INSERT INTO "dbo"."Comment" ("id", "toId", "userId", "momentId", "date", "content") VALUES
  (4, 0, 38710, 470, '2017-02-01 11:20:50', 'This is a demo comment 4.'),
  (13, 0, 82002, 58, '2017-02-01 11:20:50', 'This is a demo comment 13.'),
  (22, 0, 82001, 470, '2017-02-01 11:20:50', 'This is a demo comment 22.'),
  (167, 0, 82001, 58, '2017-03-25 11:48:41', 'Nice!'),
  (176, 0, 38710, 15, '2017-03-25 12:28:03', 'Thank you.');

DELETE FROM "dbo"."Verify" WHERE "id" IN (1623050785460);
INSERT INTO "dbo"."Verify" ("id", "type", "phone", "verify", "date") VALUES
  (1623050785460, 1, 13000082001, 8573, '2021-06-07 07:26:25');

DELETE FROM "dbo"."Login" WHERE "id" IN (1488616804093);
INSERT INTO "dbo"."Login" ("id", "userId", "type", "date") VALUES
  (1488616804093, 82001, 0, '2017-03-04 09:30:21');

DELETE FROM "dbo"."Praise" WHERE "id" IN (1);
INSERT INTO "dbo"."Praise" ("id", "userId", "momentId", "date") VALUES
  (1, 82001, 15, '2017-02-08 08:06:11');

DELETE FROM "dbo"."Response" WHERE "id" IN (1, 2, 3);
INSERT INTO "dbo"."Response" ("id", "method", "model", "structure", "detail", "date") VALUES
  (1, 'GET', 'User', '{"put": {"extra": "Response works!"}, "remove": "phone"}', NULL, '2017-05-22 12:36:47'),
  (2, 'DELETE', 'Comment', '{"remove": "Comment:child"}', NULL, '2017-05-03 17:51:26'),
  (3, 'DELETE', 'Moment', '{"remove": "Comment"}', NULL, '2017-05-03 17:51:26');

COMMIT;
