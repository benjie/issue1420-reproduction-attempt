drop schema if exists app_public CASCADE;
drop role IF EXISTS issue1420_role;

create role issue1420_role;
create schema if not exists app_public;
CREATE EXTENSION IF NOT EXISTS citext /* Don't do this: */ WITH SCHEMA app_public;
GRANT usage ON SCHEMA app_public TO issue1420_role;
ALTER DEFAULT privileges REVOKE EXECUTE ON functions FROM public;
REVOKE ALL ON DATABASE issue1420 FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM PUBLIC;

create table if not exists app_public.foo (
 id serial primary key,
 title text not null
);

GRANT SELECT ON TABLE app_public.foo TO issue1420_role;

insert into app_public.foo (title) values ('one'), ('two'), ('three');
create or replace function app_public.foo_test_ha (o app_public.foo) RETURNS text AS $$
  SELECT 'text'
$$ LANGUAGE sql STABLE;
