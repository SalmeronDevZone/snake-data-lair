-- EJERCICIO 01 · Importe por categoría                                       🟢 Fácil
-- Calcula el importe vendido (cantidad × precio_unitario) por categoría de producto,
-- teniendo en cuenta sólo los pedidos ENTREGADOS.
-- Columnas: categoria, importe. Ordena de mayor a menor importe.
-- Pista: JOIN de tres tablas + GROUP BY. Las líneas de un producto que no existe no cuentan.

SELECT pr.categoria,
       SUM(l.cantidad * l.precio_unitario) AS importe
FROM lineas_pedido l
JOIN pedidos p    ON p.id_pedido = l.id_pedido
JOIN productos pr ON pr.id_producto = l.id_producto
WHERE p.estado = 'entregado'
GROUP BY pr.categoria
ORDER BY importe DESC;
