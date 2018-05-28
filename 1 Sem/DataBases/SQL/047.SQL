SELECT x ,maker ,model FROM 
(SELECT ROW_NUMBER() OVER(ORDER BY y ,model) AS x ,y ,maker ,model FROM 
(SELECT * FROM 
(SELECT ROW_NUMBER() OVER(ORDER BY c1 DESC,maker) AS y ,maker AS maker1,c1 FROM 
(SELECT maker,COUNT(model) c1 FROM Product GROUP BY maker)t )q 
JOIN Product 
ON maker1=Product.maker)o)p
