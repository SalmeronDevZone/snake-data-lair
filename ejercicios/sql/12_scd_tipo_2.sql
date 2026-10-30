-- EJERCICIO 12 · Dimensión con historial (SCD tipo 2)                         🔴 Difícil
-- dim_cliente_scd2 guarda una versión por cada ciudad en la que ha vivido un cliente.
-- Aplica staging_clientes con fecha de carga '2025-03-31':
--   · si la ciudad de un cliente cambia: cierra su versión vigente (valido_hasta = '2025-03-31',
--     es_actual = 0) y abre una nueva (valido_desde = '2025-03-31', valido_hasta = NULL, es_actual = 1);
--   · si el cliente es nuevo: crea su primera versión (valido_desde = su fecha_alta);
--   · si no cambia nada: no toques nada.
-- Termina con:
--   SELECT id_cliente, ciudad, valido_desde, valido_hasta, es_actual
--   FROM dim_cliente_scd2 ORDER BY id_cliente, valido_desde;
-- Pista: primero el UPDATE que cierra versiones, después los INSERT. El orden importa.

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 12

