-- ----------------------------
-- Table structure for b_stone
-- ----------------------------
DROP TABLE IF EXISTS "b_stone" CASCADE;
CREATE TABLE "b_stone" (
  "id" NUMBER(20) NOT NULL,
  "cost" NUMBER(11),
  "price" NUMBER(11),
  "length" NUMBER(11),
  "width" NUMBER(11),
  "height" NUMBER(11),
  "weight" NUMBER(8,1),
  "creationdate" DATE,
  "modifydate" DATE NOT NULL,
  "modifier" NVARCHAR2(80)
)
;
COMMENT ON COLUMN "b_stone"."cost" IS '成本';
COMMENT ON COLUMN "b_stone"."price" IS '卖价';
COMMENT ON COLUMN "b_stone"."creationdate" IS '创建时间';
COMMENT ON COLUMN "b_stone"."modifydate" IS '修改时间';

-- ----------------------------
-- Records of b_stone
-- ----------------------------
