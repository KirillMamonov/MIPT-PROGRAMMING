SELECT TOP 1 WITH TIES country, x, n FROM classes
CROSS APPLY (VALUES (numguns*5000,'numguns'), (bore*3000,'bore'),(displacement,'displacement')) V(x,n)
GROUP BY country, x, n
ORDER BY RANK() OVER(PARTITION BY country ORDER BY x DESC)