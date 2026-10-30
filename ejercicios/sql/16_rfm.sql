-- EJERCICIO 16 · Segmentación RFM                                             🟡 Medio
-- Para cada cliente con pedidos ENTREGADOS, a fecha de '2025-03-31':
--   recencia_dias = días desde su último pedido entregado
--   frecuencia    = número de pedidos entregados
--   monetario     = importe total
--   segmento      = 'fiel' si recencia <= 30 y frecuencia >= 2; 'reciente' si sólo recencia <= 30;
--                   'en riesgo' si sólo frecuencia >= 2; 'dormido' en otro caso.
-- Columnas: id_cliente, recencia_dias, frecuencia, monetario, segmento. Ordena por id_cliente.
-- Pista: CAST(julianday('2025-03-31') - julianday(MAX(fecha)) AS INTEGER) y un CASE.

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 16

