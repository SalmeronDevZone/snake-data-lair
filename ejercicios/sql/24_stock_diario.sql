-- EJERCICIO 24 · Stock al cierre de cada día                                  🟡 Medio
-- A partir de las entradas (+) y salidas (-) de movimientos_stock, el stock de cada producto al
-- final de cada día en que tuvo movimientos (varios movimientos el mismo día se suman), y una
-- alerta 'stock negativo' cuando baje de 0 (NULL si no).
-- Columnas: id_producto, fecha, stock, alerta. Ordena por id_producto y fecha.
-- Pista: primero el neto por producto y día, después SUM(...) OVER (PARTITION BY id_producto ORDER BY fecha).

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 24

