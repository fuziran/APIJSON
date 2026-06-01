DROP TABLE IF EXISTS "Script" CASCADE;
CREATE TABLE "Script" (
  "id" BIGINT NOT NULL,
  "userId" BIGINT NOT NULL DEFAULT 0,
  "testAccountId" BIGINT NOT NULL DEFAULT 0,
  "documentId" BIGINT NOT NULL DEFAULT 0,
  "simple" SMALLINT NOT NULL DEFAULT 0,
  "ahead" SMALLINT NOT NULL DEFAULT 0,
  "title" VARCHAR(100) DEFAULT NULL,
  "name" VARCHAR(100) DEFAULT NULL,
  "script" TEXT NOT NULL DEFAULT '',
  "date" DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  "detail" VARCHAR(1000) DEFAULT NULL,
  CONSTRAINT "pk_Script" PRIMARY KEY ("id")
);

CREATE INDEX "idx_Script_name" ON "Script" ("name");
CREATE INDEX "idx_Script_simple" ON "Script" ("simple");

-- Auto-filled INSERT data from Kingbase MySQL/Oracle sources.

INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1, 0, 0, 0, 0, 0, NULL, 'getType', 'function getType(curObj, key) {
    var val = curObj == null ? null : curObj[key];
    return val instanceof Array ? "array" : typeof val;
}', '2022-11-16 16:01:23', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (2, 0, 0, 0, 0, 0, NULL, 'isContain', 'function isContain(curObj, arrKey, valKey) {
    var arr = curObj == null ? null : curObj[arrKey];
    var val = curObj == null ? null : curObj[valKey];
    return arr != null && arr.indexOf(val) >=0;
}', '2022-11-16 16:02:48', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (3, 0, 0, 0, 1, 0, NULL, 'init', 'var i = 1;
"init done "  + i;', '2022-11-16 16:41:35', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (4, 0, 0, 0, 0, 0, NULL, 'length', 'function length(curObj, key) {
    var val = curObj == null ? null : curObj[key];
    return val == null ? 0 : val.length;
}', '2022-11-16 17:18:43', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1670877914051, 82001, 0, 0, 1, 1, '执行脚本 2022-12-13 04:44', '', '', '2022-12-12 20:45:14', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1670878495619, 82001, 82002, 0, 1, 0, '执行脚本 2022-12-13 04:54', '', '', '2022-12-12 20:54:55', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1670878529042, 82001, 82001, 0, 1, 1, '执行脚本 2022-12-13 04:55', '', '', '2022-12-12 20:55:29', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1670878622401, 82001, 82003, 0, 1, 0, '执行脚本 2022-12-13 04:57', '', '', '2022-12-12 20:57:02', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1670885503909, 82001, 0, 1657045372046, 1, 1, '执行脚本 2022-12-13 06:51', '', '', '2022-12-12 22:51:43', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1670887211207, 82001, 0, 1657045372046, 1, 0, '执行脚本 2022-12-13 07:20', '', '', '2022-12-12 23:20:11', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1676368454070, 82001, 0, 1546414192830, 1, 0, NULL, 'casePost1546414192830', '', '2023-02-14 09:54:14', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1679282174670, 82001, 0, 0, 1, 1, NULL, '到店系统查询', '', '2023-03-20 03:16:14', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1680660620759, 82001, 0, 1511796155276, 1, 1, NULL, 'casePre1511796155276', '', '2024-05-03 03:55:14', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1680660620760, 82001, 0, 1511970009072, 1, 1, NULL, 'casePre1511970009072', '', '2024-09-08 16:00:15', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1680660620761, 82001, 0, 1511970009072, 1, 0, NULL, 'casePost1511970009072', '', '2024-09-08 16:00:32', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1680660620762, 82001, 0, 1546414192830, 1, 1, NULL, 'casePre1546414192830', '', '2024-11-28 02:10:39', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1738490311550, 0, 0, 1560244940013, 1, 0, NULL, 'casePost1560244940013', '', '2025-02-02 09:58:32', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1738490327734, 0, 0, 0, 1, 0, NULL, 'globalPost0', '', '2025-02-02 09:58:48', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1738490404341, 0, 0, 0, 1, 1, NULL, 'globalPre0', '', '2025-02-02 10:00:04', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1738490404342, 82001, 0, 0, 1, 1, NULL, '', '', '2025-03-11 08:54:24', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1738490404343, 82001, 0, 1560737118846, 1, 0, NULL, 'casePost1560737118846', '', '2025-12-15 05:16:55', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1738490404344, 82001, 0, 0, 1, 1, NULL, 'globalPre0', '', '2026-02-13 07:18:02', NULL);
INSERT INTO "Script" ("id", "userId", "testAccountId", "documentId", "simple", "ahead", "title", "name", "script", "date", "detail") VALUES (1738490404345, 82001, 0, 1703475322145, 1, 0, NULL, 'casePost1703475322145', '', '2026-02-13 07:19:21', NULL);

UPDATE "Script"
SET "script" = ''
WHERE "script" IS NULL;
