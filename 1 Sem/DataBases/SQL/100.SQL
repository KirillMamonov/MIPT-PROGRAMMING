SELECT DISTINCT T.date , T.N, X.point, X.inc, Y.point, Y.out FROM 
(SELECT DISTINCT date, ROW_NUMBER() OVER(PARTITION BY date ORDER BY code) N FROM Income
 UNION
 SELECT DISTINCT date, ROW_NUMBER() OVER(PARTITION BY date ORDER BY code) FROM Outcome) T
LEFT JOIN 
(SELECT date, point, inc, ROW_NUMBER() OVER(PARTITION BY date ORDER BY code) Ni FROM Income) X ON X.date=T.date AND X.Ni=T.N
LEFT JOIN
(SELECT date, point, out, ROW_NUMBER() OVER(PARTITION BY date ORDER BY code) No FROM Outcome) Y ON Y.date=T.date AND Y.No=T.N
