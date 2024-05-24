# Postgres queries

## Fulltext Search
Query plan [visualiser online](https://explain.dalibo.com/)

Fulltext [documentation](https://www.postgresql.org/docs/current/textsearch-features.html#TEXTSEARCH-STATISTICS)


This example is workaround for not using real stopwords function.

Stopwords might remove all query words and you might miss relevant result.
Egzample stopword `one` and you are looking for text `one thing`. Your table has record with value `the one`. You dont get this result.

```SQL
EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON) -- performance analysis

-- Temporary table
DROP TABLE IF EXISTS _stopws;

CREATE TEMPORARY TABLE IF NOT EXISTS _stopws AS
SELECT v::tsquery v1 
FROM UNNEST('{one, two, three}'::text[]) v
;

SELECT t.*, 
ts_rank_cd(t.tsvectorcolumn, query) AS relevance -- result relevance
FROM my_table t,
-- manually remove some stopwords from the query
ts_rewrite(:query, 'SELECT v1, ''::tsquery v2 FROM _stopws') query,
-- tsvector column matches query 
WHERE t.tsvectorcolumn @@ query 
ORDER BY relevance DESC

-- Most common keywords
SELECT * 
FROM ts_stat('SELECT tsvectorcolumn FROM my_table')
ORDER BY ndoc DESC, word
LIMIT 80;
```