-- EJERCICIO 18 · Media frente a mediana                                       🟡 Medio
-- Importe medio y mediano de los pedidos ENTREGADOS (importe de un pedido = suma de sus líneas;
-- los pedidos entregados sin líneas no cuentan). Ambos con 2 decimales.
-- Columnas: pedidos, media, mediana.
-- Pista: SQLite no tiene MEDIAN. Numera los importes ordenados con ROW_NUMBER(), cuenta cuántos
-- hay, y promedia el valor central (o los dos centrales si el número es par).

WITH importes AS (
    SELECT p.id_pedido, SUM(l.cantidad * l.precio_unitario) AS importe
    FROM pedidos p
    JOIN lineas_pedido l ON l.id_pedido = p.id_pedido
    WHERE p.estado = 'entregado'
    GROUP BY p.id_pedido
),
ordenados AS (
    SELECT importe,
           ROW_NUMBER() OVER (ORDER BY importe) AS n,
           COUNT(*) OVER () AS total
    FROM importes
)
SELECT MAX(total) AS pedidos,
       (SELECT ROUND(AVG(importe), 2) FROM importes) AS media,
       ROUND(AVG(importe), 2) AS mediana
FROM ordenados
WHERE n IN ((total + 1) / 2, (total + 2) / 2);
