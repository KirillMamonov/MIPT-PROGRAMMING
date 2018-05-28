SELECT speed, AVG(price)
FROM pc
GROUP BY speed
HAVING speed>600
