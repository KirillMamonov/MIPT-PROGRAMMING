SELECT outcomes.ship, displacement, numGuns FROM 
(SELECT name AS ship, displacement, numGuns FROM Ships JOIN Classes ON Classes.class=Ships.class 
UNION 
SELECT class AS ship, displacement, numGuns FROM Classes) AS T 
RIGHT JOIN Outcomes ON Outcomes.ship=T.ship 
WHERE battle = 'Guadalcanal'
