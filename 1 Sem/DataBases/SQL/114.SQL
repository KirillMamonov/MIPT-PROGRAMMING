WITH T AS (SELECT ID_psg, COUNT(*) N FROM Pass_In_Trip GROUP BY ID_psg, place)

SELECT name, N FROM
(SELECT DISTINCT ID_psg, N FROM T WHERE N =(SELECT MAX(N) FROM T)) X 
JOIN Passenger ON X.ID_psg = Passenger.ID_psg
