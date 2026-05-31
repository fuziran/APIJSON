-- ----------------------------
-- Table structure for _Visit
-- ----------------------------
DROP TABLE IF EXISTS "_Visit" CASCADE;
CREATE TABLE "_Visit" (
  "model" NVARCHAR2(15) NOT NULL,
  "id" NUMBER(20) NOT NULL,
  "operate" NUMBER(4) NOT NULL,
  "date" DATE NOT NULL
)
;
COMMENT ON COLUMN "_Visit"."operate" IS '1-增
2-删
3-改
4-查';

-- ----------------------------
-- Records of _Visit
-- ----------------------------
