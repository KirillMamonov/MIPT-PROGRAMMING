SELECT DISTINCT product.type,product.model,laptop.speed 
FROM laptop JOIN product ON laptop.model=product.model 
WHERE laptop.speed<(SELECT MIN(speed) FROM pc)
