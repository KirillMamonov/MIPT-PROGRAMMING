SELECT DISTINCT maker FROM product WHERE maker NOT IN 
(SELECT maker FROM product WHERE type='PC' AND model NOT IN 
(SELECT model FROM PC))
