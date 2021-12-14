create table cimis_pixels (
east integer,
north integer,
state integer
);
copy cimis_pixels from '/docker-entrypoint-initdb.d/cimis_500m_state.txt' with csv delimiter ' ';

-- CIMIS pixels retrieved from website.
create table pixel_boundary as
select
east,north,
st_setsrid(st_makepoint(east,north),3310) as centroid,
st_setsrid(st_makebox2d(
 st_makepoint(east-250,north-250),
 st_makepoint(east+250,north+250)),3310) as boundary
from cimis_pixels;
create index p500_centroid_idx on pixel_boundary using GIST(centroid);
create index p500_boundary_idx on pixel_boundary using GIST(boundary);

create view cimis_geojson as
with p as (
 select
  'Feature' as type,
  row_to_json((select l from (select east,north) as l),true) as properties,
  st_asgeojson(st_transform(boundary,4269))::json as geometry
 from pixel_boundary
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

create table missing_4km (
       dwr_id varchar(7)
);
copy missing_4km from '/docker-entrypoint-initdb.d/missing_4km.csv' with csv;
