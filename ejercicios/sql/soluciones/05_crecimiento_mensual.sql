-- EJERCICIO 05 · Crecimiento mes a mes                                        🟡 Medio
-- Importe de los pedidos ENTREGADOS por mes y variación porcentual respecto al mes anterior
-- (redondeada a 1 decimal; NULL en el primer mes).
-- Columnas: mes ('YYYY-MM'), importe, variacion_pct. Ordena por mes.
-- Pista: strftime('%Y-%m', fecha) y LAG().

WITH por_mes AS (
    SELECT strftime('%Y-%m', p.fecha) AS mes,
           SUM(l.cantidad * l.precio_unitario) AS importe
    FROM pedidos p
    JOIN lineas_pedido l ON l.id_pedido = p.id_pedido
    WHERE p.estado = 'entregado'
    GROUP BY mes
)
SELECT mes,
       importe,
       ROUND(100.0 * (importe - LAG(importe) OVER (ORDER BY mes)) / LAG(importe) OVER (ORDER BY mes), 1) AS variacion_pct
FROM por_mes
ORDER BY mes;
