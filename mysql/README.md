# Performance

## Query plan

Query plan [visualiser online](https://mysqlexplain.com/)

```SQL
EXPLAIN FORMAT=TRADITIONAL
SELECT id, name
FROM db.tb t
```

## Query statistics

```SQL
-- Turn on profiling
set profiling=1;

-- query
SELECT id, name
FROM db.tb t

-- review profiling data
show profiles;

-- Turn off profiling
set profiling=0;
```