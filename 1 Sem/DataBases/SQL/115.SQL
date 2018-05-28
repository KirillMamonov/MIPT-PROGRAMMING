SELECT DISTINCT Up=U.b_vol, Down=D.b_vol, Side=S.b_vol,
Rad=CAST(POWER((POWER(S.b_vol, 2) - POWER((1.0*D.b_vol-1.*U.b_vol)/2, 2)), 1.0/2.0)/2 AS DEC(4,2))
FROM utB U, utB D, utB S
WHERE U.b_vol < D.b_vol and 1.0*U.b_vol + 1.0*D.b_vol = 2.0*S.b_vol
