SELECT classes.class
FROM outcomes JOIN Ships ON (outcomes.ship = ships.name) 
INNER JOIN classes ON (ships.class = classes.class)
WHERE (outcomes.result = 'sunk') AND (classes.class IS NOT NULL)
UNION
SELECT classes.class
FROM outcomes JOIN classes ON (outcomes.ship = classes.class)
WHERE (outcomes.result = 'sunk') AND (classes.class IS NOT NULL)
