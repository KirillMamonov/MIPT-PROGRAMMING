SELECT maker, COUNT(model) FROM product WHERE type = 'pc' 
GROUP BY product.maker HAVING COUNT (DISTINCT model) >= 3
