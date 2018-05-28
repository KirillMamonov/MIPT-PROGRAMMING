SELECT A.maker, B.type, CAST(CAST(
(SELECT COUNT(*) FROM Product WHERE maker = A.maker AND type = B.type)*100 AS NUMERIC(5,2)) 
/ 
(SELECT COUNT(*) FROM Product WHERE maker = A.maker) AS NUMERIC(5,2))
FROM (SELECT DISTINCT maker FROM Product) AS A, (SELECT DISTINCT type FROM Product) AS B
