-- EJERCICIO 23 · Datos semiestructurados (JSON)                               🔴 Difícil
-- eventos_json guarda cada evento como texto JSON. Sólo para los de tipo 'compra', calcula por país
-- del cliente: número de compras, importe total y unidades totales (suma de "uds" de sus "items";
-- una compra sin items aporta 0 unidades).
-- Columnas: pais, compras, importe, unidades. Ordena por pais.
-- Pista: json_extract(payload, '$.cliente.pais') y json_each(payload, '$.items') para los items.
-- Cuidado: si unes cada evento con sus items ANTES de agregar, el importe se duplica.

WITH compras AS (
    SELECT id,
           json_extract(payload, '$.cliente.pais') AS pais,
           json_extract(payload, '$.importe')      AS importe
    FROM eventos_json
    WHERE json_extract(payload, '$.tipo') = 'compra'
),
unidades AS (
    SELECT e.id, SUM(json_extract(i.value, '$.uds')) AS uds
    FROM eventos_json e, json_each(e.payload, '$.items') i
    GROUP BY e.id
)
SELECT c.pais,
       COUNT(*)                   AS compras,
       ROUND(SUM(c.importe), 2)   AS importe,
       COALESCE(SUM(u.uds), 0)    AS unidades
FROM compras c
LEFT JOIN unidades u ON u.id = c.id
GROUP BY c.pais
ORDER BY c.pais;
