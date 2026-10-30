-- EJERCICIO 25 · Aplicar cambios capturados (CDC)                             🔴 Difícil
-- productos_replica es una copia antigua de productos. cambios_productos trae, en orden de
-- secuencia, las operaciones del origen: 'I' (alta), 'U' (cambio, con la fila completa) y 'D' (baja).
-- Un mismo producto puede cambiar varias veces: sólo importa su ÚLTIMA operación.
-- Aplica los cambios a productos_replica y termina con:
--   SELECT id_producto, nombre, categoria, precio FROM productos_replica ORDER BY id_producto;
-- Pista: la última operación de cada producto con ROW_NUMBER(); después un DELETE para las 'D'
-- y un upsert (INSERT ... ON CONFLICT DO UPDATE) para las 'I' y 'U'.

CREATE TEMP TABLE ultimos AS
SELECT operacion, id_producto, nombre, categoria, precio
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY id_producto ORDER BY secuencia DESC) AS rn
    FROM cambios_productos
)
WHERE rn = 1;

DELETE FROM productos_replica
WHERE id_producto IN (SELECT id_producto FROM ultimos WHERE operacion = 'D');

INSERT INTO productos_replica (id_producto, nombre, categoria, precio)
SELECT id_producto, nombre, categoria, precio
FROM ultimos
WHERE operacion IN ('I', 'U')
ON CONFLICT (id_producto) DO UPDATE SET
    nombre = excluded.nombre,
    categoria = excluded.categoria,
    precio = excluded.precio;

SELECT id_producto, nombre, categoria, precio FROM productos_replica ORDER BY id_producto;
