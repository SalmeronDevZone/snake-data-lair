-- EJERCICIO 15 · Análisis de cohortes                                         🔴 Difícil
-- La cohorte de un cliente es el mes de su PRIMER pedido entregado. Para cada cohorte y cada mes
-- posterior (incluido el suyo), cuántos clientes de la cohorte compraron ese mes y qué porcentaje
-- de la cohorte supone (1 decimal). Sólo pedidos ENTREGADOS.
-- Columnas: cohorte, mes, clientes_activos, pct_retencion. Ordena por cohorte y mes.
-- Pista: una CTE con la cohorte de cada cliente, otra con los meses en que compró cada uno,
-- y el tamaño de la cohorte con COUNT(*) OVER (PARTITION BY cohorte) o con otra agregación.

WITH compras AS (
    SELECT DISTINCT id_cliente, strftime('%Y-%m', fecha) AS mes
    FROM pedidos
    WHERE estado = 'entregado'
),
cohortes AS (
    SELECT id_cliente, MIN(mes) AS cohorte
    FROM compras
    GROUP BY id_cliente
),
tamano AS (
    SELECT cohorte, COUNT(*) AS clientes
    FROM cohortes
    GROUP BY cohorte
)
SELECT co.cohorte,
       cm.mes,
       COUNT(*) AS clientes_activos,
       ROUND(100.0 * COUNT(*) / t.clientes, 1) AS pct_retencion
FROM compras cm
JOIN cohortes co ON co.id_cliente = cm.id_cliente
JOIN tamano t    ON t.cohorte = co.cohorte
GROUP BY co.cohorte, cm.mes, t.clientes
ORDER BY co.cohorte, cm.mes;
