SELECT name FROM ships WHERE class = name 
UNION 
SELECT ship AS name FROM classes, outcomes WHERE classes.class = outcomes.ship
