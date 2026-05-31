-- Kingbase MySQL compatibility mode bootstrap script for APIJSON.
-- Run with ksql from this directory, or use:
--   ksql -d apijson -f Kingbase/Kingbase-MYSQL/init_public_apijson.sql

\set ON_ERROR_STOP on

\ir single/sys_Access.sql
\ir single/sys_Function.sql
\ir single/sys_Request.sql
\ir single/sys_Document.sql
\ir single/sys_Script.sql
\ir single/sys_Chain.sql
\ir single/sys_TestRecord.sql
\ir single/sys_Random.sql
\ir single/sys_Method.sql

COMMIT;
