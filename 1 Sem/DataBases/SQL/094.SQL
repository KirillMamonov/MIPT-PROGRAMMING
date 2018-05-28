SELECT DATEADD(day, S.Num, D.date), 
(SELECT COUNT(DISTINCT Pass_in_trip.trip_no) FROM Pass_in_trip
 JOIN Trip ON Pass_in_trip.trip_no = Trip.trip_no AND Trip.town_from = 'Rostov'
 AND Pass_in_trip.date = DATEADD(day, S.Num, D.date))
FROM 
(SELECT (3 * ( x - 1 ) + y - 1) AS Num FROM 
 (SELECT 1 AS x UNION ALL SELECT 2  UNION ALL SELECT 3) AS N1
 CROSS JOIN (SELECT 1 AS y UNION ALL SELECT 2 UNION ALL SELECT 3) AS N2
 WHERE (3 * ( x - 1 ) + y ) < 8) AS S,
  (SELECT MIN(A.date) AS date FROM 
     (SELECT Pass_in_trip.date, COUNT(DISTINCT Pass_in_trip.trip_no) AS Qty, 
      MAX(COUNT(DISTINCT Pass_in_trip.trip_no)) OVER() AS M_Qty
      FROM Pass_in_trip JOIN Trip ON Pass_in_trip.trip_no = Trip.trip_no
      AND Trip.town_from = 'Rostov'GROUP BY Pass_in_trip.date) AS A
   WHERE A.Qty = A.M_Qty) AS D
