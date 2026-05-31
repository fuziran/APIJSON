-- Kingbase MySQL compatibility initialization script for APIJSON Chain.
-- Source: Kingbase-mysql/single/Auto/sys_Chain.sql

SET standard_conforming_strings = on;

-- Kingbase MySQL 兼容模式 SQL
-- 转换自: MySQL/single/Auto/sys_Chain.sql
-- 转换时间: 2026-05-10 20:57:49
-- 使用方法: 在 Kingbase 数据库的 MySQL 兼容模式下执行

--
-- ------------------------------------------------------

--
-- Table structure for table `Chain`
--

DROP TABLE IF EXISTS `Chain`;
CREATE TABLE `Chain` (
  `id` bigint NOT NULL,
  `userId` bigint NOT NULL,
  `host` varchar(100) DEFAULT NULL,
  `testAccountId` varchar(45) NOT NULL DEFAULT '0',
  `toGroupId` bigint NOT NULL DEFAULT '0',
  `groupId` bigint NOT NULL,
  `groupName` varchar(100) NOT NULL,
  `rank` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `documentId` bigint NOT NULL DEFAULT '0',
  `documentName` varchar(100) DEFAULT NULL,
  `randomId` bigint NOT NULL DEFAULT '0',
  `randomName` varchar(100) DEFAULT NULL,
  `scriptId` bigint NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tagList` json DEFAULT NULL COMMENT '标签列表',
  `testName` varchar(45) DEFAULT NULL COMMENT '测试用户名称',
  `testAccount` varchar(45) DEFAULT NULL COMMENT '测试用户账号，一般是手机号、邮箱等',
  `testInfo` json DEFAULT NULL COMMENT '测试用户信息',
  PRIMARY KEY (`id`)
);

CREATE UNIQUE INDEX `idx_Chain_idnew_table_UNIQUE` ON `Chain` (`id`);

--
-- Dumping data for table `Chain`
--

INSERT INTO `Chain` VALUES (11,82001,NULL,'',0,1714655556079,'查询动态列表-查询动态详情-查询评论列表-回复评论','2024-10-27 13:46:19',0,NULL,0,NULL,0,'2024-05-02 13:12:36','[\"Chat\", \"Tommy\"]',NULL,NULL,NULL),(12,82001,NULL,'',0,1714655556079,'查询动态列表-查询动态详情-查询评论列表-回复评论','2024-10-27 13:46:19',1648334213866,NULL,0,NULL,0,'2024-05-02 13:15:49','[\"Chat\", \"Tommy\"]','','','{}'),(13,82001,NULL,'82002',0,1714655556079,'查询动态列表-查询动态详情-查询评论列表-回复评论','2024-10-27 13:46:19',1546414179257,NULL,0,NULL,0,'2024-05-02 13:16:02','[\"Chat\", \"Tommy\"]','Jan','13000082002','{\"id\": 82002, \"name\": \"Jan\", \"phone\": \"13000082002\", \"account\": \"13000082002\", \"baseUrl\": \"http://localhost:8080\", \"password\": \"123456\", \"redCount\": 0, \"remember\": false, \"blueCount\": 0, \"greenCount\": 0, \"isLoggedIn\": true, \"totalCount\": 18, \"whiteCount\": 18, \"orangeCount\": 0, \"summaryType\": \"total\"}'),(15,82001,NULL,'',0,1714655556079,'查询动态列表-查询动态详情-查询评论列表-回复评论','2024-10-27 13:46:19',1704192205562,NULL,0,NULL,0,'2024-05-02 13:21:29','[\"Chat\", \"Tommy\"]',NULL,NULL,NULL),(16,82001,NULL,'',0,1714655556079,'查询动态列表-查询动态详情-查询评论列表-回复评论','2024-10-27 13:46:19',1704192205563,NULL,0,NULL,0,'2024-05-02 13:21:54','[\"Chat\", \"Tommy\"]',NULL,NULL,NULL),(17,82001,NULL,'82003',0,1714655556079,'查询动态列表-查询动态详情-查询评论列表-回复评论','2024-10-27 13:46:19',1511969630372,NULL,0,NULL,0,'2024-05-02 13:22:10','[\"Chat\", \"Tommy\"]','Wechat','13000082003','{\"id\": 82003, \"name\": \"Wechat\", \"phone\": \"13000082003\", \"account\": \"13000082003\", \"baseUrl\": \"http://localhost:8080\", \"password\": \"123456\", \"redCount\": 0, \"remember\": false, \"blueCount\": 0, \"greenCount\": 0, \"isLoggedIn\": true, \"totalCount\": 0, \"whiteCount\": 0, \"orangeCount\": 0, \"summaryType\": \"total\"}'),(48,1704867025040,NULL,'',0,1742784526673,'查询动态列表','2025-03-24 02:48:46',0,NULL,0,NULL,0,'2025-03-24 02:48:46',NULL,NULL,NULL,NULL),(49,82001,NULL,'',0,1742784526673,'查询动态列表','2025-03-24 06:05:56',1704192205420,NULL,0,NULL,0,'2025-03-24 06:05:56','[\"Moment\", \"Lemon\"]','','','{}'),(59,82001,NULL,'',0,1742784526673,'查询动态列表','2025-08-08 04:09:57',1564483634841,NULL,0,NULL,0,'2025-08-08 04:09:58','[\"Moment\", \"Lemon\"]','','','{}'),(1759994627546,82001,NULL,'',0,1714655556079,'查询动态列表-查询动态详情-查询评论列表-回复评论','2025-10-09 07:23:47',1546414192830,NULL,0,NULL,0,'2025-10-09 07:23:47','[\"Chat\", \"Tommy\"]',NULL,NULL,NULL),(1761204465097,82001,NULL,'82001',0,1714655556079,'查询动态列表-查询动态详情-查询评论列表-回复评论','2025-10-23 07:27:45',1704192205420,NULL,0,NULL,0,'2025-10-23 07:27:45','[\"Chat\", \"Tommy\"]','Test User','13000082001','{\"id\": 82001, \"name\": \"Test User\", \"phone\": \"13000082001\", \"account\": \"13000082001\", \"baseUrl\": \"http://localhost:8080\", \"password\": \"123456\", \"redCount\": 7, \"remember\": false, \"blueCount\": 13, \"greenCount\": 0, \"isLoggedIn\": true, \"totalCount\": 26, \"whiteCount\": 6, \"orangeCount\": 0, \"summaryType\": \"total\"}'),(1761204465098,82001,NULL,'',0,1742784526673,'查询动态列表','2025-10-27 03:14:19',1522905895591,NULL,0,NULL,0,'2025-10-27 03:14:20','[\"Moment\", \"Lemon\"]','','','{}'),(1761204465117,82001,NULL,'',0,1742784526673,'查询动态列表','2025-11-30 10:43:35',1511796155276,'获取验证码',0,NULL,0,'2025-11-30 10:43:35','[\"Moment\", \"Lemon\"]',NULL,NULL,NULL),(1761204465119,82001,NULL,'0',0,1765128460243,'test chain','2025-12-07 17:27:40',0,NULL,0,NULL,0,'2025-12-07 17:27:40','[\"tets\"]',NULL,NULL,NULL),(1765722250311,82001,NULL,'0',0,1765128460243,'test chain','2025-12-14 14:24:10',1546414192830,'获取用户列表',0,NULL,0,'2025-12-14 14:24:10',NULL,NULL,NULL,NULL),(1765725895387,82003,NULL,'0',0,1765128460243,'test chain','2025-12-14 15:24:55',1560737118846,'获取单个用户信息2 12:05',0,NULL,0,'2025-12-14 15:24:55',NULL,NULL,NULL,NULL);
