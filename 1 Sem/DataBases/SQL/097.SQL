SELECT code, speed, ram, price, screen
FROM laptop WHERE EXISTS 
 (SELECT 1 X FROM 
   (SELECT v, RANK() OVER(ORDER BY v) rn FROM 
     (SELECT CAST(speed AS float) sp, CAST(ram AS float) rm,
      CAST(price AS float) pr, CAST(screen AS float) sc) l 
    UNPIVOT(v FOR c IN (sp, rm, pr, sc)) u) l 
  PIVOT (MAX(v) FOR rn IN ([1],[2],[3],[4])) p
  WHERE [1]*2 <= [2] AND [2]*2 <= [3] AND [3]*2 <= [4])
