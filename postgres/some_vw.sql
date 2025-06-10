CREATE VIEW some_vw AS 
SELECT 
    status,
    count(*) AS count
FROM some_tb
GROUP BY status;