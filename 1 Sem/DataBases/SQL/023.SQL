SELECT DISTINCT maker 
FROM product JOIN pc ON product.model=pc.model 
WHERE speed>=750 AND maker IN 
(SELECT maker 
FROM product JOIN laptop ON product.model=laptop.model 
WHERE speed>=750)
