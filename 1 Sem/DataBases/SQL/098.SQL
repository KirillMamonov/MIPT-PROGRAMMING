WITH CTE AS (SELECT Code, Speed, Ram, Speed as speed1, Ram as ram1, 0 AS count FROM PC
UNION ALL
SELECT Code, Speed, Ram, CAST(speed1 / 2 AS smallint), CAST(ram1 / 2 AS smallint), 
CASE WHEN speed1 % 2 = 1 or ram1 % 2 = 1 THEN count+1 ELSE 0 END FROM CTE
WHERE speed1 > 0 or ram1 > 0)
 
SELECT DISTINCT Code, Speed, Ram FROM CTE WHERE count = 4
