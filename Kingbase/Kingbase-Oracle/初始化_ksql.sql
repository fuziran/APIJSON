-- Kingbase Oracle initialization entry script.
-- Run with ksql, for example:
--   ksql -d apijson -f Kingbase/Kingbase-Oracle/初始化_ksql.sql

\set ON_ERROR_STOP on

\ir single/_Visit.sql
\ir single/Access.sql
\ir single/apijson_privacy.sql
\ir single/apijson_user.sql
\ir single/b_stone.sql
\ir single/Comment.sql
\ir single/Document.sql
\ir single/Function.sql
\ir single/Script.sql
\ir single/Login.sql
\ir single/Method.sql
\ir single/Moment.sql
\ir single/Praise.sql
\ir single/Random.sql
\ir single/Request.sql
\ir single/Response.sql
\ir single/TestRecord.sql
\ir single/Verify.sql
\ir single/constraints.sql
