-- EJERCICIO 19 · Media móvil                                                  🟡 Medio
-- Para cada día con pedidos ENTREGADOS: su importe y la media de ese día y los dos días con
-- ventas anteriores (media móvil de 3 filas, 2 decimales). Los primeros días promedian los que haya.
-- Columnas: fecha, importe_dia, media_movil_3. Ordena por fecha.
-- Pista: AVG(...) OVER (ORDER BY fecha ROWS BETWEEN 2 PRECEDING AND CURRENT ROW).
-- Ojo: son 3 días CON VENTAS, no 3 días de calendario (para eso mira el ejercicio 20).

WITH por_dia AS (
    SELECT p.fecha, SUM(l.cantidad * l.precio_unitario) AS importe_dia
    FROM pedidos p
    JOIN lineas_pedido l ON l.id_pedido = p.id_pedido
    WHERE p.estado = 'entregado'
    GROUP BY p.fecha
)
SELECT fecha,
       importe_dia,
       ROUND(AVG(importe_dia) OVER (ORDER BY fecha ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS media_movil_3
FROM por_dia
ORDER BY fecha;
