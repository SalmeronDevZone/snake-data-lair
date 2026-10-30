-- EJERCICIO 20 · Un calendario sin huecos                                     🟡 Medio
-- Importe de los pedidos ENTREGADOS de cada día del 1 al 10 de enero de 2025, incluidos los días
-- sin ventas (con importe 0), y el nombre del día de la semana en español.
-- Columnas: fecha, dia_semana, importe. Ordena por fecha.
-- Pista: genera los días con WITH RECURSIVE y date(fecha, '+1 day'), y haz un LEFT JOIN con las
-- ventas. strftime('%w', fecha) da 0 = domingo ... 6 = sábado.

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 20

