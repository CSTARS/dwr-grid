create table cimis_pixels (
east integer,
north integer,
state integer
);
\copy cimis_pixels from cimis_500m_state.txt with csv delimiter ' ';

-- CIMIS pixels retrieved from website.
create table pixel_boundary as
select
east,north,
st_setsrid(st_makebox2d(
 st_makepoint(east-250,north-250),
 st_makepoint(east+250,north+250)),3310) as boundary
from cimis_pixels;
