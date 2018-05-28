SELECT country FROM classes 
GROUP BY country 
HAVING COUNT(DISTINCT type) = 2
