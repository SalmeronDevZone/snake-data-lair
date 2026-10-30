-- EJERCICIO 26 · Rellenar huecos con el último valor conocido                 🔴 Difícil
-- La tabla precios sólo tiene una fila cuando el precio cambia. Para los productos 1 y 5 y cada día
-- del 1 al 6 de marzo de 2025, ¿qué precio estaba vigente? (NULL si aún no se había publicado).
-- Columnas: id_producto, fecha, precio. Ordena por id_producto y fecha.
-- Pista: calendario con WITH RECURSIVE, combinado con los productos (CROSS JOIN), y para cada
-- día el precio con la fecha más reciente que no sea posterior. Es el "forward fill" / LOCF.

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 26

