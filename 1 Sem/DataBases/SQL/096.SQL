SELECT v_name FROM 
(SELECT utV.v_name, utV.v_id,
COUNT(CASE WHEN v_color = 'R' THEN 1 END) OVER(PARTITION BY v_id) cnt_r,
COUNT(CASE when v_color = 'B' then 1 END) OVER(PARTITION BY  b_q_id) cnt_b
FROM utV JOIN utB ON utV.v_id = utB.b_v_id) AS T
WHERE cnt_r > 1 AND cnt_b > 0 GROUP BY v_name