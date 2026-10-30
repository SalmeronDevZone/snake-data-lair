-- EJERCICIO 22 · Conciliar dos sistemas                                       🟡 Medio
-- Compara las facturas del ERP con los cobros del banco y lista SÓLO las que no cuadran:
--   'sin cobro'          está en el ERP pero no en el banco
--   'cobro sin factura'  está en el banco pero no en el ERP
--   'importe distinto'   está en los dos con importes diferentes
-- Columnas: id_factura, importe_erp, importe_banco, estado. Ordena por id_factura.
-- Pista: necesitas un FULL OUTER JOIN. Si tu SQLite es antiguo (< 3.39), emúlalo con dos LEFT JOIN
-- y UNION ALL, que es lo que hace esta solución para funcionar en cualquier versión.

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 22

