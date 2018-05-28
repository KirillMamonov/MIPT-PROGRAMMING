SELECT name, CONVERT(char(10),date,120), CONVERT(char(10), MIN(DATEADD(dd,1,dt)), 120)
FROM
(SELECT name, date, DATEADD(yy,p,DATEADD(dd,n,DATEADD(mm,3,DATEADD(yy,DATEDIFF(yy,0,date),0)))) dt
 FROM Battles ,(VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8)) T(p) ,(VALUES (0),(1),(2),(3),(4),(5),(6)) X(n)) X
 WHERE date<=dt AND (Year(dt)%4=0 AND Year(dt)%100> 0 OR Year(dt)%400=0) AND DATEPART(dw,dt)=DATEPART(dw,'20180521')
GROUP BY name, date
