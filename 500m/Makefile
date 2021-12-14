#! /usr/bin/make -f

service:=pixels
PG:=psql service=${service}

info::
	echo "Make helpers"

build: tangle
	docker build --tag=local-dev/dwr-grid-500m-db docker/db

tangle:
	make --directory=docker/db/initdb.d tangle

pgsql:
	dc exec db pgsql2shp -u scb -f /io/missing_500m.shp pixels missing500m

geojson:
	${PG} -A -t --pset=footer=off -c 'select geojson from missing500m_geojson' >../geojson/missing500m.geojson
