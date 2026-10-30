-- EJERCICIO 22 · Conciliar dos sistemas                                       🟡 Medio
-- Compara las facturas del ERP con los cobros del banco y lista SÓLO las que no cuadran:
--   'sin cobro'          está en el ERP pero no en el banco
--   'cobro sin factura'  está en el banco pero no en el ERP
--   'importe distinto'   está en los dos con importes diferentes
-- Columnas: id_factura, importe_erp, importe_banco, estado. Ordena por id_factura.
-- Pista: necesitas un FULL OUTER JOIN. Si tu SQLite es antiguo (< 3.39), emúlalo con dos LEFT JOIN
-- y UNION ALL, que es lo que hace esta solución para funcionar en cualquier versión.

WITH comparacion AS (
    SELECT e.id_factura, e.importe AS importe_erp, b.importe AS importe_banco
    FROM facturas_erp e
    LEFT JOIN cobros_banco b ON b.id_factura = e.id_factura
    UNION ALL
    SELECT b.id_factura, NULL, b.importe
    FROM cobros_banco b
    WHERE NOT EXISTS (SELECT 1 FROM facturas_erp e WHERE e.id_factura = b.id_factura)
)
SELECT id_factura, importe_erp, importe_banco,
       CASE
           WHEN importe_banco IS NULL THEN 'sin cobro'
           WHEN importe_erp IS NULL THEN 'cobro sin factura'
           ELSE 'importe distinto'
       END AS estado
FROM comparacion
WHERE importe_erp IS NOT importe_banco
ORDER BY id_factura;
