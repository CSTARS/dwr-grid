CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
COMMENT ON EXTENSION postgis IS 'Postgis Geographic Package';

alter database :DBNAME set search_path to public;

CREATE ROLE anon;
CREATE ROLE admin;
CREATE ROLE authenticator noinherit;

-- ALLOW PGR TO UPGRADE ROLES
GRANT anon TO authenticator;
GRANT admin TO authenticator;

alter user anon encrypted password 'anon';
alter role anon login ;
