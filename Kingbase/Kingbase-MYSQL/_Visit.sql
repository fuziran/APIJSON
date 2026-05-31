-- Kingbase-MySQL initialization script for APIJSON _Visit.
-- Source: APIJSONDemo/APIJSON-Demo/MySQL/single/Demo/sys__Visit.sql
-- Source table has no seed data.

DROP TABLE IF EXISTS `_Visit`;

CREATE TABLE `_Visit` (
  `model` varchar(15) NOT NULL,
  `id` bigint NOT NULL,
  `operate` tinyint NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

