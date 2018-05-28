SELECT classes.class 
FROM classes LEFT JOIN 
           (SELECT class, name FROM ships 
            UNION 
            SELECT ship, ship FROM outcomes)
AS s ON s.class = classes.class 
GROUP BY classes.class 
HAVING COUNT(s.name) = 1
