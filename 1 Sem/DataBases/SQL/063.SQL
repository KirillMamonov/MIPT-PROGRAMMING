SELECT Passenger.name FROM Passenger WHERE Passenger.ID_psg IN (
SELECT PIT.ID_psg FROM Pass_in_trip AS PIT GROUP BY PIT.ID_psg
HAVING COUNT(DISTINCT PIT.place) < COUNT(PIT.place))
