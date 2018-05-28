SELECT val, value
FROM (SELECT CAST(model AS CHAR(9)) AS model,
CAST(speed AS CHAR(9)) AS speed,
CAST(ram AS CHAR(9)) AS ram,
CAST(hd AS CHAR(9)) AS hd,
CAST(cd AS CHAR(9)) AS cd,
CAST(price AS CHAR(9)) AS price
FROM PC WHERE code = (SELECT MAX(code) FROM PC)) AS N
UNPIVOT
(value FOR val IN (model, speed, ram, hd, cd, price)) AS unpvt
