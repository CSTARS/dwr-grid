#! /usr/bin/make -f

# SET the connection string to access your database
db:=quinn
PG:=psql -d ${db}

data: clean
	${PG} -f dwr_grid.sql
	${PG} -a -t --pset=footer=off -c 'select geojson from dwr_grid.calsimetaw_geojson' >geojson/calsimetaw.geojson
	${PG} -a -t --pset=footer=off -c 'select geojson from dwr_grid.cimis_geojson' >geojson/cimis.geojson
	pgsql2shp -f shp/calsimetaw -g boundary ${db} dwr_grid.calsimetaw
	pgsql2shp -f shp/cimis -g boundary ${db} dwr_grid.cimis 

clean:
	rm -f geojson/* shp/*
