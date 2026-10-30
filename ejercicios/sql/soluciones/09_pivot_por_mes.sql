-- EJERCICIO 09 · Tabla dinámica (pivot)                                       🟡 Medio
-- Unidades vendidas por categoría en pedidos ENTREGADOS, con una columna por mes del 2025.
-- Columnas: categoria, enero, febrero, marzo, total. Ordena por categoria.
-- Pista: SQLite no tiene PIVOT: usa SUM(CASE WHEN mes = '01' THEN cantidad ELSE 0 END).

SELECT pr.categoria,
       SUM(CASE WHEN strftime('%m', p.fecha) = '01' THEN l.cantidad ELSE 0 END) AS enero,
       SUM(CASE WHEN strftime('%m', p.fecha) = '02' THEN l.cantidad ELSE 0 END) AS febrero,
       SUM(CASE WHEN strftime('%m', p.fecha) = '03' THEN l.cantidad ELSE 0 END) AS marzo,
       SUM(l.cantidad) AS total
FROM lineas_pedido l
JOIN pedidos p    ON p.id_pedido = l.id_pedido
JOIN productos pr ON pr.id_producto = l.id_producto
WHERE p.estado = 'entregado' AND strftime('%Y', p.fecha) = '2025'
GROUP BY pr.categoria
ORDER BY pr.categoria;
