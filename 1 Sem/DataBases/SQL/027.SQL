SELECT product.maker, AVG(pc.hd) FROM pc, product 
WHERE product.model = pc.model AND product.maker IN 
(SELECT DISTINCT maker FROM product WHERE product.type = 'printer') 
GROUP BY maker
