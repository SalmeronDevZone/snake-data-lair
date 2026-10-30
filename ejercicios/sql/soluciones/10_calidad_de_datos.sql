-- EJERCICIO 10 · Informe de calidad de datos                                  🟡 Medio
-- Una sola consulta que devuelva cuántas incidencias hay de cada tipo:
--   'líneas con cantidad <= 0'
--   'líneas con producto inexistente'
--   'pedidos sin líneas'
--   'clientes sin email'
--   'emails repetidos'   (cuántas direcciones aparecen en más de un cliente, sin distinguir mayúsculas)
-- Columnas: regla, incidencias. Ordena por regla.
-- Pista: una subconsulta por regla unidas con UNION ALL. Así se construyen los "data quality checks".

SELECT 'líneas con cantidad <= 0' AS regla, COUNT(*) AS incidencias
FROM lineas_pedido WHERE cantidad <= 0
UNION ALL
SELECT 'líneas con producto inexistente', COUNT(*)
FROM lineas_pedido l LEFT JOIN productos p ON p.id_producto = l.id_producto
WHERE p.id_producto IS NULL
UNION ALL
SELECT 'pedidos sin líneas', COUNT(*)
FROM pedidos p WHERE NOT EXISTS (SELECT 1 FROM lineas_pedido l WHERE l.id_pedido = p.id_pedido)
UNION ALL
SELECT 'clientes sin email', COUNT(*)
FROM clientes WHERE email IS NULL OR TRIM(email) = ''
UNION ALL
SELECT 'emails repetidos', COUNT(*)
FROM (SELECT LOWER(email) FROM clientes WHERE email IS NOT NULL GROUP BY LOWER(email) HAVING COUNT(*) > 1)
ORDER BY regla;
