SELECT SUM(T) FROM
(SELECT point, sum(inc) as T FROM income_o GROUP BY point
UNION
SELECT point, -SUM(out) as T FROM outcome_o GROUP BY point) as T
