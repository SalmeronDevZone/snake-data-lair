-- EJERCICIO 11 · Carga incremental con upsert                                 🟡 Medio
-- Integra staging_clientes en clientes: inserta los clientes nuevos y actualiza los que
-- ya existen, pero SÓLO si algo ha cambiado (no reescribas filas idénticas).
-- Termina con:  SELECT id_cliente, nombre, ciudad FROM clientes ORDER BY id_cliente;
-- Pista: INSERT ... SELECT ... ON CONFLICT (id_cliente) DO UPDATE SET ... WHERE ...
-- (en SQLite, un INSERT ... SELECT con ON CONFLICT necesita un WHERE en el SELECT; vale "WHERE true").

INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_alta)
SELECT id_cliente, nombre, email, ciudad, fecha_alta
FROM staging_clientes
WHERE true
ON CONFLICT (id_cliente) DO UPDATE SET
    nombre = excluded.nombre,
    email  = excluded.email,
    ciudad = excluded.ciudad
WHERE clientes.nombre IS NOT excluded.nombre
   OR clientes.email  IS NOT excluded.email
   OR clientes.ciudad IS NOT excluded.ciudad;

SELECT id_cliente, nombre, ciudad FROM clientes ORDER BY id_cliente;
