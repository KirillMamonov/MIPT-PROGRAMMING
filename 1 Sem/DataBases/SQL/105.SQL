SELECT maker, model, ROW_NUMBER() OVER (ORDER BY maker, model),
DENSE_RANK() OVER (ORDER BY maker), RANK() OVER (ORDER BY maker),
COUNT(*) OVER (ORDER BY maker)
FROM product
