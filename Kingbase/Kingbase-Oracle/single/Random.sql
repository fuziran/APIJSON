-- ----------------------------
-- Table structure for Random
-- ----------------------------
DROP TABLE IF EXISTS "Random" CASCADE;
CREATE TABLE "Random" (
  "id" NUMBER(20) NOT NULL,
  "toId" NUMBER(20) NOT NULL,
  "userId" NUMBER(20) NOT NULL,
  "documentId" NUMBER(20) NOT NULL,
  "count" NUMBER(11) NOT NULL,
  "name" NVARCHAR2(100) NOT NULL,
  "config" NCLOB NOT NULL,
  "date" DATE NOT NULL
)
;
COMMENT ON COLUMN "Random"."id" IS '唯一标识';
COMMENT ON COLUMN "Random"."toId" IS '父项 id';
COMMENT ON COLUMN "Random"."documentId" IS '测试用例 Document 的 id';
COMMENT ON COLUMN "Random"."count" IS '请求次数，默认 1';
COMMENT ON COLUMN "Random"."name" IS '名称';
COMMENT ON COLUMN "Random"."config" IS '配置';
COMMENT ON TABLE "Random" IS '随机测试配置(必须)';

-- ----------------------------
-- Records of Random
-- ----------------------------
INSERT INTO "Random" VALUES ('1575129210368', '0', '82001', '1560244940013', '20', '配置2', 'User/id: RANDOM_IN(82001,82002,82003,70793,93793)  // 从这几个值随机取数
User/sex: RANDOM_INT(0,2)  // 从 0-2 随机取整数
[]/count: RANDOM_IN(3,5,10,20,''1'',''s'',false,[],{})  // 从这几个值随机取数
[]/page: Math.round(10*Math.random())  // 通过代码来自定义
  // []/Comment/toId: RANDOM_DB()  // 从数据库随机取值，替换 User/id 键值对', TO_DATE('2020-01-15 02:19:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1575129533653', '0', '82001', '1560244940013', '8', 'count 和 page', '[]/count: RANDOM_IN(3,5,10,20,''1'',''s'',false,[],{})  // 从这几个值随机取数 []/page: Math.round(10*Math.random())  // 通过代码来自定义  // []/Comment/toId: RANDOM_DB()  // 从数据库随机取值，替换 User/id 键值对', TO_DATE('2020-01-15 02:19:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1575134003381', '0', '82001', '1560075285563', '1', '[]/Comment/toId: RANDOM_IN(0,4,7,13,21)', '[]/Comment/toId: RANDOM_IN(0,4,7,13,21)  // 从数据库随机取值，替换 User/id 键值对', TO_DATE('2020-01-15 02:19:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1575141548694', '0', '82001', '1560244940013', '1', 'count & page', '[]/count: RANDOM_IN(3,5,10,20)  // 从这几个值随机取数
[]/page: Math.round(10*Math.random())  // 通过代码来自定义', TO_DATE('2020-01-15 02:19:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1575141679778', '0', '82001', '1560244940013', '1', '随机配置 2019-12-01 03:21', '[]/count: RANDOM_IN(3,5,10)  // 从这几个值随机取数
[]/page: Math.round(3*Math.random())  // 通过代码来自定义', TO_DATE('2020-01-15 02:19:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1579025903314', '0', '82001', '6', '5', 'methodArgs/0/value/key 随机已有值: true', 'methodArgs/0/value/key: RANDOM_IN(''a'', ''b'')', TO_DATE('2020-01-14 18:19:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1579025903315', '0', '82001', '6', '7', 'methodArgs/0/value/key 随机无效值: false', 'methodArgs/0/value/key: RANDOM_IN(''c'', ''X'', ''ab'', null, 1, false)', TO_DATE('2020-01-14 18:19:48', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1579025903316', '0', '82001', '6', '2', 'methodArgs/2/value 顺序非法值: throw', 'methodArgs/2/value: RANDOM_IN(0, -1, 2.3, false, true, {}, [])', TO_DATE('2020-01-14 18:19:48', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586160312990', '0', '82001', '1586159628678', '6', '顺序 type，顺序 value: 正常 return', 'methodArgs/0/type: ORDER_IN(''long'', ''double'', ''Number'')  // 顺序取值
methodArgs/0/value: ORDER_IN(1, 0.1, -10)  // 顺序取值

methodArgs/1/type: ORDER_IN(''long'', ''double'', ''Number'')  // 顺序取值
methodArgs/1/value: ORDER_IN(2, 3.14, 5)  // 顺序取值', TO_DATE('2020-04-06 08:05:14', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586161210976', '0', '82001', '6', '1', 'methodArgs/0/value/key 随机无效值: false - Temp 0', 'methodArgs/0/value/key: null', TO_DATE('2020-04-06 08:20:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586161247084', '0', '82001', '6', '1', 'methodArgs/0/value/key 随机无效值: false - Temp 1', 'methodArgs/0/value/key: 1', TO_DATE('2020-04-06 08:20:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586161247306', '0', '82001', '6', '1', 'methodArgs/0/value/key 随机无效值: false - Temp 1', 'methodArgs/0/value/key: 1', TO_DATE('2020-04-06 08:20:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586165928721', '0', '82001', '1586159628678', '30', '顺序 type，随机 value: 正常或报错', 'methodArgs/0/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'', ''Float'', null)  // 随机取值
methodArgs/0/value: RANDOM_IN(1, 0.1, -10, 9.99, null)  // 随机取值

methodArgs/1/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'', ''Float'', null)  // 随机取值
methodArgs/1/value: RANDOM_IN(2, 3.14, 5, -0.1, null)  // 随机取值', TO_DATE('2020-04-06 09:38:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586166010170', '0', '82001', '1586159628678', '20', '随机 type，随机 value: 正常或报错', 'methodArgs/0/type: RANDOM_IN(''long'', ''double'')  // 随机取值
methodArgs/0/value: RANDOM_IN(1, 0.1, -10, 9.99, null)  // 随机取值

methodArgs/1/type: RANDOM_IN(''long'', ''double'')  // 随机取值
methodArgs/1/value: RANDOM_IN(2, 3.14, 5, -0.1, null)  // 随机取值', TO_DATE('2020-04-06 09:40:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586166079775', '0', '82001', '1586159628678', '30', '顺序 type，顺序 value: 正常或报错', 'methodArgs/0/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'', ''Float'')  // 顺序取值
methodArgs/0/value: ORDER_IN(1, 0.1, -10, 9.99, null)  // 顺序取值

methodArgs/1/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'', ''Float'')  // 顺序取值
methodArgs/1/value: ORDER_IN(2, 3.14, 5, -0.1, null)  // 顺序取值', TO_DATE('2020-04-06 09:41:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586166554562', '0', '82001', '1586159628678', '1', 'double 0.1, double 3.14', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-06 09:49:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586166561747', '0', '82001', '1586159628678', '1', 'long 1, long 2', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 2', TO_DATE('2020-04-06 09:49:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586166563381', '0', '82001', '1586159628678', '1', 'double 0.1, double 3.14', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-06 09:49:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586166564661', '0', '82001', '1586159628678', '1', 'Number -10, Number 5', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 5', TO_DATE('2020-04-06 09:49:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586167627326', '0', '82001', '1586159628678', '0', 'long ORDER_IN, long RANDOM_INT (20): 正常 return', 'methodArgs/0/type: ''long''
methodArgs/0/value: ORDER_IN(0, 1, -1, 2, -2, 5, -5, 10, 99, 100, 101, -128)  // 顺序取值

