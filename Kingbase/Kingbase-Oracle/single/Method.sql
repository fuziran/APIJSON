-- ----------------------------
-- Table structure for Method
-- ----------------------------
DROP TABLE IF EXISTS "Method" CASCADE;
CREATE TABLE "Method" (
  "id" NUMBER(20) NOT NULL,
  "userId" NUMBER(20) NOT NULL,
  "package" NVARCHAR2(500) NOT NULL,
  "class" NVARCHAR2(50) NOT NULL,
  "classArgs" NCLOB,
  "genericClassArgs" NCLOB,
  "method" NVARCHAR2(50) NOT NULL,
  "methodArgs" NCLOB,
  "genericMethodArgs" NCLOB,
  "exceptions" NVARCHAR2(500),
  "genericExceptions" NVARCHAR2(500),
  "type" NVARCHAR2(50),
  "genericType" NVARCHAR2(50),
  "static" NUMBER(4) NOT NULL,
  "request" NCLOB,
  "demo" CLOB,
  "detail" NVARCHAR2(1000) NOT NULL,
  "date" DATE NOT NULL
)
;
COMMENT ON COLUMN "Method"."userId" IS '管理员用户Id';
COMMENT ON COLUMN "Method"."classArgs" IS '[
        {   //User user
            "type": "apijson/demo/server/model/User",
            "value": {
                "id": 1,
                "name": "APIJSON"
            }
        },
        {   //String id，不填 type 的话会根据 value 自动确定
            "value": "id"
        }
]';
COMMENT ON COLUMN "Method"."method" IS '方法名';
COMMENT ON COLUMN "Method"."methodArgs" IS '参数列表，格式是
[
        {   //User user
            "type": "apijson/demo/server/model/User",
            "value": {
                "id": 1,
                "name": "APIJSON"
            }
        },
        {   //String id，不填 type 的话会根据 value 自动确定
            "value": "id"
        }
]';
COMMENT ON COLUMN "Method"."exceptions" IS '异常类型列表';
COMMENT ON COLUMN "Method"."type" IS '返回值类型。TODO RemoteMethod 校验 type 和 back';
COMMENT ON COLUMN "Method"."static" IS '是否为 static 方法： 0-false; 1-true';
COMMENT ON COLUMN "Method"."demo" IS '可用的示例。
TODO 改成 call，和返回值示例 back 对应。';
COMMENT ON COLUMN "Method"."detail" IS '详细描述';
COMMENT ON COLUMN "Method"."date" IS '创建时间';
COMMENT ON TABLE "Method" IS '要做单元测试的方法(如果用到单元测试，则必须)';

