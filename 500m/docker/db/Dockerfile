FROM postgres:14-bullseye
MAINTAINER Quinn Hart <qjhart@ucdavis.edu>

RUN apt-get update \
	&& apt-get install -y build-essential git-core \
	postgresql-server-dev-$PG_MAJOR \
	postgresql-$PG_MAJOR-postgis-3 postgresql-$PG_MAJOR-postgis-3-scripts postgis \
  curl wget less \
  && rm -rf /var/lib/apt/lists/*

# PLV8 needs to be made be hand https://plv8.github.io/#building-for-macos-linux
# wget https://github.com/plv8/plv8/archive/v3.0.0.tar.gz
#tar -xvzf v3.0.0.tar.gz
# cd plv8-3.0.0
# make

# Put at end to stop remaking everytime :)
COPY initdb.d/ /docker-entrypoint-initdb.d/
