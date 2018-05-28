SELECT sum(s.price)/sum(s.kol) FROM 
(SELECT price,1 as kol FROM pc,product WHERE pc.model=product.model AND product.maker = 'A' 
UNION ALL 
SELECT price,1 as kol FROM laptop,product WHERE laptop.model=product.model AND product.maker='A') as s
