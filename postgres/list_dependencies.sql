SELECT DISTINCT 
      dependent_ns.nspname as dependent_schema
    , dependent_view.relname as dependent_view 
    , source_ns.nspname as source_schema
    , source_table.relname as source_table
  FROM pg_depend 
  JOIN pg_rewrite 
    ON pg_depend.objid = pg_rewrite.oid 
  JOIN pg_class AS dependent_view 
    ON pg_rewrite.ev_class = dependent_view.oid 
  JOIN pg_class AS source_table 
    ON pg_depend.refobjid = source_table.oid 
  JOIN pg_namespace dependent_ns 
    ON dependent_ns.oid = dependent_view.relnamespace
  JOIN pg_namespace source_ns 
    ON source_ns.oid = source_table.relnamespace
 WHERE source_ns.nspname = 'public'
   AND source_table.relname = 'my_table'
 ORDER BY 1,2;

 ---------
 -- since v12
SELECT *
  FROM information_schema.view_table_usage
 WHERE table_schema = 'public'
   AND table_name = 'my_table';