-- ----------------------------
-- Records of Method
-- ----------------------------
INSERT INTO "Method" VALUES ('3', '0', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'countArray', '[
        {
            "value": {
                "arr": [
                    1,
                    2,
                    3
                ]
            }
        },
        {
            "value": "arr"
        }
    ]', '[
        {
            "value": {
                "arr": [
                    1,
                    2,
                    3
                ]
            }
        },
        {
            "value": "arr"
        }
    ]', NULL, NULL, 'Integer', 'Integer', '0', NULL, '{"array": [1, 2, 3]}', '获取数组长度。没写调用键值对，会自动补全 "result()": "countArray(array)"', TO_DATE('2018-10-13 16:23:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('4', '0', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'countObject', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', NULL, NULL, 'Integer', 'Integer', '0', NULL, '{"object": {"key0": 1, "key1": 2}}', '获取对象长度。', TO_DATE('2018-10-13 16:23:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('5', '0', 'apijson.demo.server', 'DemoFunction', '[]', '[]', 'isContain', '[
        {   //JSONObject request
            "value": {
                "arr": [
                    1,
                    2,
                    4
                ],
                "num": 2
            }
        },
        {   //String arr
            "value": "arr"
        },
        {   //String item
            "value": "num"
        }
    ]', '[
        {   //JSONObject request
            "value": {
                "arr": [
                    1,
                    2,
                    4
                ],
                "num": 2
            }
        },
        {   //String arr
            "value": "arr"
        },
        {   //String item
            "value": "num"
        }
    ]', NULL, NULL, 'Boolean', 'Boolean', '0', NULL, '{"array": [1, 2, 3], "value": 2}', '判断是否数组包含值。', TO_DATE('2018-10-13 16:23:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('6', '0', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'isContainKey', '[
        {
            "value": {
                "obj": {
                    "a": 1,
                    "b": "2"
                },
                "key": "a"
            }
        },
        {
            "value": "obj"
        },
        {
            "value": "key"
        }
    ]', '[
        {
            "value": {
                "obj": {
                    "a": 1,
                    "b": "2"
                },
                "key": "a"
            }
        },
        {
            "value": "obj"
        },
        {
            "value": "key"
        }
    ]', NULL, NULL, 'Boolean', 'Boolean', '0', '{
    "methodArgs": [
        {
            "value": {
                "obj": {
                    "a": 1,
                    "b": "2"
                },
                "key": "a"
            }
        },
        {
            "value": "obj"
        },
        {
            "value": "key"
        }
    ]
}', '{"key": "id", "object": {"id": 1}}', '判断是否对象包含键。', TO_DATE('2018-10-13 16:30:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('7', '0', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'isContainValue', '[
        {
            "value": {
                "obj": {
                    "a": 1,
                    "b": "2"
                },
                "val": "2"
            }
        },
        {
            "value": "obj"
        },
        {
            "value": "val"
        }
    ]', '[
        {
            "value": {
                "obj": {
                    "a": 1,
                    "b": "2"
                },
                "val": "2"
            }
        },
        {
            "value": "obj"
        },
        {
            "value": "val"
        }
    ]', NULL, NULL, 'Boolean', 'Boolean', '0', '{
    "methodArgs": [
        {
            "value": {
                "obj": {
                    "a": 1,
                    "b": "2"
                },
                "val": "2"
            }
        },
        {
            "value": "obj"
        },
        {
            "value": "val"
        }
    ]
}', '{"value": 1, "object": {"id": 1}}', '判断是否对象包含值。', TO_DATE('2018-10-13 16:30:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('8', '0', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'getFromArray', '[
        {   //JSONObject request
            "type": "JSONObject",
            "value": {
                "arr": [
                    1,
                    2
                ],
                "index": 0
            }
        },
        {   //String arrKey
            "type": "String",
            "value": "arr"
        },
        {   //String indexKey
            "type": "String",
            "value": "index"
        }
    ],
    "classArgs": [
        {}, //RequestMethod method
        {}, //String tag
        {   //int version
            "value": 0
        },
        {}  //HttpSession session
    ]', '[
        {   //JSONObject request
            "type": "JSONObject",
            "value": {
                "arr": [
                    1,
                    2
                ],
                "index": 0
            }
        },
        {   //String arrKey
            "type": "String",
            "value": "arr"
        },
        {   //String indexKey
            "type": "String",
            "value": "index"
        }
    ],
    "classArgs": [
        {}, //RequestMethod method
        {}, //String tag
        {   //int version
            "value": 0
        },
        {}  //HttpSession session
    ]', NULL, NULL, 'Object', 'Object', '0', '{
    "methodArgs": [
        {   //JSONObject request
            "type": "JSONObject",
            "value": {
                "arr": [
                    1,
                    2
                ],
                "index": 0
            }
        },
        {   //String arrKey
            "type": "String",
            "value": "arr"
        },
        {   //String indexKey
            "type": "String",
            "value": "index"
        }
    ],
    "classArgs": [
        {}, //RequestMethod method
        {}, //String tag
        {   //int version
            "value": 0
        },
        {}  //HttpSession session
    ]
}', '{"array": [1, 2, 3], "result()": "getFromArray(array,1)"}', '根据下标获取数组里的值。position 传数字时直接作为值，而不是从所在对象 request 中取值', TO_DATE('2018-10-13 16:30:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('9', '0', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'getFromObject', '[
        {   //JSONObject request
            "value": {
                "obj": {
                    "a": 1,
                    "b": "2"
                },
                "key": "a"
            }
        },
        {   //String objKey
            "value": "obj"
        },
        {   //String keyKey
            "value": "key"
        }
    ],
    "classArgs": [
        {}, //RequestMethod method
        {}, //String tag
        {   //int version
            "value": 0
        },
        {}  //HttpSession session
    ]', '[
        {   //JSONObject request
            "value": {
                "obj": {
                    "a": 1,
                    "b": "2"
                },
                "key": "a"
            }
        },
        {   //String objKey
            "value": "obj"
        },
        {   //String keyKey
            "value": "key"
        }
    ],
    "classArgs": [
        {}, //RequestMethod method
        {}, //String tag
        {   //int version
            "value": 0
        },
        {}  //HttpSession session
    ]', NULL, NULL, 'Object', 'Object', '0', '{
    "methodArgs": [
        {   //JSONObject request
            "value": {
                "obj": {
                    "a": 1,
                    "b": "2"
                },
                "key": "a"
            }
        },
        {   //String objKey
            "value": "obj"
        },
        {   //String keyKey
            "value": "key"
        }
    ],
    "classArgs": [
        {}, //RequestMethod method
        {}, //String tag
        {   //int version
            "value": 0
        },
        {}  //HttpSession session
    ]
}', '{"key": "id", "object": {"id": 1}}', '根据键获取对象里的值。', TO_DATE('2018-10-13 16:30:31', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('10', '82002', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'deleteCommentOfMoment', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', NULL, NULL, NULL, NULL, '0', NULL, '{"momentId": 1}', '根据动态 id 删除它的所有评论', TO_DATE('2019-08-18 02:46:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('11', '82002', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'verifyIdList', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', NULL, NULL, NULL, NULL, '0', NULL, '{"array": [1, 2, 3], "result()": "verifyIdList(array)"}', '校验类型为 id 列表', TO_DATE('2019-08-18 03:58:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('12', '82002', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'verifyURLList', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', NULL, NULL, NULL, NULL, '0', NULL, '{"array": ["http://123.com.1.jpg", "http://123.com.a.png", "http://www.abc.com.test.gif"], "result()": "verifyURLList(array)"}', '校验类型为 URL 列表', TO_DATE('2019-08-18 03:58:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('13', '82002', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'getWithDefault', '[
        {   //JSONObject request
            "value": {
                "value": null,
                "defaultValue": 0
            }
        },
        {   //String valueKey
            "value": "value"
        },
        {   //String defaultValueKey
            "value": "defaultValue"
        }
    ]', '[
        {   //JSONObject request
            "value": {
                "value": null,
                "defaultValue": 0
            }
        },
        {   //String valueKey
            "value": "value"
        },
        {   //String defaultValueKey
            "value": "defaultValue"
        }
    ]', NULL, NULL, 'Object', 'Object', '0', '{
    "methodArgs": [
        {   //JSONObject request
            "value": {
                "value": null,
                "defaultValue": 0
            }
        },
        {   //String valueKey
            "value": "value"
        },
        {   //String defaultValueKey
            "value": "defaultValue"
        }
    ],
    "classArgs": [
        {}, //RequestMethod method
        {}, //String tag
        {   //int version
            "value": 0
        },
        {}  //HttpSession session
    ]
}', '{"value": null, "defaultValue": 1}', '如果 value 为 null，则返回 defaultValue', TO_DATE('2019-08-20 23:26:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('14', '82002', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'removeKey', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', NULL, NULL, NULL, NULL, '0', NULL, '{"key": "s", "key2": 2}', '从对象里移除 key', TO_DATE('2019-08-20 23:26:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('15', '82002', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'getMethodDemo', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, '{}', '获取远程函数的 Demo', TO_DATE('2019-08-20 23:26:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('16', '82002', 'apijson.demo.server', 'DemoFunction', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', '[
        {},  //RequestMethod method
        {},  //String tag
        {
            "value": 0  //int version
        },
        {}  //HttpSession session
    ]', 'getMethodDetail', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', '[
        {   //JSONObject request
            "value": {
                "1": 1,
                "2": 2
            }
        },
        {   //String num0
            "value": "1"
        },
        {   //String num1
            "type": "String",
            "value": "2"
        }
    ]', NULL, NULL, 'String', 'String', '0', NULL, '{}', '获取远程函数的详情', TO_DATE('2019-08-20 23:26:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1578823653121', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getName', '[]', '[]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getName', TO_DATE('2020-01-12 18:07:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1578823653136', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getId', '[]', '[]', NULL, NULL, 'Object', 'Object', '0', NULL, NULL, 'getId', TO_DATE('2020-01-12 18:07:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1578823653325', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setTag', '[{"type":"String"}]', '[{"type":"String"}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setTag', TO_DATE('2020-01-12 18:07:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1578823653332', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getTag', '[]', '[]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getTag', TO_DATE('2020-01-12 18:07:38', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1578823653336', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getHead', '[]', '[]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getHead', TO_DATE('2020-01-12 18:07:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1578823653760', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setHead', '[{"type":"String"}]', '[{"type":"String"}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setHead', TO_DATE('2020-01-12 18:07:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1578823653803', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getSex', '[]', '[]', NULL, NULL, 'Integer', 'Integer', '0', NULL, NULL, 'getSex', TO_DATE('2020-01-12 18:07:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1578823653807', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setSex', '[{"type":"Integer"}]', '[{"type":"Integer"}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setSex', TO_DATE('2020-01-12 18:07:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1580398205217', '82001', 'apijson.demo.server', 'DemoParser', NULL, NULL, 'createSQLConfig', NULL, NULL, NULL, NULL, 'zuo.biao.apijson.server.SQLConfig', 'zuo.biao.apijson.server.SQLConfig', '0', NULL, NULL, 'createSQLConfig', TO_DATE('2020-01-30 23:30:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1580398205332', '82001', 'apijson.demo.server', 'DemoParser', NULL, NULL, 'createSQLExecutor', NULL, NULL, NULL, NULL, 'zuo.biao.apijson.server.SQLExecutor', 'zuo.biao.apijson.server.SQLExecutor', '0', NULL, NULL, 'createSQLExecutor', TO_DATE('2020-01-30 23:30:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1586108443057', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'value', NULL, NULL, NULL, NULL, 'JSON', 'JSON', '0', '{
    "static": true,
    "methodArgs": [
        {
            "type": "Boolean",
            "value": false
        }
    ]
}', NULL, 'value', TO_DATE('2020-04-06 01:40:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1586108857346', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'value', NULL, NULL, NULL, NULL, 'JSON', 'JSON', '0', '{
    "static": true,
    "methodArgs": [
        {
            "type": "Boolean",
            "value": false
        }
    ]
}', NULL, 'value', TO_DATE('2020-04-06 01:47:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592066019909', '82001', 'apijson.demo.server', 'DemoFunction', NULL, NULL, 'countArray', NULL, NULL, NULL, NULL, 'int', NULL, '0', '{
    "methodArgs": [
        {
            "value": {
                "arr": [
                    1,
                    2,
                    3
                ]
            }
        },
        {
            "value": "arr"
        }
    ],
    "classArgs": [
        "zuo.biao.apijson.RequestMethod:PUT",  // RequestMethod method
        "String:User",  // String tag
        "int:3",  // int version
        {  // HttpSession session
            "type": "javax.servlet.http.HttpSession",
            "value": {
                "id": 82001
            }
        } 
    ]
}', NULL, '计算数组长度', TO_DATE('2020-06-14 00:33:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592066411709', '82001', 'apijson.demo.server', 'DemoFunction', NULL, NULL, 'countArray', NULL, NULL, NULL, NULL, 'int', NULL, '0', '{
    "methodArgs": [
        {
            "value": {
                "arr": [
                    1,
                    2,
                    3
                ]
            }
        },
        {
            "value": "arr"
        }
    ],
    "classArgs": [
        {   // RequestMethod method
            "type": "zuo.biao.apijson.RequestMethod",
            "value": "PUT"
        },
        {   // String tag
            "type": "String",
            "value": "User"
        },
        {   // int version
            "type": "int",
            "value": 3
        },
        {  // HttpSession session
            "type": "javax.servlet.http.HttpSession",
            "value": {
                "id": 82001
            }
        } 
    ]
}', NULL, '计算数组长度', TO_DATE('2020-06-14 00:40:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232504463', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setName', '[{"type":"String","value":"Ab_Cd-3162245196487564"}]', '[{"type":"String","value":"Ab_Cd-5513293025605116"}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setName', TO_DATE('2020-06-15 22:48:24', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232504740', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getName', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getName', TO_DATE('2020-06-15 22:48:24', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232504769', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setTag', '[{"type":"String","value":"Ab_Cd-3691689402152052"}]', '[{"type":"String","value":"Ab_Cd6180635492034519"}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setTag', TO_DATE('2020-06-15 22:48:24', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232504852', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getSex', NULL, NULL, NULL, NULL, 'Integer', 'Integer', '0', NULL, NULL, 'getSex', TO_DATE('2020-06-15 22:48:24', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232504862', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getTag', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getTag', TO_DATE('2020-06-15 22:48:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232505079', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getId', NULL, NULL, NULL, NULL, 'Object', 'Object', '0', NULL, NULL, 'getId', TO_DATE('2020-06-15 22:48:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232506216', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setSex', '[{"type":"Integer","value":-1}]', '[{"type":"Integer","value":7}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setSex', TO_DATE('2020-06-15 22:48:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232506230', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setPictureList', '[{"type":"List","value":[]}]', '[{"type":"List<String>","value":[[],[],[],[],[],[]]}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setPictureList', TO_DATE('2020-06-15 22:48:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232506244', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getPictureList', NULL, NULL, NULL, NULL, 'List', 'List<String>', '0', NULL, NULL, 'getPictureList', TO_DATE('2020-06-15 22:48:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232506459', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getContactIdList', NULL, NULL, NULL, NULL, 'List', 'List<Long>', '0', NULL, NULL, 'getContactIdList', TO_DATE('2020-06-15 22:48:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232506594', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setContactIdList', '[{"type":"List","value":[]}]', '[{"type":"List<Long>","value":[[],[],[],[],[],[]]}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setContactIdList', TO_DATE('2020-06-15 22:48:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232506737', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getHead', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getHead', TO_DATE('2020-06-15 22:48:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232507094', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setHead', '[{"type":"String","value":"Ab_Cd-8051799712775099"}]', '[{"type":"String","value":"Ab_Cd1255989810034031"}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setHead', TO_DATE('2020-06-15 22:48:26', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232543016', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"double","value":-18}]', '[{"type":"double","value":18.5}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-06-15 22:49:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232543066', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"double","value":117},{"type":"double","value":16}]', '[{"type":"double","value":-1.8},{"type":"double","value":-40.27}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'pow', TO_DATE('2020-06-15 22:49:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232543075', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"long","value":62},{"type":"long","value":58}]', '[{"type":"long","value":73},{"type":"long","value":59}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'pow', TO_DATE('2020-06-15 22:49:02', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232543084', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"Number","value":100.57}]', '[{"type":"Number","value":-0.2}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-06-15 22:49:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232543094', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"Number","value":-10.2},{"type":"Number","value":104}]', '[{"type":"Number","value":161.2},{"type":"Number","value":69}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'pow', TO_DATE('2020-06-15 22:49:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232543470', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"long","value":-2},{"type":"long","value":45}]', '[{"type":"long","value":58},{"type":"long","value":53}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-06-15 22:49:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232543706', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"double","value":123},{"type":"double","value":195}]', '[{"type":"double","value":-59.1},{"type":"double","value":39}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-06-15 22:49:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232543767', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"long","value":-93},{"type":"long","value":151}]', '[{"type":"long","value":14},{"type":"long","value":166}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'multiply', TO_DATE('2020-06-15 22:49:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232543799', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"double","value":26.12},{"type":"double","value":128.9}]', '[{"type":"double","value":-67.1},{"type":"double","value":-76}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-06-15 22:49:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232543809', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"Number","value":142.4},{"type":"Number","value":-27}]', '[{"type":"Number","value":37},{"type":"Number","value":-48.9}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-06-15 22:49:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232543935', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"Number","value":134.8},{"type":"Number","value":147}]', '[{"type":"Number","value":47.58},{"type":"Number","value":3.4}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-06-15 22:49:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232544008', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"Number","value":111},{"type":"Number","value":166.1}]', '[{"type":"Number","value":131},{"type":"Number","value":-6}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'plus', TO_DATE('2020-06-15 22:49:03', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232544255', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"double","value":152},{"type":"double","value":135.02}]', '[{"type":"double","value":33.61},{"type":"double","value":183.1}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'plus', TO_DATE('2020-06-15 22:49:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232544326', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"Number","value":59.9},{"type":"Number","value":-41.18}]', '[{"type":"Number","value":24.4},{"type":"Number","value":165.87}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'minus', TO_DATE('2020-06-15 22:49:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232544336', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"long","value":43},{"type":"long","value":178}]', '[{"type":"long","value":32},{"type":"long","value":30}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'plus', TO_DATE('2020-06-15 22:49:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232544473', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"long","value":52},{"type":"long","value":-3}]', '[{"type":"long","value":-37},{"type":"long","value":9}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'minus', TO_DATE('2020-06-15 22:49:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232544717', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":98},{"type":"long","value":126},{"type":"Object"},{"type":"unitauto.test.TestUtil$Callback1","value":{}}]', '[{"type":"long","value":-15},{"type":"long","value":120},{"type":"D","value":{}},{"type":"unitauto.test.TestUtil.unitauto.test.TestUtil$Callback1<D>","value":{}}]', NULL, NULL, 'Object', 'D', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-06-15 22:49:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232544891', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":-100},{"type":"long","value":162},{"type":"unitauto.test.TestUtil$Callback","value":{}}]', '[{"type":"long","value":57},{"type":"long","value":136},{"type":"unitauto.test.TestUtil$Callback","value":{}}]', NULL, NULL, 'Number', 'Number', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-06-15 22:49:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232544905', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":7},{"type":"long","value":17},{"type":"unitauto.test.TestInterface","value":{}}]', '[{"type":"long","value":159},{"type":"long","value":165},{"type":"unitauto.test.TestInterface","value":{}}]', NULL, NULL, 'Long', 'Long', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-06-15 22:49:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1592232912349', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', NULL, NULL, NULL, NULL, 'Number', 'Number', '0', '{
    "static": true,
    "methodArgs": [
        {
            "type": "long",
            "value": -56
        },
        {
            "type": "long",
            "value": 97
        },
        {
            "type": "unitauto.test.TestUtil$Callback",
            "value": {
                "setData(D)": {"callback":true}
            }
        }
    ]
}', NULL, '异步回调方法', TO_DATE('2020-06-15 22:55:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230281856', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"long","value":-98}]', '[{"type":"long","value":133}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-07-20 15:31:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230281880', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"Number","value":28.9},{"type":"Number","value":104.85}]', '[{"type":"Number","value":55.7},{"type":"Number","value":35.5}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'pow', TO_DATE('2020-07-20 15:31:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230281881', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"double","value":-39}]', '[{"type":"double","value":-48.1}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-07-20 15:31:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230281882', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"double","value":39},{"type":"double","value":-31.9}]', '[{"type":"double","value":39.4},{"type":"double","value":90.8}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'pow', TO_DATE('2020-07-20 15:31:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230281891', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"long","value":-54},{"type":"long","value":-19}]', '[{"type":"long","value":17},{"type":"long","value":-71}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-07-20 15:31:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230281893', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"Number","value":193}]', '[{"type":"Number","value":42.84}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-07-20 15:31:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230281914', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"long","value":-90},{"type":"long","value":105}]', '[{"type":"long","value":187},{"type":"long","value":-54}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'pow', TO_DATE('2020-07-20 15:31:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282002', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"Number","value":192.5},{"type":"Number","value":-20.8}]', '[{"type":"Number","value":-91.89},{"type":"Number","value":-45.5}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-07-20 15:31:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282022', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"double","value":-86.7},{"type":"double","value":22.6}]', '[{"type":"double","value":159},{"type":"double","value":-81.1}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-07-20 15:31:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282025', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":-9},{"type":"long","value":105},{"type":"unitauto.test.TestInterface","value":{}}]', '[{"type":"long","value":-58},{"type":"long","value":191},{"type":"unitauto.test.TestInterface","value":{}}]', NULL, NULL, 'Long', 'Long', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-07-20 15:31:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282839', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":-40},{"type":"long","value":85},{"type":"Object"},{"type":"unitauto.test.TestUtil$Callback1","value":{}}]', '[{"type":"long","value":82},{"type":"long","value":-30},{"type":"D","value":{}},{"type":"unitauto.test.TestUtil.unitauto.test.TestUtil$Callback1<D>","value":{}}]', NULL, NULL, 'Object', 'D', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-07-20 15:31:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282845', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":-65},{"type":"long","value":59},{"type":"unitauto.test.TestUtil$Callback","value":{}}]', '[{"type":"long","value":120},{"type":"long","value":184},{"type":"unitauto.test.TestUtil$Callback","value":{}}]', NULL, NULL, 'Number', 'Number', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-07-20 15:31:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282892', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"double","value":153.7},{"type":"double","value":63.7}]', '[{"type":"double","value":137},{"type":"double","value":-48.2}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'plus', TO_DATE('2020-07-20 15:31:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282900', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"long","value":-88},{"type":"long","value":155}]', '[{"type":"long","value":143},{"type":"long","value":185}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'plus', TO_DATE('2020-07-20 15:31:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282912', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"long","value":-94},{"type":"long","value":-15}]', '[{"type":"long","value":-69},{"type":"long","value":64}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'minus', TO_DATE('2020-07-20 15:31:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282941', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"double","value":34.01},{"type":"double","value":136.66}]', '[{"type":"double","value":-92.58},{"type":"double","value":166.21}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'minus', TO_DATE('2020-07-20 15:31:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282949', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"Number","value":38},{"type":"Number","value":-64.9}]', '[{"type":"Number","value":-17.61},{"type":"Number","value":196}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-07-20 15:31:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282973', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"double","value":137},{"type":"double","value":163.9}]', '[{"type":"double","value":135},{"type":"double","value":173.6}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-07-20 15:31:22', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230282984', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"long","value":40},{"type":"long","value":173}]', '[{"type":"long","value":-47},{"type":"long","value":120}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'multiply', TO_DATE('2020-07-20 15:31:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230283009', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"Number","value":24.1},{"type":"Number","value":41.2}]', '[{"type":"Number","value":63.7},{"type":"Number","value":-73.6}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'minus', TO_DATE('2020-07-20 15:31:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230508978', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"long","value":97}]', '[{"type":"long","value":-64}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-07-20 15:35:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230508980', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"long","value":196},{"type":"long","value":-84}]', '[{"type":"long","value":53},{"type":"long","value":75}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'pow', TO_DATE('2020-07-20 15:35:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230508983', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"double","value":-48.7},{"type":"double","value":178.53}]', '[{"type":"double","value":123},{"type":"double","value":-59.7}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'pow', TO_DATE('2020-07-20 15:35:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230508984', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"Number","value":-44.04},{"type":"Number","value":-86.9}]', '[{"type":"Number","value":-66.89},{"type":"Number","value":181}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'pow', TO_DATE('2020-07-20 15:35:08', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230508985', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"double","value":-73}]', '[{"type":"double","value":121.3}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-07-20 15:35:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230509846', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"Number","value":33.5},{"type":"Number","value":33}]', '[{"type":"Number","value":144.9},{"type":"Number","value":-97.85}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-07-20 15:35:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230509848', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"double","value":-5.32},{"type":"double","value":-64.7}]', '[{"type":"double","value":-14},{"type":"double","value":195.66}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-07-20 15:35:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230509885', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":58},{"type":"long","value":-91},{"type":"unitauto.test.TestUtil$Callback","value":{}}]', '[{"type":"long","value":12},{"type":"long","value":-4},{"type":"unitauto.test.TestUtil$Callback","value":{}}]', NULL, NULL, 'Number', 'Number', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-07-20 15:35:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230509890', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":36},{"type":"long","value":197},{"type":"Object"},{"type":"unitauto.test.TestUtil$Callback1","value":{}}]', '[{"type":"long","value":-29},{"type":"long","value":137},{"type":"D","value":{}},{"type":"unitauto.test.TestUtil.unitauto.test.TestUtil$Callback1<D>","value":{}}]', NULL, NULL, 'Object', 'D', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-07-20 15:35:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230509945', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"double","value":154.01},{"type":"double","value":131.9}]', '[{"type":"double","value":116.03},{"type":"double","value":39}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'plus', TO_DATE('2020-07-20 15:35:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230509947', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"Number","value":-4.3},{"type":"Number","value":-87.2}]', '[{"type":"Number","value":129},{"type":"Number","value":-72}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'plus', TO_DATE('2020-07-20 15:35:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230509952', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"long","value":11},{"type":"long","value":79}]', '[{"type":"long","value":41},{"type":"long","value":54}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'plus', TO_DATE('2020-07-20 15:35:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230509974', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"Number","value":-71.1},{"type":"Number","value":-7}]', '[{"type":"Number","value":86},{"type":"Number","value":87.47}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'minus', TO_DATE('2020-07-20 15:35:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230509979', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"double","value":-1},{"type":"double","value":147.1}]', '[{"type":"double","value":87.4},{"type":"double","value":-65.32}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'minus', TO_DATE('2020-07-20 15:35:09', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230510002', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"long","value":86},{"type":"long","value":147}]', '[{"type":"long","value":175},{"type":"long","value":127}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'minus', TO_DATE('2020-07-20 15:35:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230510847', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"double","value":-39.6},{"type":"double","value":161.9}]', '[{"type":"double","value":74.25},{"type":"double","value":194.5}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-07-20 15:35:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230510865', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"Number","value":77.3},{"type":"Number","value":54.3}]', '[{"type":"Number","value":176},{"type":"Number","value":108.1}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-07-20 15:35:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230510871', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"long","value":-7},{"type":"long","value":191}]', '[{"type":"long","value":-62},{"type":"long","value":112}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'multiply', TO_DATE('2020-07-20 15:35:10', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1595230511840', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":182},{"type":"long","value":31},{"type":"unitauto.test.TestInterface","value":{}}]', '[{"type":"long","value":76},{"type":"long","value":134},{"type":"unitauto.test.TestInterface","value":{}}]', NULL, NULL, 'Long', 'Long', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-07-20 15:35:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581592809', '82001', 'apijson.demo.server', 'DemoParser', NULL, NULL, 'createSQLConfig', NULL, NULL, NULL, NULL, 'apijson.demo.server.DemoSQLConfig', 'apijson.demo.server.DemoSQLConfig', '0', NULL, NULL, 'createSQLConfig', TO_DATE('2020-08-16 20:39:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581592814', '82001', 'apijson.demo.server', 'DemoParser', NULL, NULL, 'parseResponse', '[{"type":"JSONObject","value":{}}]', '[{"type":"JSONObject","value":{}}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'parseResponse', TO_DATE('2020-08-16 20:39:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581592817', '82001', 'apijson.demo.server', 'DemoParser', NULL, NULL, 'createVerifier', NULL, NULL, NULL, NULL, 'apijson.demo.server.DemoVerifier', 'apijson.demo.server.DemoVerifier', '0', NULL, NULL, 'createVerifier', TO_DATE('2020-08-16 20:39:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581592820', '82001', 'apijson.demo.server', 'DemoParser', NULL, NULL, 'createVerifier', NULL, NULL, NULL, NULL, 'zuo.biao.apijson.server.Verifier', 'zuo.biao.apijson.server.Verifier', '0', NULL, NULL, 'createVerifier', TO_DATE('2020-08-16 20:39:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581592822', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'get', '[{"type":"String","value":"Ab_Cd-1157427156286528"},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd7648054095795039"},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'get', TO_DATE('2020-08-16 20:39:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581592824', '82001', 'apijson.demo.server', 'DemoParser', NULL, NULL, 'getSession', NULL, NULL, NULL, NULL, 'javax.servlet.http.HttpSession', 'javax.servlet.http.HttpSession', '0', NULL, NULL, 'getSession', TO_DATE('2020-08-16 20:39:52', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593021', '82001', 'apijson.demo.server', 'DemoParser', NULL, NULL, 'createSQLExecutor', NULL, NULL, NULL, NULL, 'apijson.demo.server.DemoSQLExecutor', 'apijson.demo.server.DemoSQLExecutor', '0', NULL, NULL, 'createSQLExecutor', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593023', '82001', 'apijson.demo.server', 'DemoParser', NULL, NULL, 'createSQLConfig', NULL, NULL, NULL, NULL, 'zuo.biao.apijson.server.SQLConfig', 'zuo.biao.apijson.server.SQLConfig', '0', NULL, NULL, 'createSQLConfig', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593024', '82001', 'apijson.demo.server', 'DemoParser', NULL, NULL, 'createSQLExecutor', NULL, NULL, NULL, NULL, 'zuo.biao.apijson.server.SQLExecutor', 'zuo.biao.apijson.server.SQLExecutor', '0', NULL, NULL, 'createSQLExecutor', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593090', '82001', 'apijson.demo.server', 'DemoSQLConfig', NULL, NULL, 'getDBVersion', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getDBVersion', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593092', '82001', 'apijson.demo.server', 'DemoSQLConfig', NULL, NULL, 'getUserIdKey', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getUserIdKey', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593095', '82001', 'apijson.demo.server', 'DemoSQLConfig', NULL, NULL, 'getIdKey', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getIdKey', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593254', '82001', 'apijson.demo.server', 'DemoSQLConfig', NULL, NULL, 'getDBUri', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getDBUri', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593260', '82001', 'apijson.demo.server', 'DemoSQLConfig', NULL, NULL, 'getDBAccount', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getDBAccount', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593306', '82001', 'apijson.demo.server', 'DemoVerifier', NULL, NULL, 'value', '[{"type":"Long","value":-11}]', '[{"type":"Long","value":159}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'value', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593312', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"double","value":188}]', '[{"type":"double","value":-94.01}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593315', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"long","value":13}]', '[{"type":"long","value":73}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593325', '82001', 'apijson.demo.server', 'DemoSQLConfig', NULL, NULL, 'getDBPassword', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getDBPassword', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593479', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'delete', '[{"type":"String","value":"Ab_Cd3062065178948095"},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd8826426038086247"},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'delete', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593484', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"Number","value":78.2}]', '[{"type":"Number","value":21.29}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593529', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"long","value":-59},{"type":"long","value":167}]', '[{"type":"long","value":-18},{"type":"long","value":-92}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'pow', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593563', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"Number","value":-83.1},{"type":"Number","value":64.6}]', '[{"type":"Number","value":-67.8},{"type":"Number","value":47.56}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'pow', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593567', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"double","value":9.5},{"type":"double","value":-38.08}]', '[{"type":"double","value":130.4},{"type":"double","value":-8.55}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'pow', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593618', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"long","value":100},{"type":"long","value":120}]', '[{"type":"long","value":-56},{"type":"long","value":97}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593707', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"Number","value":32},{"type":"Number","value":-74}]', '[{"type":"Number","value":168},{"type":"Number","value":5.73}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593709', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"double","value":-34.4},{"type":"double","value":165.15}]', '[{"type":"double","value":-12.9},{"type":"double","value":105}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593746', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'head', '[{"type":"String","value":"Ab_Cd-6852072105917647"},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd-3145885969901088"},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'head', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593752', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'register', '[{"type":"String","value":"Ab_Cd-6570220238381200"}]', '[{"type":"String","value":"Ab_Cd4479476228055843"}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'register', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593784', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"long","value":-26},{"type":"long","value":-38}]', '[{"type":"long","value":11},{"type":"long","value":179}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'multiply', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593787', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'put', '[{"type":"String","value":"Ab_Cd6486082166661571"},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd-5084867555555884"},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'put', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593899', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"double","value":177.3},{"type":"double","value":155}]', '[{"type":"double","value":-21.29},{"type":"double","value":98}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593917', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'login', '[{"type":"String","value":"Ab_Cd-2403443141028760"},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd-6010892586439932"},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'login', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593920', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'delegate', '[{"type":"String","value":"Ab_Cd-2625936367096420"},{"type":"String","value":"Ab_Cd4374382783115103"},{"type":"org.springframework.http.HttpMethod","value":{}},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd4296357469010379"},{"type":"String","value":"Ab_Cd-952019352307136"},{"type":"org.springframework.http.HttpMethod","value":{}},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'delegate', TO_DATE('2020-08-16 20:39:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593952', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"Number","value":178.5},{"type":"Number","value":107.75}]', '[{"type":"Number","value":93},{"type":"Number","value":100.5}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593974', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"Number","value":-60.7},{"type":"Number","value":-24}]', '[{"type":"Number","value":148.9},{"type":"Number","value":33.08}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'plus', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581593999', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"double","value":-67.4},{"type":"double","value":27}]', '[{"type":"double","value":-10.42},{"type":"double","value":96.5}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'plus', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594039', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"long","value":22},{"type":"long","value":-78}]', '[{"type":"long","value":160},{"type":"long","value":-66}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'plus', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594079', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"Number","value":23.7},{"type":"Number","value":-93.08}]', '[{"type":"Number","value":159.2},{"type":"Number","value":92.5}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'minus', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594119', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"double","value":97},{"type":"double","value":108}]', '[{"type":"double","value":134},{"type":"double","value":164.9}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'minus', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594129', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"long","value":-69},{"type":"long","value":67}]', '[{"type":"long","value":58},{"type":"long","value":160}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'minus', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594234', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":106},{"type":"long","value":82},{"type":"Object"},{"type":"unitauto.test.TestUtil$Callback1","value":{}}]', '[{"type":"long","value":159},{"type":"long","value":37},{"type":"D","value":{}},{"type":"unitauto.test.TestUtil.unitauto.test.TestUtil$Callback1<D>","value":{}}]', NULL, NULL, 'Object', 'D', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594237', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":147},{"type":"long","value":-70},{"type":"unitauto.test.TestUtil$Callback","value":{}}]', '[{"type":"long","value":51},{"type":"long","value":43},{"type":"unitauto.test.TestUtil$Callback","value":{}}]', NULL, NULL, 'Number', 'Number', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594318', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'gets', '[{"type":"String","value":"Ab_Cd-6312873248520432"},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd8792854484003731"},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'gets', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594332', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'get', '[{"type":"Map","value":{}},{"type":"Object"}]', '[{"type":"Map<K, V>","value":{}},{"type":"K","value":{}}]', NULL, NULL, 'Object', 'V', '1', NULL, NULL, 'get', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594408', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'get', '[{"type":"Object[]"},{"type":"int","value":10}]', '[{"type":"T[]"},{"type":"int","value":4}]', NULL, NULL, 'Object', 'T', '1', NULL, NULL, 'get', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594410', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'value', '[{"type":"Double","value":112}]', '[{"type":"Double","value":26.1}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'value', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594413', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'get', '[{"type":"Collection","value":[]},{"type":"int","value":12}]', '[{"type":"Collection<T>","value":[[],[],[],[]]},{"type":"int","value":18}]', NULL, NULL, 'Object', 'T', '1', NULL, NULL, 'get', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594450', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'value', '[{"type":"Boolean","value":true}]', '[{"type":"Boolean","value":true}]', NULL, NULL, 'boolean', 'boolean', '1', NULL, NULL, 'value', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594455', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'value', '[{"type":"Float","value":39}]', '[{"type":"Float","value":50.1}]', NULL, NULL, 'float', 'float', '1', NULL, NULL, 'value', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594475', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'value', '[{"type":"Long","value":10}]', '[{"type":"Long","value":91}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'value', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594536', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'value', '[{"type":"Integer","value":9}]', '[{"type":"Integer","value":20}]', NULL, NULL, 'int', 'int', '1', NULL, NULL, 'value', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594582', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'count', '[{"type":"Collection","value":[]}]', '[{"type":"Collection<T>","value":[[],[]]}]', NULL, NULL, 'int', 'int', '1', NULL, NULL, 'count', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594586', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'count', '[{"type":"Object[]"}]', '[{"type":"T[]"}]', NULL, NULL, 'int', 'int', '1', NULL, NULL, 'count', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594588', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'heads', '[{"type":"String","value":"Ab_Cd-4121266740417652"},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd-1132533832044844"},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'heads', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594589', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'count', '[{"type":"Map","value":{}}]', '[{"type":"Map<K, V>","value":{}}]', NULL, NULL, 'int', 'int', '1', NULL, NULL, 'count', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594604', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'count', '[{"type":"Array","value":[]}]', '[{"type":"Array","value":[]}]', NULL, NULL, 'int', 'int', '1', NULL, NULL, 'count', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594654', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'toString', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'toString', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594703', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'isEmpty', '[{"type":"Object[]"}]', '[{"type":"T[]"}]', NULL, NULL, 'boolean', 'boolean', '1', NULL, NULL, 'isEmpty', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594725', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'isEmpty', '[{"type":"Map","value":{}}]', '[{"type":"Map<K, V>","value":{}}]', NULL, NULL, 'boolean', 'boolean', '1', NULL, NULL, 'isEmpty', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594737', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'isEmpty', '[{"type":"Collection","value":[]}]', '[{"type":"Collection<T>","value":[[],[],[]]}]', NULL, NULL, 'boolean', 'boolean', '1', NULL, NULL, 'isEmpty', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594740', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'post', '[{"type":"String","value":"Ab_Cd5161143851581699"},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd-5572817588794092"},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'post', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594752', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'getId', NULL, NULL, NULL, NULL, 'Long', 'Long', '0', NULL, NULL, 'getId', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594804', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'isContainValue', '[{"type":"Map","value":{}},{"type":"Object"}]', '[{"type":"Map<K, V>","value":{}},{"type":"V","value":{}}]', NULL, NULL, 'boolean', 'boolean', '1', NULL, NULL, 'isContainValue', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594842', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'isIndexInRange', '[{"type":"Integer","value":0},{"type":"Object[]"}]', '[{"type":"Integer","value":-9},{"type":"Object[]"}]', NULL, NULL, 'boolean', 'boolean', '1', NULL, NULL, 'isIndexInRange', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594898', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'openGet', '[{"type":"String","value":"Ab_Cd-6370435374052664"},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd6359458887559403"},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'openGet', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594908', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'getIndexInRange', '[{"type":"Integer","value":5},{"type":"Object[]"}]', '[{"type":"Integer","value":0},{"type":"Object[]"}]', NULL, NULL, 'int', 'int', '1', NULL, NULL, 'getIndexInRange', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594910', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'getIndexInRange', '[{"type":"Integer","value":16},{"type":"Object[]"},{"type":"int","value":1}]', '[{"type":"Integer","value":14},{"type":"Object[]"},{"type":"int","value":15}]', NULL, NULL, 'int', 'int', '1', NULL, NULL, 'getIndexInRange', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594930', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'isContain', '[{"type":"Collection","value":[]},{"type":"Object"}]', '[{"type":"Collection<T>","value":[[],[],[],[],[],[]]},{"type":"T","value":{}}]', NULL, NULL, 'boolean', 'boolean', '1', NULL, NULL, 'isContain', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581594962', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'isContainKey', '[{"type":"Map","value":{}},{"type":"Object"}]', '[{"type":"Map<K, V>","value":{}},{"type":"K","value":{}}]', NULL, NULL, 'boolean', 'boolean', '1', NULL, NULL, 'isContainKey', TO_DATE('2020-08-16 20:39:54', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595024', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'getTimeStamp', '[{"type":"String","value":"Ab_Cd-3804514124665116"}]', '[{"type":"String","value":"Ab_Cd-8094531547039535"}]', NULL, NULL, 'java.sql.Timestamp', 'java.sql.Timestamp', '1', NULL, NULL, 'getTimeStamp', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595032', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'setId', '[{"type":"Long","value":104}]', '[{"type":"Long","value":142}]', NULL, NULL, 'apijson.demo.server.model.BaseModel', 'apijson.demo.server.model.BaseModel', '0', NULL, NULL, 'setId', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595072', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'headVerify', '[{"type":"String","value":"Ab_Cd-6137208035037168"}]', '[{"type":"String","value":"Ab_Cd6586431920716171"}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'headVerify', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595076', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'openHead', '[{"type":"String","value":"Ab_Cd-3666932039275660"},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd-5142435954165576"},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'String', 'String', '0', NULL, NULL, 'openHead', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595077', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'setDate', '[{"type":"String","value":"Ab_Cd1922235212315459"}]', '[{"type":"String","value":"Ab_Cd-1654110452156260"}]', NULL, NULL, 'apijson.demo.server.model.BaseModel', 'apijson.demo.server.model.BaseModel', '0', NULL, NULL, 'setDate', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595079', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'getTimeMillis', '[{"type":"String","value":"Ab_Cd-6591371934510872"}]', '[{"type":"String","value":"Ab_Cd-4571821260429348"}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'getTimeMillis', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595151', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'getDate', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getDate', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595153', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'getUserId', NULL, NULL, NULL, NULL, 'Long', 'Long', '0', NULL, NULL, 'getUserId', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595199', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'getInRange', '[{"type":"Integer","value":19},{"type":"Object[]"},{"type":"int","value":-5}]', '[{"type":"Integer","value":1},{"type":"T[]"},{"type":"int","value":11}]', NULL, NULL, 'Object', 'T', '1', NULL, NULL, 'getInRange', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595219', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'currentTimeStamp', NULL, NULL, NULL, NULL, 'java.sql.Timestamp', 'java.sql.Timestamp', '1', NULL, NULL, 'currentTimeStamp', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595225', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'postVerify', '[{"type":"String","value":"Ab_Cd-1970164704171444"}]', '[{"type":"String","value":"Ab_Cd-6818239858248959"}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'postVerify', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595228', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'getInRange', '[{"type":"Integer","value":6},{"type":"Object[]"}]', '[{"type":"Integer","value":19},{"type":"T[]"}]', NULL, NULL, 'Object', 'T', '1', NULL, NULL, 'getInRange', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595267', '82001', 'apijson.demo.server.model', 'Login', NULL, NULL, 'getType', NULL, NULL, NULL, NULL, 'Integer', 'Integer', '0', NULL, NULL, 'getType', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595373', '82001', 'apijson.demo.server.model', 'BaseModel', NULL, NULL, 'setUserId', '[{"type":"Long","value":-89}]', '[{"type":"Long","value":124}]', NULL, NULL, 'apijson.demo.server.model.BaseModel', 'apijson.demo.server.model.BaseModel', '0', NULL, NULL, 'setUserId', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595417', '82001', 'apijson.demo.server.model', 'Login', NULL, NULL, 'setType', '[{"type":"Integer","value":-1}]', '[{"type":"Integer","value":-4}]', NULL, NULL, 'apijson.demo.server.model.Login', 'apijson.demo.server.model.Login', '0', NULL, NULL, 'setType', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595425', '82001', 'apijson.demo.server.model', 'Privacy', NULL, NULL, 'setBalance', '[{"type":"Double","value":4.5}]', '[{"type":"Double","value":181.4}]', NULL, NULL, 'apijson.demo.server.model.Privacy', 'apijson.demo.server.model.Privacy', '0', NULL, NULL, 'setBalance', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595429', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'getVerify', '[{"type":"String","value":"Ab_Cd-4472284522409016"}]', '[{"type":"String","value":"Ab_Cd5459207461498331"}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'getVerify', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595432', '82001', 'apijson.demo.server.model', 'Privacy', NULL, NULL, 'get__payPassword', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'get__payPassword', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595508', '82001', 'apijson.demo.server.model', 'Privacy', NULL, NULL, 'get__password', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'get__password', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595531', '82001', 'apijson.demo.server.model', 'Privacy', NULL, NULL, 'setPhone', '[{"type":"String","value":"Ab_Cd6859709714194195"}]', '[{"type":"String","value":"Ab_Cd3286858476430655"}]', NULL, NULL, 'apijson.demo.server.model.Privacy', 'apijson.demo.server.model.Privacy', '0', NULL, NULL, 'setPhone', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595559', '82001', 'apijson.demo.server.model', 'Privacy', NULL, NULL, 'setPassword', '[{"type":"String","value":"Ab_Cd-2768552902564852"}]', '[{"type":"String","value":"Ab_Cd3075536672041335"}]', NULL, NULL, 'apijson.demo.server.model.Privacy', 'apijson.demo.server.model.Privacy', '0', NULL, NULL, 'setPassword', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595574', '82001', 'apijson.demo.server.model', 'Privacy', NULL, NULL, 'getBalance', NULL, NULL, NULL, NULL, 'Double', 'Double', '0', NULL, NULL, 'getBalance', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595595', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'logout', '[{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'logout', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595598', '82001', 'apijson.demo.server.model', 'Privacy', NULL, NULL, 'setPayPassword', '[{"type":"String","value":"Ab_Cd8241685809193115"}]', '[{"type":"String","value":"Ab_Cd7624015128150875"}]', NULL, NULL, 'apijson.demo.server.model.Privacy', 'apijson.demo.server.model.Privacy', '0', NULL, NULL, 'setPayPassword', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595675', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getName', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getName', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595759', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setName', '[{"type":"String","value":"Ab_Cd-7072572019794439"}]', '[{"type":"String","value":"Ab_Cd429940061053447"}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setName', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595773', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getId', NULL, NULL, NULL, NULL, 'Object', 'Object', '0', NULL, NULL, 'getId', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595787', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setTag', '[{"type":"String","value":"Ab_Cd-3471001813290776"}]', '[{"type":"String","value":"Ab_Cd-1085117647660484"}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setTag', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595789', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getTag', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getTag', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595856', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getPictureList', NULL, NULL, NULL, NULL, 'List', 'List<String>', '0', NULL, NULL, 'getPictureList', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595861', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setPictureList', '[{"type":"List","value":[]}]', '[{"type":"List<String>","value":[[]]}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setPictureList', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595906', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setContactIdList', '[{"type":"List","value":[]}]', '[{"type":"List<Long>","value":[[],[],[],[],[]]}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setContactIdList', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595911', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getContactIdList', NULL, NULL, NULL, NULL, 'List', 'List<Long>', '0', NULL, NULL, 'getContactIdList', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595966', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setSex', '[{"type":"Integer","value":0}]', '[{"type":"Integer","value":10}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setSex', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595973', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getSex', NULL, NULL, NULL, NULL, 'Integer', 'Integer', '0', NULL, NULL, 'getSex', TO_DATE('2020-08-16 20:39:55', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595995', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'setHead', '[{"type":"String","value":"Ab_Cd1619935895760019"}]', '[{"type":"String","value":"Ab_Cd-8290070270201927"}]', NULL, NULL, 'apijson.demo.server.model.User', 'apijson.demo.server.model.User', '0', NULL, NULL, 'setHead', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581595999', '82001', 'apijson.demo.server.model', 'User', NULL, NULL, 'getHead', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getHead', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596063', '82001', 'apijson.demo.server.model', 'Verify', NULL, NULL, 'getVerify', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getVerify', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596065', '82001', 'apijson.demo.server.model', 'Verify', NULL, NULL, 'getType', NULL, NULL, NULL, NULL, 'Integer', 'Integer', '0', NULL, NULL, 'getType', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596085', '82001', 'apijson.demo.server.model', 'Verify', NULL, NULL, 'setVerify', '[{"type":"String","value":"Ab_Cd-5881576119367516"}]', '[{"type":"String","value":"Ab_Cd4443363998657931"}]', NULL, NULL, 'apijson.demo.server.model.Verify', 'apijson.demo.server.model.Verify', '0', NULL, NULL, 'setVerify', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596131', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'newIllegalArgumentResult', '[{"type":"JSONObject","value":{}},{"type":"String","value":"Ab_Cd2568883288218019"},{"type":"String","value":"Ab_Cd-3259402438481416"}]', '[{"type":"JSONObject","value":{}},{"type":"String","value":"Ab_Cd7674981382913027"},{"type":"String","value":"Ab_Cd4555070825225571"}]', NULL, NULL, 'JSONObject', 'JSONObject', '1', NULL, NULL, 'newIllegalArgumentResult', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596180', '82001', 'apijson.demo.server.model', 'Verify', NULL, NULL, 'setType', '[{"type":"Integer","value":-6}]', '[{"type":"Integer","value":16}]', NULL, NULL, 'apijson.demo.server.model.Verify', 'apijson.demo.server.model.Verify', '0', NULL, NULL, 'setType', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596185', '82001', 'apijson.demo.server.model', 'Verify', NULL, NULL, 'setPhone', '[{"type":"String","value":"Ab_Cd1273234476184555"}]', '[{"type":"String","value":"Ab_Cd6543285919174451"}]', NULL, NULL, 'apijson.demo.server.model.Verify', 'apijson.demo.server.model.Verify', '0', NULL, NULL, 'setPhone', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596202', '82001', 'apijson.demo.server.model', 'Verify', NULL, NULL, 'getPhone', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getPhone', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596205', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'newIllegalArgumentResult', '[{"type":"JSONObject","value":{}},{"type":"String","value":"Ab_Cd4263047756076515"}]', '[{"type":"JSONObject","value":{}},{"type":"String","value":"Ab_Cd3604676397635743"}]', NULL, NULL, 'JSONObject', 'JSONObject', '1', NULL, NULL, 'newIllegalArgumentResult', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596245', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'swaggerAPIDocs', NULL, NULL, NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'swaggerAPIDocs', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596289', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'headVerify', '[{"type":"int","value":17},{"type":"String","value":"Ab_Cd6376692975587931"},{"type":"String","value":"Ab_Cd4810178671064603"}]', '[{"type":"int","value":17},{"type":"String","value":"Ab_Cd-3502652266136312"},{"type":"String","value":"Ab_Cd2858876288004727"}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'headVerify', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596325', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'listMethod', '[{"type":"String","value":"Ab_Cd-3799921005367456"}]', '[{"type":"String","value":"Ab_Cd6244246918353627"}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'listMethod', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596326', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'putPassword', '[{"type":"String","value":"Ab_Cd-3234130510111144"}]', '[{"type":"String","value":"Ab_Cd-8725576326478723"}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'putPassword', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596371', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'putBalance', '[{"type":"String","value":"Ab_Cd-5431803491717988"},{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"String","value":"Ab_Cd2227964166239899"},{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'putBalance', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596376', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'invokeMethod', '[{"type":"String","value":"Ab_Cd7325611054650071"},{"type":"javax.servlet.http.HttpServletRequest","value":{}}]', '[{"type":"String","value":"Ab_Cd-7329500946188699"},{"type":"javax.servlet.http.HttpServletRequest","value":{}}]', NULL, NULL, NULL, NULL, '0', NULL, NULL, 'invokeMethod', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596424', '82001', 'apijson.demo.server', 'DemoObjectParser', NULL, NULL, 'setMethod', '[{"type":"zuo.biao.apijson.RequestMethod","value":{}}]', '[{"type":"zuo.biao.apijson.RequestMethod","value":{}}]', NULL, NULL, 'apijson.demo.server.DemoObjectParser', 'apijson.demo.server.DemoObjectParser', '0', NULL, NULL, 'setMethod', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596434', '82001', 'apijson.demo.server', 'DemoObjectParser', NULL, NULL, 'setMethod', '[{"type":"zuo.biao.apijson.RequestMethod","value":{}}]', '[{"type":"zuo.biao.apijson.RequestMethod","value":{}}]', NULL, NULL, 'zuo.biao.apijson.server.AbstractObjectParser', 'zuo.biao.apijson.server.AbstractObjectParser', '0', NULL, NULL, 'setMethod', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596497', '82001', 'apijson.demo.server', 'Controller', NULL, NULL, 'reload', '[{"type":"String","value":"Ab_Cd7537229692443063"}]', '[{"type":"String","value":"Ab_Cd3953500794047575"}]', NULL, NULL, 'JSONObject', 'JSONObject', '0', NULL, NULL, 'reload', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596498', '82001', 'apijson.demo.server', 'DemoObjectParser', NULL, NULL, 'setMethod', '[{"type":"zuo.biao.apijson.RequestMethod","value":{}}]', '[{"type":"zuo.biao.apijson.RequestMethod","value":{}}]', NULL, NULL, 'zuo.biao.apijson.server.ObjectParser', 'zuo.biao.apijson.server.ObjectParser', '0', NULL, NULL, 'setMethod', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1597581596516', '82001', 'apijson.demo.server', 'DemoParser', NULL, NULL, 'setSession', '[{"type":"javax.servlet.http.HttpSession","value":{}}]', '[{"type":"javax.servlet.http.HttpSession","value":{}}]', NULL, NULL, 'apijson.demo.server.DemoParser', 'apijson.demo.server.DemoParser', '0', NULL, NULL, 'setSession', TO_DATE('2020-08-16 20:39:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066878794', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":75},{"type":"long","value":87},{"type":"unitauto.test.TestUtil$Callback","value":{"minusAsId(long,long)":{"callback":true},"currentTime()":{"type":"long","return":8},"sort()":{"type":"Boolean","return":true},"setA(L)":{},"setData(D)":{},"getA()":{"type":"Object"},"getB()":{"type":"Object"},"setB(L)":{},"getData()":{"type":"Object"},"setId(L)":{},"append(L,L)":{"type":"String","return":"Uex"},"getId()":{"type":"Object"}}}]', '[{"type":"long","value":75},{"type":"long","value":87},{"type":"unitauto.test.TestUtil$Callback","value":{"minusAsId(long,long)":{"callback":true},"currentTime()":{"type":"long","return":8},"sort()":{"type":"Boolean","return":true},"setA(L)":{},"setData(D)":{},"getA()":{"type":"Object"},"getB()":{"type":"Object"},"setB(L)":{},"getData()":{"type":"Object"},"setId(L)":{},"append(L,L)":{"type":"String","return":"Uex"},"getId()":{"type":"Object"}}}]', NULL, NULL, 'Number', 'Number', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-09-26 04:47:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066878921', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"Object"},{"type":"Object"},{"type":"Object"},{"type":"unitauto.test.TestUtil$Callback2","value":{"setA(L)":{},"setData(D)":{},"getA()":{"type":"Object"},"getB()":{"type":"Object"},"setB(L)":{},"getData()":{"type":"Object"},"setId(L)":{},"append(L,L)":{"type":"String","return":"i"},"getId()":{"type":"Object"}}}]', '[{"type":"L","value":{}},{"type":"L","value":{}},{"type":"D","value":{}},{"type":"unitauto.test.TestUtil$Callback2<L, D>","value":{"setA(L)":{},"setData(D)":{},"getA()":{"type":"Object"},"getB()":{"type":"Object"},"setB(L)":{},"getData()":{"type":"Object"},"setId(L)":{},"append(L,L)":{"type":"String","return":"i"},"getId()":{"type":"Object"}}}]', NULL, NULL, 'unitauto.test.TestUtil$Callback2', 'unitauto.test.TestUtil$Callback2<L, D>', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-09-26 04:47:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066878936', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":19},{"type":"long","value":19},{"type":"Object"},{"type":"unitauto.test.TestUtil$Callback1","value":{"minusAsId(long,long)":{"callback":true},"sort()":{"type":"Boolean","return":false},"setA(L)":{},"setData(D)":{},"getA()":{"type":"Object"},"getB()":{"type":"Object"},"setB(L)":{},"getData()":{"type":"Object"},"setId(L)":{},"append(L,L)":{"type":"String","return":"Mh"},"getId()":{"type":"Object"}}}]', '[{"type":"long","value":19},{"type":"long","value":19},{"type":"D","value":{}},{"type":"unitauto.test.TestUtil$Callback1<D>","value":{"minusAsId(long,long)":{"callback":true},"sort()":{"type":"Boolean","return":false},"setA(L)":{},"setData(D)":{},"getA()":{"type":"Object"},"getB()":{"type":"Object"},"setB(L)":{},"getData()":{"type":"Object"},"setId(L)":{},"append(L,L)":{"type":"String","return":"Mh"},"getId()":{"type":"Object"}}}]', NULL, NULL, 'Object', 'D', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-09-26 04:47:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066878997', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"Number","value":41.86695761266323},{"type":"Number","value":67.87908319799828}]', '[{"type":"Number","value":41.86695761266323},{"type":"Number","value":67.87908319799828}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'minus', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879011', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"double","value":-8.320774480474196},{"type":"double","value":52.88471720788297}]', '[{"type":"double","value":-8.320774480474196},{"type":"double","value":52.88471720788297}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'minus', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879015', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"long","value":40},{"type":"long","value":25}]', '[{"type":"long","value":40},{"type":"long","value":25}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'minus', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879086', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"long","value":76},{"type":"long","value":19}]', '[{"type":"long","value":76},{"type":"long","value":19}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'multiply', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879088', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"Number","value":8.988056293928404},{"type":"Number","value":3.2985783579843164}]', '[{"type":"Number","value":8.988056293928404},{"type":"Number","value":3.2985783579843164}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879206', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"Number","value":21.615341671694345},{"type":"Number","value":-0.35516529933650953}]', '[{"type":"Number","value":21.615341671694345},{"type":"Number","value":-0.35516529933650953}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'plus', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879208', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"double","value":96.54026507482254},{"type":"double","value":28.833210972219327}]', '[{"type":"double","value":96.54026507482254},{"type":"double","value":28.833210972219327}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'plus', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879216', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"long","value":45}]', '[{"type":"long","value":45}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879220', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"long","value":98},{"type":"long","value":71}]', '[{"type":"long","value":98},{"type":"long","value":71}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'plus', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879223', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"double","value":71.13539688100869},{"type":"double","value":68.80718620972296}]', '[{"type":"double","value":71.13539688100869},{"type":"double","value":68.80718620972296}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879273', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"Number","value":-4.526099491265661}]', '[{"type":"Number","value":-4.526099491265661}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879392', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"long","value":59},{"type":"long","value":38}]', '[{"type":"long","value":59},{"type":"long","value":38}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'pow', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879401', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"Number","value":15.324223042014761},{"type":"Number","value":53.72359304798836}]', '[{"type":"Number","value":15.324223042014761},{"type":"Number","value":53.72359304798836}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'pow', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879403', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"long","value":33},{"type":"long","value":40}]', '[{"type":"long","value":33},{"type":"long","value":40}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879405', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"double","value":-3.980160293592472},{"type":"double","value":75.97554417352407}]', '[{"type":"double","value":-3.980160293592472},{"type":"double","value":75.97554417352407}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'pow', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879408', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"double","value":65.30423945654718},{"type":"double","value":92.81313983234305}]', '[{"type":"double","value":65.30423945654718},{"type":"double","value":92.81313983234305}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879409', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"double","value":64.06228333550854}]', '[{"type":"double","value":64.06228333550854}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1601066879524', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"Number","value":5.9139310449596305},{"type":"Number","value":17.409419140887884}]', '[{"type":"Number","value":5.9139310449596305},{"type":"Number","value":17.409419140887884}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-09-26 04:47:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603015545204', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":75},{"type":"long","value":87},{"type":"public abstract static interface unitauto.test.TestUtil$Callback","value":{"setA(L)":{},"call(){}":{"sort()":[{"time":1603015542252,"return":true}],"getId()":[{"time":1603015539251}],"setData(D)":[{"methodArgs":[{"type":"public final class java.lang.String","value":"Mock inner interface success!"}],"time":1603015542252}],"minusAsId(long,long)":[{"methodArgs":[{"type":"public final class java.lang.Long","value":75},{"type":"public final class java.lang.Long","value":87}],"time":1603015542252}]},"call()[]":[{"method":"getId()","time":1603015539251},{"method":"sort()","time":1603015542252,"return":true},{"methodArgs":[{"$ref":"$.methodArgs[2].value.call\\(\\)\\{\\}.minusAsId\\(long\\,long\\)[0].methodArgs[0]"},{"$ref":"$.methodArgs[2].value.call\\(\\)\\{\\}.minusAsId\\(long\\,long\\)[0].methodArgs[1]"}],"method":"minusAsId(long,long)","time":1603015542252},{"methodArgs":[{"$ref":"$.methodArgs[2].value.call\\(\\)\\{\\}.setData\\(D\\)[0].methodArgs[0]"}],"method":"setData(D)","time":1603015542252}],"setData(D)":{"callback":true},"setB(L)":{},"getA()":{"type":"Object"},"data":"Mock inner interface success!","getB()":{"type":"Object"},"getData()":{"type":"Object"},"setId(L)":{},"currentTime()":{"type":"long","return":8},"sort()":{"type":"Boolean","return":true},"append(L,L)":{"type":"String","return":"Uex"},"getId()":{"type":"Object"},"minusAsId(long,long)":{}}}]', '[{"type":"long","value":75},{"type":"long","value":87},{"type":"unitauto.test.TestUtil$Callback","value":{"minusAsId(long,long)":{},"currentTime()":{"type":"long","return":8},"sort()":{"type":"Boolean","return":true},"setA(L)":{},"setData(D)":{"callback":true},"getA()":{"type":"Object"},"getB()":{"type":"Object"},"setB(L)":{},"getData()":{"type":"Object"},"setId(L)":{},"append(L,L)":{"type":"String","return":"Uex"},"getId()":{"type":"Object"}}}]', NULL, NULL, 'Number', 'Number', '0', '{
    "static": true,
    "methodArgs": [
        {
            "type": "long",
            "value": 75
        },
        {
            "type": "long",
            "value": 87
        },
        {
            "type": "unitauto.test.TestUtil$Callback",
            "value": {
                "minusAsId(long,long)": {},
                "currentTime()": {
                    "type": "long",
                    "return": 8
                },
                "sort()": {
                    "type": "Boolean",
                    "return": true
                },
                "setA(L)": {},
                "setData(D)": { "callback": true},
                "getA()": {
                    "type": "Object"
                },
                "getB()": {
                    "type": "Object"
                },
                "setB(L)": {},
                "getData()": {
                    "type": "Object"
                },
                "setId(L)": {},
                "append(L,L)": {
                    "type": "String",
                    "return": "Uex"
                },
                "getId()": {
                    "type": "Object"
                }
            }
        }
    ]
}', NULL, 'computeAsync', TO_DATE('2020-10-18 18:05:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603015723077', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"public abstract class java.lang.Number","value":5.9139310449596305},{"type":"public abstract class java.lang.Number","value":17.409419140887884}]', '[{"type":"Number","value":5.9139310449596305},{"type":"Number","value":17.409419140887884}]', NULL, NULL, 'double', 'double', '0', '{
    "static": true,
    "methodArgs": [{"type":"Number","value":5.9139310449596305},{"type":"Number","value":17.409419140887884}]
}', NULL, '除法运算', TO_DATE('2020-10-18 18:08:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603817773655', '82001', 'unitauto.test', 'TestEnum', NULL, NULL, 'toChinese', '[{"type":"public final enum unitauto.test.TestEnum","value":"WOMAN"}]', '[{"type":"unitauto.test.TestEnum","value":"WOMAN"}]', NULL, NULL, 'String', 'String', '0', '{
    "static": true,
    "methodArgs": [
        {
            "type": "unitauto.test.TestEnum",
            "value": "WOMAN"
        }
    ]
}', NULL, 'toChinese', TO_DATE('2020-10-28 00:56:13', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603817803198', '82001', 'unitauto.test', 'TestEnum', NULL, NULL, 'toChinese', '[{"type":"public final enum unitauto.test.TestEnum"}]', '["unitauto.test.TestEnum:"]', NULL, NULL, 'String', 'String', '0', '{
    "static": true,
    "methodArgs": [
        "unitauto.test.TestEnum:"
    ]
}', NULL, 'toChinese', TO_DATE('2020-10-28 00:56:43', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603817836500', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getFiledAnnotations', '[{"type":"public final class java.lang.String","value":"time"}]', '[{"type":"String","value":"time"}]', NULL, NULL, 'annotation.Annotation[]', 'annotation.Annotation[]', '0', '{
    "methodArgs": [
        {
            "type": "String",
            "value": "time"
        }
    ]
}', NULL, 'getFiledAnnotations', TO_DATE('2020-10-28 00:57:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603817850838', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getFiledAnnotations', '[{"type":"public final class java.lang.String","value":"id"}]', '[{"type":"String","value":"id"}]', NULL, NULL, 'annotation.Annotation[]', 'annotation.Annotation[]', '0', '{
    "methodArgs": [
        {
            "type": "String",
            "value": "id"
        }
    ]
}', NULL, 'getFiledAnnotations', TO_DATE('2020-10-28 00:57:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603817867359', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'toString', '[{"type":"public abstract interface java.lang.annotation.Annotation","value":{"call(){}":{"toString()":[{"time":1603817864202,"return":"{\"required()\":true}"}]},"call()[]":[{"method":"toString()","time":1603817864202,"return":"{\"required()\":true}"}],"required()":true}}]', '[{"type":"java.lang.annotation.Annotation","value":{"required()":true}}]', NULL, NULL, 'String', 'String', '0', '{
    "methodArgs": [
        {
            "type": "java.lang.annotation.Annotation",
            "value": {
                "required()": true
            }
        }
    ]
}', NULL, 'toString', TO_DATE('2020-10-28 00:57:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603817892889', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'isRequired', '[{"type":"public abstract @interface unitauto.test.TestAnnotation","value":{"call(){}":{"required()":[{"time":1603817889620,"return":true}]},"call()[]":[{"method":"required()","time":1603817889620,"return":true}],"required()":true}}]', '[{"type":"unitauto.test.TestAnnotation","value":{"required()":true}}]', NULL, NULL, 'boolean', 'boolean', '0', '{
    "methodArgs": [
        {
            "type": "unitauto.test.TestAnnotation",
            "value": {
                "required()": true
            }
        }
    ]
}', NULL, 'isRequired', TO_DATE('2020-10-28 00:58:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603817910196', '82001', 'unitauto.test', 'TestEnum', NULL, NULL, 'toChinese', NULL, '[]', NULL, NULL, 'String', 'String', '0', '{
    "methodArgs": []
}', NULL, 'toChinese', TO_DATE('2020-10-28 00:58:30', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603817929709', '82001', 'unitauto.test', 'TestSingleton', NULL, NULL, 'getName', NULL, '[]', NULL, NULL, 'String', 'String', '0', '{
    "constructor": "getDefault",
    "methodArgs": []
}', NULL, 'getName', TO_DATE('2020-10-28 00:58:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603817963818', '82001', 'unitauto.test', 'TestSingleton', NULL, NULL, 'test', '[{"type":"public final class java.lang.String","value":"get instance with args"}]', '["get instance with args"]', NULL, NULL, 'boolean', 'boolean', '0', '{
    "constructor": "getInstance",
    "classArgs": [
        "boolean:false"
    ],
    "methodArgs": [
        "get instance with args"
    ]
}', NULL, 'test', TO_DATE('2020-10-28 00:59:23', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603817981819', '82001', 'unitauto.test', 'TestSingleton', NULL, NULL, 'test', NULL, '[]', NULL, NULL, 'boolean', 'boolean', '0', '{
    "constructor": "getDefault",
    "methodArgs": []
}', NULL, 'test', TO_DATE('2020-10-28 00:59:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819565987', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"Number","value":73.25847940047305},{"type":"Number","value":13.698706260183513}]', '[{"type":"Number","value":73.25847940047305},{"type":"Number","value":13.698706260183513}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'minus', TO_DATE('2020-10-28 01:26:05', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819565992', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"double","value":4.666350923060126},{"type":"double","value":11.998433612386627}]', '[{"type":"double","value":4.666350923060126},{"type":"double","value":11.998433612386627}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'minus', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819565995', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"long","value":78}]', '[{"type":"long","value":78}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566005', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":53},{"type":"long","value":-3},{"type":"Object"},{"type":"unitauto.test.TestUtil$Callback1","value":{"sort()":{"type":"Boolean","return":true},"minusAsId(long,long)":{"callback":true},"append(L,L)":{"type":"String","return":"Ildl"},"getId()":{"type":"Object"},"setId(L)":{},"getData()":{"type":"Object"},"setData(D)":{},"setA(L)":{},"setB(L)":{},"getA()":{"type":"Object"},"getB()":{"type":"Object"}}}]', '[{"type":"long","value":53},{"type":"long","value":-3},{"type":"D","value":{}},{"type":"unitauto.test.TestUtil.unitauto.test.TestUtil$Callback1<D>","value":{"sort()":{"type":"Boolean","return":true},"minusAsId(long,long)":{"callback":true},"append(L,L)":{"type":"String","return":"Ildl"},"getId()":{"type":"Object"},"setId(L)":{},"getData()":{"type":"Object"},"setData(D)":{},"setA(L)":{},"setB(L)":{},"getA()":{"type":"Object"},"getB()":{"type":"Object"}}}]', NULL, NULL, 'Object', 'D', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566006', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'minus', '[{"type":"long","value":98},{"type":"long","value":94}]', '[{"type":"long","value":98},{"type":"long","value":94}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'minus', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566085', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":78},{"type":"long","value":91},{"type":"unitauto.test.TestUtil$Callback","value":{"minusAsId(long,long)":{"callback":true},"currentTime()":{"type":"long","return":50},"sort()":{"type":"Boolean","return":false},"append(L,L)":{"type":"String","return":"Ahwc"},"getId()":{"type":"Object"},"setId(L)":{},"getData()":{"type":"Object"},"setData(D)":{},"setA(L)":{},"setB(L)":{},"getA()":{"type":"Object"},"getB()":{"type":"Object"}}}]', '[{"type":"long","value":78},{"type":"long","value":91},{"type":"unitauto.test.TestUtil$Callback","value":{"minusAsId(long,long)":{"callback":true},"currentTime()":{"type":"long","return":50},"sort()":{"type":"Boolean","return":false},"append(L,L)":{"type":"String","return":"Ahwc"},"getId()":{"type":"Object"},"setId(L)":{},"getData()":{"type":"Object"},"setData(D)":{},"setA(L)":{},"setB(L)":{},"getA()":{"type":"Object"},"getB()":{"type":"Object"}}}]', NULL, NULL, 'Number', 'Number', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566111', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"double","value":4.221247429234431}]', '[{"type":"double","value":4.221247429234431}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566112', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'computeAsync', '[{"type":"long","value":23},{"type":"long","value":48},{"type":"unitauto.test.TestInterface","value":{"getId()":{"type":"Long","return":-9},"sort()":{"type":"Boolean"},"setId(Long)":{},"getData()":{"type":"Object"},"setData(Object)":{},"minusAsId(long,long)":{"callback":true}}}]', '[{"type":"long","value":23},{"type":"long","value":48},{"type":"unitauto.test.TestInterface","value":{"getId()":{"type":"Long","return":-9},"sort()":{"type":"Boolean"},"setId(Long)":{},"getData()":{"type":"Object"},"setData(Object)":{},"minusAsId(long,long)":{"callback":true}}}]', NULL, NULL, 'Long', 'Long', '1', NULL, NULL, 'computeAsync', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566120', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"long","value":32},{"type":"long","value":26}]', '[{"type":"long","value":32},{"type":"long","value":26}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566121', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'sqrt', '[{"type":"Number","value":59.13051734715717}]', '[{"type":"Number","value":59.13051734715717}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'sqrt', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566184', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"long","value":-3},{"type":"long","value":94}]', '[{"type":"long","value":-3},{"type":"long","value":94}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'pow', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566209', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'pow', '[{"type":"Number","value":33.53318441778551},{"type":"Number","value":12.440944441211832}]', '[{"type":"Number","value":33.53318441778551},{"type":"Number","value":12.440944441211832}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'pow', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566221', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"double","value":5.19349215502809},{"type":"double","value":37.14161319131342}]', '[{"type":"double","value":5.19349215502809},{"type":"double","value":37.14161319131342}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566224', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"double","value":92.94031784627708},{"type":"double","value":44.68579475935381}]', '[{"type":"double","value":92.94031784627708},{"type":"double","value":44.68579475935381}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566226', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'divide', '[{"type":"Number","value":46.484809200028764},{"type":"Number","value":89.75525826450051}]', '[{"type":"Number","value":46.484809200028764},{"type":"Number","value":89.75525826450051}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'divide', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566228', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"long","value":60},{"type":"long","value":-2}]', '[{"type":"long","value":60},{"type":"long","value":-2}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'multiply', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566261', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'multiply', '[{"type":"Number","value":30.227607622681507},{"type":"Number","value":26.30478804479599}]', '[{"type":"Number","value":30.227607622681507},{"type":"Number","value":26.30478804479599}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'multiply', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566303', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"Number","value":44.15434990884568},{"type":"Number","value":18.055984652423163}]', '[{"type":"Number","value":44.15434990884568},{"type":"Number","value":18.055984652423163}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'plus', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566315', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"long","value":45},{"type":"long","value":87}]', '[{"type":"long","value":45},{"type":"long","value":87}]', NULL, NULL, 'long', 'long', '1', NULL, NULL, 'plus', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819566317', '82001', 'unitauto.test', 'TestUtil', NULL, NULL, 'plus', '[{"type":"double","value":29.300014408428552},{"type":"double","value":19.16203616092248}]', '[{"type":"double","value":29.300014408428552},{"type":"double","value":19.16203616092248}]', NULL, NULL, 'double', 'double', '1', NULL, NULL, 'plus', TO_DATE('2020-10-28 01:26:06', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656075', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'toString', '[{"type":"java.lang.annotation.Annotation","value":{"annotationType()":{"type":"java.lang.Class"}}}]', '[{"type":"java.lang.annotation.Annotation","value":{"annotationType()":{"type":"java.lang.Class"}}}]', NULL, NULL, 'String', 'String', '1', NULL, NULL, 'toString', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656085', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'setTagList', '[{"type":"List","value":["mV`","","pPHb"]}]', '[{"type":"List<String>","value":["mV`","","pPHb"]}]', NULL, NULL, NULL, NULL, '0', NULL, NULL, 'setTagList', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656086', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getTagList', NULL, NULL, NULL, NULL, 'List', 'List<String>', '0', NULL, NULL, 'getTagList', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656101', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getClassAnnotation', '[{"type":"java.lang.Class","value":{}},{"type":"java.lang.Class","value":{}}]', '[{"type":"Class<?>","value":{}},{"type":"Class<A>","value":{}}]', NULL, NULL, 'java.lang.annotation.Annotation', 'A', '0', NULL, NULL, 'getClassAnnotation', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656180', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getFiledAnnotation', '[{"type":"String","value":"Y"},{"type":"java.lang.Class","value":{}}]', '[{"type":"String","value":"Y"},{"type":"Class<A>","value":{}}]', 'NoSuchFieldException,SecurityException', 'NoSuchFieldException,SecurityException', 'java.lang.annotation.Annotation', 'A', '0', NULL, NULL, 'getFiledAnnotation', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656188', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getClassAnnotations', NULL, NULL, NULL, NULL, 'annotation.Annotation[]', 'annotation.Annotation[]', '0', NULL, NULL, 'getClassAnnotations', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656198', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getId', NULL, NULL, NULL, NULL, 'Long', 'Long', '0', NULL, NULL, 'getId', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656201', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getName', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getName', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656264', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getTimeAnnotations', NULL, NULL, 'NoSuchFieldException,SecurityException', 'NoSuchFieldException,SecurityException', 'annotation.Annotation[]', 'annotation.Annotation[]', '0', NULL, NULL, 'getTimeAnnotations', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656292', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'isRequired', '[{"type":"unitauto.test.TestAnnotation","value":{"required()":{"type":"boolean","return":false},"alias()":{"type":"String","return":""},"gender()":{"type":"unitauto.test.TestEnum","return":"MAN"},"annotationType()":{"type":"java.lang.Class"}}}]', '[{"type":"unitauto.test.TestAnnotation","value":{"required()":{"type":"boolean","return":false},"alias()":{"type":"String","return":""},"gender()":{"type":"unitauto.test.TestEnum","return":"MAN"},"annotationType()":{"type":"java.lang.Class"}}}]', NULL, NULL, 'boolean', 'boolean', '1', NULL, NULL, 'isRequired', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656294', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'setId', '[{"type":"Long","value":40}]', '[{"type":"Long","value":40}]', NULL, NULL, NULL, NULL, '0', NULL, NULL, 'setId', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656295', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getFiledAnnotations', '[{"type":"String","value":"h"}]', '[{"type":"String","value":"h"}]', 'NoSuchFieldException,SecurityException', 'NoSuchFieldException,SecurityException', 'annotation.Annotation[]', 'annotation.Annotation[]', '0', NULL, NULL, 'getFiledAnnotations', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656296', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'setTime', '[{"type":"Long","value":24}]', '[{"type":"Long","value":24}]', NULL, NULL, NULL, NULL, '0', NULL, NULL, 'setTime', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819656331', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getTime', NULL, NULL, NULL, NULL, 'Long', 'Long', '0', NULL, NULL, 'getTime', TO_DATE('2020-10-28 01:27:36', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819691596', '82001', 'unitauto.test', 'TestSingleton', NULL, NULL, 'getDefault', NULL, NULL, NULL, NULL, 'unitauto.test.TestSingleton', 'unitauto.test.TestSingleton', '1', NULL, NULL, 'getDefault', TO_DATE('2020-10-28 01:28:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819691612', '82001', 'unitauto.test', 'TestSingleton', NULL, NULL, 'getInstance', '[{"type":"boolean","value":true}]', '[{"type":"boolean","value":true}]', NULL, NULL, 'unitauto.test.TestSingleton', 'unitauto.test.TestSingleton', '1', NULL, NULL, 'getInstance', TO_DATE('2020-10-28 01:28:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819691613', '82001', 'unitauto.test', 'TestSingleton', NULL, NULL, 'getName', NULL, NULL, NULL, NULL, 'String', 'String', '0', NULL, NULL, 'getName', TO_DATE('2020-10-28 01:28:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603819691616', '82001', 'unitauto.test', 'TestSingleton', NULL, NULL, 'setName', '[{"type":"String","value":"Yk]"}]', '[{"type":"String","value":"Yk]"}]', NULL, NULL, NULL, NULL, '0', NULL, NULL, 'setName', TO_DATE('2020-10-28 01:28:11', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603820036845', '82001', 'unitauto.test', 'TestBean', NULL, NULL, 'getFiledAnnotations', '[{"type":"public final class java.lang.String","value":"id"}]', '[{"type":"String","value":"id"}]', NULL, NULL, 'annotation.Annotation[]', 'annotation.Annotation[]', '0', '{
    "methodArgs": [
        {
            "type": "String",
            "value": "id"
        }
    ]
}', NULL, 'getFiledAnnotations', TO_DATE('2020-10-28 01:33:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1603822242584', '82001', 'unitauto.test', 'TestSingleton', NULL, NULL, 'test', NULL, '[]', NULL, NULL, 'boolean', 'boolean', '0', '{
    "methodArgs": [],
    "this": {
        "type": "unitauto.test.TestSingleton",
        "value": {
            "name": "Test"
        }
    }
}', NULL, '通过传参 this 来 mock 自身', TO_DATE('2020-10-28 02:10:42', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "Method" VALUES ('1604152910192', '82001', 'android.widget', 'LinearLayout', NULL, NULL, 'getChildAt', '[{"type":"int","value":3}]', '["int:3"]', NULL, NULL, 'android.view.View', 'android.view.View', '0', '{
    "methodArgs": [
        "int:3"
    ]
}', NULL, 'getChildAt', TO_DATE('2020-10-31 22:01:50', 'SYYYY-MM-DD HH24:MI:SS'));
