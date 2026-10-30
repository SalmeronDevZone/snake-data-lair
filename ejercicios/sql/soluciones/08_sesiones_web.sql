-- EJERCICIO 08 · Sesionizar clics                                             🔴 Difícil
-- Una sesión termina cuando un cliente pasa MÁS de 30 minutos sin hacer clic.
-- Para cada cliente: número de sesiones, número de eventos y eventos por sesión (1 decimal).
-- Columnas: id_cliente, sesiones, eventos, eventos_por_sesion. Ordena por id_cliente.
-- Pista: LAG(momento) para el clic anterior; marca 1 si empieza sesión nueva y haz una
-- suma acumulada de esas marcas para numerar las sesiones.

WITH con_anterior AS (
    SELECT id_cliente, momento,
           LAG(momento) OVER (PARTITION BY id_cliente ORDER BY momento) AS anterior
    FROM eventos_web
),
marcas AS (
    SELECT id_cliente, momento,
           CASE WHEN anterior IS NULL
                  OR (julianday(momento) - julianday(anterior)) * 24 * 60 > 30
                THEN 1 ELSE 0 END AS nueva_sesion
    FROM con_anterior
),
sesiones AS (
    SELECT id_cliente,
           SUM(nueva_sesion) OVER (PARTITION BY id_cliente ORDER BY momento) AS num_sesion
    FROM marcas
)
SELECT id_cliente,
       MAX(num_sesion) AS sesiones,
       COUNT(*)        AS eventos,
       ROUND(1.0 * COUNT(*) / MAX(num_sesion), 1) AS eventos_por_sesion
FROM sesiones
GROUP BY id_cliente
ORDER BY id_cliente;
