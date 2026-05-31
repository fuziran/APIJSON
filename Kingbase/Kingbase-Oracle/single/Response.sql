-- ----------------------------
-- Table structure for Response
-- ----------------------------
DROP TABLE IF EXISTS "Response" CASCADE;
CREATE TABLE "Response" (
  "id" NUMBER(20) NOT NULL,
  "method" NVARCHAR2(10),
  "model" NVARCHAR2(20) NOT NULL,
  "structure" CLOB NOT NULL,
  "detail" NCLOB,
  "date" DATE
)
;
COMMENT ON COLUMN "Response"."id" IS '唯一标识';
COMMENT ON COLUMN "Response"."method" IS '方法';
COMMENT ON COLUMN "Response"."model" IS '表名，table是SQL关键词不能用';
COMMENT ON COLUMN "Response"."structure" IS '结构';
COMMENT ON COLUMN "Response"."detail" IS '详细说明';
COMMENT ON COLUMN "Response"."date" IS '创建日期';
COMMENT ON TABLE "Response" IS '返回结果处理配置(目前未用上)
每次启动服务器时加载整个表到内存。';

-- ----------------------------
-- Records of Response
-- ----------------------------
INSERT INTO "Response" VALUES ('1', 'GET', 'User', '{"put": {"extra": "Response works! Test:He(She) is lazy and wrote nothing here"}, "remove": "phone"}', NULL, TO_DATE('2017-05-22 20:36:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Response" VALUES ('2', 'DELETE', 'Comment', '{"remove": "Comment:child"}', NULL, TO_DATE('2017-05-04 01:51:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Response" VALUES ('3', 'DELETE', 'Moment', '{"remove": "Comment"}', NULL, TO_DATE('2017-05-04 01:51:26', 'SYYYY-MM-DD HH24:MI:SS'));
