SELECT DISTINCT name FROM ships WHERE name LIKE '% % %'
UNION
SELECT DISTINCT ship FROM outcomes WHERE ship LIKE '% % %'
