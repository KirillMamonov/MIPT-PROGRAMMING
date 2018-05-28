SELECT name, trip_no, date FROM
(SELECT ROW_NUMBER() OVER(ORDER BY date+time_out,ID_psg) N,name,Trip.trip_no,date
FROM Company, Pass_in_trip, Trip
WHERE Company.ID_comp=Trip.ID_comp AND Trip.trip_no=Pass_in_trip.trip_no
AND town_from='Rostov' AND year(date)=2003 AND month(date)=4) T
WHERE N = 5
