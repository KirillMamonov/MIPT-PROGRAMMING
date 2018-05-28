SELECT DISTINCT b.B_VOL, bb.B_VOL, bbb.B_VOL FROM utB b, utB bb, utB bbb
WHERE b.B_VOL < bb.B_VOL AND bb.B_VOL < bbb.B_VOL
AND NOT (bbb.B_VOL > SQRT(SQUARE(b.B_VOL) + SQUARE(bb.B_VOL)))