SELECT point, date, SUM(out) AS Outcome, SUM(inc) AS Income FROM
(SELECT point, date, inc, NULL AS out FROM Income
UNION ALL
SELECT point, date, NULL AS inc, out FROM Outcome) AS t1
GROUP BY point, date
