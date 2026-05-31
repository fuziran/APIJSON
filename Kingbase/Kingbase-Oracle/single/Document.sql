-- ----------------------------
-- Table structure for Document
-- ----------------------------
DROP TABLE IF EXISTS "Document" CASCADE;
CREATE TABLE "Document" (
  "id" NUMBER(20) NOT NULL,
  "userId" NUMBER(20) NOT NULL,
  "testAccountId" NUMBER(20) NOT NULL,
  "version" NUMBER(4) NOT NULL,
  "name" NVARCHAR2(100) NOT NULL,
  "type" NVARCHAR2(5) NOT NULL,
  "url" NVARCHAR2(250) NOT NULL,
  "request" NCLOB NOT NULL,
  "header" NCLOB,
  "date" DATE
)
;
COMMENT ON COLUMN "Document"."id" IS '唯一标识';
COMMENT ON COLUMN "Document"."userId" IS '管理员用户id。
需要先建Admin表，新增登录等相关接口。';
COMMENT ON COLUMN "Document"."testAccountId" IS '测试账号id。0-不限';
COMMENT ON COLUMN "Document"."version" IS '接口版本号
<=0 - 不限制版本，任意版本都可用这个接口；
>0 - 在这个版本添加的接口。

可在给新版文档前调高默认值，新增的测试用例就不用手动设置版本号了。';
COMMENT ON COLUMN "Document"."name" IS '接口名称';
COMMENT ON COLUMN "Document"."type" IS 'PARAM - GET  url parameters,
FORM - POST  application/www-x-form-url-encoded,
JSON - POST  application/json';
COMMENT ON COLUMN "Document"."url" IS '请求地址';
COMMENT ON COLUMN "Document"."request" IS '请求
用json格式会导致强制排序，而请求中引用赋值只能引用上面的字段，必须有序。';
COMMENT ON COLUMN "Document"."header" IS '请求头 Request Header：
key: value  //注释';
COMMENT ON COLUMN "Document"."date" IS '创建日期';
COMMENT ON TABLE "Document" IS '测试用例文档
后端开发者在测试好后，把选好的测试用例上传，这样就能共享给前端/客户端开发者';

