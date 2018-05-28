SELECT COUNT(maker) FROM product WHERE maker IN
(SELECT maker FROM product GROUP BY maker HAVING COUNT(model) = 1)
