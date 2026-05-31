-- Kingbase MySQL compatibility mode UIGO tables for APIJSON.
-- Run after init_public_apijson.sql.

\set ON_ERROR_STOP on

\ir single/sys_Device.sql
\ir single/sys_System.sql
\ir single/sys_Flow.sql
\ir single/sys_Input.sql
\ir single/sys_Output.sql

COMMIT;
