-- EJERCICIO 26 · Rellenar huecos con el último valor conocido                 🔴 Difícil
-- La tabla precios sólo tiene una fila cuando el precio cambia. Para los productos 1 y 5 y cada día
-- del 1 al 6 de marzo de 2025, ¿qué precio estaba vigente? (NULL si aún no se había publicado).
-- Columnas: id_producto, fecha, precio. Ordena por id_producto y fecha.
-- Pista: calendario con WITH RECURSIVE, combinado con los productos (CROSS JOIN), y para cada
-- día el precio con la fecha más reciente que no sea posterior. Es el "forward fill" / LOCF.

WITH RECURSIVE dias AS (
    SELECT '2025-03-01' AS fecha
    UNION ALL
    SELECT date(fecha, '+1 day') FROM dias WHERE fecha < '2025-03-06'
),
productos_con_precio AS (
    SELECT DISTINCT id_producto FROM precios WHERE id_producto IN (1, 5)
)
SELECT p.id_producto,
       d.fecha,
       (SELECT pr.precio
        FROM precios pr
        WHERE pr.id_producto = p.id_producto AND pr.fecha <= d.fecha
        ORDER BY pr.fecha DESC
        LIMIT 1) AS precio
FROM productos_con_precio p
CROSS JOIN dias d
ORDER BY p.id_producto, d.fecha;
