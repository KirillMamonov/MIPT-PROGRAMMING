SELECT Passenger.name, A.minutes 
FROM (SELECT P.ID_psg, 
      SUM((DATEDIFF(minute, time_out, time_in) + 1440)%1440) AS minutes, 
      MAX(SUM((DATEDIFF(minute, time_out, time_in) + 1440)%1440)) OVER() AS MaxMinutes 
      FROM Pass_in_trip P JOIN 
       Trip AS T ON P.trip_no = T.trip_no 
      GROUP BY P.ID_psg ) AS A JOIN 
Passenger ON Passenger.ID_psg = A.ID_psg 
WHERE A.minutes = A.MaxMinutes
