-- ----------------------------
-- Table structure for apijson_user
-- ----------------------------
DROP TABLE IF EXISTS "apijson_user" CASCADE;
CREATE TABLE "apijson_user" (
  "id" NUMBER(20) NOT NULL,
  "sex" NUMBER(4) NOT NULL,
  "name" NVARCHAR2(20),
  "tag" NVARCHAR2(45),
  "head" NVARCHAR2(300),
  "contactIdList" CLOB,
  "pictureList" CLOB,
  "date" DATE
)
;
COMMENT ON COLUMN "apijson_user"."id" IS '唯一标识';
COMMENT ON COLUMN "apijson_user"."sex" IS '性别：
0-男
1-女';
COMMENT ON COLUMN "apijson_user"."name" IS '名称';
COMMENT ON COLUMN "apijson_user"."tag" IS '标签';
COMMENT ON COLUMN "apijson_user"."head" IS '头像url';
COMMENT ON COLUMN "apijson_user"."contactIdList" IS '联系人id列表';
COMMENT ON COLUMN "apijson_user"."pictureList" IS '照片列表';
COMMENT ON COLUMN "apijson_user"."date" IS '创建日期';
COMMENT ON TABLE "apijson_user" IS '用户公开信息表。
对安全要求高，不想泄漏真实名称。对外名称为 User';

