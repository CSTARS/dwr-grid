CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
COMMENT ON EXTENSION postgis IS 'Postgis Geographic Package';

CREATE EXTENSION IF NOT EXISTS plv8;
COMMENT ON EXTENSION plv8 IS 'Postgres Javascript (v8)';

alter database :DBNAME set search_path to goes,public;

CREATE ROLE anon;
CREATE ROLE admin;
CREATE ROLE authenticator noinherit;

-- ALLOW PGR TO UPGRADE ROLES
GRANT anon TO authenticator;
GRANT admin TO authenticator;

alter user anon encrypted password 'anon';
alter role anon login ;
