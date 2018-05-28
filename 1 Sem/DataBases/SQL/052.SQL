SELECT Ships.name
FROM Ships 
INNER JOIN Classes ON Ships.class = Classes.class
WHERE ISNULL(Classes.country, 'JAPAN') = 'JAPAN'
AND ISNULL(Classes.bore, 18) < 19 
AND ISNULL(Classes.type, 'bb') = 'bb' 
AND ISNULL(Classes.displacement, 65000) <= 65000
AND ISNULL(Classes.numGuns, 9) >= 9
