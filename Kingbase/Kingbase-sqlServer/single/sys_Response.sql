DROP TABLE IF EXISTS "Response" CASCADE;
CREATE TABLE "Response" (
  "id" BIGINT NOT NULL,
  "method" VARCHAR(10) NOT NULL DEFAULT 'GET',
  "model" VARCHAR(30) NOT NULL,
  "structure" TEXT NOT NULL,
  "detail" TEXT DEFAULT NULL,
  "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "pk_Response" PRIMARY KEY ("id")
);

INSERT INTO "Response" (id, method, model, structure, detail, date) VALUES (1, 'GET', 'User', '{"put": {"extra": "Response works! Test:He(She) is lazy and wrote nothing here"}, "remove": "phone"}', null, '2017-05-22 20:36:47.000');
INSERT INTO "Response" (id, method, model, structure, detail, date) VALUES (2, 'DELETE', 'Comment', '{"remove": "Comment:child"}', null, '2017-05-04 01:51:26.000');
INSERT INTO "Response" (id, method, model, structure, detail, date) VALUES (3, 'DELETE', 'Moment', '{"remove": "Comment"}', null, '2017-05-04 01:51:26.000');
