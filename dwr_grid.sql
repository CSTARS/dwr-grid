-- This SQL file is used to generate the geojson and shapefiles
-- for dwr_grid project.  It uses as input, the calsimetaw.csv file
-- which delinates the pixels used for that project. Also, the cimis.csv
-- file for the list of cimis pixels used.
drop schema dwr_grid cascade;
create schema dwr_grid;
set search_path=dwr_grid,public;

create table dwr_grid as 
with en as (
select
(row||'_'||col)::varchar(7) as dwr_id,
col,row,
col*4000-402000 as east,
456000-row*4000 as north
from generate_series(1,236) as col,
generate_series(1,265) as row)
select dwr_id,col,row,
east,north,
st_setsrid(st_makepoint(east,north),3310)::geometry('Point',3310) as centroid,
st_setsrid(
  st_makebox2d(
   st_makepoint(east-2000,north-2000),
   st_makepoint(east+2000,north+2000)),3310)::geometry('Polygon',3310) as boundary
from en;

alter table dwr_grid add primary key(dwr_id);

create table calsimetaw_inp (
dwr_id varchar(7),
prism boolean,
cimis boolean
);
\copy calsimetaw_inp from calsimetaw.csv with csv header

create table calsimetaw as
select dwr_id,
col,row,
east,north,
cimis,prism,
boundary
from dwr_grid i
join calsimetaw_inp using (dwr_id);

create view calsimetaw_geojson as 
with p as (
 select
  'Feature' as type,
  row_to_json((select l from (select dwr_id,col,row,east,north,cimis,prism) as l),true) as properties,
  st_asgeojson(st_transform(boundary,4269))::json as geometry
 from calsimetaw
  ),
 f as (
  select row_to_json(p,true) as feature
  from p
 ),
 c as (
  select 'Feature Col lection' as type,
  array_to_json(array_agg(feature),true) as features
  from f
)
select row_to_json(c,true) as geojson
from c;

create table cimis_grid as
with en as (
select east,north
from
generate_series(-410000+1000,610000-1000,2000) as east,
generate_series(-660000+1000,460000-1000,2000) as north
)
select
east,north,
st_setsrid(st_makepoint(east,north),3310)::geometry('Point',3310) as centroid,
st_setsrid(
  st_makebox2d(
   st_makepoint(east-2000,north-2000),
   st_makepoint(east+2000,north+2000)),3310)::geometry('Polygon',3310) as boundary
from en;

create table state (
east integer,
north integer
);
\copy state from cimis.csv with csv

create table cimis as
select east,north,boundary
from cimis_grid
join state using (east,north);

create view cimis_geojson as 
with p as (
 select
  'Feature' as type,
  row_to_json((select l from (select east,north) as l),true) as properties,
  st_asgeojson(st_transform(boundary,4269))::json as geometry
 from cimis
 ),
 f as (
  select row_to_json(p,true) as feature
  from p
 ),
 c as (
  select 'Feature Collection' as type,
  array_to_json(array_agg(feature),true) as features
  from f
)
select row_to_json(c,true) as geojson
from c;
