SELECT maker, MAX(type) FROM product 
GROUP BY maker HAVING COUNT(model) > 1 and COUNT(DISTINCT type) = 1
