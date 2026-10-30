-- EJERCICIO 16 · Segmentación RFM                                             🟡 Medio
-- Para cada cliente con pedidos ENTREGADOS, a fecha de '2025-03-31':
--   recencia_dias = días desde su último pedido entregado
--   frecuencia    = número de pedidos entregados
--   monetario     = importe total
--   segmento      = 'fiel' si recencia <= 30 y frecuencia >= 2; 'reciente' si sólo recencia <= 30;
--                   'en riesgo' si sólo frecuencia >= 2; 'dormido' en otro caso.
-- Columnas: id_cliente, recencia_dias, frecuencia, monetario, segmento. Ordena por id_cliente.
-- Pista: CAST(julianday('2025-03-31') - julianday(MAX(fecha)) AS INTEGER) y un CASE.

WITH rfm AS (
    SELECT p.id_cliente,
           CAST(julianday('2025-03-31') - julianday(MAX(p.fecha)) AS INTEGER) AS recencia_dias,
           COUNT(DISTINCT p.id_pedido) AS frecuencia,
           SUM(l.cantidad * l.precio_unitario) AS monetario
    FROM pedidos p
    JOIN lineas_pedido l ON l.id_pedido = p.id_pedido
    WHERE p.estado = 'entregado'
    GROUP BY p.id_cliente
)
SELECT id_cliente, recencia_dias, frecuencia, monetario,
       CASE
           WHEN recencia_dias <= 30 AND frecuencia >= 2 THEN 'fiel'
           WHEN recencia_dias <= 30 THEN 'reciente'
           WHEN frecuencia >= 2 THEN 'en riesgo'
           ELSE 'dormido'
       END AS segmento
FROM rfm
ORDER BY id_cliente;
