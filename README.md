# DBT Mutli-cloud w/trino

## Overview

Example utilising dbt and trino to transform data across different cloud providers/warehouses.


### Spin up infra

Below to spin up:
 - trino
 - minio to serve delta lake table
 - sql-server
 - postgres (in place of redshift)
 - hive metastore to serve delta lake table metadata
 - minio init - setup bucket and delta table

```bash
docker-compose -f docker/docker-compose.yaml
```

### Run dbt

Execution of below will run the models on some mock datasets. In essence, pulling in sales info from sql-server, web page activity tracking data from delta lake, and then aggregating to postgres.

Said script bakes in some calls to trino to initialise delta schema and table locations.

```bash
cd multi_cloud
./dbt_run.sh
```