WITH sel AS(SELECT Ships.name, Classes.numGuns, Classes.displacement
FROM Ships INNER JOIN Classes ON Classes.class = Ships.class
UNION
SELECT Outcomes.ship, Classes.numGuns, Classes.displacement
FROM Outcomes INNER JOIN Classes ON Classes.class = Outcomes.ship)

SELECT T.name
FROM sel AS T
WHERE T.numGuns >= ALL (SELECT sel.numGuns FROM sel WHERE sel.displacement = T.displacement)
