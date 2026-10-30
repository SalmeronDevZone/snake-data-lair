-- EJERCICIO 24 · Stock al cierre de cada día                                  🟡 Medio
-- A partir de las entradas (+) y salidas (-) de movimientos_stock, el stock de cada producto al
-- final de cada día en que tuvo movimientos (varios movimientos el mismo día se suman), y una
-- alerta 'stock negativo' cuando baje de 0 (NULL si no).
-- Columnas: id_producto, fecha, stock, alerta. Ordena por id_producto y fecha.
-- Pista: primero el neto por producto y día, después SUM(...) OVER (PARTITION BY id_producto ORDER BY fecha).

WITH neto AS (
    SELECT id_producto, fecha, SUM(cantidad) AS neto
    FROM movimientos_stock
    GROUP BY id_producto, fecha
),
stock AS (
    SELECT id_producto, fecha,
           SUM(neto) OVER (PARTITION BY id_producto ORDER BY fecha) AS stock
    FROM neto
)
SELECT id_producto, fecha, stock,
       CASE WHEN stock < 0 THEN 'stock negativo' END AS alerta
FROM stock
ORDER BY id_producto, fecha;
