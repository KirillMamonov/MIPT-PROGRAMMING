SELECT DISTINCT product.model, price FROM product  JOIN PC ON product.model=PC.model WHERE maker='B' 
UNION 
SELECT DISTINCT product.model, price FROM product  JOIN laptop ON product.model=laptop.model WHERE maker='B' 
UNION
SELECT DISTINCT product.model, price FROM product  JOIN printer ON product.model=printer.model WHERE maker='B'