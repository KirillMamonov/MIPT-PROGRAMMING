SELECT (SELECT name FROM Passenger WHERE ID_psg = T.ID_psg) FROM 
(SELECT DISTINCT ID_psg
FROM Pass_in_trip INNER JOIN Trip ON Pass_in_trip.trip_no = Trip.trip_no
WHERE DATENAME(weekday, date) = 'Saturday' AND Trip.time_out > Trip.time_in) AS T
