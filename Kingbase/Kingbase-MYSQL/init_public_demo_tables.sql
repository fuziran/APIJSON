-- Kingbase MySQL compatibility mode demo tables for APIJSON.
-- Run after init_public_apijson.sql.

\set ON_ERROR_STOP on

\ir single/sys__Visit.sql
\ir single/sys_apijson_user.sql
\ir single/sys_apijson_privacy.sql
\ir single/sys_Moment.sql
\ir single/sys_Comment.sql
\ir single/sys_Verify.sql
\ir single/sys_Login.sql
\ir single/sys_Praise.sql

COMMIT;
