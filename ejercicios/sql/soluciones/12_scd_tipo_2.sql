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

-- 1. Cerrar las versiones vigentes cuya ciudad ha cambiado
UPDATE dim_cliente_scd2
SET valido_hasta = '2025-03-31', es_actual = 0
WHERE es_actual = 1
  AND EXISTS (
      SELECT 1 FROM staging_clientes s
      WHERE s.id_cliente = dim_cliente_scd2.id_cliente
        AND s.ciudad <> dim_cliente_scd2.ciudad
  );

-- 2. Abrir una versión nueva para los que acabamos de cerrar
INSERT INTO dim_cliente_scd2 (id_cliente, ciudad, valido_desde, valido_hasta, es_actual)
SELECT s.id_cliente, s.ciudad, '2025-03-31', NULL, 1
FROM staging_clientes s
WHERE EXISTS (SELECT 1 FROM dim_cliente_scd2 d WHERE d.id_cliente = s.id_cliente)
  AND NOT EXISTS (SELECT 1 FROM dim_cliente_scd2 d WHERE d.id_cliente = s.id_cliente AND d.es_actual = 1);

-- 3. Primera versión de los clientes nuevos
INSERT INTO dim_cliente_scd2 (id_cliente, ciudad, valido_desde, valido_hasta, es_actual)
SELECT s.id_cliente, s.ciudad, s.fecha_alta, NULL, 1
FROM staging_clientes s
WHERE NOT EXISTS (SELECT 1 FROM dim_cliente_scd2 d WHERE d.id_cliente = s.id_cliente);

SELECT id_cliente, ciudad, valido_desde, valido_hasta, es_actual
FROM dim_cliente_scd2
ORDER BY id_cliente, valido_desde;
