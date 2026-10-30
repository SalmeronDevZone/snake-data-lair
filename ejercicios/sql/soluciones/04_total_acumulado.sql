-- EJERCICIO 04 · Ventas diarias y total acumulado                            🟡 Medio
-- Para cada día con pedidos ENTREGADOS: el importe de ese día y el importe acumulado
-- desde el primer día.
-- Columnas: fecha, importe_dia, importe_acumulado. Ordena por fecha.
-- Pista: agrega por día en una CTE y luego SUM(...) OVER (ORDER BY fecha).

WITH por_dia AS (
    SELECT p.fecha, SUM(l.cantidad * l.precio_unitario) AS importe_dia
    FROM pedidos p
    JOIN lineas_pedido l ON l.id_pedido = p.id_pedido
    WHERE p.estado = 'entregado'
    GROUP BY p.fecha
)
SELECT fecha,
       importe_dia,
       SUM(importe_dia) OVER (ORDER BY fecha) AS importe_acumulado
FROM por_dia
ORDER BY fecha;
