SELECT classes.class, COUNT(T.ship) 
FROM classes LEFT JOIN 
(SELECT outcomes.ship, ships.class 
FROM outcomes LEFT JOIN ships ON ships.name = outcomes.ship 
WHERE outcomes.result = 'sunk') AS T 
ON T.class = classes.class OR T.ship = classes.class GROUP BY classes.class
