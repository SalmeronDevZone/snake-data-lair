-- EJERCICIO 06 · Deduplicar una tabla de carga                               🟡 Medio
-- pedidos_raw recibe una copia de cada pedido cada vez que cambia (y a veces la misma dos veces).
-- Quédate con la versión MÁS RECIENTE de cada pedido (según cargado_en).
-- Columnas: id_pedido, estado, importe. Ordena por id_pedido.
-- Pista: ROW_NUMBER() OVER (PARTITION BY id_pedido ORDER BY cargado_en DESC) = 1.
-- Es el patrón con el que se limpian casi todas las capas "raw" o "bronze".

WITH versiones AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY id_pedido ORDER BY cargado_en DESC) AS rn
    FROM pedidos_raw
)
SELECT id_pedido, estado, importe
FROM versiones
WHERE rn = 1
ORDER BY id_pedido;