-- ----------------------------
-- Records of apijson_user
-- ----------------------------
INSERT INTO "apijson_user" VALUES ('38710', '0', 'TommyLemon', 'Android&Java', 'http://static.oschina.net/uploads/user/1218/2437072_100.jpg?t=1461076033000', '[82003, 82005, 90814, 82004, 82009, 82002, 82044, 93793, 70793]', '["http://static.oschina.net/uploads/user/1218/2437072_100.jpg?t=1461076033000", "http://common.cnblogs.com/images/icon_weibo_24.png"]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('70793', '0', 'Strong', 'djdj', 'http://static.oschina.net/uploads/user/585/1170143_50.jpg?t=1390226446000', '[38710, 82002]', '["http://static.oschina.net/uploads/img/201604/22172508_eGDi.jpg", "http://static.oschina.net/uploads/img/201604/22172507_rrZ5.jpg", "https://camo.githubusercontent.com/788c0a7e11a", "https://camo.githubusercontent.com/f513f67"]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82001', '0', '测试账号', 'Dev', 'https://avatars2.githubusercontent.com/u/19383298?s=460&u=b0af1193a77e285255faaf9b9fe1d9c399756d73&v=4', '[82034, 82005, 38710, 82035, 82002, 82025, 93793, 1524042900591]', '["http://common.cnblogs.com/images/icon_weibo_24.png"]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82002', '1', 'Happy~', 'iOS', 'http://static.oschina.net/uploads/user/1174/2348263_50.png?t=1439773471000', '[82005, 82001, 38710]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82003', '0', 'Wechat', NULL, 'http://common.cnblogs.com/images/wechat.png', '[82001, 93793]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82004', '0', 'Tommy', 'fasef', 'http://static.oschina.net/uploads/user/1200/2400261_50.png?t=1439638750000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82005', '1', 'Jan', 'AG', 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82001, 38710, 1532439021068]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82006', '1', 'Meria', NULL, 'http://static.oschina.net/uploads/user/998/1997902_50.jpg?t=1407806577000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82009', '0', 'God', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82012', '0', 'Steve', 'FEWE', 'http://static.oschina.net/uploads/user/1/3064_50.jpg?t=1449566001000', '[82004, 82002, 93793]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82020', '0', 'ORANGE', NULL, 'http://static.oschina.net/uploads/user/48/96289_50.jpg?t=1452751699000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82021', '1', 'Tommy', NULL, 'http://static.oschina.net/uploads/user/19/39085_50.jpg', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82022', '0', 'Internet', NULL, 'http://static.oschina.net/uploads/user/1332/2664107_50.jpg?t=1457405500000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82023', '0', 'No1', NULL, 'http://static.oschina.net/uploads/user/1385/2770216_50.jpg?t=1464405516000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82024', '0', 'Lemon', NULL, 'http://static.oschina.net/uploads/user/427/855532_50.jpg?t=1435030876000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82025', '1', 'Tommy', NULL, 'http://static.oschina.net/uploads/user/629/1258821_50.jpg?t=1378063141000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82026', '0', 'iOS', NULL, 'http://static.oschina.net/uploads/user/1200/2400261_50.png?t=1439638750000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82027', '0', 'Yong', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82028', '1', 'gaeg', NULL, 'http://static.oschina.net/uploads/user/585/1170143_50.jpg?t=1390226446000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82029', '0', 'GASG', NULL, 'http://common.cnblogs.com/images/wechat.png', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82030', '1', 'Fun', NULL, 'http://static.oschina.net/uploads/user/998/1997902_50.jpg?t=1407806577000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82031', '0', 'Lemon', NULL, 'http://static.oschina.net/uploads/user/48/96331_50.jpg', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82032', '0', 'Stack', 'fasdg', 'http://static.oschina.net/uploads/user/1385/2770216_50.jpg?t=1464405516000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82033', '1', 'GAS', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82034', '1', 'Jump', NULL, 'http://static.oschina.net/uploads/user/1332/2664107_50.jpg?t=1457405500000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82035', '1', 'Tab', NULL, 'http://static.oschina.net/uploads/user/629/1258821_50.jpg?t=1378063141000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82036', '0', 'SAG', NULL, 'http://static.oschina.net/uploads/user/1332/2664107_50.jpg?t=1457405500000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82037', '0', 'Test', NULL, 'http://static.oschina.net/uploads/user/1200/2400261_50.png?t=1439638750000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82038', '0', 'Battle', NULL, 'http://static.oschina.net/uploads/user/48/96289_50.jpg?t=1452751699000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82039', '1', 'Everyday', NULL, 'http://common.cnblogs.com/images/icon_weibo_24.png', '[]', '[]', TO_DATE('2017-02-19 21:57:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82040', '1', 'Dream', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[70793]', '[]', TO_DATE('2017-03-03 00:44:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82041', '0', 'Holo', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[38710, 82001]', '[]', TO_DATE('2017-03-04 17:59:34', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82042', '1', 'Why', NULL, 'http://static.oschina.net/uploads/user/585/1170143_50.jpg?t=1390226446000', '[]', '[]', TO_DATE('2017-03-04 18:04:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82043', '0', 'Holiday', NULL, 'http://static.oschina.net/uploads/user/998/1997902_50.jpg?t=1407806577000', '[70793, 82006]', '[]', TO_DATE('2017-03-04 18:05:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82044', '1', 'Love', NULL, 'http://static.oschina.net/uploads/user/1174/2348263_50.png?t=1439773471000', '[82006]', '[]', TO_DATE('2017-03-04 18:20:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82045', '0', 'Green', NULL, 'http://common.cnblogs.com/images/wechat.png', '[82001, 82002, 82003, 1485246481130]', '[]', TO_DATE('2017-03-04 18:22:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82046', '0', 'Team', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[38710, 82002, 1485246481130]', '[]', TO_DATE('2017-03-04 23:11:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82047', '0', 'Tesla', NULL, 'http://common.cnblogs.com/images/wechat.png', '[]', '[]', TO_DATE('2017-03-05 00:02:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82048', '0', 'Moto', NULL, 'http://static.oschina.net/uploads/user/48/96289_50.jpg?t=1452751699000', '[]', '[]', TO_DATE('2017-03-05 00:04:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82049', '0', 'ITMan', NULL, 'http://static.oschina.net/uploads/user/629/1258821_50.jpg?t=1378063141000', '[]', '[]', TO_DATE('2017-03-05 17:51:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82050', '0', 'Parl', NULL, 'http://static.oschina.net/uploads/user/998/1997902_50.jpg?t=1407806577000', '[]', '[]', TO_DATE('2017-03-05 17:52:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82051', '0', 'Girl', NULL, 'http://static.oschina.net/uploads/user/1332/2664107_50.jpg?t=1457405500000', '[]', '[]', TO_DATE('2017-03-05 17:53:37', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82052', '0', 'Unbrella', NULL, 'http://static.oschina.net/uploads/user/1385/2770216_50.jpg?t=1464405516000', '[]', '[]', TO_DATE('2017-03-05 17:57:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82053', '0', 'Alice', NULL, 'http://common.cnblogs.com/images/wechat.png', '[]', '[]', TO_DATE('2017-03-05 23:25:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82054', '0', 'Harvey', NULL, 'http://static.oschina.net/uploads/user/19/39085_50.jpg', '[]', '[]', TO_DATE('2017-03-06 20:29:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82055', '1', 'Solid', NULL, 'http://static.oschina.net/uploads/user/19/39085_50.jpg', '[38710, 82002]', '[]', TO_DATE('2017-03-11 23:04:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82056', '1', 'IronMan', NULL, 'http://static.oschina.net/uploads/user/48/96289_50.jpg?t=1452751699000', '[]', '[]', TO_DATE('2017-03-11 23:32:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82057', '0', 'NullPointerExeption', NULL, 'http://static.oschina.net/uploads/user/1385/2770216_50.jpg?t=1464405516000', '[]', '[]', TO_DATE('2017-03-12 14:01:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82058', '0', 'StupidBird', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82001, 82002]', '[]', TO_DATE('2017-03-12 19:23:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82059', '1', 'He&She', NULL, 'http://static.oschina.net/uploads/user/585/1170143_50.jpg?t=1390226446000', '[]', '[]', TO_DATE('2017-03-19 22:49:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('82060', '1', 'Anyway~', NULL, 'http://static.oschina.net/uploads/user/1/3064_50.jpg?t=1449566001000', '[]', '[]', TO_DATE('2017-03-21 22:10:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('88888', '0', '管理员', '管理员', 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2021-01-31 02:52:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('90814', '0', '007', NULL, 'http://static.oschina.net/uploads/user/51/102723_50.jpg?t=1449212504000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('93793', '0', 'Mike', 'GES', 'http://static.oschina.net/uploads/user/48/96331_50.jpg', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('93794', '0', 'Lemon', NULL, 'http://static.oschina.net/uploads/user/48/97721_50.jpg?t=1451544779000', '[]', '[]', TO_DATE('2017-02-01 19:21:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('99999', '0', '贡献者', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2021-01-31 02:53:01', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1490109742863', '1', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-03-21 23:22:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1490109845208', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-03-21 23:24:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1490420651686', '1', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[70793]', '[]', TO_DATE('2017-03-25 13:44:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1490427139175', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[38710, 70793]', '[]', TO_DATE('2017-03-25 15:32:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1490427577823', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-03-25 15:39:37', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1490584952968', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-03-27 11:22:32', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1490973670928', '1', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[70793, 93793]', '[]', TO_DATE('2017-03-31 23:21:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1492936169722', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-04-23 16:29:29', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1493480142628', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-04-29 23:35:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1493747512860', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-05-03 01:51:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1493747777770', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-05-03 01:56:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1493748594003', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-05-03 02:09:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1493748615711', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-05-03 02:10:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1493749090643', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-05-03 02:18:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1493836043151', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-05-04 02:27:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1493883110132', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-05-04 15:31:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1493890214167', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-05-04 17:30:14', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1493890303473', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-05-04 17:31:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1493890303474', '0', 'Test Post', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-06-12 23:50:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1497792972314', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-06-18 21:36:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1499057230629', '0', '一二三', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-07-03 12:47:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1500825221910', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-07-23 23:53:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1502639062900', '0', 'TESLA', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-08-13 23:44:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1502639424119', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-08-13 23:50:24', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1507220582167', '0', 'APIJSONUser', '通过APIJSONAuto的图像化界面注册，按Enter而不是Register', 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-10-06 00:23:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1508072071492', '0', '赵钱孙李', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-10-15 20:54:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1508072105320', '1', '周吴郑王', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-10-15 20:55:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1508072160401', '0', '四五六', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-10-15 20:56:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1508072202871', '0', '七八九十', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-10-15 20:56:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1510495628760', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-11-12 22:07:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1511407581570', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82002, 82003, 82005, 82006, 82021, 82023, 82036, 82033]', '[]', TO_DATE('2017-11-23 11:26:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1511761906715', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-11-27 13:51:46', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1511965911349', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-11-29 22:31:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1512387063078', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', '[]', TO_DATE('2017-12-04 19:31:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1512531601485', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82001]', '[]', TO_DATE('2017-12-06 11:40:01', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1514623064133', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2017-12-30 16:37:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1514625918255', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82002, 93793]', NULL, TO_DATE('2017-12-30 17:25:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1514626163032', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2017-12-30 17:29:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1514858422969', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[93793, 82056]', NULL, TO_DATE('2018-01-02 10:00:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1515565976140', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82003, 82021]', NULL, TO_DATE('2018-01-10 14:32:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1518218350585', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-02-10 07:19:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1519778917280', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-02-28 08:48:37', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1520242280259', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82002]', NULL, TO_DATE('2018-03-05 17:31:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1521274648008', '0', 'Kiro', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-03-17 16:17:28', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1521371722416', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-03-18 19:15:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1521374327542', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-03-18 19:58:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1523626157302', '1', 'Charlie_brown', '', 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[1523935772553, 93793]', NULL, TO_DATE('2018-04-13 21:29:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1523935772553', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[1523626157302]', NULL, TO_DATE('2018-04-17 11:29:32', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1524042900591', '1', '哈哈哈', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82002, 82003]', NULL, TO_DATE('2018-04-18 17:15:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1524298730523', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[]', NULL, TO_DATE('2018-04-21 16:18:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1524878698882', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-04-28 09:24:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1525677515673', '0', 'APIJSONUser', NULL, 'http://static.oschina.net/uploads/user/48/96289_50.jpg?t=1452751699000', '[82003, 82002, 38710]', NULL, TO_DATE('2018-05-07 15:18:35', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1527495857924', '0', 'account', NULL, 'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2510057322,2452415311&fm=27&gp=0.jpg', '[1527821445610, 82012]', NULL, TO_DATE('2018-05-28 16:24:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1527498229991', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[1499057230629]', NULL, TO_DATE('2018-05-28 17:03:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1527821445610', '0', 'accountt', NULL, 'http://static.oschina.net/uploads/user/1332/2664107_50.jpg?t=1457405500000', '[1527495857924]', NULL, TO_DATE('2018-06-01 10:50:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1528250827953', '1', 'limengt', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[1528264711016]', NULL, TO_DATE('2018-06-06 10:07:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1528254173621', '1', 'A', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82001, 38710]', NULL, TO_DATE('2018-06-06 11:02:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1528255497767', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82002]', NULL, TO_DATE('2018-06-06 11:24:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1528264711016', '0', '梦', NULL, 'http://static.oschina.net/uploads/user/629/1258821_50.jpg?t=1378063141000', '[82021, 1528250827953]', NULL, TO_DATE('2018-06-06 13:58:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1528339692804', '1', '568599', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[1528250827953, 1528264711016]', NULL, TO_DATE('2018-06-07 10:48:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1528344980598', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-06-07 12:16:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1528356470041', '0', 'aaaa', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[1528339692804]', NULL, TO_DATE('2018-06-07 15:27:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1531969715979', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82002, 82003, 82005]', NULL, TO_DATE('2018-07-19 11:08:35', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1532188114543', '0', '宁旭', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-07-21 23:48:34', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1532439021068', '0', 'huxiaofan', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[38710, 82002, 82003, 82006, 82021]', NULL, TO_DATE('2018-07-24 21:30:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1533835176109', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[1532188114543]', NULL, TO_DATE('2018-08-10 01:19:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1534926301956', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82003, 82002, 82025]', NULL, TO_DATE('2018-08-22 16:25:01', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1538504264944', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-10-03 02:17:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1538504500574', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-10-03 02:21:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1538987952996', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-10-08 16:39:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1541583762603', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-11-07 17:42:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1544276209348', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82002, 38710]', NULL, TO_DATE('2018-12-08 21:36:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1544503822963', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[93793, 82003]', NULL, TO_DATE('2018-12-11 12:50:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1545707526805', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-12-25 11:12:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1545895694424', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2018-12-27 15:28:14', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1547177436600', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2019-01-11 11:30:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1548068043688', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2019-01-21 18:54:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1553095415917', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[82001]', NULL, TO_DATE('2019-03-20 23:23:35', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1553527700480', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2019-03-25 23:28:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1559129626356', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', '[1507220582167]', NULL, TO_DATE('2019-05-29 19:33:46', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1560409157504', '0', '上邪', NULL, '最好的时光', NULL, NULL, TO_DATE('2019-06-13 14:59:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1561539257158', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2019-06-26 16:54:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1563605318975', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2019-07-20 14:48:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1570529238569', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2019-10-08 18:07:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1571629309520', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2019-10-21 11:41:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1592544225995', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2020-06-19 13:23:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1594366766076', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2020-07-10 15:39:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1606355327749', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2020-11-26 09:48:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1607327721514', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2020-12-07 15:55:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "apijson_user" VALUES ('1612026209696', '0', 'APIJSONUser', NULL, 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png', NULL, NULL, TO_DATE('2021-01-31 01:03:29', 'SYYYY-MM-DD HH24:MI:SS'));
