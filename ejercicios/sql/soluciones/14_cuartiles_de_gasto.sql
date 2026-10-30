-- EJERCICIO 14 · Segmentar clientes en cuartiles                              🟡 Medio
-- Reparte en 4 grupos (cuartil 1 = los que más gastan) a los clientes con pedidos ENTREGADOS,
-- según su gasto total. En caso de empate de gasto, desempata el id_cliente más bajo.
-- Columnas: id_cliente, nombre, gasto, cuartil. Ordena por cuartil, gasto descendente e id_cliente.
-- Pista: NTILE(4) OVER (ORDER BY ...). Sin desempate, el resultado no sería reproducible.

WITH gasto AS (
    SELECT p.id_cliente, SUM(l.cantidad * l.precio_unitario) AS gasto
    FROM pedidos p
    JOIN lineas_pedido l ON l.id_pedido = p.id_pedido
    WHERE p.estado = 'entregado'
    GROUP BY p.id_cliente
)
SELECT g.id_cliente, c.nombre, g.gasto,
       NTILE(4) OVER (ORDER BY g.gasto DESC, g.id_cliente) AS cuartil
FROM gasto g
JOIN clientes c ON c.id_cliente = g.id_cliente
ORDER BY cuartil, g.gasto DESC, g.id_cliente;
