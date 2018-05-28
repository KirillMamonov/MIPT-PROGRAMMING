WITH New AS 
(SELECT *, CASE WHEN color = 'n' THEN 1 ELSE 0 END + 
(SELECT COUNT(color) FROM Printer WHERE code < P.code AND color = 'n') AS Col
FROM Printer AS P)

SELECT code, model, color, type, price,
(SELECT MAX(model) FROM New WHERE Col = N.Col) max_model,
(SELECT COUNT(DISTINCT type) FROM New WHERE Col = N.Col) distct_types,
(SELECT AVG(price) FROM New WHERE Col = N.Col) avg_price
FROM New N