-- EJERCICIO 19 · Media móvil                                                  🟡 Medio
-- Para cada día con pedidos ENTREGADOS: su importe y la media de ese día y los dos días con
-- ventas anteriores (media móvil de 3 filas, 2 decimales). Los primeros días promedian los que haya.
-- Columnas: fecha, importe_dia, media_movil_3. Ordena por fecha.
-- Pista: AVG(...) OVER (ORDER BY fecha ROWS BETWEEN 2 PRECEDING AND CURRENT ROW).
-- Ojo: son 3 días CON VENTAS, no 3 días de calendario (para eso mira el ejercicio 20).

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 19