-- ----------------------------
-- Records of Document
-- ----------------------------
INSERT INTO "Document" VALUES ('1', '82001', '82001', '1', '登录', 'JSON', '/login', '{
    "type": 0, //密码类型，0-登录密码  1-验证码
    "phone": "13000082001",  //手机号
    "password": "123456",  //登录密码或验证码
    "version": 1,  //版本号
    "remember": false  //记住登录
}', NULL, TO_DATE('2017-11-26 15:35:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('2', '82001', '0', '1', '注册(先获取验证码type:1)', 'JSON', '/register', '{
    "Privacy": {
        "phone": "13000083333",
        "_password": "123456"
    },
    "User": {
        "name": "APIJSONUser"
    },
    "verify": "6840" //验证码，需要先调用接口 /post/verify
}', NULL, TO_DATE('2017-11-26 15:35:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('3', '82001', '0', '1', '退出登录', 'JSON', '/logout', '{}', NULL, TO_DATE('2017-11-26 17:56:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1511689914599', '82001', '0', '1', '获取用户隐私信息', 'JSON', '/gets', '{"tag": "Privacy", "Privacy": {"id": 82001}}', NULL, TO_DATE('2017-11-26 17:51:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1511796155276', '82001', '0', '1', '获取验证码', 'JSON', '/post/verify', '{
    "type": 0,  //类型: 0-登录 1-注册 2-修改登录密码 3-修改支付密码
    "phone": "13000082001"  //手机号
}', NULL, TO_DATE('2017-11-27 23:23:28', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1511796208671', '82001', '0', '1', '检查验证码是否存在', 'JSON', '/heads/verify', '{
    "type": 0,  //类型: 0-登录 1-注册 2-修改登录密码 3-修改支付密码
    "phone": "13000082001"  //手机号
}', NULL, TO_DATE('2017-11-27 23:23:28', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1511796589078', '82001', '82001', '1', '修改登录密码(先获取验证码type:2)-手机号+验证码', 'JSON', '/put/password', '{
    "verify": "10322",  //验证码，需要先调用接口 /post/verify
    "Privacy": {
        "phone": "13000082001",
        "_password": "666666"
    }
}', NULL, TO_DATE('2017-11-27 23:23:28', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1511796882184', '82001', '82001', '1', '充值(需要支付密码)/提现', 'JSON', '/put/balance', '{"tag": "Privacy", "Privacy": {"id": 82001, "balance+": 100.15, "_payPassword": "123456"}}', NULL, TO_DATE('2017-11-27 23:34:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1511969417633', '82001', '82001', '1', '点赞/取消点赞', 'JSON', '/put', '{
    "Moment": {
        "id": 15,
        "praiseUserIdList-": [
            82001
        ]
    },
    "tag": "Moment"
}', NULL, TO_DATE('2017-11-29 23:30:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1511969630372', '82001', '82001', '1', '新增评论', 'JSON', '/post', '{     "Comment": {         "momentId": 15,         "content": "测试新增评论"     },     "tag": "Comment" }', NULL, TO_DATE('2017-11-29 23:33:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1511970009072', '82001', '82001', '1', '新增动态', 'JSON', '/post', '{     "Moment": {         "content": "测试新增动态",         "pictureList": ["http://static.oschina.net/uploads/user/48/96331_50.jpg"         ]     },     "tag": "Moment" }', NULL, TO_DATE('2017-11-29 23:40:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1511970224333', '82001', '82001', '1', '修改用户信息', 'JSON', '/put', '{
     "User": {
         "id": 82001,
         "name": "测试账号"
     },
     "tag": "User"
 }', NULL, TO_DATE('2017-11-29 23:43:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521901518765', '88888', '0', '2', '功能符(对象关键词): ⑤从pictureList获取第0张图片：', 'JSON', '/get', '{     "User": {         "id": 38710,         "@position": 0,         "firstPicture()": "getFromArray(pictureList,@position)"     } }', NULL, TO_DATE('2018-03-24 22:25:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521901610784', '88888', '0', '2', '功能符(对象关键词): ④查询 按userId分组、id最大值>=100 的Moment数组', 'JSON', '/get', '{"[]":{"count":10,"Moment":{"@column":"userId;max(id):maxId","@group":"userId","@having":"maxId>=100"}}}', NULL, TO_DATE('2018-03-24 22:26:50', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521901682846', '88888', '0', '2', '功能符(对象关键词): ③查询按userId分组的Moment数组', 'JSON', '/get', '{"[]":{"count":10,"Moment":{"@column":"userId,id","@group":"userId,id"}}}', NULL, TO_DATE('2018-03-24 22:28:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521901746809', '88888', '0', '2', '功能符(对象关键词): ②查询按 name降序、id默认顺序 排序的User数组', 'JSON', '/get', '{"[]":{"count":10,"User":{"@column":"name,id","@order":"name-,id"}}}', NULL, TO_DATE('2018-03-24 22:29:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521901787203', '88888', '0', '2', '功能符(对象关键词): ①只查询id,sex,name这几列并且请求结果也按照这个顺序', 'JSON', '/get', '{"User":{"@column":"id,sex,name","id":38710}}', NULL, TO_DATE('2018-03-24 22:29:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521902033332', '88888', '0', '2', '功能符(数组关键词): ③查询User数组和对应的User总数', 'JSON', '/get', '{"[]":{"query":2,"count":5,"User":{}},"total@":"/[]/total"}', NULL, TO_DATE('2018-03-24 22:33:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521902069871', '88888', '0', '2', '功能符(数组关键词): ②查询第3页的User数组，每页5个', 'JSON', '/get', '{"[]":{"count":5,"page":3,"User":{}}}', NULL, TO_DATE('2018-03-24 22:34:29', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521902110680', '88888', '0', '2', '功能符(数组关键词): ①查询User数组，最多5个', 'JSON', '/get', '{"[]":{"count":5,"User":{}}}', NULL, TO_DATE('2018-03-24 22:35:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521903761689', '88888', '0', '2', '功能符(逻辑运算): ③ ! 非运算', 'JSON', '/head', '{"User":{"id!{}":[82001,38710]}}', NULL, TO_DATE('2018-03-24 23:02:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521903828410', '88888', '0', '2', '功能符(逻辑运算): ② | 或运算', 'JSON', '/head', '{"User":{"id|{}":">90000,<=80000"}}', NULL, TO_DATE('2018-03-24 23:03:48', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521903882830', '88888', '0', '2', '功能符(逻辑运算): ① & 与运算', 'JSON', '/head', '{"User":{"id&{}":">80000,<=90000"}}', NULL, TO_DATE('2018-03-24 23:04:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521904098111', '88888', '0', '2', '功能符: 减少 或 去除', 'JSON', '/put/balance', '{
    
    "Privacy": {
        "id": 82001,
        "balance+": -100,
        "_payPassword": "123456"
    },"tag": "Privacy"
}', NULL, TO_DATE('2018-03-24 23:08:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521904162066', '88888', '0', '2', '功能符: 增加 或 扩展', 'JSON', '/put', '{
    "Moment": {
        "id": 15,
        "praiseUserIdList+": [
            82001
        ]
    },
    "tag": "Moment"
}', NULL, TO_DATE('2018-03-24 23:09:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521904337054', '88888', '0', '2', '功能符: 新建别名', 'JSON', '/get', '{"Comment":{"@column":"id,toId:parentId","id":51}}', NULL, TO_DATE('2018-03-24 23:12:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521904394042', '88888', '0', '2', '功能符: 正则匹配', 'JSON', '/get', '{"User[]":{"count":3,"User":{"name~":"^[0-9]+$"}}}', NULL, TO_DATE('2018-03-24 23:13:14', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521904437584', '88888', '0', '2', '功能符: 模糊搜索', 'JSON', '/get', '{"User[]":{"count":3,"User":{"name$":"%m%"}}}', NULL, TO_DATE('2018-03-24 23:13:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521904547992', '88888', '0', '2', '功能符: 引用赋值', 'JSON', '/get', '{"Moment":{
   "userId":38710
},
"User":{
   "id@":"/Moment/userId"
}}', NULL, TO_DATE('2018-03-24 23:15:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521904617127', '88888', '0', '2', '功能符: 远程调用函数', 'JSON', '/get', '{     "Moment": {         "id": 301,         "@column": "userId,praiseUserIdList",         "isPraised()": "isContain(praiseUserIdList,userId)"     } }', NULL, TO_DATE('2018-03-24 23:16:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521904653622', '88888', '0', '2', '功能符: 包含选项范围', 'JSON', '/get', '{"User[]":{"count":3,"User":{"contactIdList<>":38710}}}', NULL, TO_DATE('2018-03-24 23:17:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521904698935', '88888', '0', '2', '功能符: 匹配条件范围', 'JSON', '/get', '{"User[]":{"count":3,"User":{"id{}":"<=80000,>90000"}}}', NULL, TO_DATE('2018-03-24 23:18:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521904756674', '88888', '0', '2', '功能符: 查询数组', 'JSON', '/get', '{"User[]":{"count":3,"User":{}}}', NULL, TO_DATE('2018-03-24 23:19:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521905263828', '88888', '82001', '2', '操作方法(DELETE):  删除数据', 'JSON', '/delete', '{
   "Moment":{
     "id":120
   },
   "tag":"Moment"
}', NULL, TO_DATE('2018-03-24 23:27:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521905599150', '88888', '82001', '2', '操作方法(PUT):  修改数据，只修改所传的字段', 'JSON', '/put', '{
   "Moment":{
     "id":235,
     "content":"APIJSON,let interfaces and documents go to hell !"
   },
   "tag":"Moment"
}', NULL, TO_DATE('2018-03-24 23:33:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521905680680', '88888', '82001', '2', '操作方法(POST):  新增数据', 'JSON', '/post', '{     "Moment": {          "content": "APIJSON,let interfaces and documents go to hell !"     },     "tag": "Moment" }', NULL, TO_DATE('2018-03-24 23:34:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521905787850', '88888', '82001', '2', '操作方法(HEADS):  安全/私密获取数量，用于获取银行卡数量等 对安全性要求高的数据总数', 'JSON', '/heads', '{
    "Login": {
        "userId": 38710,"type":1
    },
    "tag": "Login"
}', NULL, TO_DATE('2018-03-24 23:36:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521905868719', '88888', '82001', '2', '操作方法(GETS):  安全/私密获取数据，用于获取钱包等 对安全性要求高的数据', 'JSON', '/gets', '{
    "Privacy": {
        "id": 82001
    },
    "tag": "Privacy"
}', NULL, TO_DATE('2018-03-24 23:37:48', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521905895591', '88888', '82001', '2', '操作方法(HEAD):  普通获取数量，可用浏览器调试', 'JSON', '/head', '{
   "Moment":{
     "userId":38710
   }
}', NULL, TO_DATE('2018-03-24 23:38:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521905913188', '88888', '82001', '2', '操作方法(GET):  普通获取数据，可用浏览器调试', 'JSON', '/get', '{
   "Moment":{
     "id":235
   }
}', NULL, TO_DATE('2018-03-24 23:38:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521906240332', '88888', '0', '2', 'User发布的Moment列表，每个Moment包括 1.发布者User 2.前3条Comment: ③不查已获取的User', 'JSON', '/get', '{
   "[]":{
     "page":0,
     "count":3, 
     "Moment":{
       "userId":38710
     },
     "Comment[]":{
       "count":3,
       "Comment":{
         "momentId@":"[]/Moment/id"
       }
     }
   }
}', NULL, TO_DATE('2018-03-24 23:44:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521906265960', '88888', '0', '2', 'User发布的Moment列表，每个Moment包括 1.发布者User 2.前3条Comment: ②省去重复的User', 'JSON', '/get', '{
   "User":{
     "id":38710
   },
   "[]":{
     "page":0,
     "count":3, 
     "Moment":{
       "userId":38710
     }, 
     "Comment[]":{
       "count":3,
       "Comment":{
         "momentId@":"[]/Moment/id"
       }
     }
   }
}', NULL, TO_DATE('2018-03-24 23:44:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521906517001', '88888', '0', '2', 'User发布的Moment列表，每个Moment包括 1.发布者User 2.前3条Comment: ①指定id', 'JSON', '/get', '{
    "[]": {
        "page": 0,
        "count": 3,
        "Moment":{"userId":38710}, "User":{"id":38710} ,
        "Comment[]": {
            "count": 3,
            "Comment": {
                "momentId@": "[]/Moment/id"
            }
        }
    }
}', NULL, TO_DATE('2018-03-24 23:48:37', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521907009308', '88888', '0', '2', 'Moment列表，每个Moment包括 1.发布者User 2.前3条Comment', 'JSON', '/get', '{
   "[]":{
     "page":0, 
     "count":3, 
     "Moment":{}, 
     "User":{
       "id@":"/Moment/userId"
     },
     "Comment[]":{
       "count":3,
       "Comment":{
         "momentId@":"[]/Moment/id"
       }
     }
   }
}', NULL, TO_DATE('2018-03-24 23:56:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521907303540', '88888', '0', '2', 'User列表', 'JSON', '/get', '{
   "User[]":{
     "page":0,
     "count":3, 
     "User":{
       "sex":0
     }
   }
}', NULL, TO_DATE('2018-03-25 00:01:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521907317871', '88888', '0', '2', 'Moment和对应的User', 'JSON', '/get', '{
   "Moment":{
     "userId":38710
   }, 
   "User":{
     "id":38710
   }
}', NULL, TO_DATE('2018-03-25 00:01:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521907333041', '88888', '0', '2', 'User', 'JSON', '/get', '{
   "User":{
     "id":38710
   }
}', NULL, TO_DATE('2018-03-25 00:02:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521907333043', '88888', '82002', '3', '微信个人资料-用户信息+最近3个有照片的动态的第0张照片', 'JSON', '/get', '{
    "User": {
        "id": 82002
    },
    "Moment-firstPicture[]": {
        "count": 3,
        "Moment": {
            "userId@": "User/id",
            "@column": "pictureList",
            "@having": "json_length(pictureList)>0",
            "firstPicture()": "getFromArray(pictureList,0)"
        }
    }
}', NULL, TO_DATE('2018-03-25 00:03:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521907333044', '82001', '82002', '3', '微信个人资料-用户信息+最近3个有照片的动态的第0张照片', 'JSON', '/get', '{
     "User": {
         "id": 82002
     },
     "Moment-firstPicture[]": {
         "count": 3,
         "Moment": {
             "userId@": "User/id",
             "@column": "userId,pictureList",
             "@having": "json_length(pictureList)>0",
             "firstPicture()": "getFromArray(pictureList,0)"
         }
     }
 }', NULL, TO_DATE('2018-03-25 00:03:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521907333046', '88888', '0', '2', '获取粉丝的动态列表', 'JSON', '/get', '{     "Moment[]": {         "join": "&/User/id@",         "Moment": {},         "User": {             "id@": "/Moment/userId",             "contactIdList<>": 82001,             "@column": "id"         }     } }', NULL, TO_DATE('2018-03-25 00:03:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521907546129', '88888', '0', '2', '获取类似微信朋友圈的动态列表', 'JSON', '/get', '{
    "[]": {
        "page": 0,
        "count": 2,
        "Moment": {
            "content$": "%a%"
        },
        "User": {
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "Comment[]": {
            "count": 2,
            "Comment": {
                "momentId@": "[]/Moment/id"
            }
        }
    }
}', NULL, TO_DATE('2018-03-25 00:05:46', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521907570452', '88888', '0', '2', '获取动态及发布者用户', 'JSON', '/get', '{
    "Moment": {},
    "User": {
        "id@": "Moment/userId"
    }
}', NULL, TO_DATE('2018-03-25 00:06:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521907587430', '88888', '0', '2', '获取用户列表', 'JSON', '/get', '{
    "[]": {
        "count": 3,
        "User": {
            "@column": "id,name"
        }
    }
}', NULL, TO_DATE('2018-03-25 00:06:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1521907601299', '88888', '0', '2', '获取用户', 'JSON', '/get', '{
  "User":{
  }
}', NULL, TO_DATE('2018-03-25 00:06:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1522905263828', '82001', '0', '2', '操作方法(DELETE):  删除数据', 'JSON', '/delete', '{
   "Moment":{
     "id":120
   },
   "tag":"Moment"
}', NULL, TO_DATE('2018-03-24 21:27:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1522905599150', '82001', '0', '2', '操作方法(PUT):  修改数据，只修改所传的字段', 'JSON', '/put', '{
   "Moment":{
     "id":235,
     "content":"APIJSON,let interfaces and documents go to hell !"
   },
   "tag":"Moment"
}', NULL, TO_DATE('2018-03-24 21:33:19', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1522905680680', '82001', '0', '2', '操作方法(POST):  新增数据', 'JSON', '/post', '{     "Moment": {          "content": "APIJSON,let interfaces and documents go to hell !"     },     "tag": "Moment" }', NULL, TO_DATE('2018-03-24 21:34:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1522905787850', '82001', '0', '2', '操作方法(HEADS):  安全/私密获取数量，用于获取银行卡数量等 对安全性要求高的数据总数', 'JSON', '/heads', '{
    "Login": {
        "userId": 38710,"type":1
    },
    "tag": "Login"
}', NULL, TO_DATE('2018-03-24 21:36:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1522905868719', '82001', '0', '2', '操作方法(GETS):  安全/私密获取数据，用于获取钱包等 对安全性要求高的数据', 'JSON', '/gets', '{
    "Privacy": {
        "id": 82001
    },
    "tag": "Privacy"
}', NULL, TO_DATE('2018-03-24 21:37:48', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1522905895591', '82001', '0', '2', '操作方法(HEAD):  普通获取数量，可用浏览器调试', 'JSON', '/head', '{
   "Moment":{
     "userId":38710
   }
}', NULL, TO_DATE('2018-03-24 21:38:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1522905913188', '82001', '0', '2', '操作方法(GET):  普通获取数据，可用浏览器调试', 'JSON', '/get', '{
   "Moment":{
     "id":235
   }
}', NULL, TO_DATE('2018-03-24 21:38:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544881887527', '88888', '0', '3', 'Moment INNER JOIN User LEFT JOIN Comment', 'JSON', '/get', '{
    "[]": {
        "count": 10,
        "page": 0,
        "join": "&/User/id@,</Comment/momentId@",
        "Moment": {
            "@order": "date+"
        },
        "User": {
            "name~": [
                "a",
                "t"
            ],
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "Comment": {
            "momentId@": "/Moment/id",
            "@column": "id,momentId,content"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:51:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544882007411', '88888', '0', '3', 'Moment LEFT JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "</User/id@",
        "Moment": {
            "@column": "id,userId,content"
        },
        "User": {
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:53:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544882038386', '88888', '0', '3', 'Comment LEFT JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "</User/id@",
        "Comment": {
            "@column": "id,userId,content","@order":"date-"
        },
        "User": {
            "@column": "id,name",
            "id@": "/Comment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:53:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544882070832', '88888', '0', '3', 'Moment INNER JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "&/User/id@",
        "Moment": {
            "@column": "id,userId,content"
        },
        "User": {"name~":["a","t"],
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:54:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544882126906', '88888', '0', '3', 'Comment INNER JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "&/User/id@",
        "Comment": {
            "content~": "a",
            "@order": "date-"
        },
        "User": {
            "name~": [
                "a",
                "t"
            ],
            "@column": "id,name",
            "id@": "/Comment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:55:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544882162662', '88888', '0', '3', 'Moment APP JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "@/User/id@",
        "Moment": {
            "@column": "id,userId,content"
        },
        "User": {
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:56:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544882183671', '88888', '0', '3', 'Comment APP JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "@/User/id@",
        "Comment": {
            "content~": "a",
            "@order": "date-"
        },
        "User": {
            "name~": [
                "a",
                "t"
            ],
            "@column": "id,name",
            "id@": "/Comment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:56:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544882236758', '88888', '0', '3', '朋友圈 LEFT JOIN', 'JSON', '/get', '{
    "[]": {
        "count": 5,
        "page": 0,
        "join": "</User/id@",
        "Moment": {
            "@order": "date+"
        },
        "User": {
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "User[]": {
            "count": 10,
            "User": {
                "id{}@": "[]/Moment/praiseUserIdList",
                "@column": "id,name"
            }
        },
        "[]": {
            "count": 6, "join": "</User/id@",
            "Comment": {
                "@order": "date+",
                "momentId@": "[]/Moment/id"
            },
            "User": {
                "id@": "/Comment/userId",
                "@column": "id,name"
            }
        }
    }
}', NULL, TO_DATE('2018-12-15 21:57:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544882253771', '88888', '0', '3', '朋友圈 APP JOIN', 'JSON', '/get', '{
    "[]": {
        "count": 5,
        "page": 0,
        "join": "@/User/id@",
        "Moment": {
            "@order": "date+"
        },
        "User": {
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "User[]": {
            "count": 10,
            "User": {
                "id{}@": "[]/Moment/praiseUserIdList",
                "@column": "id,name"
            }
        },
        "[]": {
            "count": 6,
            "join": "@/User/id@",
            "Comment": {
                "@order": "date+",
                "momentId@": "[]/Moment/id"
            },
            "User": {
                "id@": "/Comment/userId",
                "@column": "id,name"
            }
        }
    }
}', NULL, TO_DATE('2018-12-15 21:57:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544882327374', '88888', '0', '3', 'Comment SIDE JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "^/User/id@",
        "Comment": {
            "@column": "id,userId,content",
            "@order": "date-"
        },
        "User": {
            "@column": "id,name",
            "id@": "/Comment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:58:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544882345510', '88888', '0', '3', 'Moment SIDE JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "^/User/id@",
        "Moment": {
            "@column": "id,userId,content"
        },
        "User": {
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:59:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883133787', '88888', '0', '3', 'Moment^User each with condition', 'JSON', '/get', '{
    "[]": {
        "join": "^/User/id@",
        "Moment": {"content~":"a",
            "@column": "id,userId,content"
        },
        "User": {"sex":1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:12:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883165350', '88888', '0', '3', 'Moment<User each with condition', 'JSON', '/get', '{
    "[]": {
        "join": "</User/id@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:12:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883183460', '88888', '0', '3', 'Moment&User each with condition', 'JSON', '/get', '{
    "[]": {
        "join": "&/User/id@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:13:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883206003', '88888', '0', '3', 'Moment|User each with condition', 'JSON', '/get', '{
    "[]": {
        "join": "|/User/id@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:13:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883224060', '88888', '0', '3', 'Moment!User each with condition', 'JSON', '/get', '{
    "[]": {
        "join": "!/User/id@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:13:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883250598', '88888', '0', '3', 'Moment>User each with condition', 'JSON', '/get', '{
    "[]": {
        "join": ">/User/id@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:14:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883278939', '88888', '0', '3', 'Moment@User each with condition', 'JSON', '/get', '{
    "[]": {
        "join": "@/User/id@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:14:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883352884', '88888', '0', '3', 'Moment<User<Comment', 'JSON', '/get', '{
    "[]": {
        "join": "</User/id@,</Comment/momentId@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        },
        "Comment": {
            "momentId@": "/Moment/id"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:15:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883368286', '88888', '0', '3', 'Moment&User<Comment', 'JSON', '/get', '{
    "[]": {
        "join": "&/User/id@,</Comment/momentId@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        },
        "Comment": {
            "momentId@": "/Moment/id"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:16:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883407371', '88888', '0', '3', 'Moment|User<Comment', 'JSON', '/get', '{
    "[]": {
        "join": "|/User/id@,</Comment/momentId@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        },
        "Comment": {
            "momentId@": "/Moment/id"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:16:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883431831', '88888', '0', '3', 'Moment^User<Comment', 'JSON', '/get', '{
    "[]": {
        "join": "^/User/id@,</Comment/momentId@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        },
        "Comment": {
            "momentId@": "/Moment/id"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:17:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544883455364', '88888', '0', '3', 'Moment@User<Comment', 'JSON', '/get', '{
    "[]": {
        "join": "@/User/id@,</Comment/momentId@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        },
        "Comment": {
            "momentId@": "/Moment/id"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:17:35', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884133788', '88888', '0', '3', 'Moment@User each with condition', 'JSON', '/get', '{     "[]": {         "join": "@/User/id@",         "Moment": {"content~":"a",             "@column": "id,userId,content"         },         "User": {"sex":1,             "@column": "id,name",             "id@": "/Moment/userId"         }     } }', NULL, TO_DATE('2018-12-15 22:12:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884165351', '88888', '0', '3', 'Moment@User each with condition', 'JSON', '/get', '{     "[]": {         "join": "@/User/id@",         "Moment": {             "content~": "a",             "@column": "id,userId,content"         },         "User": {             "sex": 1,             "@column": "id,name",             "id@": "/Moment/userId"         }     } }', NULL, TO_DATE('2018-12-15 22:12:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884183460', '88888', '0', '3', 'Moment@User each with condition', 'JSON', '/get', '{     "[]": {         "join": "@/User/id@",         "Moment": {             "content~": "a",             "@column": "id,userId,content"         },         "User": {             "sex": 1,             "@column": "id,name",             "id@": "/Moment/userId"         }     } }', NULL, TO_DATE('2018-12-15 22:13:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884206003', '88888', '0', '3', 'Moment@User each with condition', 'JSON', '/get', '{     "[]": {         "join": "@/User/id@",         "Moment": {             "content~": "a",             "@column": "id,userId,content"         },         "User": {             "sex": 1,             "@column": "id,name",             "id@": "/Moment/userId"         }     } }', NULL, TO_DATE('2018-12-15 22:13:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884224060', '88888', '0', '3', 'Moment@User each with condition', 'JSON', '/get', '{     "[]": {         "join": "@/User/id@",         "Moment": {             "content~": "a",             "@column": "id,userId,content"         },         "User": {             "sex": 1,             "@column": "id,name",             "id@": "/Moment/userId"         }     } }', NULL, TO_DATE('2018-12-15 22:13:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884250598', '88888', '0', '3', 'Moment@User each with condition', 'JSON', '/get', '{     "[]": {         "join": "@/User/id@",         "Moment": {             "content~": "a",             "@column": "id,userId,content"         },         "User": {             "sex": 1,             "@column": "id,name",             "id@": "/Moment/userId"         }     } }', NULL, TO_DATE('2018-12-15 22:14:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884278939', '88888', '0', '3', 'Moment@User each with condition', 'JSON', '/get', '{
    "[]": {
        "join": "@/User/id@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:14:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884352884', '88888', '0', '3', 'Moment@User<Comment', 'JSON', '/get', '{     "[]": {         "join": "@/User/id@,</Comment/momentId@",         "Moment": {             "content~": "a",             "@column": "id,userId,content"         },         "User": {             "sex": 1,             "@column": "id,name",             "id@": "/Moment/userId"         },         "Comment": {             "momentId@": "/Moment/id"         }     } }', NULL, TO_DATE('2018-12-15 22:15:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884368286', '88888', '0', '3', 'Moment@User<Comment', 'JSON', '/get', '{     "[]": {         "join": "@/User/id@,</Comment/momentId@",         "Moment": {             "content~": "a",             "@column": "id,userId,content"         },         "User": {             "sex": 1,             "@column": "id,name",             "id@": "/Moment/userId"         },         "Comment": {             "momentId@": "/Moment/id"         }     } }', NULL, TO_DATE('2018-12-15 22:16:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884407371', '88888', '0', '3', 'Moment@User<Comment', 'JSON', '/get', '{     "[]": {         "join": "@/User/id@,</Comment/momentId@",         "Moment": {             "content~": "a",             "@column": "id,userId,content"         },         "User": {             "sex": 1,             "@column": "id,name",             "id@": "/Moment/userId"         },         "Comment": {             "momentId@": "/Moment/id"         }     } }', NULL, TO_DATE('2018-12-15 22:16:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884431831', '88888', '0', '3', 'Moment@User<Comment', 'JSON', '/get', '{     "[]": {         "join": "@/User/id@,</Comment/momentId@",         "Moment": {             "content~": "a",             "@column": "id,userId,content"         },         "User": {             "sex": 1,             "@column": "id,name",             "id@": "/Moment/userId"         },         "Comment": {             "momentId@": "/Moment/id"         }     } }', NULL, TO_DATE('2018-12-15 22:17:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1544884455364', '88888', '0', '3', 'Moment@User<Comment', 'JSON', '/get', '{
    "[]": {
        "join": "@/User/id@,</Comment/momentId@",
        "Moment": {
            "content~": "a",
            "@column": "id,userId,content"
        },
        "User": {
            "sex": 1,
            "@column": "id,name",
            "id@": "/Moment/userId"
        },
        "Comment": {
            "momentId@": "/Moment/id"
        }
    }
}', NULL, TO_DATE('2018-12-15 22:17:35', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546414155879', '82001', '82001', '3', '获取类似微信朋友圈的动态列表', 'JSON', '/get', '{
    "[]": {
        "page": 0,
        "count": 2,
        "Moment": {
            "content$": "%a%"
        },
        "User": {
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "Comment[]": {
            "count": 2,
            "Comment": {
                "momentId@": "[]/Moment/id"
            }
        }
    }
}', NULL, TO_DATE('2019-01-02 15:29:15', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546414179257', '82001', '82001', '3', '获取动态及发布者用户', 'JSON', '/get', '{
    "Moment": {},
    "User": {
        "id@": "Moment/userId"
    }
}', NULL, TO_DATE('2019-01-02 15:29:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546414192830', '82001', '82001', '3', '获取用户列表', 'JSON', '/get', '{
    "[]": {
        "count": 3,
        "User": {
            "@column": "id,name"
        }
    }
}', NULL, TO_DATE('2019-01-02 15:29:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546414207052', '82001', '82001', '3', '获取用户', 'JSON', '/get', '{
  "User":{
  }
}', NULL, TO_DATE('2019-01-02 15:30:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546881887421', '88888', '0', '1', '子查询 WHERE id IN(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
    "[]": {
        "User": {
            "id{}@": {
                "from": "Comment",
                "Comment": {
                    "momentId": 15,
                    "@column": "userId"
                }
            },
            "@column": "id,sex,name"
        }
    }
}', NULL, TO_DATE('2018-02-24 22:25:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546881887422', '88888', '0', '1', '子查询 WHERE EXISTS(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
    "[]": {
        "User": {
            "id}{@": {
                "from": "Comment",
                "Comment": {
                    "momentId": 15,
                    "@column": "userId"
                }
            },
            "@column": "id,sex,name"
        }
    }
}', NULL, TO_DATE('2018-02-24 22:25:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546881887423', '88888', '0', '1', '子查询 WHERE id=(SELECT min(userId) FROM Comment)', 'JSON', '/get', '{
    "User": {
        "id@": {
            "from": "Comment",
            "Comment": {
                "@column": "min(userId)"
            }
        }
    }
}', NULL, TO_DATE('2018-02-24 22:28:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546881887521', '82001', '82001', '1', '子查询 WHERE id IN(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
    "[]": {
        "User": {
            "id{}@": {
                "from": "Comment",
                "Comment": {
                    "momentId": 15,
                    "@column": "userId"
                }
            },
            "@column": "id,sex,name"
        }
    }
}', NULL, TO_DATE('2018-02-24 22:25:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546881887522', '82001', '82001', '1', '子查询 WHERE EXISTS(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
    "[]": {
        "User": {
            "id}{@": {
                "from": "Comment",
                "Comment": {
                    "momentId": 15,
                    "@column": "userId"
                }
            },
            "@column": "id,sex,name"
        }
    }
}', NULL, TO_DATE('2018-02-24 22:25:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546881887523', '82001', '82001', '1', '子查询 WHERE id=(SELECT min(userId) FROM Comment)', 'JSON', '/get', '{
    "User": {
        "id@": {
            "from": "Comment",
            "Comment": {
                "@column": "min(userId)"
            }
        }
    }
}', NULL, TO_DATE('2018-02-24 22:28:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546881887524', '88888', '88888', '1', '存储过程', 'JSON', '/get', '{
    "User": {
        "@limit": 10,
        "@offset": 0,
        "@procedure()": "getCommentByUserId(id,@limit,@offset)"
    }
}', NULL, TO_DATE('2018-03-24 21:34:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546881887525', '82001', '82001', '1', '存储过程', 'JSON', '/get', '{
    "User": {
        "@limit": 10,
        "@offset": 0,
        "@procedure()": "getCommentByUserId(id,@limit,@offset)"
    }
}', NULL, TO_DATE('2018-03-24 21:34:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546881887527', '82001', '0', '1', 'Moment INNER JOIN User LEFT JOIN Comment', 'JSON', '/get', '{
    "[]": {
        "count": 10,
        "page": 0,
        "join": "&/User/id@,</Comment/momentId@",
        "Moment": {
            "@order": "date+"
        },
        "User": {
            "name~": [
                "a",
                "t"
            ],
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "Comment": {
            "momentId@": "/Moment/id",
            "@column": "id,momentId,content"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:51:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546882007411', '82001', '0', '1', 'Moment LEFT JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "</User/id@",
        "Moment": {
            "@column": "id,userId,content"
        },
        "User": {
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:53:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546882038386', '82001', '0', '1', 'Comment LEFT JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "</User/id@",
        "Comment": {
            "@column": "id,userId,content","@order":"date-"
        },
        "User": {
            "@column": "id,name",
            "id@": "/Comment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:53:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546882070832', '82001', '0', '1', 'Moment INNER JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "&/User/id@",
        "Moment": {
            "@column": "id,userId,content"
        },
        "User": {"name~":["a","t"],
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:54:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546882126906', '82001', '0', '1', 'Comment INNER JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "&/User/id@",
        "Comment": {
            "content~": "a",
            "@order": "date-"
        },
        "User": {
            "name~": [
                "a",
                "t"
            ],
            "@column": "id,name",
            "id@": "/Comment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:55:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546882162662', '82001', '0', '1', 'Moment APP JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "@/User/id@",
        "Moment": {
            "@column": "id,userId,content"
        },
        "User": {
            "@column": "id,name",
            "id@": "/Moment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 21:56:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546882183671', '82001', '0', '1', 'Comment APP JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "@/User/id@",
        "Comment": {
            "content~": "a",
            "@order": "date-"
        },
        "User": {
            "name~": [
                "a",
                "t"
            ],
            "@column": "id,name",
            "id@": "/Comment/userId"
        }
    }
}', NULL, TO_DATE('2018-12-15 20:56:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546882236758', '82001', '0', '1', '朋友圈 LEFT JOIN', 'JSON', '/get', '{
    "[]": {
        "count": 5,
        "page": 0,
        "join": "</User/id@",
        "Moment": {
            "@order": "date+"
        },
        "User": {
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "User[]": {
            "count": 10,
            "User": {
                "id{}@": "[]/Moment/praiseUserIdList",
                "@column": "id,name"
            }
        },
        "[]": {
            "count": 6, "join": "</User/id@",
            "Comment": {
                "@order": "date+",
                "momentId@": "[]/Moment/id"
            },
            "User": {
                "id@": "/Comment/userId",
                "@column": "id,name"
            }
        }
    }
}', NULL, TO_DATE('2018-12-15 20:57:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546882253771', '82001', '0', '1', '朋友圈 APP JOIN', 'JSON', '/get', '{
    "[]": {
        "count": 5,
        "page": 0,
        "join": "@/User/id@",
        "Moment": {
            "@order": "date+"
        },
        "User": {
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "User[]": {
            "count": 10,
            "User": {
                "id{}@": "[]/Moment/praiseUserIdList",
                "@column": "id,name"
            }
        },
        "[]": {
            "count": 6,
            "join": "@/User/id@",
            "Comment": {
                "@order": "date+",
                "momentId@": "[]/Moment/id"
            },
            "User": {
                "id@": "/Comment/userId",
                "@column": "id,name"
            }
        }
    }
}', NULL, TO_DATE('2018-12-15 20:57:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546901518765', '82001', '0', '2', '功能符(对象关键词): ⑤从pictureList获取第0张图片：', 'JSON', '/get', '{     "User": {         "id": 38710,         "@position": 0,         "firstPicture()": "getFromArray(pictureList,@position)"     } }', NULL, TO_DATE('2018-03-24 22:25:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546902069871', '82001', '0', '2', '功能符(数组关键词): ②查询第3页的User数组，每页5个', 'JSON', '/get', '{"[]":{"count":5,"page":3,"User":{}}}', NULL, TO_DATE('2018-03-24 22:34:29', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546902110680', '82001', '0', '2', '功能符(数组关键词): ①查询User数组，最多5个', 'JSON', '/get', '{"[]":{"count":5,"User":{}}}', NULL, TO_DATE('2018-03-24 22:35:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546903761689', '82001', '0', '2', '功能符(逻辑运算): ③ ! 非运算', 'JSON', '/head', '{"User":{"id!{}":[82001,38710]}}', NULL, TO_DATE('2018-03-24 23:02:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546903828410', '82001', '0', '2', '功能符(逻辑运算): ② | 或运算', 'JSON', '/head', '{"User":{"id|{}":">90000,<=80000"}}', NULL, TO_DATE('2018-03-24 23:03:48', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546903882830', '82001', '0', '2', '功能符(逻辑运算): ① & 与运算', 'JSON', '/head', '{"User":{"id&{}":">80000,<=90000"}}', NULL, TO_DATE('2018-03-24 23:04:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546904098111', '82001', '82001', '2', '功能符: 减少 或 去除', 'JSON', '/put/balance', '{
    
    "Privacy": {
        "id": 82001,
        "balance+": -100,
        "_payPassword": "123456"
    },"tag": "Privacy"
}', NULL, TO_DATE('2018-03-24 23:08:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546904162066', '82001', '82001', '2', '功能符: 增加 或 扩展', 'JSON', '/put', '{
    "Moment": {
        "id": 15,
        "praiseUserIdList+": [
            82001
        ]
    },
    "tag": "Moment"
}', NULL, TO_DATE('2018-03-24 23:09:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546904337054', '82001', '0', '2', '功能符: 新建别名', 'JSON', '/get', '{"Comment":{"@column":"id,toId:parentId","id":51}}', NULL, TO_DATE('2018-03-24 23:12:17', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546904394042', '82001', '0', '2', '功能符: 正则匹配', 'JSON', '/get', '{"User[]":{"count":3,"User":{"name~":"^[0-9]+$"}}}', NULL, TO_DATE('2018-03-24 23:13:14', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546904437584', '82001', '0', '2', '功能符: 模糊搜索', 'JSON', '/get', '{"User[]":{"count":3,"User":{"name$":"%m%"}}}', NULL, TO_DATE('2018-03-24 23:13:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546904547992', '82001', '0', '2', '功能符: 引用赋值', 'JSON', '/get', '{"Moment":{
   "userId":38710
},
"User":{
   "id@":"/Moment/userId"
}}', NULL, TO_DATE('2018-03-24 23:15:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546904617127', '82001', '0', '2', '功能符: 远程调用函数', 'JSON', '/get', '{     "Moment": {         "id": 301,         "@column": "userId,praiseUserIdList",         "isPraised()": "isContain(praiseUserIdList,userId)"     } }', NULL, TO_DATE('2018-03-24 23:16:57', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546904653622', '82001', '0', '2', '功能符: 包含选项范围', 'JSON', '/get', '{"User[]":{"count":3,"User":{"contactIdList<>":38710}}}', NULL, TO_DATE('2018-03-24 23:17:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546904698935', '82001', '0', '2', '功能符: 匹配条件范围', 'JSON', '/get', '{"User[]":{"count":3,"User":{"id{}":"<=80000,>90000"}}}', NULL, TO_DATE('2018-03-24 23:18:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546904756674', '82001', '0', '2', '功能符: 查询数组', 'JSON', '/get', '{"User[]":{"count":3,"User":{}}}', NULL, TO_DATE('2018-03-24 23:19:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1546907333046', '82001', '0', '1', '获取粉丝的动态列表', 'JSON', '/get', '{     "Moment[]": {         "join": "&/User/id@",         "Moment": {},         "User": {             "id@": "/Moment/userId",             "contactIdList<>": 82001,             "@column": "id"         }     } }', NULL, TO_DATE('2018-03-25 00:03:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1547401498195', '88888', '0', '1', '子查询FROM和IN', 'JSON', '/get', '{
     "sql@": {
         "from": "Comment",
         "Comment": {
             "momentId": 12,
             "@column": "userId",
             "@group": "userId"
         }
     },
     "Comment-userId[]": {
         "Comment": {
             "@from@": "sql"
         }
     },
     "[]": {
         "User": {
             "id{}@": "sql",
             "sex": 1,
             "@column": "id,sex,name"
         }
     }
 }', NULL, TO_DATE('2019-01-14 01:44:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1548728831507', '82001', '82001', '3', 'get test', 'JSON', '/get', '{
    "User": {
        "id": 82001
    },
    "[]": {
        "Comment": {
            "userId@": "User/id"
        }
    }
}', NULL, TO_DATE('2019-01-29 10:27:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1556385621907', '82001', '0', '1', '子查询 WHERE id IN(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
    "subquery@": {
        "from": "Comment",
        "Comment": {
            "momentId": 15,
            "@column": "userId"
        }
    },
    "[]": {
        "User": {
            "id{}@": "subquery",
            "@column": "id,sex,name"
        }
    }
}', NULL, TO_DATE('2018-02-24 22:28:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1556385621908', '88888', '0', '1', '子查询 WHERE id IN(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
    "subquery@": {
        "from": "Comment",
        "Comment": {
            "momentId": 15,
            "@column": "userId"
        }
    },
    "[]": {
        "User": {
            "id{}@": "subquery",
            "@column": "id,sex,name"
        }
    }
}', NULL, TO_DATE('2018-02-24 22:28:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1556385677607', '82001', '0', '1', '子查询 WHERE EXISTS(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
    "subquery@": {
        "from": "Comment",
        "Comment": {
            "momentId": 15,
            "@column": "userId"
        }
    },
    "[]": {
        "User": {
            "id}{@": "subquery",
            "@column": "id,sex,name"
        }
    }
}', NULL, TO_DATE('2018-02-24 22:28:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1556385677608', '88888', '0', '1', '子查询 WHERE EXISTS(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
    "subquery@": {
        "from": "Comment",
        "Comment": {
            "momentId": 15,
            "@column": "userId"
        }
    },
    "[]": {
        "User": {
            "id}{@": "subquery",
            "@column": "id,sex,name"
        }
    }
}', NULL, TO_DATE('2018-02-24 22:28:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1558944411696', '82001', '82001', '3', '关联查询 Comment.userId = User.id', 'JSON', '/get', '{
    "User": {
        "id": 82001
    },
    "[]": {
        "Comment": {
            "userId@": "User/id"
        }
    }
}', NULL, TO_DATE('2019-05-27 16:06:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1559995734352', '82001', '0', '3', 'get 自定义关键词和远程函数的应用', 'JSON', '/get', '{
    "User": {
        "id": 82001,
        "@column": "contactIdList",
        "@value": 82006,
        "isContect()": "isContain(contactIdList,@value)"
    }
}
/*
1、获取User表中的id==82001的数据块；
2、获取contactIdList列中的数据；
3、设定自定义关键词和值"@value": 82006；
4、调用远程函数isContain判断 contactIdList 中是否存在值为82006的id；
5、判断结果看 isContect的值。
*/', NULL, TO_DATE('2019-06-08 20:08:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1560075285563', '82001', '0', '3', 'Comment JOIN User', 'JSON', '/get', '{
    "[]": {
        "join": "</User/id@",
        "Comment": {
            "@order": "date-"
        },
        "User": {
            "id@": "/Comment/userId"
        }
    }
}', NULL, TO_DATE('2019-06-09 18:14:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1560244940013', '82001', '82001', '3', '测试查询', 'JSON', '/get', '{
    "User": {
        "id": 82001
    },
    "[]": {
        "Comment": {
            "userId@": "User/id"
        }
    }
}', NULL, TO_DATE('2019-06-11 17:22:20', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1560737118846', '82001', '82001', '3', 'get User', 'JSON', '/get', '{
    "User": {
        "id": 82002
    }
}', NULL, TO_DATE('2019-06-17 10:05:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1563115049174', '88888', '0', '3', '去重 DISTINCT', 'JSON', '/get', '{
    "[]": {
        "Comment": {
            "@column": "DISTINCT momentId;count(DISTINCT userId)",
            "@group": "momentId"
        }
    },
    "@explain": true
}', NULL, TO_DATE('2018-03-20 22:25:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1563120735968', '82001', '0', '3', '去重 DISTINCT', 'JSON', '/get', '{
    "[]": {
        "Comment": {
            "@column": "DISTINCT momentId;count(DISTINCT userId)",
            "@group": "momentId"
        }
    },
    "@explain": true
}', NULL, TO_DATE('2018-03-20 22:25:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1563983388528', '82001', '0', '3', '热更新 权限控制、请求校验、远程函数 等配置', 'JSON', '/reload', '{
    "type": "REQUEST", // ALL-全部, ACCESS-权限, REQUEST-请求校验, FUNCTION-远程函数
    "phone": "13000082001",
    "verify": "1234" //验证码，调用 /post/verify ，type:4 获取
}', NULL, TO_DATE('2019-07-24 23:49:48', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1563983969937', '88888', '0', '3', '热更新 权限控制、请求校验、远程函数 等配置', 'JSON', '/reload', '{
    "type": "REQUEST", // ALL-全部, ACCESS-权限, REQUEST-请求校验, FUNCTION-远程函数
    "phone": "13000082001",
    "verify": "1234" //验证码，调用 /post/verify ，type:4 获取
}', NULL, TO_DATE('2019-07-24 23:59:29', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564388238598', '1564369325432', '82001', '3', '测试上传', 'JSON', '/get', '{
    "User": {
        "id": 82001
    },
    "[]": {
        "Comment": {
            "userId@": "User/id"
        }
    }
}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634765', '1564369325432', '82001', '1', '登录', 'JSON', '/login', '{
     "type": 0, //密码类型，0-登录密码  1-验证码
     "phone": "13000082001",  //手机号
     "password": "123456",  //登录密码或验证码
     "version": 1,  //版本号
     "remember": false  //记住登录
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634766', '1564369325432', '0', '1', '注册(先获取验证码type:1)', 'JSON', '/register', '{
     "Privacy": {
         "phone": "13000083333",
         "_password": "123456"
     },
     "User": {
         "name": "APIJSONUser"
     },
     "verify": "6840" //验证码，需要先调用接口 /post/verify
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634841', '82001', '0', '2', '视图表 ViewTable 查单条记录 /get', 'JSON', '/get', '{
    "ViewTable": {"id": 82001}
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634842', '82001', '0', '2', '视图表 ViewTable 查列表带条件', 'JSON', '/get', '{
    "ViewTable[]": {
        "ViewTable": {
            "toId": 0,
            "content~": "a"
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634843', '82001', '0', '2', '视图表 ViewTable INNER JOIN Moment', 'JSON', '/get', '{
    "[]": {
        "join": "&/Moment/id@",
        "ViewTable": {"toId":0},
        "Moment": {"content~":"a",
            "id@": "/ViewTable/momentId"
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634844', '82001', '0', '2', '视图表 ViewTable 子查询', 'JSON', '/get', '{
    "ViewTable[]": {
        "ViewTable": {
            "momentId{}@": {
                "from": "Moment",
                "Moment": {
                    "@column": "id"
                }
            }
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634845', '82001', '0', '2', '视图表 ViewTable LEFT JOIN Moment', 'JSON', '/get', '{
    "[]": {
        "join": "</Moment/id@",
        "ViewTable": {},
        "Moment": {
            "id@": "/ViewTable/momentId"
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634846', '82001', '0', '2', '全局关键词', 'JSON', '/get', '{
    "[]": {
        "count": 3,
        "Moment": {},
      
        "User": {
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "[]": {
            "count": 6,
            "Comment": {
                "momentId@": "[]/Moment/id"
            },
            "User": {
                "id@": "/Comment/userId",
                "@column": "id,name"
            }
        }
    },
    "format": false,
    "tag": "Moment[]",
    "version": 0,
    "@role": "CIRCLE",
    "@database": "MYSQL",
    "@schema": "sys",
    "@explain": true,
    "@cache": 0
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634853', '1564369325432', '0', '1', '退出登录', 'JSON', '/logout', '{}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634854', '1564369325432', '0', '1', '获取用户隐私信息', 'JSON', '/gets', '{"tag": "Privacy", "Privacy": {"id": 82001}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634855', '1564369325432', '0', '1', '获取验证码', 'JSON', '/post/verify', '{
     "type": 0,  //类型: 0-登录 1-注册 2-修改登录密码 3-修改支付密码
     "phone": "13000082001"  //手机号
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634856', '1564369325432', '0', '1', '检查验证码是否存在', 'JSON', '/heads/verify', '{
     "type": 0,  //类型: 0-登录 1-注册 2-修改登录密码 3-修改支付密码
     "phone": "13000082001"  //手机号
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634857', '1564369325432', '82001', '1', '修改登录密码(先获取验证码type:2)-手机号+验证码', 'JSON', '/put/password', '{
     "verify": "10322",  //验证码，需要先调用接口 /post/verify
     "Privacy": {
         "phone": "13000082001",
         "_password": "666666"
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634858', '1564369325432', '82001', '1', '充值(需要支付密码)/提现', 'JSON', '/put/balance', '{"tag": "Privacy", "Privacy": {"id": 82001, "balance+": 100.15, "_payPassword": "123456"}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634859', '1564369325432', '82001', '1', '点赞/取消点赞', 'JSON', '/put', '{
     "Moment": {
         "id": 15,
         "praiseUserIdList-": [
             82001
         ]
     },
     "tag": "Moment"
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634860', '1564369325432', '82001', '1', '新增评论', 'JSON', '/post', '{     "Comment": {         "momentId": 15,         "content": "测试新增评论"     },     "tag": "Comment" }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634861', '1564369325432', '82001', '1', '新增动态', 'JSON', '/post', '{     "Moment": {         "content": "测试新增动态",         "pictureList": ["http://static.oschina.net/uploads/user/48/96331_50.jpg"         ]     },     "tag": "Moment" }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634862', '1564369325432', '82001', '1', '修改用户信息', 'JSON', '/put', '{
     "User": {
         "id": 82001,
         "name": "测试账号"
     },
     "tag": "User"
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634863', '1564369325432', '82002', '3', '微信个人资料-用户信息+最近3个有照片的动态的第0张照片', 'JSON', '/get', '{
     "User": {
         "id": 82002
     },
     "Moment-firstPicture[]": {
         "count": 3,
         "Moment": {
             "userId@": "User/id",
             "@column": "userId,pictureList",
             "@having": "json_length(pictureList)>0",...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634864', '1564369325432', '0', '2', '操作方法(DELETE):  删除数据', 'JSON', '/delete', '{
    "Moment":{
      "id":120
    },
    "tag":"Moment"
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634865', '1564369325432', '0', '2', '操作方法(PUT):  修改数据，只修改所传的字段', 'JSON', '/put', '{
    "Moment":{
      "id":235,
      "content":"APIJSON,let interfaces and documents go to hell !"
    },
    "tag":"Moment"
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634866', '1564369325432', '0', '2', '操作方法(POST):  新增数据', 'JSON', '/post', '{     "Moment": {          "content": "APIJSON,let interfaces and documents go to hell !"     },     "tag": "Moment" }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634867', '1564369325432', '0', '2', '操作方法(HEADS):  安全/私密获取数量，用于获取银行卡数量等 对安全性要求高的数据总数', 'JSON', '/heads', '{
     "Login": {
         "userId": 38710,"type":1
     },
     "tag": "Login"
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634868', '1564369325432', '0', '2', '操作方法(GETS):  安全/私密获取数据，用于获取钱包等 对安全性要求高的数据', 'JSON', '/gets', '{
     "Privacy": {
         "id": 82001
     },
     "tag": "Privacy"
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634869', '1564369325432', '0', '2', '操作方法(HEAD):  普通获取数量，可用浏览器调试', 'JSON', '/head', '{
    "Moment":{
      "userId":38710
    }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634870', '1564369325432', '0', '2', '操作方法(GET):  普通获取数据，可用浏览器调试', 'JSON', '/get', '{
    "Moment":{
      "id":235
    }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634871', '1564369325432', '82001', '3', '获取类似微信朋友圈的动态列表', 'JSON', '/get', '{
     "[]": {
         "page": 0,
         "count": 2,
         "Moment": {
             "content$": "%a%"
         },
         "User": {
             "id@": "/Moment/userId",
             "@column": "id,name,head"
         },
         "Comment[]": {
             "...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634872', '1564369325432', '82001', '3', '获取动态及发布者用户', 'JSON', '/get', '{
     "Moment": {},
     "User": {
         "id@": "Moment/userId"
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634873', '1564369325432', '82001', '3', '获取用户列表', 'JSON', '/get', '{
     "[]": {
         "count": 3,
         "User": {
             "@column": "id,name"
         }
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634874', '1564369325432', '82001', '3', '获取用户', 'JSON', '/get', '{
   "User":{
   }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634875', '1564369325432', '82001', '1', '子查询 WHERE id IN(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
     "[]": {
         "User": {
             "id{}@": {
                 "from": "Comment",
                 "Comment": {
                     "momentId": 15,
                     "@column": "userId"
                 }
             },
             "@column": "id...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634876', '1564369325432', '82001', '1', '子查询 WHERE EXISTS(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
     "[]": {
         "User": {
             "id}{@": {
                 "from": "Comment",
                 "Comment": {
                     "momentId": 15,
                     "@column": "userId"
                 }
             },
             "@column": "id...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634877', '1564369325432', '82001', '1', '子查询 WHERE id=(SELECT min(userId) FROM Comment)', 'JSON', '/get', '{
     "User": {
         "id@": {
             "from": "Comment",
             "Comment": {
                 "@column": "min(userId)"
             }
         }
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634878', '1564369325432', '82001', '1', '存储过程', 'JSON', '/get', '{
     "User": {
         "@limit": 10,
         "@offset": 0,
         "@procedure()": "getCommentByUserId(id,@limit,@offset)"
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634879', '1564369325432', '0', '1', 'Moment INNER JOIN User LEFT JOIN Comment', 'JSON', '/get', '{
     "[]": {
         "count": 10,
         "page": 0,
         "join": "&/User/id@,</Comment/momentId@",
         "Moment": {
             "@order": "date+"
         },
         "User": {
             "name~": [
                 "a",
                 "t"
        ...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634880', '1564369325432', '0', '1', 'Moment LEFT JOIN User', 'JSON', '/get', '{
     "[]": {
         "join": "</User/id@",
         "Moment": {
             "@column": "id,userId,content"
         },
         "User": {
             "@column": "id,name",
             "id@": "/Moment/userId"
         }
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634881', '1564369325432', '0', '1', 'Comment LEFT JOIN User', 'JSON', '/get', '{
     "[]": {
         "join": "</User/id@",
         "Comment": {
             "@column": "id,userId,content","@order":"date-"
         },
         "User": {
             "@column": "id,name",
             "id@": "/Comment/userId"
         }
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634882', '1564369325432', '0', '1', 'Moment INNER JOIN User', 'JSON', '/get', '{
     "[]": {
         "join": "&/User/id@",
         "Moment": {
             "@column": "id,userId,content"
         },
         "User": {"name~":["a","t"],
             "@column": "id,name",
             "id@": "/Moment/userId"
         }
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634883', '1564369325432', '0', '1', 'Comment INNER JOIN User', 'JSON', '/get', '{
     "[]": {
         "join": "&/User/id@",
         "Comment": {
             "content~": "a",
             "@order": "date-"
         },
         "User": {
             "name~": [
                 "a",
                 "t"
             ],
             "@column":...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634884', '1564369325432', '0', '1', 'Moment APP JOIN User', 'JSON', '/get', '{
     "[]": {
         "join": "@/User/id@",
         "Moment": {
             "@column": "id,userId,content"
         },
         "User": {
             "@column": "id,name",
             "id@": "/Moment/userId"
         }
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634885', '1564369325432', '0', '1', 'Comment APP JOIN User', 'JSON', '/get', '{
     "[]": {
         "join": "@/User/id@",
         "Comment": {
             "content~": "a",
             "@order": "date-"
         },
         "User": {
             "name~": [
                 "a",
                 "t"
             ],
             "@column":...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634886', '1564369325432', '0', '1', '朋友圈 LEFT JOIN', 'JSON', '/get', '{
     "[]": {
         "count": 5,
         "page": 0,
         "join": "</User/id@",
         "Moment": {
             "@order": "date+"
         },
         "User": {
             "id@": "/Moment/userId",
             "@column": "id,name,head"
         },
       ...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634887', '1564369325432', '0', '1', '朋友圈 APP JOIN', 'JSON', '/get', '{
     "[]": {
         "count": 5,
         "page": 0,
         "join": "@/User/id@",
         "Moment": {
             "@order": "date+"
         },
         "User": {
             "id@": "/Moment/userId",
             "@column": "id,name,head"
         },
       ...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634888', '1564369325432', '0', '2', '功能符(对象关键词): ⑤从pictureList获取第0张图片：', 'JSON', '/get', '{     "User": {         "id": 38710,         "@position": 0,         "firstPicture()": "getFromArray(pictureList,@position)"     } }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634889', '1564369325432', '0', '2', '功能符(数组关键词): ②查询第3页的User数组，每页5个', 'JSON', '/get', '{"[]":{"count":5,"page":3,"User":{}}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634890', '1564369325432', '0', '2', '功能符(数组关键词): ①查询User数组，最多5个', 'JSON', '/get', '{"[]":{"count":5,"User":{}}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634891', '1564369325432', '0', '2', '功能符(逻辑运算): ③ ! 非运算', 'JSON', '/head', '{"User":{"id!{}":[82001,38710]}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634892', '1564369325432', '0', '2', '功能符(逻辑运算): ② | 或运算', 'JSON', '/head', '{"User":{"id|{}":">90000,<=80000"}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634893', '1564369325432', '0', '2', '功能符(逻辑运算): ① & 与运算', 'JSON', '/head', '{"User":{"id&{}":">80000,<=90000"}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634894', '1564369325432', '82001', '2', '功能符: 减少 或 去除', 'JSON', '/put/balance', '{
     
     "Privacy": {
         "id": 82001,
         "balance+": -100,
         "_payPassword": "123456"
     },"tag": "Privacy"
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634895', '1564369325432', '82001', '2', '功能符: 增加 或 扩展', 'JSON', '/put', '{
     "Moment": {
         "id": 15,
         "praiseUserIdList+": [
             82001
         ]
     },
     "tag": "Moment"
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634896', '1564369325432', '0', '2', '功能符: 新建别名', 'JSON', '/get', '{"Comment":{"@column":"id,toId:parentId","id":51}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634897', '1564369325432', '0', '2', '功能符: 正则匹配', 'JSON', '/get', '{"User[]":{"count":3,"User":{"name~":"^[0-9]+$"}}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634898', '1564369325432', '0', '2', '功能符: 模糊搜索', 'JSON', '/get', '{"User[]":{"count":3,"User":{"name$":"%m%"}}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634899', '1564369325432', '0', '2', '功能符: 引用赋值', 'JSON', '/get', '{"Moment":{
    "userId":38710
 },
 "User":{
    "id@":"/Moment/userId"
 }}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634900', '1564369325432', '0', '2', '功能符: 远程调用函数', 'JSON', '/get', '{     "Moment": {         "id": 301,         "@column": "userId,praiseUserIdList",         "isPraised()": "isContain(praiseUserIdList,userId)"     } }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634901', '1564369325432', '0', '2', '功能符: 包含选项范围', 'JSON', '/get', '{"User[]":{"count":3,"User":{"contactIdList<>":38710}}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634902', '1564369325432', '0', '2', '功能符: 匹配条件范围', 'JSON', '/get', '{"User[]":{"count":3,"User":{"id{}":"<=80000,>90000"}}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634903', '1564369325432', '0', '2', '功能符: 查询数组', 'JSON', '/get', '{"User[]":{"count":3,"User":{}}}', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634904', '1564369325432', '0', '1', '获取粉丝的动态列表', 'JSON', '/get', '{     "Moment[]": {         "join": "&/User/id@",         "Moment": {},         "User": {             "id@": "/Moment/userId",             "contactIdList<>": 82001,             "@column": "id"         }     } }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634905', '1564369325432', '82001', '3', 'get test', 'JSON', '/get', '{
     "User": {
         "id": 82001
     },
     "[]": {
         "Comment": {
             "userId@": "User/id"
         }
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634906', '1564369325432', '0', '1', '子查询 WHERE id IN(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
     "subquery@": {
         "from": "Comment",
         "Comment": {
             "momentId": 15,
             "@column": "userId"
         }
     },
     "[]": {
         "User": {
             "id{}@": "subquery",
             "@column": "id,sex,name"
         ...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634907', '1564369325432', '0', '1', '子查询 WHERE EXISTS(SELECT userId FROM Comment WHERE momentId=15)', 'JSON', '/get', '{
     "subquery@": {
         "from": "Comment",
         "Comment": {
             "momentId": 15,
             "@column": "userId"
         }
     },
     "[]": {
         "User": {
             "id}{@": "subquery",
             "@column": "id,sex,name"
         ...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634908', '1564369325432', '82001', '3', '关联查询 Comment.userId = User.id', 'JSON', '/get', '{
     "User": {
         "id": 82001
     },
     "[]": {
         "Comment": {
             "userId@": "User/id"
         }
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634909', '1564369325432', '0', '3', 'get 自定义关键词和远程函数的应用', 'JSON', '/get', '{
     "User": {
         "id": 82001,
         "@column": "contactIdList",
         "@value": 82006,
         "isContect()": "isContain(contactIdList,@value)"
     }
 }
 /*
 1、获取User表中的id==82001的数据块；
 2、获取contactIdList列中的数据...', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634910', '1564369325432', '0', '3', 'Comment JOIN User', 'JSON', '/get', '{
     "[]": {
         "join": "</User/id@",
         "Comment": {
             "@order": "date-"
         },
         "User": {
             "id@": "/Comment/userId"
         }
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634911', '1564369325432', '82001', '3', '测试查询', 'JSON', '/get', '{
     "User": {
         "id": 82001
     },
     "[]": {
         "Comment": {
             "userId@": "User/id"
         }
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634912', '1564369325432', '82001', '3', 'get User', 'JSON', '/get', '{
     "User": {
         "id": 82002
     }
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634913', '1564369325432', '0', '3', '去重 DISTINCT', 'JSON', '/get', '{
     "[]": {
         "Comment": {
             "@column": "DISTINCT momentId;count(DISTINCT userId)",
             "@group": "momentId"
         }
     },
     "@explain": true
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634914', '1564369325432', '0', '3', '热更新 权限控制、请求校验、远程函数 等配置', 'JSON', '/reload', '{
     "type": "REQUEST", // ALL-全部, ACCESS-权限, REQUEST-请求校验, FUNCTION-远程函数
     "phone": "13000082001",
     "verify": "1234" //验证码，调用 /post/verify ，type:4 获取
 }', NULL, TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634915', '82001', '0', '2', '功能符：连续范围', 'JSON', '/get', '{"User[]":{"count":3,"User":{"date%":"2017-10-01,2018-10-01"}}}', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564483634916', '82001', '0', '3', '获取用户名称列表', 'JSON', '/get', '{
    "User-name[]": {
        "User": {
            "@column": "name"
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1564907459034', '82001', '0', '3', '请求头 Request Header', 'JSON', '/get', '{
    "User": {
        "id": 82001
    },
    "[]": {
        "Comment": {
            "userId@": "User/id"
        }
    }
}', 'Authorization: Basic GERIJ2438R9FH239NW=  //取出 /login 接口返回的 token
Other-Header: test', TO_DATE('2019-08-04 16:30:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1567927050590', '88888', '0', '3', 'test response hint', 'JSON', '/get', '{
    "[]": {
        "count": 5,
        "page": 0,
        "Moment": {
            "@order": "date+"
        },
        "User": {
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "User[]": {
            "count": 10,
            "query": 2,
            "User": {
                "id{}@": "[]/Moment/praiseUserIdList",
                "@column": "id,name"
            }
        },
        "Comment-userId[]": {
            "count": 6,
            "query": 2,
            "Comment": {
                "@order": "date+",
                "momentId@": "[]/Moment/id"
            }
        },
        "praiseCount@": "/User[]/total",
        "commentCount@": "/Comment-userId[]/total"
    }
}', '', TO_DATE('2019-09-08 15:17:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1572174664812', '88888', '0', '3', '部分功能总览', 'JSON', '/get', '{
    "[]": {
        "count": 5,
        "page": 0,
        "join": "</User/id@",
        "Moment": {
            "@order": "date+",
            "@column": "id,userId;date_format(date,%Y-%m-%d %H:%m)",
            "@explain": true,
            "content~": "o",
            "userId!": 82001,
            "@combine": "userId!,content~"
        },
        "User": {
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "[]": {
            "count": 6,
            "join": "@/User/id@",
            "Comment": {
                "@order": "date-",
                "momentId@": "[]/Moment/id"
            },
            "User": {
                "id@": "/Comment/userId",
                "@column": "DISTINCT id,name;concat(%,name,%):concat"
            }
        }
    }
}', '', TO_DATE('2019-10-27 19:11:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1583173736243', '88888', '0', '3', '批量修改-每项单独设置', 'JSON', '/put', '{
    "Comment[]": [
        {
            "id": 1581271679641,
            "content": "test"
        },
        {
            "id": 1581314845034,
            "momentId": 12,
            "date": "2020-02-02"
        }
    ],
    "tag": "Comment:[]"
}', '', TO_DATE('2020-03-03 02:28:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1583173841064', '88888', '0', '3', '批量新增-每项单独设置', 'JSON', '/post', '{
    "Moment[]": [
        {
            "content": "测试新增动态"
        },
        
        {
            "pictureList": [
                "http://abc.com/3.png"
            ]
        },
        {
            "content": "test",
            "praiseUserIdList": [
                82002
            ],
            "pictureList": [
                "http://abc.com/2.png"
            ]
        }
    ],
    "tag": "Moment:[]"
}', '', TO_DATE('2020-03-03 02:30:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1583415965740', '99999', '0', '3', 'where子查询中多表关联筛选', 'JSON', '/get', '{
    "User": {
        "id@": {
            "from": "Comment",
			 "join": "&/Moment/id@",
            "Comment": {
                "@column": "min(userId)"
            },
            "Moment": {
                "id@": "/Comment/momentId",
				  "@column":""
            }
        }
    },
    "@explain": true
}', '', TO_DATE('2020-03-05 21:46:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1583510816154', '99999', '0', '3', '复杂的子查询与关联查询', 'JSON', '/get', '{
    "sql@": {
        "from": "Comment",
        "join": "&/Comment:to/userId@",
        "Comment": {
            "@column": "userId",
            "content~": "a"
        },
        "Comment:to": {
            "userId@": "/Comment/userId",
            "@column": "",
            "content~": "j"
        }
    },
    "[]": {
        "Moment": {
            "userId{}@": {
                "from": "User",
                "User": {
                    "id{}@": "sql",
                    "@column": "id"
                }
            }
        }
    },
    "@explain": true
}', '', TO_DATE('2020-03-07 00:06:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1583513151839', '99999', '0', '3', '类似12306根据两站来查火车班次', 'JSON', '/get', '{   //类似 12306 根据始发站和到达站来过滤火车班次，班次和线路多对一，线路和站点多对多
    "sql@": {
        "from": "Comment",
        "join": "&/Comment:to/userId@",
        "Comment": {  //假装是始发站
            "@column": "userId",
            "content~": "a"   //假装是站点名
        },
        "Comment:to": {  //假装是终点站
            "userId@": "/Comment/userId",
            "@column": "",
            "content~": "j"  //假装是站点名
        }
    },
    "[]": {
        "Moment": {  //假装是班次
            "userId{}@": {
                "from": "User",
                "User": {  //假装是线路
                    "id{}@": "sql",
                    "@column": "id"
                }
            }
        }
    },
    "@explain": true
}', '', TO_DATE('2020-03-07 00:45:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1584113823081', '2000', '0', '3', '自连接返回数据错误', 'JSON', '/get', '{
    "[]": {
        "join": "&/Comment:to/id@",
        "Comment": {},  //解决方案：加 "@column": "id,toId"
        "Comment:to": {
            "id@": "/Comment/toId",
            "id>": 0
        }
    },
    "@explain": true
}
/*
 这是一个 3.3.0, 3.8.6-4.0.0 都发现存在的 bug，
 事实上也是自从支持自连接（副表 Comment AS `to`）以来就存在。
 原因是对副表生成的 SQL 里表名和主表表名一样，导致 
 AbstractSQLExecutor.onPutColumn 中 299 行
 item = onPutColumn(config, rs, rsmd, index, item, i, config.isExplain() == false && hasJoin && i >= viceColumnStart ? childMap : null);
 488 行 if 走了第一个分支（应该走 else 来把副表的值存进 childMap）
 finalTable = table;
 从而使 JOIN 查出来的主副表全部字段都在 521 行
 finalTable.put(lable, getValue(config, rs, rsmd, tablePosition, table, columnIndex, lable, childMap));
 由于主副表有相同字段，导致后面 put 的副表字段替代了前面 put 的主表同名字段。
 
 除了以上折中方案，还可以判断 AS 的副表别名来做区分，put 进 childMap。
*/', '', TO_DATE('2020-03-13 23:37:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1584117747580', '2000', '0', '3', '全局默认字段失效', 'JSON', '/login', '{
    "type": 0,
    "phone": "13000082001",
    "password": "123456",
    "version": 1,
    "remember": false,
    "format": true,  //失效
    "defaults": {  //失效
        "format": true,
        "@explain": true,
        "@database": "POSTGRESQL",
        "@schema": "sys"
    }
}', '', TO_DATE('2020-03-14 00:42:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1584118278602', '2000', '0', '3', 'SIDE JOIN 实现可能有误', 'JSON', '/get', '{
    "[]": {
        "join": "^/User/id@",
        "Comment": {
            "momentId": 12
        },
        "User": {
            "id@": "/Comment/toId",
            "sex": 0
        }
    },
    "@explain": true
}
/*
 SIDE JOIN 实现可能有误，并且性能不大好。
 Comment 的条件 A: momentId=12
 User 的条件 B: sex=0
 理论上 NOT(A AND B) 等价于(A AND NOT B) OR (B AND NOT A) 
 目前使用的是后者，当我想要改成前者，分别用对应的 SQL 放数据库执行，
 发现结果集不一样！
 SELECT `Comment`.*, `User`.* FROM `sys`.`Comment` AS `Comment` INNER JOIN `sys`.`apijson_user` AS `User` ON `User`.`id` = `Comment`.`toId` WHERE ( NOT ( `Comment`.`momentId` = 12 AND `User`.`sex` = 0 ) ) LIMIT 10 OFFSET 0
 SELECT `Comment`.*, `User`.* FROM `sys`.`Comment` AS `Comment` INNER JOIN `sys`.`apijson_user` AS `User` ON `User`.`id` = `Comment`.`toId` WHERE ( ( ( (`Comment`.`momentId` = 12) ) AND NOT ( ( (`User`.`sex` = 0) ) ) ) OR ( ( (`User`.`sex` = 0) ) AND NOT ( ( (`Comment`.`momentId` = 12) ) ) ) ) LIMIT 10 OFFSET 0
*/', '', TO_DATE('2020-03-14 00:51:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1584120971519', '2020', '0', '3', '新增 WITH AS', 'JSON', '/get', '{   //看看关注的人最近有什么动态（分享、评论）
    "sql@": {
        "with": true,  //生成 WITH(SELECT id ...) AS `sql`
        "from": "User",
        "User": {
            "@column": "id",
            "@role": "CONTACT"
        }
    },
    "Moment[]": {
        "Moment": {
            "userId{}@": "sql",
            "@order": "date-"
        }
    },
    "Comment[]": {
        "Comment": {
            "userId{}@": "sql",
            "@order": "date-"
        }
    },
    "@explain": true
}', '', TO_DATE('2020-03-14 01:36:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1584120990337', '2020', '0', '3', '新增 UNION', 'JSON', '/get', '{
    "[]": {
        "User": {
            "name~": "a",
            "tag~": "a",
            "@combine": "name~,tag~",    
            "@union": 1  //将 @combine 中的 N 个 OR 连接字段用 UNION 替换，原本一条 SQL 需要拆分成 N 条 SQL 来 UNION 
        }
    },
    "@explain": true
}', '', TO_DATE('2020-03-14 01:36:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1584121026469', '2020', '0', '3', '新增分布式执行', 'JSON', '/get', '{
    "User": {
        "@url": "http://apijson.cn:8080/get"  //转发给其它服务器执行
    },
    "[]": {
        "Comment": {
            "userId@": "User/id"
        }
    },
    "@explain": true
}', '', TO_DATE('2020-03-14 01:37:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1589859330200', '1589859275450', '1589859275450', '3', 'login', 'JSON', '/login', '{
    "type": 0,
    "phone": "13525569073",
    "password": "123456",
    "version": 1,
    "remember": false,
    "format": false,
    "defaults": {
        "@database": "MYSQL",
        "@schema": "sys"
    }
}', '', TO_DATE('2020-05-19 11:35:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1592545943722', '1592544818327', '1592544225995', '3', 'login', 'JSON', '/login', '{
    "body": {
        "personName": "杨家湖超限班长",
        "Authenticated": true,
        "UserName": "yjhcxbz",
        "personMobile": "",
        "iconList": [
            "PTCL"
        ],
        "Token": "3dba223a3a9046f7abfffdddc9f93936",
        "userOrgName": "杨家湖收费站",
        "userId": "297edfab72c14e940172c1552d4b0002",
        "userOrgId": "009429986"
    },
    "head": {
        "clientId": null,
        "ret": {
            "retCode": "000000",
            "retMsg": null
        },
        "timestamp": "2020-06-19 11:46:52"
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2020-06-19 13:52:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1592546007877', '1592544818327', '1592544225995', '3', 'login11', 'JSON', '/login', '{
    "body": {
        "personName": "杨家湖超限班长",
        "Authenticated": true,
        "UserName": "yjhcxbz",
        "personMobile": "",
        "iconList": [
            "PTCL"
        ],
        "Token": "3dba223a3a9046f7abfffdddc9f93936",
        "userOrgName": "杨家湖收费站",
        "userId": "297edfab72c14e940172c1552d4b0002",
        "userOrgId": "009429986"
    },
    "head": {
        "clientId": null,
        "ret": {
            "retCode": "000000",
            "retMsg": null
        },
        "timestamp": "2020-06-19 11:46:52"
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2020-06-19 13:53:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1593973492312', '1593972128383', '0', '3', 'login1', 'JSON', '/login', '{
    "type": 0,
    "phone": "13000082002",
    "password": "123456",
    "version": 1,
    "remember": false,
    "format": false,
    "defaults": {
        "@database": "MYSQL",
        "@schema": "sys"
    }
}', '', TO_DATE('2020-07-06 02:24:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1593973606841', '1593972128383', '0', '3', 'get1', 'JSON', '/get', '{
    "User": {
        "id": 82001
    },
    "[]": {
        "Comment": {
            "userId@": "User/id"
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2020-07-06 02:26:46', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1593973707836', '1593972128383', '0', '3', 'get1', 'JSON', '/get', '{
    "User": {
        "id": 82001
    },
    "[]": {//ooo
        "Comment": {
            "userId@": "User/id"
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2020-07-06 02:28:27', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1596002514234', '1596002416764', '0', '3', 'get', 'JSON', '/get', '{
    "type": 0,
    "phone": "13000082002",
    "password": "123456",
    "version": 1,
    "remember": false,
    "format": false,
    "defaults": {
        "@database": "MYSQL",
        "@schema": "sys"
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2020-07-29 14:01:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1596439230051', '1596439187212', '0', '3', 'login', 'JSON', '/login', '{
    "type": 0,
    "phone": "13000082002",
    "password": "123456",
    "version": 1,
    "remember": false,
    "format": false,
    "defaults": {
        "@database": "MYSQL",
        "@schema": "sys"
    }
}', '', TO_DATE('2020-08-03 15:20:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1602231365650', '2020', '0', '3', 'JOIN 对象支持包含多个 @ 引用赋值 的字段', 'JSON', '/get', '{   // 自动合并  ON Method.class = `Method:group`.class AND Method.package = `Method:group`.package
    "Method[]": {
        "count": 0,
        "join": "@/Method/class@,@/Method/package@",
        "Method:group": {
            "@column": "DISTINCT class",
            "@order": "class+",
            "@having": "length(class)>0",
            "package*~": null,
            "class*~": null,
            "@combine": null
        },
        "Method": {
            "package@": "[]/Method/package",
            "class@": "/Method:group/class",
            "@column": "class,genericClassArgs",
            "@order": "class+",
            "arguments()": "getMethodArguments(genericClassArgs)"
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2020-10-09 16:16:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1607881786667', '99999', '0', '3', 'get', 'JSON', '/get', '{
    "Comment[]": {
        "Comment": {
            "@column": "date,content;concat(id,^,<,>?|,toId,&,{},userId,LES+=)",
            "@having": "to_days(date)%7=0"
        }
    },
    "@explain": true
}
                                                                                                                                                                                                              
', '', TO_DATE('2020-12-14 01:49:46', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1607881843319', '99999', '0', '3', '复杂的 @having', 'JSON', '/get', '{
    "Comment[]": {
        "Comment": {
            "@having": "concat(id,^,<,>?|,&,{},:[],DROP!)<=8^3*3.14-7/4+50"
        }
    },
    "@explain": true
}
                                                                                                                                                                                                              
', '', TO_DATE('2020-12-14 01:50:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1607881872995', '99999', '0', '3', '最近7天', 'JSON', '/get', '{
    "Comment": {
        "@having": "to_days(now())-to_days(`date`)<=7",
        "@raw": "@having"
    },
    "@explain": true
}
                                                                                                                                                                                                              
', '', TO_DATE('2020-12-14 01:51:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1607881932306', '99999', '0', '3', '@raw 自定义 SQL 片段', 'JSON', '/get', '{   // 类似 12306 根据始发站和到达站来过滤火车班次，班次和线路多对一，线路和站点多对多
    "sql@": {
        "from": "Comment",
        "join": "&/Comment:to/userId@",
        "Comment": {  // 假装是始发站
            "@column": "userId",
            "content~": "a",  // 假装是站点名
            "momentId>": "to.momentId",
            "@raw": "momentId>"
        },
        "Comment:to": {  // 假装是终点站
            "userId@": "/Comment/userId",
            "@column": "",
            "content~": "j"  // 假装是站点名
        }
    },
    "[]": {
        "Moment": {  // 假装是班次
            "userId{}@": {
                "from": "User",
                "User": {  // 假装是线路
                    "id{}@": "sql",
                    "@column": "id"
                }
            }
        }
    },
    "@explain": true
}
                                                                                                                                                                                                              
', '', TO_DATE('2020-12-14 01:52:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1608087204039', '82001', '0', '3', 'get', 'JSON', '/get', '{
  "Moment": {
    "id": 12
  }
}', '', TO_DATE('2020-12-16 10:53:24', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1608995763278', '99999', '0', '3', 'SQL 函数与表达式', 'JSON', '/get', '{
    "Comment[]": {
        "Comment": {
            "@column": "userId;(toId)%3=0;group_concat(DISTINCT +,id)",
            "@having": "max(id)>100;userId%5>=1",
            "@group": "userId,toId"
        }
    },
    "@explain": true
}
                                                                                                                                                                                                              
', '', TO_DATE('2020-12-26 23:16:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1612031683609', '88888', '0', '2', '视图表 ViewTable 查单条记录 /get', 'JSON', '/get', '{
    "ViewTable": {"id": 82001}
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1612031683610', '88888', '0', '2', '视图表 ViewTable 查列表带条件', 'JSON', '/get', '{
    "ViewTable[]": {
        "ViewTable": {
            "toId": 0,
            "content~": "a"
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1612031683611', '88888', '0', '2', '视图表 ViewTable INNER JOIN Moment', 'JSON', '/get', '{
    "[]": {
        "join": "&/Moment/id@",
        "ViewTable": {"toId":0},
        "Moment": {"content~":"a",
            "id@": "/ViewTable/momentId"
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1612031683612', '88888', '0', '2', '视图表 ViewTable 子查询', 'JSON', '/get', '{
    "ViewTable[]": {
        "ViewTable": {
            "momentId{}@": {
                "from": "Moment",
                "Moment": {
                    "@column": "id"
                }
            }
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1612031683613', '88888', '0', '2', '视图表 ViewTable LEFT JOIN Moment', 'JSON', '/get', '{
    "[]": {
        "join": "</Moment/id@",
        "ViewTable": {},
        "Moment": {
            "id@": "/ViewTable/momentId"
        }
    }
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1612031683614', '88888', '0', '2', '全局关键词', 'JSON', '/get', '{
    "[]": {
        "count": 3,
        "Moment": {},
      
        "User": {
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "[]": {
            "count": 6,
            "Comment": {
                "momentId@": "[]/Moment/id"
            },
            "User": {
                "id@": "/Comment/userId",
                "@column": "id,name"
            }
        }
    },
    "format": false,
    "tag": "Moment[]",
    "version": 0,
    "@role": "CIRCLE",
    "@database": "MYSQL",
    "@schema": "sys",
    "@explain": true,
    "@cache": 0
}
                                                                                                                                                                                                              
', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Document" VALUES ('1612031683615', '88888', '0', '2', '功能符：连续范围', 'JSON', '/get', '{"User[]":{"count":3,"User":{"date%":"2017-10-01,2018-10-01"}}}', '', TO_DATE('2019-07-29 16:43:18', 'SYYYY-MM-DD HH24:MI:SS'));

ALTER TABLE "Document" ADD "apijson" NCLOB;
COMMENT ON COLUMN "Document"."apijson" IS 'APIAuto/APIJSON 文档内容。兼容新版 APIJSON 启动时的 Document.apijson 过滤。';
UPDATE "Document" SET "apijson" = "request" WHERE "apijson" IS NULL;
