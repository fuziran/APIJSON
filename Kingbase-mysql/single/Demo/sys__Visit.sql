-- Kingbase MySQL 兼容模式 SQL
-- 转换自: MySQL/single/Demo/sys__Visit.sql
-- 转换时间: 2026-05-10 20:57:48
-- 使用方法: 在 Kingbase 数据库的 MySQL 兼容模式下执行

--
-- ------------------------------------------------------


--
-- Table structure for table `_Visit`
--

DROP TABLE IF EXISTS `_Visit`;
CREATE TABLE `_Visit` (
  `model` varchar(15) NOT NULL,
  `id` bigint(15) NOT NULL,
  `operate` tinyint(4) NOT NULL COMMENT '1-增\n2-删\n3-改\n4-查',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `_Visit`
--

LOCK TABLES `_Visit` WRITE;
UNLOCK TABLES;


-- Dump completed on 2025-07-07  1:39:02
