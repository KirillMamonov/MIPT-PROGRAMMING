SELECT COALESCE(Company.name, 'TOTAL'), formula1, formula2, formula3, formula4 FROM 
(SELECT Id_comp ,
 CONVERT(numeric(18,2), AVG(trmin)) formula1,
 CONVERT(numeric(18,2), EXP(AVG(LOG(trmin)))) formula2,
 CONVERT(numeric(18,2), SQRT(AVG(trmin*trmin))) formula3,
 CONVERT(numeric(18,2), COUNT(*)/SUM(1/trmin)) formula4
 FROM (SELECT ID_comp, CONVERT(numeric(18,2), 
       CASE WHEN time_in >= time_out THEN datediff(minute, time_out, time_in)
       ELSE DATEDIFF(minute, time_out, DATEADD(day, 1, time_in))
       END) trmin
       FROM (SELECT trip_no FROM Pass_in_trip GROUP BY trip_no, [date]) X 
       JOIN Trip ON X.trip_no = Trip.trip_no) T
 GROUP BY ID_comp WITH CUBE) Y
LEFT JOIN Company ON Y.ID_comp = Company.ID_comp
