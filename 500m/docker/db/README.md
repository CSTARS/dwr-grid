# Initialization

This Docker file basically initializes the postgres database with adding the
postgis extenstion. Then we initialize of the postgres database in the
Dockerfile.

Below is an example of a docker-compose file that includes a docker volume for
the database.  ~/var/lib/postgresql/data~ is where the raw data is downloaded as
well.

``` yml
# This is an example docker-compose for this image
version: '2'

volumes:
  db:

services:
  postgres:
    build: ./postgres
    volumes:
      - db:/var/lib/postgresql/data
    ports:
      - 5432:5432
```

You can tail the docker-compose logs to verify that the postgres database is
still chugging along.  This is only done on the initialization of the database.
Afterwards the docker service can be started and stopped quickly.

## Included data

We include one ~goes~ schema.  This adds some functions designed to convert GOES
data frames into standard projections and what not.  We keep this as a goes
schema, so it could be more easily added to alternative databases.
