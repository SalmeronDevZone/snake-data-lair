-- EJERCICIO 20 · Un calendario sin huecos                                     🟡 Medio
-- Importe de los pedidos ENTREGADOS de cada día del 1 al 10 de enero de 2025, incluidos los días
-- sin ventas (con importe 0), y el nombre del día de la semana en español.
-- Columnas: fecha, dia_semana, importe. Ordena por fecha.
-- Pista: genera los días con WITH RECURSIVE y date(fecha, '+1 day'), y haz un LEFT JOIN con las
-- ventas. strftime('%w', fecha) da 0 = domingo ... 6 = sábado.

WITH RECURSIVE calendario AS (
    SELECT '2025-01-01' AS fecha
    UNION ALL
    SELECT date(fecha, '+1 day') FROM calendario WHERE fecha < '2025-01-10'
),
ventas AS (
    SELECT p.fecha, SUM(l.cantidad * l.precio_unitario) AS importe
    FROM pedidos p
    JOIN lineas_pedido l ON l.id_pedido = p.id_pedido
    WHERE p.estado = 'entregado'
    GROUP BY p.fecha
)
SELECT c.fecha,
       CASE strftime('%w', c.fecha)
           WHEN '0' THEN 'domingo' WHEN '1' THEN 'lunes' WHEN '2' THEN 'martes'
           WHEN '3' THEN 'miércoles' WHEN '4' THEN 'jueves' WHEN '5' THEN 'viernes'
           ELSE 'sábado'
       END AS dia_semana,
       COALESCE(v.importe, 0) AS importe
FROM calendario c
LEFT JOIN ventas v ON v.fecha = c.fecha
ORDER BY c.fecha;
