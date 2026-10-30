-- EJERCICIO 25 · Aplicar cambios capturados (CDC)                             🔴 Difícil
-- productos_replica es una copia antigua de productos. cambios_productos trae, en orden de
-- secuencia, las operaciones del origen: 'I' (alta), 'U' (cambio, con la fila completa) y 'D' (baja).
-- Un mismo producto puede cambiar varias veces: sólo importa su ÚLTIMA operación.
-- Aplica los cambios a productos_replica y termina con:
--   SELECT id_producto, nombre, categoria, precio FROM productos_replica ORDER BY id_producto;
-- Pista: la última operación de cada producto con ROW_NUMBER(); después un DELETE para las 'D'
-- y un upsert (INSERT ... ON CONFLICT DO UPDATE) para las 'I' y 'U'.

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 25

