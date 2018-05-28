SELECT (SELECT name FROM Company WHERE ID_comp = T.ID_comp), SUM(time) FROM 
(SELECT SUM( CASE WHEN time_in > time_out THEN ABS(DATEDIFF(mi, time_in, time_out)) 
 ELSE 24*60 - ABS(DATEDIFF(mi, time_in, time_out)) END) AS time, ID_comp, date
 FROM 
  (SELECT MAX(Trip.time_in) time_in, MAX(Trip.time_out) time_out, Trip.ID_comp, date
   FROM Pass_in_trip INNER JOIN Trip ON Trip.trip_no = Pass_in_trip.trip_no
   GROUP BY Pass_in_trip.date, Trip.ID_comp, Trip.trip_no) AS X
 GROUP BY date, ID_comp) AS T
GROUP BY ID_comp
