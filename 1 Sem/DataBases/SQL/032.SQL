SELECT country, CAST(AVG((POWER(bore,3)/2)) AS NUMERIC(7,2)) AS weight
FROM (SELECT country, classes.class, bore, name FROM classes LEFT JOIN ships ON 
      classes.class=ships.class  
      UNION ALL
      SELECT DISTINCT country, class, bore, ship FROM classes t1 LEFT JOIN 
      outcomes t2 ON t1.class=t2.ship 
      WHERE ship=class AND ship NOT IN (SELECT name FROM ships)) a
WHERE name!='null' GROUP BY country
