SELECT COUNT(*) FROM 
(SELECT COUNT(trip_no) AS trip_no, town_from, town_to
FROM Trip GROUP BY town_from, town_to HAVING COUNT(trip_no) >= ALL 
(SELECT COUNT(trip_no) FROM Trip GROUP BY town_from, town_to)
) AS T
