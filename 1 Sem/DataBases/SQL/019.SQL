SELECT product.maker, AVG(screen) 
FROM laptop LEFT JOIN product ON product.model= laptop.model 
GROUP BY product.maker
