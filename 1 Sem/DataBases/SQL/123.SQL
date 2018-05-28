SELECT maker,SUM(CASE WHEN num_goods > 1 THEN num_goods ELSE 0 END),
SUM(CASE WHEN num_prices > 1 THEN 1 ELSE 0 END) FROM
 (SELECT maker, COUNT(good) num_goods, COUNT(price) num_prices FROM
  (SELECT P.maker, 
   CASE WHEN R.price IS NULL THEN NULL ELSE P.model + P.type END, R.price
   FROM Product P LEFT JOIN
    (SELECT model, price FROM PC UNION ALL
     SELECT model, price FROM Printer UNION ALL
     SELECT model, price FROM Laptop) R on P.model = R.model
  ) T(maker, good, price)
  GROUP BY maker, price) S
GROUP BY maker
