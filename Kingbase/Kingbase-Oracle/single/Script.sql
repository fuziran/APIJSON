-- ----------------------------
-- Table structure for Script
-- ----------------------------
DROP TABLE IF EXISTS "Script" CASCADE;
CREATE TABLE "Script" (
  "id" NUMBER(20) NOT NULL,
  "userId" NUMBER(20) DEFAULT 0 NOT NULL,
  "testAccountId" NUMBER(20) DEFAULT 0 NOT NULL,
  "chainGroupId" NUMBER(20) DEFAULT 0 NOT NULL,
  "chainId" NUMBER(20) DEFAULT 0 NOT NULL,
  "documentId" NUMBER(20) DEFAULT 0 NOT NULL,
  "simple" NUMBER(4) DEFAULT 0 NOT NULL,
  "ahead" NUMBER(4) DEFAULT 0 NOT NULL,
  "title" NVARCHAR2(100),
  "name" NVARCHAR2(100) NOT NULL,
  "script" CLOB NOT NULL,
  "date" DATE NOT NULL,
  "detail" NVARCHAR2(1000)
)
;
COMMENT ON COLUMN "Script"."userId" IS '用户 id';
COMMENT ON COLUMN "Script"."testAccountId" IS '测试账号 id';
COMMENT ON COLUMN "Script"."documentId" IS '测试用例 id';
COMMENT ON COLUMN "Script"."simple" IS '是否为可直接执行的简单代码段：0-否 1-是';
COMMENT ON COLUMN "Script"."ahead" IS '是否为前置脚本';
COMMENT ON COLUMN "Script"."title" IS '函数名';
COMMENT ON COLUMN "Script"."name" IS '名称';
COMMENT ON TABLE "Script" IS '脚本，前置预处理脚本、后置断言和恢复脚本等';

-- ----------------------------
-- Records of Script
-- ----------------------------
