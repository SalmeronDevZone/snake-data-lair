-- EJERCICIO 11 · Carga incremental con upsert                                 🟡 Medio
-- Integra staging_clientes en clientes: inserta los clientes nuevos y actualiza los que
-- ya existen, pero SÓLO si algo ha cambiado (no reescribas filas idénticas).
-- Termina con:  SELECT id_cliente, nombre, ciudad FROM clientes ORDER BY id_cliente;
-- Pista: INSERT ... SELECT ... ON CONFLICT (id_cliente) DO UPDATE SET ... WHERE ...
-- (en SQLite, un INSERT ... SELECT con ON CONFLICT necesita un WHERE en el SELECT; vale "WHERE true").

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 11

