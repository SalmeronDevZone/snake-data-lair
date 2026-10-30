-- EJERCICIO 21 · De formato ancho a largo (unpivot)                           🟢 Fácil
-- ventas_ancho tiene una columna por mes, como una hoja de cálculo. Conviértela en una fila por
-- tienda y mes ('2025-01', '2025-02', '2025-03'), sin los meses vacíos (NULL).
-- Columnas: tienda, mes, importe. Ordena por tienda y mes.
-- Pista: un SELECT por columna unidos con UNION ALL. Es la operación inversa del ejercicio 09.

SELECT tienda, mes, importe
FROM (
    SELECT tienda, '2025-01' AS mes, ene AS importe FROM ventas_ancho
    UNION ALL
    SELECT tienda, '2025-02', feb FROM ventas_ancho
    UNION ALL
    SELECT tienda, '2025-03', mar FROM ventas_ancho
)
WHERE importe IS NOT NULL
ORDER BY tienda, mes;
