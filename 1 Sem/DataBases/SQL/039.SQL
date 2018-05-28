SELECT DISTINCT O.ship
FROM Outcomes AS O INNER JOIN Battles AS B ON (B.name = O.battle)
WHERE (O.result = 'damaged') AND EXISTS 
(SELECT Outcomes.ship FROM Outcomes 
INNER JOIN Battles ON (Battles.name = Outcomes.battle)
WHERE (O.ship = Outcomes.ship) AND (Battles.date > B.date) )
