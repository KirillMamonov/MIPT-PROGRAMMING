SELECT MIN(t.trip_no), MIN(tt.trip_no), MIN(ttt.trip_no), MAX(t.trip_no), MAX(tt.trip_no), MAX(ttt.trip_no)
FROM trip t, trip tt, trip ttt
WHERE tt.trip_no > t.trip_no AND ttt.trip_no > tt.trip_no