methodArgs/1/type: ''long''
methodArgs/1/value: RANDOM_INT(-10000, 100000000)  // 随机整数', TO_DATE('2020-04-06 10:07:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586167725143', '0', '82001', '1586159628678', '1', 'long 100, long 23647003', 'methodArgs/0/type: "long" 
methodArgs/0/value: 100 
methodArgs/1/type: "long" 
methodArgs/1/value: 23647003', TO_DATE('2020-04-06 10:08:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586167727522', '0', '82001', '1586159628678', '1', 'long 101, long 21275596', 'methodArgs/0/type: "long" 
methodArgs/0/value: 101 
methodArgs/1/type: "long" 
methodArgs/1/value: 21275596', TO_DATE('2020-04-06 10:08:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586167729635', '0', '82001', '1586159628678', '1', 'long -128, long 56191505', 'methodArgs/0/type: "long" 
methodArgs/0/value: -128 
methodArgs/1/type: "long" 
methodArgs/1/value: 56191505', TO_DATE('2020-04-06 10:08:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586167731202', '0', '82001', '1586159628678', '1', 'long 0, long 48527682', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: 48527682', TO_DATE('2020-04-06 10:09:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586167735912', '0', '82001', '1586159628678', '1', 'long 1, long 89922375', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 89922375', TO_DATE('2020-04-06 10:09:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586167740094', '0', '82001', '1586159628678', '1', 'long -1, long 39242809', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 39242809', TO_DATE('2020-04-06 10:09:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586169941994', '1579025903315', '82001', '6', '1', 'methodArgs/0/value/key 随机无效值: false - Temp', 'methodArgs/0/value/key: 1', TO_DATE('2020-04-06 10:45:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586171727997', '1579025903315', '82001', '6', '1', 'methodArgs/0/value/key 随机无效值: false - Temp 0', 'methodArgs/0/value/key: 1', TO_DATE('2020-04-06 11:15:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586171860292', '1579025903315', '82001', '6', '1', 'methodArgs/0/value/key: null', 'methodArgs/0/value/key: null', TO_DATE('2020-04-06 11:17:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586171873734', '1579025903315', '82001', '6', '1', 'methodArgs/0/value/key 随机无效值: false - Temp 1', 'methodArgs/0/value/key: "c"', TO_DATE('2020-04-06 11:18:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586171875763', '1579025903315', '82001', '6', '1', 'methodArgs/0/value/key 随机无效值: false - Temp 3', 'methodArgs/0/value/key: 1', TO_DATE('2020-04-06 11:18:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586171926247', '1579025903316', '82001', '6', '1', 'methodArgs/2/value 顺序非法值: throw - Temp 6', 'methodArgs/2/value: {}', TO_DATE('2020-04-06 11:19:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586171933213', '1579025903314', '82001', '6', '1', 'methodArgs/0/value/key 随机已有值: true - Temp 0', 'methodArgs/0/value/key: "b"', TO_DATE('2020-04-06 11:19:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586171934803', '1579025903314', '82001', '6', '1', 'methodArgs/0/value/key 随机已有值: true - Temp 1', 'methodArgs/0/value/key: "a"', TO_DATE('2020-04-06 11:19:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586172371236', '1579025903316', '82001', '6', '1', 'methodArgs/2/value 顺序非法值: throw - Temp 0', 'methodArgs/2/value: 2.3', TO_DATE('2020-04-06 11:26:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586172381706', '1579025903316', '82001', '6', '1', 'methodArgs/2/value 顺序非法值: throw - Temp 6', 'methodArgs/2/value: -1', TO_DATE('2020-04-06 11:26:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586172983136', '1579025903315', '82001', '6', '1', 'methodArgs/0/value/key 随机无效值: false - Temp 5', 'methodArgs/0/value/key: null', TO_DATE('2020-04-06 11:36:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586173005184', '1579025903314', '82001', '6', '1', 'methodArgs/0/value/key 随机已有值: true - Temp 3', 'methodArgs/0/value/key: "b"', TO_DATE('2020-04-06 11:37:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586173045809', '1579025903314', '82001', '6', '1', 'methodArgs/0/value/key 随机已有值: true - Temp 2', 'methodArgs/0/value/key: "b"', TO_DATE('2020-04-06 11:37:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586173072436', '1579025903315', '82001', '6', '1', 'methodArgs/0/value/key 随机无效值: false - Temp 6', 'methodArgs/0/value/key: "c"', TO_DATE('2020-04-06 11:38:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586175845253', '1579025903314', '82001', '6', '1', 'methodArgs/0/value/key 随机已有值: true - Temp 4', 'methodArgs/0/value/key: "a"', TO_DATE('2020-04-06 12:24:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586189268266', '1586166010170', '82001', '1586159628678', '1', 'double 0.1, double 3.14', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-06 16:08:01', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586193949946', '1586165928721', '82001', '1586159628678', '1', 'long, 0.1, long, 5', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "long" 
methodArgs/1/value: 5', TO_DATE('2020-04-06 17:26:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586193987577', '1586165928721', '82001', '1586159628678', '1', 'Number, 9.99, Number, -0.1', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "Number" 
methodArgs/1/value: -0.1', TO_DATE('2020-04-06 17:26:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194045072', '1586165928721', '82001', '1586159628678', '1', 'double, 9.99, double, 2', 'methodArgs/0/type: "double" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "double" 
methodArgs/1/value: 2', TO_DATE('2020-04-06 17:27:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194047823', '1586165928721', '82001', '1586159628678', '1', 'Number, 1, Number, -0.1', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 1 
methodArgs/1/type: "Number" 
methodArgs/1/value: -0.1', TO_DATE('2020-04-06 17:27:46', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194050068', '1586165928721', '82001', '1586159628678', '1', 'double, -10, double, 5', 'methodArgs/0/type: "double" 
methodArgs/0/value: -10 
methodArgs/1/type: "double" 
methodArgs/1/value: 5', TO_DATE('2020-04-06 17:27:48', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194052335', '1586165928721', '82001', '1586159628678', '1', 'Number, 9.99, Number, 2', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "Number" 
methodArgs/1/value: 2', TO_DATE('2020-04-06 17:27:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194056043', '1586165928721', '82001', '1586159628678', '1', 'double, -10, double, -0.1', 'methodArgs/0/type: "double" 
methodArgs/0/value: -10 
methodArgs/1/type: "double" 
methodArgs/1/value: -0.1', TO_DATE('2020-04-06 17:27:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194292235', '1586166079775', '82001', '1586159628678', '1', 'double, 0.1, double, 3.14', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-06 17:31:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194297208', '1586166079775', '82001', '1586159628678', '1', 'long, 1, long, 2', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 2', TO_DATE('2020-04-06 17:31:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194323228', '1586165928721', '82001', '1586159628678', '1', 'long, 9.99, long, 2', 'methodArgs/0/type: "long" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "long" 
methodArgs/1/value: 2', TO_DATE('2020-04-06 17:32:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194354978', '1586165928721', '82001', '1586159628678', '1', 'Number, 1, Number, 3.14', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 1 
methodArgs/1/type: "Number" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-06 17:32:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194370747', '1586165928721', '82001', '1586159628678', '1', 'Number, -10, Number, 5', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 5', TO_DATE('2020-04-06 17:33:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194470991', '1586165928721', '82001', '1586159628678', '1', 'long, 9.99, long, 3.14', 'methodArgs/0/type: "long" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "long" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-06 17:34:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194474729', '1586165928721', '82001', '1586159628678', '1', 'Number, -10, Number, -0.1', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: -0.1', TO_DATE('2020-04-06 17:34:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194476655', '1586165928721', '82001', '1586159628678', '1', 'double, 0.1, double, -0.1', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: -0.1', TO_DATE('2020-04-06 17:34:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194583999', '1586165928721', '82001', '1586159628678', '1', 'Number, 0.1, Number, 3.14', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "Number" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-06 17:36:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194591151', '1586165928721', '82001', '1586159628678', '1', 'double, 9.99, double, -0.1', 'methodArgs/0/type: "double" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "double" 
methodArgs/1/value: -0.1', TO_DATE('2020-04-06 17:36:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194594906', '1586165928721', '82001', '1586159628678', '1', 'Number, 1, Number, 5', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 1 
methodArgs/1/type: "Number" 
methodArgs/1/value: 5', TO_DATE('2020-04-06 17:36:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586194624546', '1586165928721', '82001', '1586159628678', '1', 'Number, 0.1, Number, 5', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "Number" 
methodArgs/1/value: 5', TO_DATE('2020-04-06 17:37:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195304834', '1586167627326', '82001', '1586159628678', '1', 'long, 99, long, 6892628', 'methodArgs/0/type: "long" 
methodArgs/0/value: 99 
methodArgs/1/type: "long" 
methodArgs/1/value: 6892628', TO_DATE('2020-04-06 17:48:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195307580', '1586167627326', '82001', '1586159628678', '1', 'long, 10, long, 13678529', 'methodArgs/0/type: "long" 
methodArgs/0/value: 10 
methodArgs/1/type: "long" 
methodArgs/1/value: 13678529', TO_DATE('2020-04-06 17:48:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195310393', '1586167627326', '82001', '1586159628678', '1', 'long, -5, long, 31010241', 'methodArgs/0/type: "long" 
methodArgs/0/value: -5 
methodArgs/1/type: "long" 
methodArgs/1/value: 31010241', TO_DATE('2020-04-06 17:48:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195312026', '1586167627326', '82001', '1586159628678', '1', 'long, 5, long, 33700725', 'methodArgs/0/type: "long" 
methodArgs/0/value: 5 
methodArgs/1/type: "long" 
methodArgs/1/value: 33700725', TO_DATE('2020-04-06 17:48:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195313624', '1586167627326', '82001', '1586159628678', '1', 'long, -2, long, 17954702', 'methodArgs/0/type: "long" 
methodArgs/0/value: -2 
methodArgs/1/type: "long" 
methodArgs/1/value: 17954702', TO_DATE('2020-04-06 17:48:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195315466', '1586167627326', '82001', '1586159628678', '1', 'long, -1, long, 35324031', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 35324031', TO_DATE('2020-04-06 17:48:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195316596', '1586167627326', '82001', '1586159628678', '1', 'long, 1, long, 94305646', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 94305646', TO_DATE('2020-04-06 17:48:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195317876', '1586167627326', '82001', '1586159628678', '1', 'long, 2, long, 70173680', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: 70173680', TO_DATE('2020-04-06 17:48:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195320449', '1586167627326', '82001', '1586159628678', '1', 'long, 0, long, 68708292', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: 68708292', TO_DATE('2020-04-06 17:49:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195322653', '1586167627326', '82001', '1586159628678', '1', 'long, 101, long, 63653362', 'methodArgs/0/type: "long" 
methodArgs/0/value: 101 
methodArgs/1/type: "long" 
methodArgs/1/value: 63653362', TO_DATE('2020-04-06 17:49:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195324152', '1586167627326', '82001', '1586159628678', '1', 'long, 100, long, 34403982', 'methodArgs/0/type: "long" 
methodArgs/0/value: 100 
methodArgs/1/type: "long" 
methodArgs/1/value: 34403982', TO_DATE('2020-04-06 17:49:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195325652', '1586167627326', '82001', '1586159628678', '1', 'long, -128, long, 30210189', 'methodArgs/0/type: "long" 
methodArgs/0/value: -128 
methodArgs/1/type: "long" 
methodArgs/1/value: 30210189', TO_DATE('2020-04-06 17:49:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195327133', '1586167627326', '82001', '1586159628678', '1', 'long, 0, long, 52191107', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: 52191107', TO_DATE('2020-04-06 17:49:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195330601', '1586167627326', '82001', '1586159628678', '1', 'long, 1, long, 31823035', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 31823035', TO_DATE('2020-04-06 17:49:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586195606215', '1586166010170', '82001', '1586159628678', '1', 'double, 0.1, double, 3.14', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-06 17:53:46', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197339783', '1586165928721', '82001', '1586159628678', '1', 'Number, 0.1, Number, 2', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "Number" 
methodArgs/1/value: 2', TO_DATE('2020-04-07 02:22:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197347349', '1586165928721', '82001', '1586159628678', '1', 'double, 9.99, double, -0.1', 'methodArgs/0/type: "double" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "double" 
methodArgs/1/value: -0.1', TO_DATE('2020-04-07 02:22:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197350665', '1586165928721', '82001', '1586159628678', '1', 'Number, 0.1, Number, null', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "Number" 
methodArgs/1/value: null', TO_DATE('2020-04-07 02:22:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197366258', '1586165928721', '82001', '1586159628678', '1', 'double, 0.1, double, 5', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:22:46', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197692128', '1586166010170', '82001', '1586159628678', '1', 'double, -10, double, 5', 'methodArgs/0/type: "double" 
methodArgs/0/value: -10 
methodArgs/1/type: "double" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:28:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197699530', '1586166010170', '82001', '1586159628678', '1', 'double, -10, double, 5', 'methodArgs/0/type: "double" 
methodArgs/0/value: -10 
methodArgs/1/type: "double" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:28:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197707927', '1586166010170', '82001', '1586159628678', '1', 'double, -10, double, 5', 'methodArgs/0/type: "double" 
methodArgs/0/value: -10 
methodArgs/1/type: "double" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:28:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197709965', '1586166010170', '82001', '1586159628678', '1', 'double, 1, double, 5', 'methodArgs/0/type: "double" 
methodArgs/0/value: 1 
methodArgs/1/type: "double" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:28:29', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197722104', '1586166010170', '82001', '1586159628678', '1', 'double, -10, double, -0.1', 'methodArgs/0/type: "double" 
methodArgs/0/value: -10 
methodArgs/1/type: "double" 
methodArgs/1/value: -0.1', TO_DATE('2020-04-07 02:28:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197727968', '1586166010170', '82001', '1586159628678', '1', 'double, 0.1, double, 5', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:28:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197732669', '1586166010170', '82001', '1586159628678', '1', 'double, 1, double, 5', 'methodArgs/0/type: "double" 
methodArgs/0/value: 1 
methodArgs/1/type: "double" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:28:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197735421', '1586166010170', '82001', '1586159628678', '1', 'long, -10, long, 5', 'methodArgs/0/type: "long" 
methodArgs/0/value: -10 
methodArgs/1/type: "long" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:28:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197766913', '1586166079775', '82001', '1586159628678', '1', 'double, 0.1, double, 3.14', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-07 02:29:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197887634', '1586166079775', '82001', '1586159628678', '1', 'double, 0.1, double, 3.14', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-07 02:31:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586197889196', '1586166079775', '82001', '1586159628678', '1', 'Number, -10, Number, 5', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:31:29', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198223771', '1586160312990', '82001', '1586159628678', '1', 'long, 1, long, 2', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 2', TO_DATE('2020-04-07 02:37:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198225797', '1586160312990', '82001', '1586159628678', '1', 'double, 0.1, double, 3.14', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-07 02:37:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198227842', '1586160312990', '82001', '1586159628678', '1', 'Number, -10, Number, 5', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:37:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198263885', '1586160312990', '82001', '1586159628678', '1', 'long, 1, long, 2', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 2', TO_DATE('2020-04-07 02:37:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198265314', '1586160312990', '82001', '1586159628678', '1', 'double, 0.1, double, 3.14', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-07 02:37:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198266452', '1586160312990', '82001', '1586159628678', '1', 'Number, -10, Number, 5', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:37:46', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198337594', '0', '82001', '1586159628678', '1', 'long, -2, long, 25085664', 'methodArgs/0/type: "long" 
methodArgs/0/value: -2 
methodArgs/1/type: "long" 
methodArgs/1/value: 25085664', TO_DATE('2020-04-07 02:38:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198390591', '0', '82001', '1586159628678', '1', 'long, -1, long, 0', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 0', TO_DATE('2020-04-07 02:39:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198584539', '0', '82001', '1586198428686', '100', 'long, ORDER_IN, long, RANDOM_INT', 'methodArgs/0/type: ''long''
methodArgs/0/value: ORDER_IN(0, 1, -1, 2, -2, 5, -5, 10, 99, 100, 101, -128, 1024)  // 顺序取值

methodArgs/1/type: ''long''
methodArgs/1/value: RANDOM_INT(-100, 10000)  // 随机整数', TO_DATE('2020-04-07 02:43:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198634396', '1586198584539', '82001', '1586198428686', '1', 'long, 0, long, 6729', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: 6729', TO_DATE('2020-04-07 02:43:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198636482', '1586198584539', '82001', '1586198428686', '1', 'long, -1, long, 2815', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 2815', TO_DATE('2020-04-07 02:43:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198640235', '1586198584539', '82001', '1586198428686', '1', 'long, 99, long, 3635', 'methodArgs/0/type: "long" 
methodArgs/0/value: 99 
methodArgs/1/type: "long" 
methodArgs/1/value: 3635', TO_DATE('2020-04-07 02:44:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198641498', '1586198584539', '82001', '1586198428686', '1', 'long, 100, long, 2982', 'methodArgs/0/type: "long" 
methodArgs/0/value: 100 
methodArgs/1/type: "long" 
methodArgs/1/value: 2982', TO_DATE('2020-04-07 02:44:01', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198643983', '1586198584539', '82001', '1586198428686', '1', 'long, -5, long, 9222', 'methodArgs/0/type: "long" 
methodArgs/0/value: -5 
methodArgs/1/type: "long" 
methodArgs/1/value: 9222', TO_DATE('2020-04-07 02:44:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198646222', '1586198584539', '82001', '1586198428686', '1', 'long, -128, long, 3336', 'methodArgs/0/type: "long" 
methodArgs/0/value: -128 
methodArgs/1/type: "long" 
methodArgs/1/value: 3336', TO_DATE('2020-04-07 02:44:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198648647', '1586198584539', '82001', '1586198428686', '1', 'long, -2, long, 1516', 'methodArgs/0/type: "long" 
methodArgs/0/value: -2 
methodArgs/1/type: "long" 
methodArgs/1/value: 1516', TO_DATE('2020-04-07 02:44:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198650756', '1586198584539', '82001', '1586198428686', '1', 'long, -5, long, 8393', 'methodArgs/0/type: "long" 
methodArgs/0/value: -5 
methodArgs/1/type: "long" 
methodArgs/1/value: 8393', TO_DATE('2020-04-07 02:44:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198653805', '1586198584539', '82001', '1586198428686', '1', 'long, -2, long, 4', 'methodArgs/0/type: "long" 
methodArgs/0/value: -2 
methodArgs/1/type: "long" 
methodArgs/1/value: 4', TO_DATE('2020-04-07 02:44:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198654776', '1586198584539', '82001', '1586198428686', '1', 'long, 5, long, 9369', 'methodArgs/0/type: "long" 
methodArgs/0/value: 5 
methodArgs/1/type: "long" 
methodArgs/1/value: 9369', TO_DATE('2020-04-07 02:44:14', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198656594', '1586198584539', '82001', '1586198428686', '1', 'long, -1, long, 4300', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 4300', TO_DATE('2020-04-07 02:44:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198659115', '1586198584539', '82001', '1586198428686', '1', 'long, 1024, long, -74', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1024 
methodArgs/1/type: "long" 
methodArgs/1/value: -74', TO_DATE('2020-04-07 02:44:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198661373', '1586198584539', '82001', '1586198428686', '1', 'long, -128, long, 6444', 'methodArgs/0/type: "long" 
methodArgs/0/value: -128 
methodArgs/1/type: "long" 
methodArgs/1/value: 6444', TO_DATE('2020-04-07 02:44:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198663346', '1586198584539', '82001', '1586198428686', '1', 'long, 101, long, 4277', 'methodArgs/0/type: "long" 
methodArgs/0/value: 101 
methodArgs/1/type: "long" 
methodArgs/1/value: 4277', TO_DATE('2020-04-07 02:44:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198665002', '1586198584539', '82001', '1586198428686', '1', 'long, 100, long, 3765', 'methodArgs/0/type: "long" 
methodArgs/0/value: 100 
methodArgs/1/type: "long" 
methodArgs/1/value: 3765', TO_DATE('2020-04-07 02:44:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198695619', '1586198584539', '82001', '1586198428686', '1', 'long, 5, long, 7363', 'methodArgs/0/type: "long" 
methodArgs/0/value: 5 
methodArgs/1/type: "long" 
methodArgs/1/value: 7363', TO_DATE('2020-04-07 02:44:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198697496', '1586198584539', '82001', '1586198428686', '1', 'long, -5, long, 6551', 'methodArgs/0/type: "long" 
methodArgs/0/value: -5 
methodArgs/1/type: "long" 
methodArgs/1/value: 6551', TO_DATE('2020-04-07 02:44:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198765199', '0', '82001', '1586198428686', '50', 'long, RANDOM_IN, long, ORDER_INT', 'methodArgs/0/type: ''long''
methodArgs/0/value: RANDOM_IN(0, 1, -1, 2, -2, 5, -5, 10, 99, 100, 101, -128, 1024)  // 顺序取值

methodArgs/1/type: ''long''
methodArgs/1/value: ORDER_INT(-10, 100)  // 随机整数', TO_DATE('2020-04-07 02:46:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198789510', '1586198765199', '82001', '1586198428686', '1', 'long, 0, long, -8', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: -8', TO_DATE('2020-04-07 02:46:29', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198791354', '1586198765199', '82001', '1586198428686', '1', 'long, 0, long, -10', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: -10', TO_DATE('2020-04-07 02:46:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198792453', '1586198765199', '82001', '1586198428686', '1', 'long, 100, long, -9', 'methodArgs/0/type: "long" 
methodArgs/0/value: 100 
methodArgs/1/type: "long" 
methodArgs/1/value: -9', TO_DATE('2020-04-07 02:46:32', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198794144', '1586198765199', '82001', '1586198428686', '1', 'long, 100, long, -7', 'methodArgs/0/type: "long" 
methodArgs/0/value: 100 
methodArgs/1/type: "long" 
methodArgs/1/value: -7', TO_DATE('2020-04-07 02:46:34', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198799169', '1586198765199', '82001', '1586198428686', '1', 'long, 100, long, -2', 'methodArgs/0/type: "long" 
methodArgs/0/value: 100 
methodArgs/1/type: "long" 
methodArgs/1/value: -2', TO_DATE('2020-04-07 02:46:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198800057', '1586198765199', '82001', '1586198428686', '1', 'long, 2, long, -1', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: -1', TO_DATE('2020-04-07 02:46:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198801391', '1586198765199', '82001', '1586198428686', '1', 'long, 101, long, 0', 'methodArgs/0/type: "long" 
methodArgs/0/value: 101 
methodArgs/1/type: "long" 
methodArgs/1/value: 0', TO_DATE('2020-04-07 02:46:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198803774', '1586198765199', '82001', '1586198428686', '1', 'long, -1, long, 1', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 1', TO_DATE('2020-04-07 02:46:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198805251', '1586198765199', '82001', '1586198428686', '1', 'long, 10, long, 2', 'methodArgs/0/type: "long" 
methodArgs/0/value: 10 
methodArgs/1/type: "long" 
methodArgs/1/value: 2', TO_DATE('2020-04-07 02:46:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198806707', '1586198765199', '82001', '1586198428686', '1', 'long, 10, long, 3', 'methodArgs/0/type: "long" 
methodArgs/0/value: 10 
methodArgs/1/type: "long" 
methodArgs/1/value: 3', TO_DATE('2020-04-07 02:46:46', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198807768', '1586198765199', '82001', '1586198428686', '1', 'long, 1024, long, 4', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1024 
methodArgs/1/type: "long" 
methodArgs/1/value: 4', TO_DATE('2020-04-07 02:46:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198809615', '1586198765199', '82001', '1586198428686', '1', 'long, 2, long, 5', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 02:46:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198811742', '1586198765199', '82001', '1586198428686', '1', 'long, 1024, long, 9', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1024 
methodArgs/1/type: "long" 
methodArgs/1/value: 9', TO_DATE('2020-04-07 02:46:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198813215', '1586198765199', '82001', '1586198428686', '1', 'long, 99, long, 10', 'methodArgs/0/type: "long" 
methodArgs/0/value: 99 
methodArgs/1/type: "long" 
methodArgs/1/value: 10', TO_DATE('2020-04-07 02:46:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198815061', '1586198765199', '82001', '1586198428686', '1', 'long, 1, long, 11', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 11', TO_DATE('2020-04-07 02:46:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198816949', '1586198765199', '82001', '1586198428686', '1', 'long, 101, long, 12', 'methodArgs/0/type: "long" 
methodArgs/0/value: 101 
methodArgs/1/type: "long" 
methodArgs/1/value: 12', TO_DATE('2020-04-07 02:46:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198820584', '1586198765199', '82001', '1586198428686', '1', 'long, 10, long, 19', 'methodArgs/0/type: "long" 
methodArgs/0/value: 10 
methodArgs/1/type: "long" 
methodArgs/1/value: 19', TO_DATE('2020-04-07 02:47:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198822202', '1586198765199', '82001', '1586198428686', '1', 'long, 5, long, 22', 'methodArgs/0/type: "long" 
methodArgs/0/value: 5 
methodArgs/1/type: "long" 
methodArgs/1/value: 22', TO_DATE('2020-04-07 02:47:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198831493', '1586198765199', '82001', '1586198428686', '1', 'long, 100, long, 27', 'methodArgs/0/type: "long" 
methodArgs/0/value: 100 
methodArgs/1/type: "long" 
methodArgs/1/value: 27', TO_DATE('2020-04-07 02:47:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198833478', '1586198765199', '82001', '1586198428686', '1', 'long, 10, long, 26', 'methodArgs/0/type: "long" 
methodArgs/0/value: 10 
methodArgs/1/type: "long" 
methodArgs/1/value: 26', TO_DATE('2020-04-07 02:47:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198834808', '1586198765199', '82001', '1586198428686', '1', 'long, 2, long, 25', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: 25', TO_DATE('2020-04-07 02:47:14', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198836671', '1586198765199', '82001', '1586198428686', '1', 'long, -128, long, 24', 'methodArgs/0/type: "long" 
methodArgs/0/value: -128 
methodArgs/1/type: "long" 
methodArgs/1/value: 24', TO_DATE('2020-04-07 02:47:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198840322', '1586198765199', '82001', '1586198428686', '1', 'long, -1, long, 21', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 21', TO_DATE('2020-04-07 02:47:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198842201', '1586198765199', '82001', '1586198428686', '1', 'long, -5, long, 30', 'methodArgs/0/type: "long" 
methodArgs/0/value: -5 
methodArgs/1/type: "long" 
methodArgs/1/value: 30', TO_DATE('2020-04-07 02:47:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198845127', '1586198765199', '82001', '1586198428686', '1', 'long, -128, long, 36', 'methodArgs/0/type: "long" 
methodArgs/0/value: -128 
methodArgs/1/type: "long" 
methodArgs/1/value: 36', TO_DATE('2020-04-07 02:47:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198846342', '1586198765199', '82001', '1586198428686', '1', 'long, 5, long, 35', 'methodArgs/0/type: "long" 
methodArgs/0/value: 5 
methodArgs/1/type: "long" 
methodArgs/1/value: 35', TO_DATE('2020-04-07 02:47:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198847341', '1586198765199', '82001', '1586198428686', '1', 'long, -5, long, 34', 'methodArgs/0/type: "long" 
methodArgs/0/value: -5 
methodArgs/1/type: "long" 
methodArgs/1/value: 34', TO_DATE('2020-04-07 02:47:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198848709', '1586198765199', '82001', '1586198428686', '1', 'long, 10, long, 38', 'methodArgs/0/type: "long" 
methodArgs/0/value: 10 
methodArgs/1/type: "long" 
methodArgs/1/value: 38', TO_DATE('2020-04-07 02:47:28', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198849784', '1586198765199', '82001', '1586198428686', '1', 'long, 2, long, 37', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: 37', TO_DATE('2020-04-07 02:47:29', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198850993', '1586198765199', '82001', '1586198428686', '1', 'long, 0, long, 39', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: 39', TO_DATE('2020-04-07 02:47:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198852777', '1586198765199', '82001', '1586198428686', '1', 'long, -128, long, 33', 'methodArgs/0/type: "long" 
methodArgs/0/value: -128 
methodArgs/1/type: "long" 
methodArgs/1/value: 33', TO_DATE('2020-04-07 02:47:32', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198853986', '1586198765199', '82001', '1586198428686', '1', 'long, 0, long, 31', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: 31', TO_DATE('2020-04-07 02:47:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198856277', '1586198765199', '82001', '1586198428686', '1', 'long, 100, long, -6', 'methodArgs/0/type: "long" 
methodArgs/0/value: 100 
methodArgs/1/type: "long" 
methodArgs/1/value: -6', TO_DATE('2020-04-07 02:47:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198858003', '1586198765199', '82001', '1586198428686', '1', 'long, -5, long, -3', 'methodArgs/0/type: "long" 
methodArgs/0/value: -5 
methodArgs/1/type: "long" 
methodArgs/1/value: -3', TO_DATE('2020-04-07 02:47:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198859535', '1586198765199', '82001', '1586198428686', '1', 'long, -5, long, -5', 'methodArgs/0/type: "long" 
methodArgs/0/value: -5 
methodArgs/1/type: "long" 
methodArgs/1/value: -5', TO_DATE('2020-04-07 02:47:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198860675', '1586198765199', '82001', '1586198428686', '1', 'long, 1, long, -4', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: -4', TO_DATE('2020-04-07 02:47:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586198864522', '1586198765199', '82001', '1586198428686', '1', 'long, 100, long, 17', 'methodArgs/0/type: "long" 
methodArgs/0/value: 100 
methodArgs/1/type: "long" 
methodArgs/1/value: 17', TO_DATE('2020-04-07 02:47:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586199426860', '1586167627326', '82001', '1586159628678', '1', 'long, 2, long, 73393533', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: 73393533', TO_DATE('2020-04-07 02:57:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586199430135', '1586167627326', '82001', '1586159628678', '1', 'long, -1, long, 21720759', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 21720759', TO_DATE('2020-04-07 02:57:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586199433521', '1586167627326', '82001', '1586159628678', '1', 'long, 1, long, 9423427', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 9423427', TO_DATE('2020-04-07 02:57:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586199436521', '1586167627326', '82001', '1586159628678', '1', 'long, -128, long, 67173039', 'methodArgs/0/type: "long" 
methodArgs/0/value: -128 
methodArgs/1/type: "long" 
methodArgs/1/value: 67173039', TO_DATE('2020-04-07 02:57:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586199438044', '1586167627326', '82001', '1586159628678', '1', 'long, 101, long, 88860103', 'methodArgs/0/type: "long" 
methodArgs/0/value: 101 
methodArgs/1/type: "long" 
methodArgs/1/value: 88860103', TO_DATE('2020-04-07 02:57:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231119895', '0', '82001', '1586159628678', '20', '顺序 type，顺序 value: 正常或报错', 'methodArgs/0/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'', ''Float'')  // 顺序取值
methodArgs/0/value: ORDER_IN(1, 0.1, -10, 9.99, null)  // 顺序取值

methodArgs/1/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'', ''Float'')  // 顺序取值
methodArgs/1/value: ORDER_IN(2, 3.14, 5, -0.1, null)  // 顺序取值', TO_DATE('2020-04-07 11:45:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231169236', '1586231119895', '82001', '1586159628678', '1', 'long, 1, long, 2', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 2', TO_DATE('2020-04-07 11:46:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231176318', '1586231119895', '82001', '1586159628678', '1', 'double, 0.1, double, 3.14', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 3.14', TO_DATE('2020-04-07 11:46:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231207098', '1586231119895', '82001', '1586159628678', '1', 'Number, -10, Number, 5', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 11:46:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231241636', '1586231119895', '82001', '1586159628678', '1', 'long, 1, long, 2', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 2', TO_DATE('2020-04-07 11:47:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231259230', '1586231119895', '82001', '1586159628678', '1', 'Number, -10, Number, 5', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 11:47:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231404519', '0', '82001', '1586159628678', '50', 'ORDER_IN, ORDER_IN, ORDER_IN, ORDER_INT', 'methodArgs/0/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'', ''Float'')  // 顺序取值
methodArgs/0/value: ORDER_IN(1, 0.1, -10, 9.99, null)  // 顺序取值

methodArgs/1/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'', ''Float'')  // 顺序取值
methodArgs/1/value: ORDER_INT(-10, 100)  // 顺序取值', TO_DATE('2020-04-07 11:50:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231453083', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, -10', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: -10', TO_DATE('2020-04-07 11:50:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231455467', '1586231404519', '82001', '1586159628678', '1', 'double, 0.1, double, -9', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: -9', TO_DATE('2020-04-07 11:50:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231458713', '1586231404519', '82001', '1586159628678', '1', 'Number, -10, Number, -8', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: -8', TO_DATE('2020-04-07 11:50:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231469178', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, -5', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: -5', TO_DATE('2020-04-07 11:51:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231496820', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, 0', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 0', TO_DATE('2020-04-07 11:51:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231499489', '1586231404519', '82001', '1586159628678', '1', 'double, 0.1, double, 1', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 1', TO_DATE('2020-04-07 11:51:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586231503362', '1586231404519', '82001', '1586159628678', '1', 'Number, -10, Number, 7', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 7', TO_DATE('2020-04-07 11:51:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232142033', '1586165928721', '82001', '1586159628678', '1', 'double, 9.99, double, 2', 'methodArgs/0/type: "double" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "double" 
methodArgs/1/value: 2', TO_DATE('2020-04-07 12:02:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232142038', '1586165928721', '82001', '1586159628678', '1', 'double, 9.99, double, 2', 'methodArgs/0/type: "double" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "double" 
methodArgs/1/value: 2', TO_DATE('2020-04-07 12:02:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232160115', '1586165928721', '82001', '1586159628678', '1', 'Number, 0.1, Number, -0.1', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "Number" 
methodArgs/1/value: -0.1', TO_DATE('2020-04-07 12:02:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232308014', '1586166010170', '82001', '1586159628678', '1', 'double, 1, long, 2', 'methodArgs/0/type: "double" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 2', TO_DATE('2020-04-07 12:05:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232310489', '1586166010170', '82001', '1586159628678', '1', 'double, 9.99, double, -0.1', 'methodArgs/0/type: "double" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "double" 
methodArgs/1/value: -0.1', TO_DATE('2020-04-07 12:05:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232483507', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, -10', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: -10', TO_DATE('2020-04-07 12:08:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232490705', '1586231404519', '82001', '1586159628678', '1', 'double, 0.1, double, -9', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: -9', TO_DATE('2020-04-07 12:08:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232493184', '1586231404519', '82001', '1586159628678', '1', 'Number, -10, Number, -8', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: -8', TO_DATE('2020-04-07 12:08:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232520640', '0', '82001', '1586159628678', '1', '随机配置 2020-04-07 12:08', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 2', TO_DATE('2020-04-07 12:08:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232577840', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, -5', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: -5', TO_DATE('2020-04-07 12:09:37', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232582693', '1586231404519', '82001', '1586159628678', '1', 'double, 0.1, double, -4', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: -4', TO_DATE('2020-04-07 12:09:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232587350', '1586231404519', '82001', '1586159628678', '1', 'Number, -10, Number, -3', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: -3', TO_DATE('2020-04-07 12:09:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232591779', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, 0', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 0', TO_DATE('2020-04-07 12:09:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232595135', '1586231404519', '82001', '1586159628678', '1', 'Number, -10, Number, 7', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 7', TO_DATE('2020-04-07 12:09:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232597349', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, 5', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 12:09:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232599745', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, 10', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 10', TO_DATE('2020-04-07 12:09:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232603243', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, 15', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 15', TO_DATE('2020-04-07 12:10:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232606944', '1586231404519', '82001', '1586159628678', '1', 'double, 0.1, double, 16', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 16', TO_DATE('2020-04-07 12:10:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586232609806', '1586231404519', '82001', '1586159628678', '1', 'Number, -10, Number, 17', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 17', TO_DATE('2020-04-07 12:10:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586233289465', '0', '82001', '1586160409878', '110', '随机配置 2020-04-07 12:21', 'methodArgs/0/value: ORDER_INT(-10, 100)', TO_DATE('2020-04-07 12:21:29', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586242902337', '1586198765199', '82001', '1586198428686', '1', 'long, 1, long, -2', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: -2', TO_DATE('2020-04-07 15:01:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586242972089', '1586198765199', '82001', '1586198428686', '1', 'long, 101, long, -7', 'methodArgs/0/type: "long" 
methodArgs/0/value: 101 
methodArgs/1/type: "long" 
methodArgs/1/value: -7', TO_DATE('2020-04-07 15:02:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243003485', '1586198584539', '82001', '1586198428686', '1', 'long, 0, long, 2811', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: 2811', TO_DATE('2020-04-07 15:03:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243007202', '1586198584539', '82001', '1586198428686', '1', 'long, -2, long, 4628', 'methodArgs/0/type: "long" 
methodArgs/0/value: -2 
methodArgs/1/type: "long" 
methodArgs/1/value: 4628', TO_DATE('2020-04-07 15:03:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243011737', '1586198584539', '82001', '1586198428686', '1', 'long, -128, long, 7950', 'methodArgs/0/type: "long" 
methodArgs/0/value: -128 
methodArgs/1/type: "long" 
methodArgs/1/value: 7950', TO_DATE('2020-04-07 15:03:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243014211', '1586198584539', '82001', '1586198428686', '1', 'long, -1, long, 143', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 143', TO_DATE('2020-04-07 15:03:34', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243015820', '1586198584539', '82001', '1586198428686', '1', 'long, -2, long, 8612', 'methodArgs/0/type: "long" 
methodArgs/0/value: -2 
methodArgs/1/type: "long" 
methodArgs/1/value: 8612', TO_DATE('2020-04-07 15:03:35', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243017339', '1586198584539', '82001', '1586198428686', '1', 'long, 1, long, 3173', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 3173', TO_DATE('2020-04-07 15:03:37', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243019546', '1586198584539', '82001', '1586198428686', '1', 'long, 0, long, 4203', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: 4203', TO_DATE('2020-04-07 15:03:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243020896', '1586198584539', '82001', '1586198428686', '1', 'long, 1, long, 4589', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 4589', TO_DATE('2020-04-07 15:03:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243022578', '1586198584539', '82001', '1586198428686', '1', 'long, -1, long, 3150', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 3150', TO_DATE('2020-04-07 15:03:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243025082', '1586198584539', '82001', '1586198428686', '1', 'long, -5, long, 2275', 'methodArgs/0/type: "long" 
methodArgs/0/value: -5 
methodArgs/1/type: "long" 
methodArgs/1/value: 2275', TO_DATE('2020-04-07 15:03:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243027062', '1586198584539', '82001', '1586198428686', '1', 'long, -128, long, 510', 'methodArgs/0/type: "long" 
methodArgs/0/value: -128 
methodArgs/1/type: "long" 
methodArgs/1/value: 510', TO_DATE('2020-04-07 15:03:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243028081', '1586198584539', '82001', '1586198428686', '1', 'long, 101, long, 9271', 'methodArgs/0/type: "long" 
methodArgs/0/value: 101 
methodArgs/1/type: "long" 
methodArgs/1/value: 9271', TO_DATE('2020-04-07 15:03:48', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243036551', '1586198584539', '82001', '1586198428686', '1', 'long, 2, long, 6483', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: 6483', TO_DATE('2020-04-07 15:03:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243039978', '1586198584539', '82001', '1586198428686', '1', 'long, 0, long, 6438', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: 6438', TO_DATE('2020-04-07 15:03:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243042016', '1586198584539', '82001', '1586198428686', '1', 'long, 1, long, 961', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 961', TO_DATE('2020-04-07 15:04:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243043748', '1586198584539', '82001', '1586198428686', '1', 'long, -1, long, 5156', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 5156', TO_DATE('2020-04-07 15:04:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243045491', '1586198584539', '82001', '1586198428686', '1', 'long, 2, long, 1307', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: 1307', TO_DATE('2020-04-07 15:04:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243048433', '1586198584539', '82001', '1586198428686', '1', 'long, 99, long, 4952', 'methodArgs/0/type: "long" 
methodArgs/0/value: 99 
methodArgs/1/type: "long" 
methodArgs/1/value: 4952', TO_DATE('2020-04-07 15:04:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243049746', '1586198584539', '82001', '1586198428686', '1', 'long, 10, long, 106', 'methodArgs/0/type: "long" 
methodArgs/0/value: 10 
methodArgs/1/type: "long" 
methodArgs/1/value: 106', TO_DATE('2020-04-07 15:04:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243051679', '1586198584539', '82001', '1586198428686', '1', 'long, -5, long, 1173', 'methodArgs/0/type: "long" 
methodArgs/0/value: -5 
methodArgs/1/type: "long" 
methodArgs/1/value: 1173', TO_DATE('2020-04-07 15:04:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243053574', '1586198584539', '82001', '1586198428686', '1', 'long, -2, long, 9752', 'methodArgs/0/type: "long" 
methodArgs/0/value: -2 
methodArgs/1/type: "long" 
methodArgs/1/value: 9752', TO_DATE('2020-04-07 15:04:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243055316', '1586198584539', '82001', '1586198428686', '1', 'long, -1, long, 1501', 'methodArgs/0/type: "long" 
methodArgs/0/value: -1 
methodArgs/1/type: "long" 
methodArgs/1/value: 1501', TO_DATE('2020-04-07 15:04:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243058066', '1586198584539', '82001', '1586198428686', '1', 'long, 1, long, 3979', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 3979', TO_DATE('2020-04-07 15:04:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243059013', '1586198584539', '82001', '1586198428686', '1', 'long, 0, long, 926', 'methodArgs/0/type: "long" 
methodArgs/0/value: 0 
methodArgs/1/type: "long" 
methodArgs/1/value: 926', TO_DATE('2020-04-07 15:04:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243222467', '1586231404519', '82001', '1586159628678', '1', 'Number, -10, Number, 12', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 12', TO_DATE('2020-04-07 15:07:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243226505', '1586231404519', '82001', '1586159628678', '1', 'Number, -10, Number, 17', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 17', TO_DATE('2020-04-07 15:07:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243233545', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, 15', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 15', TO_DATE('2020-04-07 15:07:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243235828', '1586231404519', '82001', '1586159628678', '1', 'double, 0.1, double, 16', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 16', TO_DATE('2020-04-07 15:07:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243240122', '1586231404519', '82001', '1586159628678', '1', 'double, 0.1, double, 11', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 11', TO_DATE('2020-04-07 15:07:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243245530', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, 10', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 10', TO_DATE('2020-04-07 15:07:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243248976', '1586231404519', '82001', '1586159628678', '1', 'double, 0.1, double, 6', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: 6', TO_DATE('2020-04-07 15:07:28', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243250413', '1586231404519', '82001', '1586159628678', '1', 'Number, -10, Number, 7', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 7', TO_DATE('2020-04-07 15:07:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243253942', '1586231404519', '82001', '1586159628678', '1', 'long, 1, long, 0', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 0', TO_DATE('2020-04-07 15:07:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586243278329', '1586231119895', '82001', '1586159628678', '1', 'Number, -10, Number, 5', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 5', TO_DATE('2020-04-07 15:07:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586248112435', '0', '82001', '1586159628678', '5', '随机配置 2020-04-07 16:28', 'methodArgs/0/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'', ''Float'')  // 顺序取值
methodArgs/0/value: ORDER_IN(1, 0.1, -10, 9.99, null)  // 顺序取值

methodArgs/1/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'', ''Float'')  // 顺序取值
methodArgs/1/value: ORDER_INT(-10, 100)  // 顺序取值', TO_DATE('2020-04-07 16:28:32', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586248442638', '1586248112435', '82001', '1586159628678', '1', 'long, 1, long, -10', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: -10', TO_DATE('2020-04-07 16:34:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586248642428', '1586231404519', '82001', '1586159628678', '1', 'Float, null, Float, -6', 'methodArgs/0/type: "Float" 
methodArgs/0/value: null 
methodArgs/1/type: "Float" 
methodArgs/1/value: -6', TO_DATE('2020-04-07 16:37:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586266899677', '1586248112435', '82001', '1586159628678', '1', 'double, 0.1, double, -9', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0.1 
methodArgs/1/type: "double" 
methodArgs/1/value: -9', TO_DATE('2020-04-07 21:41:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586266901593', '1586248112435', '82001', '1586159628678', '1', 'Number, -10, Number, -8', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: -8', TO_DATE('2020-04-07 21:41:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279537151', '0', '82001', '1586159628678', '1', 'RANDOM_INT(-10, 100), ORDER_INT(-10, 100)', 'methodArgs/0/value: RANDOM_INT(-10, 100)
methodArgs/1/value: ORDER_INT(-10, 100)', TO_DATE('2020-04-08 01:12:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279667155', '0', '82001', '1586159628678', '20', 'ORDER_INT(-100, 10), ORDER_INT(-10, 100)', 'methodArgs/0/value: ORDER_INT(-100, 10)
methodArgs/1/value: ORDER_INT(-10, 100)', TO_DATE('2020-04-08 01:14:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279787628', '1586279667155', '82001', '1586159628678', '1', '-100, -10', 'methodArgs/0/value: -100 
methodArgs/1/value: -10', TO_DATE('2020-04-08 01:16:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279791014', '1586279667155', '82001', '1586159628678', '1', '-99, -9', 'methodArgs/0/value: -99 
methodArgs/1/value: -9', TO_DATE('2020-04-08 01:16:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279803016', '1586279667155', '82001', '1586159628678', '1', '-9, 81', 'methodArgs/0/value: -9 
methodArgs/1/value: 81', TO_DATE('2020-04-08 01:16:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279805059', '1586279667155', '82001', '1586159628678', '1', '-3, 87', 'methodArgs/0/value: -3 
methodArgs/1/value: 87', TO_DATE('2020-04-08 01:16:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279812486', '1586279667155', '82001', '1586159628678', '1', '-2, 88', 'methodArgs/0/value: -2 
methodArgs/1/value: 88', TO_DATE('2020-04-08 01:16:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279813854', '1586279667155', '82001', '1586159628678', '1', '-1, 89', 'methodArgs/0/value: -1 
methodArgs/1/value: 89', TO_DATE('2020-04-08 01:16:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279816501', '1586279667155', '82001', '1586159628678', '1', '-10, 80', 'methodArgs/0/value: -10 
methodArgs/1/value: 80', TO_DATE('2020-04-08 01:16:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279823264', '1586279667155', '82001', '1586159628678', '1', '-91, -1', 'methodArgs/0/value: -91 
methodArgs/1/value: -1', TO_DATE('2020-04-08 01:17:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279829764', '1586279667155', '82001', '1586159628678', '1', '-90, 0', 'methodArgs/0/value: -90 
methodArgs/1/value: 0', TO_DATE('2020-04-08 01:17:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279832171', '1586279667155', '82001', '1586159628678', '1', '-89, 1', 'methodArgs/0/value: -89 
methodArgs/1/value: 1', TO_DATE('2020-04-08 01:17:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279833191', '1586279667155', '82001', '1586159628678', '1', '-88, 2', 'methodArgs/0/value: -88 
methodArgs/1/value: 2', TO_DATE('2020-04-08 01:17:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279836091', '1586279667155', '82001', '1586159628678', '1', '-92, -2', 'methodArgs/0/value: -92 
methodArgs/1/value: -2', TO_DATE('2020-04-08 01:17:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279840142', '1586279667155', '82001', '1586159628678', '1', '-56, 34', 'methodArgs/0/value: -56 
methodArgs/1/value: 34', TO_DATE('2020-04-08 01:17:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586279942254', '1586279667155', '82001', '1586159628678', '1', '-18, 72', 'methodArgs/0/value: -18 
methodArgs/1/value: 72', TO_DATE('2020-04-08 01:19:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280076513', '0', '82001', '1586159628678', '50', 'ORDER_IN, RANDOM_IN 配置', 'methodArgs/0/value: ORDER_IN(0, 1, 2, -1, -2, -3, 4, 0.12, -3.14, 10, 99, 100)
methodArgs/1/value: RANDOM_IN(1, 2, -1, -2, -3, 4, 0.12, -3.14, 10, 99, 100)', TO_DATE('2020-04-08 01:21:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280160205', '1586280076513', '82001', '1586159628678', '1', '0, 2', 'methodArgs/0/value: 0 
methodArgs/1/value: 2', TO_DATE('2020-04-08 01:22:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280164207', '1586280076513', '82001', '1586159628678', '1', '1, 4', 'methodArgs/0/value: 1 
methodArgs/1/value: 4', TO_DATE('2020-04-08 01:22:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280165976', '1586280076513', '82001', '1586159628678', '1', '2, 4', 'methodArgs/0/value: 2 
methodArgs/1/value: 4', TO_DATE('2020-04-08 01:22:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280167348', '1586280076513', '82001', '1586159628678', '1', '-1, -1', 'methodArgs/0/value: -1 
methodArgs/1/value: -1', TO_DATE('2020-04-08 01:22:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280168574', '1586280076513', '82001', '1586159628678', '1', '-2, 4', 'methodArgs/0/value: -2 
methodArgs/1/value: 4', TO_DATE('2020-04-08 01:22:48', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280170337', '1586280076513', '82001', '1586159628678', '1', '-3, -3', 'methodArgs/0/value: -3 
methodArgs/1/value: -3', TO_DATE('2020-04-08 01:22:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280172423', '1586280076513', '82001', '1586159628678', '1', '4, 100', 'methodArgs/0/value: 4 
methodArgs/1/value: 100', TO_DATE('2020-04-08 01:22:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280173542', '1586280076513', '82001', '1586159628678', '1', '0.12, -3.14', 'methodArgs/0/value: 0.12 
methodArgs/1/value: -3.14', TO_DATE('2020-04-08 01:22:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280174923', '1586280076513', '82001', '1586159628678', '1', '-3.14, -3.14', 'methodArgs/0/value: -3.14 
methodArgs/1/value: -3.14', TO_DATE('2020-04-08 01:22:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280176731', '1586280076513', '82001', '1586159628678', '1', '10, -3.14', 'methodArgs/0/value: 10 
methodArgs/1/value: -3.14', TO_DATE('2020-04-08 01:22:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280177814', '1586280076513', '82001', '1586159628678', '1', '99, 2', 'methodArgs/0/value: 99 
methodArgs/1/value: 2', TO_DATE('2020-04-08 01:22:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280178916', '1586280076513', '82001', '1586159628678', '1', '100, -3', 'methodArgs/0/value: 100 
methodArgs/1/value: -3', TO_DATE('2020-04-08 01:22:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280180599', '1586280076513', '82001', '1586159628678', '1', '0, -3', 'methodArgs/0/value: 0 
methodArgs/1/value: -3', TO_DATE('2020-04-08 01:23:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280181576', '1586280076513', '82001', '1586159628678', '1', '1, 0.12', 'methodArgs/0/value: 1 
methodArgs/1/value: 0.12', TO_DATE('2020-04-08 01:23:01', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280182596', '1586280076513', '82001', '1586159628678', '1', '2, 100', 'methodArgs/0/value: 2 
methodArgs/1/value: 100', TO_DATE('2020-04-08 01:23:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280184221', '1586280076513', '82001', '1586159628678', '1', '-1, 4', 'methodArgs/0/value: -1 
methodArgs/1/value: 4', TO_DATE('2020-04-08 01:23:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280187297', '1586280076513', '82001', '1586159628678', '1', '-2, 1', 'methodArgs/0/value: -2 
methodArgs/1/value: 1', TO_DATE('2020-04-08 01:23:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280188256', '1586280076513', '82001', '1586159628678', '1', '-3, 99', 'methodArgs/0/value: -3 
methodArgs/1/value: 99', TO_DATE('2020-04-08 01:23:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280189992', '1586280076513', '82001', '1586159628678', '1', '4, -3', 'methodArgs/0/value: 4 
methodArgs/1/value: -3', TO_DATE('2020-04-08 01:23:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280191363', '1586280076513', '82001', '1586159628678', '1', '0.12, 4', 'methodArgs/0/value: 0.12 
methodArgs/1/value: 4', TO_DATE('2020-04-08 01:23:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280193161', '1586280076513', '82001', '1586159628678', '1', '-3.14, 4', 'methodArgs/0/value: -3.14 
methodArgs/1/value: 4', TO_DATE('2020-04-08 01:23:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280194704', '1586280076513', '82001', '1586159628678', '1', '100, 1', 'methodArgs/0/value: 100 
methodArgs/1/value: 1', TO_DATE('2020-04-08 01:23:14', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280197120', '1586280076513', '82001', '1586159628678', '1', '99, 100', 'methodArgs/0/value: 99 
methodArgs/1/value: 100', TO_DATE('2020-04-08 01:23:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280198327', '1586280076513', '82001', '1586159628678', '1', '10, 4', 'methodArgs/0/value: 10 
methodArgs/1/value: 4', TO_DATE('2020-04-08 01:23:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280201467', '1586280076513', '82001', '1586159628678', '1', '0, -3', 'methodArgs/0/value: 0 
methodArgs/1/value: -3', TO_DATE('2020-04-08 01:23:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280202421', '1586280076513', '82001', '1586159628678', '1', '100, 99', 'methodArgs/0/value: 100 
methodArgs/1/value: 99', TO_DATE('2020-04-08 01:23:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280203292', '1586280076513', '82001', '1586159628678', '1', '99, -3', 'methodArgs/0/value: 99 
methodArgs/1/value: -3', TO_DATE('2020-04-08 01:23:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280204580', '1586280076513', '82001', '1586159628678', '1', '10, 2', 'methodArgs/0/value: 10 
methodArgs/1/value: 2', TO_DATE('2020-04-08 01:23:24', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280206276', '1586280076513', '82001', '1586159628678', '1', '-3.14, -3', 'methodArgs/0/value: -3.14 
methodArgs/1/value: -3', TO_DATE('2020-04-08 01:23:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280207785', '1586280076513', '82001', '1586159628678', '1', '0.12, -3.14', 'methodArgs/0/value: 0.12 
methodArgs/1/value: -3.14', TO_DATE('2020-04-08 01:23:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280210613', '1586280076513', '82001', '1586159628678', '1', '4, 4', 'methodArgs/0/value: 4 
methodArgs/1/value: 4', TO_DATE('2020-04-08 01:23:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280305344', '1586280076513', '82001', '1586159628678', '1', '1, 2', 'methodArgs/0/value: 1 
methodArgs/1/value: 2', TO_DATE('2020-04-08 01:25:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280312365', '1586280076513', '82001', '1586159628678', '1', '10, 100', 'methodArgs/0/value: 10 
methodArgs/1/value: 100', TO_DATE('2020-04-08 01:25:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280317738', '1586280076513', '82001', '1586159628678', '1', '99, 4', 'methodArgs/0/value: 99 
methodArgs/1/value: 4', TO_DATE('2020-04-08 01:25:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1586280320523', '1586280076513', '82001', '1586159628678', '1', '1, -2', 'methodArgs/0/value: 1 
methodArgs/1/value: -2', TO_DATE('2020-04-08 01:25:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236063697', '0', '82001', '1592232912349', '20', '随机配置（模拟同步、异步、返回值等各种情况）', 'methodArgs/0/value: RANDOM_IN(1, 0.1, -10, 9.99, null)  // 随机取值
methodArgs/1/value: ORDER_INT(-10, 100)  // 顺序整数

methodArgs/2/value/id: RANDOM_INT(1, 100)  // 随机整数
methodArgs/2/value/sort()/callback: RANDOM_IN(true, false, null)  // 随机整数
methodArgs/2/value/sort()/return: ORDER_IN(true, false, null)  // 随机整数
methodArgs/2/value/setData(D)/callback: ORDER_IN(true, false, null)  // 顺序取值

  // 清空文本内容可查看规则', TO_DATE('2020-06-15 23:47:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236120511', '1592236063697', '82001', '1592232912349', '1', '-10, -9, 60, false, false, false', 'methodArgs/0/value: -10 
methodArgs/1/value: -9 
methodArgs/2/value/id: 60 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-06-15 23:48:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236129822', '1592236063697', '82001', '1592232912349', '1', '-10, -6, 93, null, false, false', 'methodArgs/0/value: -10 
methodArgs/1/value: -6 
methodArgs/2/value/id: 93 
methodArgs/2/value/sort()/callback: null 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-06-15 23:48:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236131622', '1592236063697', '82001', '1592232912349', '1', '1, -5, 29, true, null, null', 'methodArgs/0/value: 1 
methodArgs/1/value: -5 
methodArgs/2/value/id: 29 
methodArgs/2/value/sort()/callback: true 
methodArgs/2/value/sort()/return: null 
methodArgs/2/value/setData(D)/callback: null', TO_DATE('2020-06-15 23:48:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236138019', '1592236063697', '82001', '1592232912349', '1', '-10, -1, 46, false, true, true', 'methodArgs/0/value: -10 
methodArgs/1/value: -1 
methodArgs/2/value/id: 46 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: true 
methodArgs/2/value/setData(D)/callback: true', TO_DATE('2020-06-15 23:48:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236142525', '1592236063697', '82001', '1592232912349', '1', '-10, 2, 43, false, true, true', 'methodArgs/0/value: -10 
methodArgs/1/value: 2 
methodArgs/2/value/id: 43 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: true 
methodArgs/2/value/setData(D)/callback: true', TO_DATE('2020-06-15 23:49:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236143975', '1592236063697', '82001', '1592232912349', '1', '-10, 3, 68, false, false, false', 'methodArgs/0/value: -10 
methodArgs/1/value: 3 
methodArgs/2/value/id: 68 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-06-15 23:49:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236148039', '1592236063697', '82001', '1592232912349', '1', '-10, 6, 13, false, false, false', 'methodArgs/0/value: -10 
methodArgs/1/value: 6 
methodArgs/2/value/id: 13 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-06-15 23:49:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236219210', '1592236063697', '82001', '1592232912349', '1', '-10, -10, 35, null, true, true', 'methodArgs/0/value: -10 
methodArgs/1/value: -10 
methodArgs/2/value/id: 35 
methodArgs/2/value/sort()/callback: null 
methodArgs/2/value/sort()/return: true 
methodArgs/2/value/setData(D)/callback: true', TO_DATE('2020-06-15 23:50:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236222611', '1592236063697', '82001', '1592232912349', '1', '0.1, -9, 37, false, false, false', 'methodArgs/0/value: 0.1 
methodArgs/1/value: -9 
methodArgs/2/value/id: 37 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-06-15 23:50:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236224205', '1592236063697', '82001', '1592232912349', '1', '-10, -8, 58, false, null, null', 'methodArgs/0/value: -10 
methodArgs/1/value: -8 
methodArgs/2/value/id: 58 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: null 
methodArgs/2/value/setData(D)/callback: null', TO_DATE('2020-06-15 23:50:24', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236225905', '1592236063697', '82001', '1592232912349', '1', '0.1, -7, 97, true, true, true', 'methodArgs/0/value: 0.1 
methodArgs/1/value: -7 
methodArgs/2/value/id: 97 
methodArgs/2/value/sort()/callback: true 
methodArgs/2/value/sort()/return: true 
methodArgs/2/value/setData(D)/callback: true', TO_DATE('2020-06-15 23:50:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236234662', '1592236063697', '82001', '1592232912349', '1', '1, -3, 24, null, false, false', 'methodArgs/0/value: 1 
methodArgs/1/value: -3 
methodArgs/2/value/id: 24 
methodArgs/2/value/sort()/callback: null 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-06-15 23:50:34', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236238868', '1592236063697', '82001', '1592232912349', '1', '-10, 0, 87, false, false, false', 'methodArgs/0/value: -10 
methodArgs/1/value: 0 
methodArgs/2/value/id: 87 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-06-15 23:50:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236241680', '1592236063697', '82001', '1592232912349', '1', '0.1, 1, 16, false, null, null', 'methodArgs/0/value: 0.1 
methodArgs/1/value: 1 
methodArgs/2/value/id: 16 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: null 
methodArgs/2/value/setData(D)/callback: null', TO_DATE('2020-06-15 23:50:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236249655', '1592236063697', '82001', '1592232912349', '1', '0.1, -6, 94, true, false, false', 'methodArgs/0/value: 0.1 
methodArgs/1/value: -6 
methodArgs/2/value/id: 94 
methodArgs/2/value/sort()/callback: true 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-06-15 23:50:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236300946', '0', '82001', '1592232912349', '10', '随机配置 2020-06-15 23:51', 'methodArgs/0/value: RANDOM_IN(1, 2, -3, 5, -10, 12, 50)  // 随机取值
methodArgs/1/value: ORDER_INT(-10, 100)  // 顺序整数

methodArgs/2/value/id: RANDOM_INT(1, 100)  // 随机整数
methodArgs/2/value/sort()/callback: RANDOM_IN(true, false, null)  // 随机整数
methodArgs/2/value/sort()/return: ORDER_IN(true, false, null)  // 随机整数
methodArgs/2/value/setData(D)/callback: ORDER_IN(true, false, null)  // 顺序取值

  // 清空文本内容可查看规则', TO_DATE('2020-06-15 23:51:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236325414', '1592236300946', '82001', '1592232912349', '1', '5, -9, 89, false, false, false', 'methodArgs/0/value: 5 
methodArgs/1/value: -9 
methodArgs/2/value/id: 89 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-06-15 23:52:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236327093', '1592236300946', '82001', '1592232912349', '1', '12, -8, 57, false, null, null', 'methodArgs/0/value: 12 
methodArgs/1/value: -8 
methodArgs/2/value/id: 57 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: null 
methodArgs/2/value/setData(D)/callback: null', TO_DATE('2020-06-15 23:52:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236329908', '1592236300946', '82001', '1592232912349', '1', '2, -7, 72, null, true, true', 'methodArgs/0/value: 2 
methodArgs/1/value: -7 
methodArgs/2/value/id: 72 
methodArgs/2/value/sort()/callback: null 
methodArgs/2/value/sort()/return: true 
methodArgs/2/value/setData(D)/callback: true', TO_DATE('2020-06-15 23:52:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236331278', '1592236300946', '82001', '1592232912349', '1', '12, -6, 37, true, false, false', 'methodArgs/0/value: 12 
methodArgs/1/value: -6 
methodArgs/2/value/id: 37 
methodArgs/2/value/sort()/callback: true 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-06-15 23:52:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236332607', '1592236300946', '82001', '1592232912349', '1', '-3, -5, 56, null, null, null', 'methodArgs/0/value: -3 
methodArgs/1/value: -5 
methodArgs/2/value/id: 56 
methodArgs/2/value/sort()/callback: null 
methodArgs/2/value/sort()/return: null 
methodArgs/2/value/setData(D)/callback: null', TO_DATE('2020-06-15 23:52:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236337079', '1592236300946', '82001', '1592232912349', '1', '-3, -3, 29, false, false, false', 'methodArgs/0/value: -3 
methodArgs/1/value: -3 
methodArgs/2/value/id: 29 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-06-15 23:52:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236338392', '1592236300946', '82001', '1592232912349', '1', '1, -2, 81, false, null, null', 'methodArgs/0/value: 1 
methodArgs/1/value: -2 
methodArgs/2/value/id: 81 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: null 
methodArgs/2/value/setData(D)/callback: null', TO_DATE('2020-06-15 23:52:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236516817', '0', '82001', '1592232544326', '50', '随机配置 2020-06-15 23:55', 'methodArgs/0/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'')  // 顺序取值
methodArgs/0/value: RANDOM_IN(1, 2, -10, 9.99, null)  // 随机取值

methodArgs/1/type: ORDER_IN(''long'', ''double'', ''Number'', ''int'')  // 顺序取值
methodArgs/1/value: ORDER_INT(-10, 100)  // 顺序整数', TO_DATE('2020-06-15 23:55:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236538024', '1592236516817', '82001', '1592232544326', '1', 'long, -10, long, -10', 'methodArgs/0/type: "long" 
methodArgs/0/value: -10 
methodArgs/1/type: "long" 
methodArgs/1/value: -10', TO_DATE('2020-06-15 23:55:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236540298', '1592236516817', '82001', '1592232544326', '1', 'double, 1, double, -9', 'methodArgs/0/type: "double" 
methodArgs/0/value: 1 
methodArgs/1/type: "double" 
methodArgs/1/value: -9', TO_DATE('2020-06-15 23:55:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236541830', '1592236516817', '82001', '1592232544326', '1', 'Number, 2, Number, -8', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 2 
methodArgs/1/type: "Number" 
methodArgs/1/value: -8', TO_DATE('2020-06-15 23:55:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236545792', '1592236516817', '82001', '1592232544326', '1', 'long, -10, long, -6', 'methodArgs/0/type: "long" 
methodArgs/0/value: -10 
methodArgs/1/type: "long" 
methodArgs/1/value: -6', TO_DATE('2020-06-15 23:55:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236547836', '1592236516817', '82001', '1592232544326', '1', 'double, 2, double, -5', 'methodArgs/0/type: "double" 
methodArgs/0/value: 2 
methodArgs/1/type: "double" 
methodArgs/1/value: -5', TO_DATE('2020-06-15 23:55:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236549171', '1592236516817', '82001', '1592232544326', '1', 'Number, -10, Number, -4', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: -4', TO_DATE('2020-06-15 23:55:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236550384', '1592236516817', '82001', '1592232544326', '1', 'int, 9.99, int, -3', 'methodArgs/0/type: "int" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "int" 
methodArgs/1/value: -3', TO_DATE('2020-06-15 23:55:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236555400', '1592236516817', '82001', '1592232544326', '1', 'double, -10, double, -1', 'methodArgs/0/type: "double" 
methodArgs/0/value: -10 
methodArgs/1/type: "double" 
methodArgs/1/value: -1', TO_DATE('2020-06-15 23:55:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236558165', '1592236516817', '82001', '1592232544326', '1', 'Number, 9.99, Number, 0', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "Number" 
methodArgs/1/value: 0', TO_DATE('2020-06-15 23:55:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236560482', '1592236516817', '82001', '1592232544326', '1', 'long, null, long, 2', 'methodArgs/0/type: "long" 
methodArgs/0/value: null 
methodArgs/1/type: "long" 
methodArgs/1/value: 2', TO_DATE('2020-06-15 23:56:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236566594', '1592236516817', '82001', '1592232544326', '1', 'Number, -10, Number, 4', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 4', TO_DATE('2020-06-15 23:56:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236571068', '1592236516817', '82001', '1592232544326', '1', 'double, 1, double, 7', 'methodArgs/0/type: "double" 
methodArgs/0/value: 1 
methodArgs/1/type: "double" 
methodArgs/1/value: 7', TO_DATE('2020-06-15 23:56:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236573614', '1592236516817', '82001', '1592232544326', '1', 'Number, -10, Number, 8', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 8', TO_DATE('2020-06-15 23:56:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236575917', '1592236516817', '82001', '1592232544326', '1', 'long, 2, long, 10', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: 10', TO_DATE('2020-06-15 23:56:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236578178', '1592236516817', '82001', '1592232544326', '1', 'double, -10, double, 11', 'methodArgs/0/type: "double" 
methodArgs/0/value: -10 
methodArgs/1/type: "double" 
methodArgs/1/value: 11', TO_DATE('2020-06-15 23:56:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236579227', '1592236516817', '82001', '1592232544326', '1', 'Number, 1, Number, 12', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 1 
methodArgs/1/type: "Number" 
methodArgs/1/value: 12', TO_DATE('2020-06-15 23:56:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236580951', '1592236516817', '82001', '1592232544326', '1', 'int, -10, int, 13', 'methodArgs/0/type: "int" 
methodArgs/0/value: -10 
methodArgs/1/type: "int" 
methodArgs/1/value: 13', TO_DATE('2020-06-15 23:56:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236583191', '1592236516817', '82001', '1592232544326', '1', 'long, 2, long, 14', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: 14', TO_DATE('2020-06-15 23:56:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236587324', '1592236516817', '82001', '1592232544326', '1', 'double, 2, double, 15', 'methodArgs/0/type: "double" 
methodArgs/0/value: 2 
methodArgs/1/type: "double" 
methodArgs/1/value: 15', TO_DATE('2020-06-15 23:56:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236590200', '1592236516817', '82001', '1592232544326', '1', 'Number, 2, Number, 16', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 2 
methodArgs/1/type: "Number" 
methodArgs/1/value: 16', TO_DATE('2020-06-15 23:56:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236594434', '1592236516817', '82001', '1592232544326', '1', 'long, 1, long, 18', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 18', TO_DATE('2020-06-15 23:56:34', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236596915', '1592236516817', '82001', '1592232544326', '1', 'Number, -10, Number, 20', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 20', TO_DATE('2020-06-15 23:56:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236602791', '1592236516817', '82001', '1592232544326', '1', 'double, 2, double, 23', 'methodArgs/0/type: "double" 
methodArgs/0/value: 2 
methodArgs/1/type: "double" 
methodArgs/1/value: 23', TO_DATE('2020-06-15 23:56:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236604267', '1592236516817', '82001', '1592232544326', '1', 'Number, -10, Number, 24', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 24', TO_DATE('2020-06-15 23:56:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236607642', '1592236516817', '82001', '1592232544326', '1', 'long, 1, long, 26', 'methodArgs/0/type: "long" 
methodArgs/0/value: 1 
methodArgs/1/type: "long" 
methodArgs/1/value: 26', TO_DATE('2020-06-15 23:56:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236609138', '1592236516817', '82001', '1592232544326', '1', 'double, -10, double, 27', 'methodArgs/0/type: "double" 
methodArgs/0/value: -10 
methodArgs/1/type: "double" 
methodArgs/1/value: 27', TO_DATE('2020-06-15 23:56:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236611321', '1592236516817', '82001', '1592232544326', '1', 'Number, -10, Number, 28', 'methodArgs/0/type: "Number" 
methodArgs/0/value: -10 
methodArgs/1/type: "Number" 
methodArgs/1/value: 28', TO_DATE('2020-06-15 23:56:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236615311', '1592236516817', '82001', '1592232544326', '1', 'long, -10, long, 30', 'methodArgs/0/type: "long" 
methodArgs/0/value: -10 
methodArgs/1/type: "long" 
methodArgs/1/value: 30', TO_DATE('2020-06-15 23:56:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236620361', '1592236516817', '82001', '1592232544326', '1', 'Number, 9.99, Number, 32', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "Number" 
methodArgs/1/value: 32', TO_DATE('2020-06-15 23:57:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236623833', '1592236516817', '82001', '1592232544326', '1', 'long, 2, long, 34', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: 34', TO_DATE('2020-06-15 23:57:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236627517', '1592236516817', '82001', '1592232544326', '1', 'Number, 9.99, Number, 36', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "Number" 
methodArgs/1/value: 36', TO_DATE('2020-06-15 23:57:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236631345', '1592236516817', '82001', '1592232544326', '1', 'long, 2, long, 38', 'methodArgs/0/type: "long" 
methodArgs/0/value: 2 
methodArgs/1/type: "long" 
methodArgs/1/value: 38', TO_DATE('2020-06-15 23:57:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236633127', '1592236516817', '82001', '1592232544326', '1', 'double, 2, double, 39', 'methodArgs/0/type: "double" 
methodArgs/0/value: 2 
methodArgs/1/type: "double" 
methodArgs/1/value: 39', TO_DATE('2020-06-15 23:57:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236688771', '0', '82001', '1592232544326', '10', '随机配置 2020-06-15 23:58', 'methodArgs/0/type: ORDER_IN(''long'', ''double'', ''Number'')  // 顺序取值
methodArgs/0/value: RANDOM_IN(1, 2, -10, 9.99, 0, null)  // 随机取值

methodArgs/1/type: ORDER_IN(''long'', ''double'', ''Number'')  // 顺序取值
methodArgs/1/value: ORDER_INT(-10, 100)  // 顺序整数', TO_DATE('2020-06-15 23:58:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236698823', '1592236688771', '82001', '1592232544326', '1', 'long, -10, long, -10', 'methodArgs/0/type: "long" 
methodArgs/0/value: -10 
methodArgs/1/type: "long" 
methodArgs/1/value: -10', TO_DATE('2020-06-15 23:58:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236700066', '1592236688771', '82001', '1592232544326', '1', 'double, 0, double, -9', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0 
methodArgs/1/type: "double" 
methodArgs/1/value: -9', TO_DATE('2020-06-15 23:58:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236701104', '1592236688771', '82001', '1592232544326', '1', 'Number, 1, Number, -8', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 1 
methodArgs/1/type: "Number" 
methodArgs/1/value: -8', TO_DATE('2020-06-15 23:58:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236702454', '1592236688771', '82001', '1592232544326', '1', 'long, 9.99, long, -7', 'methodArgs/0/type: "long" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "long" 
methodArgs/1/value: -7', TO_DATE('2020-06-15 23:58:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236705390', '1592236688771', '82001', '1592232544326', '1', 'double, 0, double, -6', 'methodArgs/0/type: "double" 
methodArgs/0/value: 0 
methodArgs/1/type: "double" 
methodArgs/1/value: -6', TO_DATE('2020-06-15 23:58:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236706512', '1592236688771', '82001', '1592232544326', '1', 'Number, 9.99, Number, -5', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 9.99 
methodArgs/1/type: "Number" 
methodArgs/1/value: -5', TO_DATE('2020-06-15 23:58:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236709153', '1592236688771', '82001', '1592232544326', '1', 'long, -10, long, -4', 'methodArgs/0/type: "long" 
methodArgs/0/value: -10 
methodArgs/1/type: "long" 
methodArgs/1/value: -4', TO_DATE('2020-06-15 23:58:29', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236711390', '1592236688771', '82001', '1592232544326', '1', 'double, 2, double, -3', 'methodArgs/0/type: "double" 
methodArgs/0/value: 2 
methodArgs/1/type: "double" 
methodArgs/1/value: -3', TO_DATE('2020-06-15 23:58:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236713133', '1592236688771', '82001', '1592232544326', '1', 'Number, 1, Number, -2', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 1 
methodArgs/1/type: "Number" 
methodArgs/1/value: -2', TO_DATE('2020-06-15 23:58:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236731951', '1592236516817', '82001', '1592232544326', '1', 'double, 1, double, -9', 'methodArgs/0/type: "double" 
methodArgs/0/value: 1 
methodArgs/1/type: "double" 
methodArgs/1/value: -9', TO_DATE('2020-06-15 23:58:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1592236733731', '1592236516817', '82001', '1592232544326', '1', 'Number, 1, Number, -8', 'methodArgs/0/type: "Number" 
methodArgs/0/value: 1 
methodArgs/1/type: "Number" 
methodArgs/1/value: -8', TO_DATE('2020-06-15 23:58:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1594457036085', '1592236300946', '82001', '1592232912349', '1', '2, -9, 7, true, false, false', 'methodArgs/0/value: 2 
methodArgs/1/value: -9 
methodArgs/2/value/id: 7 
methodArgs/2/value/sort()/callback: true 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-07-11 16:43:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1594457184597', '1592236300946', '82001', '1592232912349', '1', '5, -8, 72, true, null, null', 'methodArgs/0/value: 5 
methodArgs/1/value: -8 
methodArgs/2/value/id: 72 
methodArgs/2/value/sort()/callback: true 
methodArgs/2/value/sort()/return: null 
methodArgs/2/value/setData(D)/callback: null', TO_DATE('2020-07-11 16:46:24', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1594457295834', '1592236063697', '82001', '1592232912349', '1', '-10, -10, 83, false, true, true', 'methodArgs/0/value: -10 
methodArgs/1/value: -10 
methodArgs/2/value/id: 83 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: true 
methodArgs/2/value/setData(D)/callback: true', TO_DATE('2020-07-11 16:48:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1594457297410', '1592236063697', '82001', '1592232912349', '1', 'null, -9, 28, null, false, false', 'methodArgs/0/value: null 
methodArgs/1/value: -9 
methodArgs/2/value/id: 28 
methodArgs/2/value/sort()/callback: null 
methodArgs/2/value/sort()/return: false 
methodArgs/2/value/setData(D)/callback: false', TO_DATE('2020-07-11 16:48:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1594457298916', '1592236063697', '82001', '1592232912349', '1', '-10, -8, 52, true, null, null', 'methodArgs/0/value: -10 
methodArgs/1/value: -8 
methodArgs/2/value/id: 52 
methodArgs/2/value/sort()/callback: true 
methodArgs/2/value/sort()/return: null 
methodArgs/2/value/setData(D)/callback: null', TO_DATE('2020-07-11 16:48:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1594470112124', '1592236300946', '82001', '1592232912349', '1', '12, -10, 42, false, true, true', 'methodArgs/0/value: 12 
methodArgs/1/value: -10 
methodArgs/2/value/id: 42 
methodArgs/2/value/sort()/callback: false 
methodArgs/2/value/sort()/return: true 
methodArgs/2/value/setData(D)/callback: true', TO_DATE('2020-07-11 20:21:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1595232174907', '0', '82001', '1595230510865', '1', 'order1-5', 'methodArgs/1/value: ORDER_INT(1,5)', TO_DATE('2020-07-20 16:02:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1595232196860', '1595232174907', '82001', '1595230510865', '1', '1', 'methodArgs/1/value: 1', TO_DATE('2020-07-20 16:03:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603012413149', '0', '82001', '1603012413040', '1', '默认配置(上传测试用例时自动生成)', 'static: ORDER_IN(undefined, null, false, true)
methodArgs: ORDER_IN(undefined, null, [], [{"type":"long","value":1}], [{"type":"long","value":2}], [{"type":"long","value":1},{"type":"long","value":2}])', TO_DATE('2020-10-18 17:13:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603012799802', '0', '82001', '1603012799703', '1', '默认配置(上传测试用例时自动生成)', 'static: ORDER_IN(undefined, null, false, true)
methodArgs: ORDER_IN(undefined, null, [], [{"type":"long","value":1}], [{"type":"long","value":2}], [{"type":"long","value":1},{"type":"long","value":2}])', TO_DATE('2020-10-18 17:19:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603012998586', '0', '82001', '1603012998480', '1', '默认配置(上传测试用例时自动生成)', 'static: ORDER_IN(undefined, null, false, true)
methodArgs: ORDER_IN(undefined, null, [], [{"type":"long","value":1}], [{"type":"long","value":2}], [{"type":"long","value":1},{"type":"long","value":2}])', TO_DATE('2020-10-18 17:23:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603015545325', '0', '82001', '1603015545204', '1', '默认配置(上传测试用例时自动生成)', 'static: ORDER_IN(undefined, null, false, true)
methodArgs: ORDER_IN(undefined, null, [], [{"type":"long","value":75}], [{"type":"apijson.demo.server.MathUtil$Callback","value":{"minusAsId(long,long)":{},"currentTime()":{"type":"long","return":8},"sort()":{"type":"Boolean","return":true},"setA(L)":{},"setData(D)":{"callback":true},"getA()":{"type":"Object"},"getB()":{"type":"Object"},"setB(L)":{},"getData()":{"type":"Object"},"setId(L)":{},"append(L,L)":{"type":"String","return":"Uex"},"getId()":{"type":"Object"}}}], [{"type":"long","value":87}], [{"type":"long","value":75},{"type":"long","value":87},{"type":"apijson.demo.server.MathUtil$Callback","value":{"minusAsId(long,long)":{},"currentTime()":{"type":"long","return":8},"sort()":{"type":"Boolean","return":true},"setA(L)":{},"setData(D)":{"callback":true},"getA()":{"type":"Object"},"getB()":{"type":"Object"},"setB(L)":{},"getData()":{"type":"Object"},"setId(L)":{},"append(L,L)":{"type":"String","return":"Uex"},"getId()":{"type":"Object"}}}])', TO_DATE('2020-10-18 18:05:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603015723182', '0', '82001', '1603015723077', '1', '默认配置(上传测试用例时自动生成)', 'static: ORDER_IN(undefined, null, false, true)
methodArgs: ORDER_IN(undefined, null, [], [{"type":"Number","value":5.9139310449596305}], [{"type":"Number","value":17.409419140887884}], [{"type":"Number","value":5.9139310449596305},{"type":"Number","value":17.409419140887884}])', TO_DATE('2020-10-18 18:08:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603817773749', '0', '82001', '1603817773655', '1', '默认配置(上传测试用例时自动生成)', 'static: ORDER_IN(undefined, null, false, true)
methodArgs: ORDER_IN(undefined, null, [], [{"type":"unitauto.test.TestEnum","value":"WOMAN"}])', TO_DATE('2020-10-28 00:56:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603817803298', '0', '82001', '1603817803198', '1', '默认配置(上传测试用例时自动生成)', 'static: ORDER_IN(undefined, null, false, true)
methodArgs: ORDER_IN(undefined, null, [], ["unitauto.test.TestEnum:"])', TO_DATE('2020-10-28 00:56:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603817836597', '0', '82001', '1603817836500', '1', '默认配置(上传测试用例时自动生成)', 'methodArgs: ORDER_IN(undefined, null, [], [{"type":"String","value":"time"}])', TO_DATE('2020-10-28 00:57:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603817850929', '0', '82001', '1603817850838', '1', '默认配置(上传测试用例时自动生成)', 'methodArgs: ORDER_IN(undefined, null, [], [{"type":"String","value":"id"}])', TO_DATE('2020-10-28 00:57:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603817867454', '0', '82001', '1603817867359', '1', '默认配置(上传测试用例时自动生成)', 'methodArgs: ORDER_IN(undefined, null, [], [{"type":"java.lang.annotation.Annotation","value":{"required()":true}}])', TO_DATE('2020-10-28 00:57:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603817892989', '0', '82001', '1603817892889', '1', '默认配置(上传测试用例时自动生成)', 'methodArgs: ORDER_IN(undefined, null, [], [{"type":"unitauto.test.TestAnnotation","value":{"required()":true}}])', TO_DATE('2020-10-28 00:58:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603817910364', '0', '82001', '1603817910196', '1', '默认配置(上传测试用例时自动生成)', 'methodArgs: ORDER_IN(undefined, null, [])', TO_DATE('2020-10-28 00:58:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603817929802', '0', '82001', '1603817929709', '1', '默认配置(上传测试用例时自动生成)', 'constructor: ORDER_IN(undefined, null, "", "getDefault")
methodArgs: ORDER_IN(undefined, null, [])', TO_DATE('2020-10-28 00:58:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603817963919', '0', '82001', '1603817963818', '1', '默认配置(上传测试用例时自动生成)', 'constructor: ORDER_IN(undefined, null, "", "getInstance")
classArgs: ORDER_IN(undefined, null, [], ["boolean:false"])
methodArgs: ORDER_IN(undefined, null, [], ["get instance with args"])', TO_DATE('2020-10-28 00:59:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603817981918', '0', '82001', '1603817981819', '1', '默认配置(上传测试用例时自动生成)', 'constructor: ORDER_IN(undefined, null, "", "getDefault")
methodArgs: ORDER_IN(undefined, null, [])', TO_DATE('2020-10-28 00:59:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603820036944', '0', '82001', '1603820036845', '1', '默认配置(上传测试用例时自动生成)', 'methodArgs: ORDER_IN(undefined, null, [], [{"type":"String","value":"id"}])', TO_DATE('2020-10-28 01:33:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1603822242693', '0', '82001', '1603822242584', '1', '默认配置(上传测试用例时自动生成)', 'methodArgs: ORDER_IN(undefined, null, [])
this/type: ORDER_IN(undefined, null, "", "unitauto.test.TestSingleton")
this/value/name: ORDER_IN(undefined, null, "", "Test")', TO_DATE('2020-10-28 02:10:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1604152910319', '0', '82001', '1604152910192', '1', '默认配置(上传测试用例时自动生成)', 'methodArgs: ORDER_IN(undefined, null, [], ["int:3"])', TO_DATE('2020-10-31 22:01:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1612027165493', '0', '82001', '1612027165354', '1', '默认配置(上传测试用例时自动生成)', 'ViewTable/id: ORDER_IN(undefined, null, 82001)
  // 可替代上面的 ViewTable/id: RANDOM_INT(1, 820010)', TO_DATE('2021-01-31 01:19:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1612028057097', '0', '82001', '1612028056928', '1', '默认配置(上传测试用例时自动生成)', 'User[]/count: ORDER_IN(undefined, null, 0, 1, 5, 10, 20, 3)
User[]/User/date%: ORDER_IN(undefined, null, "", "2017-10-01,2018-10-01")', TO_DATE('2021-01-31 01:34:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1612028084918', '0', '82001', '1612028084784', '1', '默认配置(上传测试用例时自动生成)', 'User[]/count: ORDER_IN(undefined, null, 0, 1, 5, 10, 20, 3)
User[]/User/date%: ORDER_IN(undefined, null, "", "2017-10-01,2018-10-01")', TO_DATE('2021-01-31 01:34:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1612030537572', '0', '82001', '1612030537309', '1', '默认配置(上传测试用例时自动生成)', '[]/count: ORDER_IN(undefined, null, 0, 1, 5, 10, 20, 3)
[]/[]/count: ORDER_IN(undefined, null, 0, 1, 5, 10, 20, 6)', TO_DATE('2021-01-31 02:15:37', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1612031258049', '0', '82001', '1612031257907', '1', '默认配置(上传测试用例时自动生成)', '[]/join: ORDER_IN(undefined, null, "", "</Moment/id@")', TO_DATE('2021-01-31 02:27:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1612031277280', '0', '82001', '1612031277117', '1', '默认配置(上传测试用例时自动生成)', '[]/join: ORDER_IN(undefined, null, "", "</Moment/id@")', TO_DATE('2021-01-31 02:27:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1612031347491', '0', '82001', '1612031347328', '1', '默认配置(上传测试用例时自动生成)', '[]/join: ORDER_IN(undefined, null, "", "&/Moment/id@")
[]/ViewTable/toId: ORDER_IN(undefined, null, 0)
  // 可替代上面的 []/ViewTable/toId: RANDOM_INT(1, 0)
[]/Moment/content~: ORDER_IN(undefined, null, "", "a")', TO_DATE('2021-01-31 02:29:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1612031662513', '0', '82001', '1612031662371', '1', '默认配置(上传测试用例时自动生成)', 'ViewTable[]/ViewTable/toId: ORDER_IN(undefined, null, 0)
  // 可替代上面的 ViewTable[]/ViewTable/toId: RANDOM_INT(1, 0)
ViewTable[]/ViewTable/content~: ORDER_IN(undefined, null, "", "a")', TO_DATE('2021-01-31 02:34:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1612031683745', '0', '82001', '1612031683608', '1', '默认配置(上传测试用例时自动生成)', 'ViewTable/id: ORDER_IN(undefined, null, 82001)
  // 可替代上面的 ViewTable/id: RANDOM_INT(1, 820010)', TO_DATE('2021-01-31 02:34:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041597430', '1575129210368', '82001', '1560244940013', '1', '82002, 0, 10, 4, undefined', 'User/id: 82002
User/sex: 0
[]/count: 10
[]/page: 4
// []/Comment/toId: undefined', TO_DATE('2021-02-11 19:06:37', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041599009', '1575129210368', '82001', '1560244940013', '1', '82002, 1, 1, 3, undefined', 'User/id: 82002
User/sex: 1
[]/count: "1"
[]/page: 3
// []/Comment/toId: undefined', TO_DATE('2021-02-11 19:06:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041618772', '1575129533653', '82001', '1560244940013', '1', 'false', '[]/count: false', TO_DATE('2021-02-11 19:06:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041620394', '1575129533653', '82001', '1560244940013', '1', '10', '[]/count: 10', TO_DATE('2021-02-11 19:07:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041625948', '1575129533653', '82001', '1560244940013', '1', 's', '[]/count: "s"', TO_DATE('2021-02-11 19:07:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041643148', '1575129533653', '82001', '1560244940013', '1', '[]', '[]/count: []', TO_DATE('2021-02-11 19:07:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041650211', '1575129533653', '82001', '1560244940013', '1', '20', '[]/count: 20', TO_DATE('2021-02-11 19:07:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041651772', '1575129533653', '82001', '1560244940013', '1', '5', '[]/count: 5', TO_DATE('2021-02-11 19:07:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041973322', '0', '82001', '1511689914599', '8', '不同 id，测试越权操作: 只有和当期测试账号 id 相同时才成功返回余额等，其它报错', 'Privacy/id: ORDER_IN(38710, 70793, 82001, 82002, 82003, 82004, 82005, 93793)', TO_DATE('2021-02-11 19:12:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041987408', '1613041973322', '82001', '1511689914599', '1', '38710', 'Privacy/id: 38710', TO_DATE('2021-02-11 19:13:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041989776', '1613041973322', '82001', '1511689914599', '1', '70793', 'Privacy/id: 70793', TO_DATE('2021-02-11 19:13:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041991148', '1613041973322', '82001', '1511689914599', '1', '82001', 'Privacy/id: 82001', TO_DATE('2021-02-11 19:13:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041997568', '1613041973322', '82001', '1511689914599', '1', '82002', 'Privacy/id: 82002', TO_DATE('2021-02-11 19:13:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041998081', '1613041973322', '82001', '1511689914599', '1', '82003', 'Privacy/id: 82003', TO_DATE('2021-02-11 19:13:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041998485', '1613041973322', '82001', '1511689914599', '1', '82004', 'Privacy/id: 82004', TO_DATE('2021-02-11 19:13:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613041999900', '1613041973322', '82001', '1511689914599', '1', '93793', 'Privacy/id: 93793', TO_DATE('2021-02-11 19:13:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613042000312', '1613041973322', '82001', '1511689914599', '1', '82005', 'Privacy/id: 82005', TO_DATE('2021-02-11 19:13:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062371800', '1575129210368', '82001', '1560244940013', '1', '82002, 2, [], 3, undefined', 'User/id: 82002
User/sex: 2
[]/count: []
[]/page: 3
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:52:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062373291', '1575129210368', '82001', '1560244940013', '1', '82001, 1, {}, 9, undefined', 'User/id: 82001
User/sex: 1
[]/count: {}
[]/page: 9
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:52:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062374244', '1575129210368', '82001', '1560244940013', '1', '70793, 1, false, 0, undefined', 'User/id: 70793
User/sex: 1
[]/count: false
[]/page: 0
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:52:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062375301', '1575129210368', '82001', '1560244940013', '1', '82001, 1, [], 2, undefined', 'User/id: 82001
User/sex: 1
[]/count: []
[]/page: 2
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:52:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062375760', '1575129210368', '82001', '1560244940013', '1', '82003, 1, 1, 0, undefined', 'User/id: 82003
User/sex: 1
[]/count: "1"
[]/page: 0
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:52:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062376541', '1575129210368', '82001', '1560244940013', '1', '70793, 1, 10, 5, undefined', 'User/id: 70793
User/sex: 1
[]/count: 10
[]/page: 5
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:52:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062377272', '1575129210368', '82001', '1560244940013', '1', '82001, 1, 20, 6, undefined', 'User/id: 82001
User/sex: 1
[]/count: 20
[]/page: 6
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:52:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062377632', '1575129210368', '82001', '1560244940013', '1', '82001, 1, 3, 2, undefined', 'User/id: 82001
User/sex: 1
[]/count: 3
[]/page: 2
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:52:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062379011', '1575129210368', '82001', '1560244940013', '1', '70793, 0, 5, 8, undefined', 'User/id: 70793
User/sex: 0
[]/count: 5
[]/page: 8
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:52:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062379380', '1575129210368', '82001', '1560244940013', '1', '70793, 1, false, 2, undefined', 'User/id: 70793
User/sex: 1
[]/count: false
[]/page: 2
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:52:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062379970', '1575129210368', '82001', '1560244940013', '1', '70793, 0, 1, 8, undefined', 'User/id: 70793
User/sex: 0
[]/count: "1"
[]/page: 8
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:52:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062380560', '1575129210368', '82001', '1560244940013', '1', '70793, 1, 1, 0, undefined', 'User/id: 70793
User/sex: 1
[]/count: "1"
[]/page: 0
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:53:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062381525', '1575129210368', '82001', '1560244940013', '1', '82001, 1, [], 5, undefined', 'User/id: 82001
User/sex: 1
[]/count: []
[]/page: 5
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:53:01', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062381942', '1575129210368', '82001', '1560244940013', '1', '82003, 1, false, 8, undefined', 'User/id: 82003
User/sex: 1
[]/count: false
[]/page: 8
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:53:01', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062383638', '1575129210368', '82001', '1560244940013', '1', '70793, 1, 3, 1, undefined', 'User/id: 70793
User/sex: 1
[]/count: 3
[]/page: 1
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:53:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062384000', '1575129210368', '82001', '1560244940013', '1', '82002, 2, s, 3, undefined', 'User/id: 82002
User/sex: 2
[]/count: "s"
[]/page: 3
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:53:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062384973', '1575129210368', '82001', '1560244940013', '1', '82003, 2, 1, 3, undefined', 'User/id: 82003
User/sex: 2
[]/count: "1"
[]/page: 3
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:53:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062674328', '0', '82001', '1560244940013', '8', 'count 和 page: 啥都可能', '[]/count: RANDOM_IN(3,5,10,20,''1'',''s'',false,[],{})  // 从这几个值随机取数 
[]/page: Math.round(10*Math.random())  // 通过代码来自定义
  // []/Comment/toId: RANDOM_DB()  // 从数据库随机取值，替换 User/id 键值对', TO_DATE('2021-02-12 00:57:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062685979', '1613062674328', '82001', '1560244940013', '1', '1, 7, undefined', '[]/count: "1"
[]/page: 7
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:58:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062705382', '1613062674328', '82001', '1560244940013', '1', '3, 9, undefined', '[]/count: 3
[]/page: 9
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:58:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062707620', '1613062674328', '82001', '1560244940013', '1', '20, 8, undefined', '[]/count: 20
[]/page: 8
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:58:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062708990', '1613062674328', '82001', '1560244940013', '1', '10, 7, undefined', '[]/count: 10
[]/page: 7
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:58:28', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062710032', '1613062674328', '82001', '1560244940013', '1', '10, 0, undefined', '[]/count: 10
[]/page: 0
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:58:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062711516', '1613062674328', '82001', '1560244940013', '1', '10, 6, undefined', '[]/count: 10
[]/page: 6
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:58:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062712506', '1613062674328', '82001', '1560244940013', '1', '3, 5, undefined', '[]/count: 3
[]/page: 5
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:58:32', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062764498', '1613062674328', '82001', '1560244940013', '1', 's, 10, undefined', '[]/count: "s"
[]/page: 10
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:59:24', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062794640', '1575129210368', '82001', '1560244940013', '1', '70793, 1, [], 6, undefined', 'User/id: 70793
User/sex: 1
[]/count: []
[]/page: 6
// []/Comment/toId: undefined', TO_DATE('2021-02-12 00:59:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062800917', '1575129533653', '82001', '1560244940013', '1', '[]', '[]/count: []', TO_DATE('2021-02-12 01:00:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Random" VALUES ('1613062804128', '1575129533653', '82001', '1560244940013', '1', '20', '[]/count: 20', TO_DATE('2021-02-12 01:00:04', 'SYYYY-MM-DD HH24:MI:SS'));
