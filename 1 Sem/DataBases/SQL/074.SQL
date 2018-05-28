WITH T AS (SELECT Country, Class FROM Classes WHERE Country = 'Russia')

SELECT * FROM T
UNION
SELECT Country, Class FROM Classes WHERE (SELECT COUNT(*) FROM T) = 0
