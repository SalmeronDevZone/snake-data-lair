-- EJERCICIO 15 · Análisis de cohortes                                         🔴 Difícil
-- La cohorte de un cliente es el mes de su PRIMER pedido entregado. Para cada cohorte y cada mes
-- posterior (incluido el suyo), cuántos clientes de la cohorte compraron ese mes y qué porcentaje
-- de la cohorte supone (1 decimal). Sólo pedidos ENTREGADOS.
-- Columnas: cohorte, mes, clientes_activos, pct_retencion. Ordena por cohorte y mes.
-- Pista: una CTE con la cohorte de cada cliente, otra con los meses en que compró cada uno,
-- y el tamaño de la cohorte con COUNT(*) OVER (PARTITION BY cohorte) o con otra agregación.

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 15

