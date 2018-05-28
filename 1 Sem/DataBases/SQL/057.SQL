SELECT class,COUNT(name) FROM 
(SELECT name,class FROM Ships UNION SELECT ship,ship FROM Outcomes )Ships2 
WHERE name IN (SELECT ship FROM Outcomes WHERE result='sunk') AND class IN 
(SELECT CS FROM 
  (SELECT Classes.class AS CS,COUNT(name) AS TR FROM 
    (SELECT name,class FROM Ships UNION SELECT ship,ship FROM Outcomes)Ships2 
     JOIN Classes ON Ships2.class=Classes.class 
   GROUP BY Classes.class )RES WHERE TR>=3) 
GROUP BY class
