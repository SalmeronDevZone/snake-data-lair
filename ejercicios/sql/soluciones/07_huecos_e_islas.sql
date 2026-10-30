-- EJERCICIO 07 · Huecos e islas: rachas de días con pedidos                  🔴 Difícil
-- Agrupa los días con algún pedido (en cualquier estado) en rachas de días CONSECUTIVOS.
-- Columnas: inicio, fin, dias. Ordena por inicio.
-- Pista: con fechas distintas, julianday(fecha) - ROW_NUMBER() OVER (ORDER BY fecha)
-- da el mismo valor para todos los días de una misma racha.

WITH dias AS (
    SELECT DISTINCT fecha FROM pedidos
),
grupos AS (
    SELECT fecha,
           julianday(fecha) - ROW_NUMBER() OVER (ORDER BY fecha) AS grupo
    FROM dias
)
SELECT MIN(fecha) AS inicio,
       MAX(fecha) AS fin,
       COUNT(*)   AS dias
FROM grupos
GROUP BY grupo
ORDER BY inicio;
