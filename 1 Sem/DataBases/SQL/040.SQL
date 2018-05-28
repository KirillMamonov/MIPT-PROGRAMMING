SELECT ships.class, ships.name, classes.country 
FROM ships LEFT JOIN classes ON ships.class = classes.class 
WHERE classes.numGuns >= 10
