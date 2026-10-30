-- EJERCICIO 03 · El producto estrella de cada categoría                      🟡 Medio
-- Para cada categoría, el producto con más unidades vendidas en pedidos ENTREGADOS.
-- Si hay empate, salen todos los empatados.
-- Columnas: categoria, producto, unidades. Ordena por categoria y producto.
-- Pista: agrega por producto y después RANK() OVER (PARTITION BY categoria ...).

WITH unidades AS (
    SELECT pr.categoria, pr.nombre AS producto, SUM(l.cantidad) AS unidades
    FROM lineas_pedido l
    JOIN pedidos p    ON p.id_pedido = l.id_pedido
    JOIN productos pr ON pr.id_producto = l.id_producto
    WHERE p.estado = 'entregado'
    GROUP BY pr.categoria, pr.nombre
),
ranking AS (
    SELECT *, RANK() OVER (PARTITION BY categoria ORDER BY unidades DESC) AS puesto
    FROM unidades
)
SELECT categoria, producto, unidades
FROM ranking
WHERE puesto = 1
ORDER BY categoria, producto;
