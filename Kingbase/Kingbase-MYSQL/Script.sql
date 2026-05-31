-- Kingbase-MySQL initialization script for APIJSON Script.
-- Source: APIJSONDemo/APIJSON-Demo/MySQL/single/Auto/sys_Script.sql
-- Cleaned from mysqldump syntax for KStudio execution.

DROP TABLE IF EXISTS `Script`;

CREATE TABLE `Script` (
  `id` bigint NOT NULL,
  `userId` bigint NOT NULL DEFAULT 0,
  `testAccountId` bigint NOT NULL DEFAULT 0,
  `chainGroupId` bigint NOT NULL DEFAULT 0,
  `chainId` bigint NOT NULL DEFAULT 0,
  `documentId` bigint NOT NULL DEFAULT 0,
  `simple` tinyint NOT NULL DEFAULT 0,
  `ahead` tinyint NOT NULL DEFAULT 0,
  `title` varchar(100) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `Script` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `detail` varchar(1000) DEFAULT NULL,
  `randomId` bigint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

INSERT INTO `Script` VALUES (1,0,0,0,0,0,0,0,NULL,$apijson_1$getType$apijson_1$,$apijson_2$function getType(curObj, key) {
    var val = curObj == null ? null : curObj[key];
    return val instanceof Array ? "array" : typeof val;
}$apijson_2$,$apijson_3$2022-11-16 16:01:23$apijson_3$,NULL,0),(2,0,0,0,0,0,0,0,NULL,$apijson_4$isContain$apijson_4$,$apijson_5$function isContain(curObj, arrKey, valKey) {
    var arr = curObj == null ? null : curObj[arrKey];
    var val = curObj == null ? null : curObj[valKey];
    return arr != null && arr.indexOf(val) >=0;
}$apijson_5$,$apijson_6$2022-11-16 16:02:48$apijson_6$,NULL,0),(3,0,0,0,0,0,1,0,NULL,$apijson_7$init$apijson_7$,$apijson_8$var i = 1;
"init done "  + i;$apijson_8$,$apijson_9$2022-11-16 16:41:35$apijson_9$,NULL,0),(4,0,0,0,0,0,0,0,NULL,$apijson_10$length$apijson_10$,$apijson_11$function length(curObj, key) {
    var val = curObj == null ? null : curObj[key];
    return val == null ? 0 : val.length;
}$apijson_11$,$apijson_12$2022-11-16 17:18:43$apijson_12$,NULL,0),(1670877914051,82001,0,0,0,0,1,1,$apijson_13$执行脚本 2022-12-13 04:44$apijson_13$,$apijson_14$$apijson_14$,$apijson_15$function assert(assertion, msg) {
     if (assertion === true) {
         return
     }
     if (msg == null) {
         msg = 'assert failed! assertion = ' + assertion
     }

     if (isTest) {
         console.log(msg)
         alert(msg)
     } else {
         throw new Error(msg)
     } 
}  

if (isTest) {
     assert(true)
     assert(false)
     assert(true, 'ok')
     assert(false, 'data.User shoule not be null!') 
}

function getCurAccount() {
  return App.getCurrentAccount()
}$apijson_15$,$apijson_16$2022-12-12 20:45:14$apijson_16$,NULL,0),(1670878495619,82001,82002,0,0,0,1,0,$apijson_17$执行脚本 2022-12-13 04:54$apijson_17$,$apijson_18$$apijson_18$,$apijson_19$function getCurAccount() {
  return App.getCurrentAccount()
}$apijson_19$,$apijson_20$2022-12-12 20:54:55$apijson_20$,NULL,0),(1670878529042,82001,82001,0,0,0,1,1,$apijson_21$执行脚本 2022-12-13 04:55$apijson_21$,$apijson_22$$apijson_22$,$apijson_23$function getCurAccount() {
  return App.getCurrentAccount()
}$apijson_23$,$apijson_24$2022-12-12 20:55:29$apijson_24$,NULL,0),(1670878622401,82001,82003,0,0,0,1,0,$apijson_25$执行脚本 2022-12-13 04:57$apijson_25$,$apijson_26$$apijson_26$,$apijson_27$if (isPre) {
  header['my-header'] = 'test'
}$apijson_27$,$apijson_28$2022-12-12 20:57:02$apijson_28$,NULL,0),(1670885503909,82001,0,0,0,1657045372046,1,1,$apijson_29$执行脚本 2022-12-13 06:51$apijson_29$,$apijson_30$$apijson_30$,$apijson_31$if (isPre) {
  req.User.id = 82005
}$apijson_31$,$apijson_32$2022-12-12 22:51:43$apijson_32$,NULL,0),(1670887211207,82001,0,0,0,1657045372046,1,0,$apijson_33$执行脚本 2022-12-13 07:20$apijson_33$,$apijson_34$$apijson_34$,$apijson_35$$apijson_35$,$apijson_36$2022-12-12 23:20:11$apijson_36$,NULL,0),(1676368454070,82001,0,0,0,1546414192830,1,0,NULL,$apijson_37$casePost1546414192830$apijson_37$,$apijson_38$$apijson_38$,$apijson_39$2023-02-14 09:54:14$apijson_39$,NULL,0),(1679282174670,82001,0,0,0,0,1,1,NULL,$apijson_40$到店系统查询$apijson_40$,$apijson_41$$apijson_41$,$apijson_42$2023-03-20 03:16:14$apijson_42$,NULL,0),(1680660620759,82001,0,0,0,1511796155276,1,1,NULL,$apijson_43$casePre1511796155276$apijson_43$,$apijson_44$if (isPre) {
    console.log('test pre script 4 /post/verify')    
}
$apijson_44$,$apijson_45$2024-05-03 03:55:14$apijson_45$,NULL,0),(1680660620760,82001,0,1716706529846,42,1511970009072,1,1,NULL,$apijson_46$casePre1511970009072$apijson_46$,$apijson_47$if (isPre) { console.log("test pre script") }$apijson_47$,$apijson_48$2024-09-08 16:00:15$apijson_48$,NULL,0),(1680660620761,82001,0,1716706529846,42,1511970009072,1,0,NULL,$apijson_49$casePost1511970009072$apijson_49$,$apijson_50$console.log('run post script')$apijson_50$,$apijson_51$2024-09-08 16:00:32$apijson_51$,NULL,0),(1680660620762,82001,0,1714209723275,2,1546414192830,1,1,NULL,$apijson_52$casePre1546414192830$apijson_52$,$apijson_53$$apijson_53$,$apijson_54$2024-11-28 02:10:39$apijson_54$,NULL,0),(1738490311550,0,0,0,0,1560244940013,1,0,NULL,$apijson_55$casePost1560244940013$apijson_55$,$apijson_56$$apijson_56$,$apijson_57$2025-02-02 09:58:32$apijson_57$,NULL,0),(1738490327734,0,0,0,0,0,1,0,NULL,$apijson_58$globalPost0$apijson_58$,$apijson_59$if (data != null) {
    delete data["sql:generate|cache|execute|maxExecute"]
}
$apijson_59$,$apijson_60$2025-02-02 09:58:48$apijson_60$,NULL,0),(1738490404341,0,0,0,0,0,1,1,NULL,$apijson_61$globalPre0$apijson_61$,$apijson_62$req['@explain'] = true$apijson_62$,$apijson_63$2025-02-02 10:00:04$apijson_63$,NULL,0),(1738490404342,82001,0,0,0,0,1,1,NULL,$apijson_64$$apijson_64$,$apijson_65$$apijson_65$,$apijson_66$2025-03-11 08:54:24$apijson_66$,NULL,0),(1738490404343,82001,0,0,0,1560737118846,1,0,NULL,$apijson_67$casePost1560737118846$apijson_67$,$apijson_68$$apijson_68$,$apijson_69$2025-12-15 05:16:55$apijson_69$,NULL,0),(1738490404344,82001,0,0,0,0,1,1,NULL,$apijson_70$globalPre0$apijson_70$,$apijson_71$function assert(b, msg) { 
  if (b) { 
     return; 
  } function assert(b, msg) { 
  if (b) { 
     return; 
  } 
  throw new Error(msg || '断言失败'); 
}; 

App.assert = assert;
  throw new Error(msg || '断言失败'); 
}; 
App.assert = assert;$apijson_71$,$apijson_72$2026-02-13 07:18:02$apijson_72$,NULL,0),(1738490404345,82001,0,0,0,1703475322145,1,0,NULL,$apijson_73$casePost1703475322145$apijson_73$,$apijson_74$var data = data || res.data || {}
var methodArgs = data.methodArgs || []; 
var a = (methodArgs[0] || {}).value; 
var b = (methodArgs[1] || {}).value;
App.assert(data['return'] == Math.pow(a, b), data['return'] + ' != Math.pow(' + a + ', ' + b + ') = ' + Math.pow(a, b)); // + '\n\n' + JSON.stringify(data, null, 4));$apijson_74$,$apijson_75$2026-02-13 07:19:21$apijson_75$,NULL,0);
