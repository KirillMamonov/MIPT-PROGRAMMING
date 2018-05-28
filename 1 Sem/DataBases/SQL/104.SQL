SELECT DISTINCT class,'bc-'+CAST(X AS char(2)) FROM
(SELECT x.class, x.numGuns, 
 ROW_NUMBER() OVER(PARTITION BY x.class ORDER BY x.numguns) X
 FROM Classes x,Classes y
 WHERE x.type='bc') AS T
WHERE numguns >= X