-- ----------------------------
-- Primary Key structure for table Access
-- ----------------------------
ALTER TABLE "Access" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table Access
-- ----------------------------
CREATE UNIQUE INDEX "Access_name_UNIQUE"
  ON "Access" ("name");
CREATE UNIQUE INDEX "Access_alias_UNIQUE"
  ON "Access" ("alias");

-- ----------------------------
-- Primary Key structure for table apijson_privacy
-- ----------------------------
ALTER TABLE "apijson_privacy" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table apijson_privacy
-- ----------------------------
CREATE UNIQUE INDEX "Privacy_phone_UNIQUE"
  ON "apijson_privacy" ("phone");

-- ----------------------------
-- Primary Key structure for table apijson_user
-- ----------------------------
ALTER TABLE "apijson_user" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table b_stone
-- ----------------------------
ALTER TABLE "b_stone" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table Comment
-- ----------------------------
ALTER TABLE "Comment" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table Comment
-- ----------------------------
CREATE INDEX "Comment_userId_IDX"
  ON "Comment" ("userId");
CREATE INDEX "Comment_momentId_IDX"
  ON "Comment" ("momentId");
CREATE INDEX "Comment_toId_IDX"
  ON "Comment" ("toId");

-- ----------------------------
-- Primary Key structure for table Document
-- ----------------------------
ALTER TABLE "Document" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table Function
-- ----------------------------
ALTER TABLE "Function" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table Script
-- ----------------------------
ALTER TABLE "Script" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table Login
-- ----------------------------
ALTER TABLE "Login" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table Method
-- ----------------------------
ALTER TABLE "Method" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table Moment
-- ----------------------------
ALTER TABLE "Moment" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table Moment
-- ----------------------------
CREATE INDEX "Moment_userId_date_IDX"
  ON "Moment" ("userId", "date");

-- ----------------------------
-- Primary Key structure for table Praise
-- ----------------------------
ALTER TABLE "Praise" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table Random
-- ----------------------------
ALTER TABLE "Random" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table Request
-- ----------------------------
ALTER TABLE "Request" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table Response
-- ----------------------------
ALTER TABLE "Response" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table Response
-- ----------------------------
CREATE UNIQUE INDEX "Response_id_UNIQUE"
  ON "Response" ("id");

-- ----------------------------
-- Primary Key structure for table TestRecord
-- ----------------------------
ALTER TABLE "TestRecord" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table Verify
-- ----------------------------
ALTER TABLE "Verify" ADD PRIMARY KEY ("id");
