-- Kingbase MySQL compatibility mode full initialization entry script.
-- Run with ksql, for example:
--   ksql -d apijson -f Kingbase/Kingbase-MYSQL/sys.sql

\set ON_ERROR_STOP on

\ir init_public_apijson.sql
\ir init_public_demo_tables.sql
\ir init_public_uigo.sql

COMMIT;
