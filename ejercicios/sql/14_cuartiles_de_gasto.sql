-- EJERCICIO 14 · Segmentar clientes en cuartiles                              🟡 Medio
-- Reparte en 4 grupos (cuartil 1 = los que más gastan) a los clientes con pedidos ENTREGADOS,
-- según su gasto total. En caso de empate de gasto, desempata el id_cliente más bajo.
-- Columnas: id_cliente, nombre, gasto, cuartil. Ordena por cuartil, gasto descendente e id_cliente.
-- Pista: NTILE(4) OVER (ORDER BY ...). Sin desempate, el resultado no sería reproducible.

-- ✍️  Escribe tu solución debajo y comprueba con:  python comprobar.py 14

