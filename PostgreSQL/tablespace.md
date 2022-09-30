# Create tablespace

## Create dir
```shell
mkdir -p /data/tablespace
chown -R postgres:postgres /data/tablespace
```

## Create tablespace
```sql
CREATE TABLESPACE etl LOCATION '/data/tablespace';

ALTER TABLE etl.account SET TABLESPACE etl;

ALTER DATABASE my-db SET default_tablespace = etl;
```
