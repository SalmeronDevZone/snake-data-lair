-- EJERCICIO 23 · Datos semiestructurados (JSON)                               🔴 Difícil
-- eventos_json guarda cada evento como texto JSON. Sólo para los de tipo 'compra', calcula por país
-- del cliente: número de compras, importe total y unidades totales (suma de "uds" de sus "items";
-- una compra sin items aporta 0 unidades).
-- Columnas: pais, compras, importe, unidades. Ordena por pais.
-- Pista: json_extract(payload, '$.cliente.pais') y json_each(payload, '$.items') para los items.
-- Cuidado: si unes cada evento con sus items ANTES de agregar, el importe se duplica.

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 23

