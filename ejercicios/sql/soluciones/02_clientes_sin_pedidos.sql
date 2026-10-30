-- EJERCICIO 02 · Clientes sin pedidos                                         🟢 Fácil
-- Lista los clientes que no han hecho ningún pedido (en ningún estado).
-- Columnas: id_cliente, nombre. Ordena por id_cliente.
-- Pista: anti-join con LEFT JOIN ... WHERE ... IS NULL, o NOT EXISTS.

SELECT c.id_cliente, c.nombre
FROM clientes c
WHERE NOT EXISTS (SELECT 1 FROM pedidos p WHERE p.id_cliente = c.id_cliente)
ORDER BY c.id_cliente;
