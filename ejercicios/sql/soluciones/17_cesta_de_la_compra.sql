-- EJERCICIO 17 · Cesta de la compra: qué se compra junto                     🟡 Medio
-- Con la tabla tickets, cuenta en cuántos tickets aparece cada PAREJA de productos y quédate con
-- las que aparecen juntas al menos 2 veces. Cada pareja una sola vez, con producto_a < producto_b.
-- Columnas: producto_a, producto_b, veces. Ordena por veces descendente, producto_a y producto_b.
-- Pista: auto-join de tickets consigo misma por id_ticket con a.producto < b.producto.

SELECT a.producto AS producto_a,
       b.producto AS producto_b,
       COUNT(*)   AS veces
FROM tickets a
JOIN tickets b ON b.id_ticket = a.id_ticket AND a.producto < b.producto
GROUP BY a.producto, b.producto
HAVING COUNT(*) >= 2
ORDER BY veces DESC, producto_a, producto_b;
