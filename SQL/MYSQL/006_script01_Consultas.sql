SELECT productos.nombre, productos.unidad, productos.precio
FROM productos
WHERE productos.precio<=3;

SELECT p.nombre, p.unidad,p.precio
FROM productos p
WHERE p.precio<=3;

SELECT nombre 
FROM productos
WHERE paisorigen = 'España' 
AND tipo = 'fruta'
UNION 
SELECT nombre 
FROM productos
WHERE paisorigen IN ('México','Colombia','Chile')
AND tipo = 'fruta'
ORDER BY nombre;

SELECT DISTINCT nombre 
FROM productos
WHERE paisorigen IN ('España','México','Colombia','Chile')
AND tipo = 'fruta'
ORDER BY nombre;

SELECT nombre 
FROM productos
WHERE paisorigen = 'España' 
AND tipo = 'fruta'
INTERSECT 
SELECT nombre 
FROM productos
WHERE paisorigen IN ('México','Colombia','Chile')
AND tipo = 'fruta'
ORDER BY nombre;

SELECT nombre 
FROM productos
WHERE paisorigen = 'España' 
AND tipo = 'fruta'
MINUS 
SELECT nombre 
FROM productos
WHERE paisorigen IN ('México','Colombia','Chile')
AND tipo = 'fruta'
ORDER BY nombre;

SELECT * 
FROM clientes, pedidos;

SELECT clientes.*, pedidos.* 
FROM clientes, pedidos;

SELECT clientes.*, pedidos.* 
FROM clientes, pedidos
WHERE clientes.dni = pedidos.dni;

SELECT c.*, p.* 
FROM clientes c, pedidos p
WHERE c.dni = p.dni;

SELECT c.nombre, c.apellido1, c.apellido2, p.fecha_pedido,
 p.forma_pago 
FROM clientes c, pedidos p
WHERE c.dni = p.dni;

SELECT DISTINCT pr.nombre, c.nombre, c.apellido1, c.apellido2 
FROM clientes c, pedidos p, incluyen i, productos pr
WHERE c.dni = p.dni 
AND p.codigo = i.codigo_pedido 
AND i.codigo_producto = pr.codigo
AND i.cantidad > 2;

SELECT c.nombre, c.apellido1, c.apellido2, p.fecha_pedido,
 p.forma_pago 
FROM clientes c 
INNER JOIN pedidos p
ON c.dni = p.dni;

SELECT DISTINCT pr.nombre, c.nombre, c.apellido1, c.apellido2 
FROM clientes c
INNER JOIN pedidos p 
ON c.dni = p.dni 
INNER JOIN incluyen i
ON p.codigo = i.codigo_pedido 
INNER JOIN productos pr
ON i.codigo_producto = pr.codigo
WHERE i.cantidad > 2;

SELECT c.nombre, c.apellido1, c.apellido2, p.fecha_pedido,
 p.forma_pago
FROM clientes c 
NATURAL JOIN pedidos p;

SELECT c.dni, c.nombre, c.apellido1, c.apellido2, p.dni,   
p.fecha_pedido, p.forma_pago
FROM clientes c 
CROSS JOIN pedidos p;

SELECT c.dni, c.nombre, c.apellido1, c.apellido2,
p.dni, p.fecha_pedido, p.forma_pago
FROM clientes c
LEFT JOIN pedidos p
ON c.dni = p.dni
ORDER BY c.dni;

SELECT  pr.codigo,pr.nombre, i.*
FROM incluyen i
RIGHT JOIN productos pr
ON i.codigo_producto = pr.codigo
ORDER BY pr.codigo;

SELECT c.dni 
FROM clientes c 
LEFT JOIN pedidos p
ON c.dni = p.dni
WHERE p.dni IS NULL;

-- Su equivalente usando MINUS (o EXCEPT) es:
SELECT dni
FROM clientes c 
MINUS
SELECT dni
FROM pedidos;

SELECT c.dni, c.nombre, c.apellido1, c.apellido2, p.dni, 
p.fecha_pedido, p.forma_pago
FROM clientes c 
FULL OUTER JOIN pedidos p
ON c.dni = p.dni;

SELECT c.dni, c.nombre, c.apellido1, c.apellido2, p.dni, 
p.fecha_pedido, p.forma_pago
FROM clientes c 
LEFT JOIN pedidos p 
ON c.dni = p.dni
UNION ALL
SELECT c.dni, c.nombre, c.apellido1, c.apellido2, p.dni, 
p.fecha_pedido, p.forma_pago
FROM clientes c 
RIGHT JOIN pedidos p 
ON c.dni = p.dni
ORDER BY 1;

SELECT DISTINCT i1.codigo_pedido
FROM incluyen i1, incluyen i2
WHERE i1.cantidad = i2.cantidad 
AND i1.codigo_producto = i2.codigo_producto
AND i1.codigo_pedido <> i2.codigo_pedido;

SELECT DISTINCT i1.codigo_pedido
FROM incluyen i1
INNER JOIN incluyen i2
ON i1.cantidad = i2.cantidad 
AND i1.codigo_producto = i2.codigo_producto
WHERE i1.codigo_pedido <> i2.codigo_pedido
ORDER BY i1.codigo_pedido;

SELECT DISTINCT p1.nombre, p2.nombre
FROM productos p1, productos p2
WHERE p1.precio = p2.precio
ORDER BY p1.nombre;

SELECT DISTINCT p1.nombre, p2.nombre
FROM productos p1, productos p2
WHERE p1.precio = p2.precio
AND p1.nombre < p2.nombre
ORDER BY p1.nombre;

SELECT DISTINCT p1.nombre, p2.nombre
FROM productos p1
INNER JOIN productos p2
ON p1.precio = p2.precio
WHERE p1.nombre < p2.nombre;

SELECT DISTINCT c1.nombre
FROM productos c1, productos c2
WHERE c1.nombre = c2.nombre
AND c1.paisorigen <> c2.paisorigen;

SELECT DISTINCT c1.nombre
FROM productos c1
INNER JOIN productos c2
ON c1.nombre = c2.nombre
AND c1.paisorigen <> c2.paisorigen;

-- en MySQL y SQLite
SELECT DISTINCT nombre, apellido1, apellido2
FROM clientes 
WHERE dni IN (
SELECT dni 
FROM pedidos
WHERE fecha_pedido BETWEEN '2022-01-15' AND '2022-01-31')
ORDER BY apellido1, apellido2, nombre;

-- en Oracle
SELECT DISTINCT nombre, apellido1, apellido2
FROM clientes 
WHERE dni IN (
SELECT dni 
FROM pedidos
WHERE fecha_pedido BETWEEN DATE '2022-01-15' AND DATE '2022-01-31')
ORDER BY apellido1, apellido2, nombre;

SELECT DISTINCT nombre, apellido1, apellido2
FROM clientes 
WHERE dni IN (
SELECT dni
FROM pedidos
WHERE codigo IN (
SELECT codigo_pedido 
FROM incluyen
WHERE codigo_producto IN (
SELECT codigo 
FROM productos
WHERE nombre IN ('Mandarina', 'Naranja')
)
)
);

SELECT DISTINCT c.nombre, c.apellido1, c.apellido2
FROM clientes c, pedidos p, incluyen i
WHERE c.dni = p.dni 
AND p.codigo = i.codigo_pedido
AND i.codigo_producto IN (
SELECT codigo 
FROM productos
WHERE nombre IN ('Mandarina', 'Naranja')
);

SELECT DISTINCT nombre, apellido1, apellido2
FROM clientes 
WHERE (provincia, pais) NOT IN (
SELECT DISTINCT provincia,  pais
FROM pedidos 
WHERE provincia IS NOT NULL 
AND pais IS NOT NULL);

SELECT DISTINCT nombre
FROM productos
WHERE precio = ( SELECT MAX(precio) 
			FROM productos );

SELECT provincia, pais, COUNT(*) "Total"
FROM pedidos
WHERE codigo IN (SELECT codigo_pedido
FROM incluyen 
WHERE cantidad > 1)
AND pais IS NOT NULL
GROUP BY provincia, pais;

SELECT tipo, SUM(i.cantidad) "Total kilos vendidos"
FROM productos p, incluyen i
WHERE p.codigo = i.codigo_producto
AND unidad = 'kg'
GROUP BY tipo
HAVING SUM(i.cantidad) >= ( SELECT MAX(cantidad)
FROM incluyen i, productos p
WHERE p.codigo = i.codigo_producto
AND unidad = 'kg'
);

SELECT DISTINCT nombre
FROM productos 
WHERE codigo <> ALL (SELECT DISTINCT codigo_producto 
			FROM incluyen);

SELECT nombre
FROM productos 
WHERE tipo NOT IN ('fruta','verdura') 
AND  precio < ANY ( SELECT precio 
  FROM productos
  WHERE tipo NOT IN ('fruta','verdura') 
);

SELECT DISTINCT fecha_pedido
FROM pedidos p
WHERE 'Sevilla' = (SELECT provincia 
			FROM clientes c
			WHERE p.dni = c.dni);

SELECT DISTINCT p.fecha_pedido 
FROM pedidos p, clientes c
WHERE p.dni = c.dni and c.provincia = 'Sevilla';

SELECT DISTINCT c.dni, c.provincia
FROM clientes c
WHERE c.provincia IN (SELECT p.provincia 
                          FROM pedidos p
                          WHERE p.dni = c.dni
                          AND p.provincia IS NOT NULL)
ORDER BY c.dni;

SELECT p.codigo
FROM pedidos p
WHERE 10<= (SELECT SUM(i.cantidad)
            FROM incluyen i, productos pr
            WHERE i.codigo_pedido = p.codigo
            AND pr.codigo = i.codigo_producto
            AND pr.unidad = 'kg');

SELECT DISTINCT nombre
FROM productos p
WHERE EXISTS (SELECT DISTINCT codigo_producto 
			FROM incluyen i
WHERE p.codigo = i.codigo_producto );

SELECT DISTINCT nombre
FROM productos p, incluyen i
WHERE p.codigo = i.codigo_producto;

SELECT nombre 
FROM proveedores pr
WHERE NOT EXISTS 
    (SELECT DISTINCT tipo 
    FROM productos
    MINUS
    SELECT DISTINCT tipo
    FROM productos p, componen c, suministros s
    WHERE p.codigo = c.codigo_producto
    AND c.codigo_suministro = s.codigo
    AND s.codigo_proveedor = pr.codigo);

SELECT nombre 
FROM proveedores pr
WHERE NOT EXISTS 
(SELECT DISTINCT p1.tipo 
FROM productos p1
LEFT JOIN ( SELECT DISTINCT p.tipo
FROM productos p, componen c, suministros s
WHERE p.codigo = c.codigo_producto
AND c.codigo_suministro = s.codigo
AND s.codigo_proveedor = pr.codigo) p2
ON p1.tipo = p2.tipo
WHERE p2.tipo IS NULL);

SELECT codigo, fecha_pedido
FROM pedidos p
WHERE NOT EXISTS (
	SELECT codigo
   	FROM productos 
    	WHERE tipo = 'legumbre'
    MINUS
	SELECT i.codigo_producto
    	FROM incluyen i, productos pro
	WHERE pro.tipo = 'legumbre'
    	AND i.codigo_producto = pro.codigo
    	AND i.codigo_pedido = p.codigo
);

-- consulta anterior en MySQL
SELECT codigo, fecha_pedido
FROM pedidos p
WHERE NOT EXISTS (
	SELECT p1.codigo
    	FROM productos p1
	LEFT JOIN (	SELECT i.codigo_producto
				FROM incluyen i, productos pro
				WHERE pro.tipo = 'legumbre'
				AND i.codigo_producto = pro.codigo
				AND i.codigo_pedido = p.codigo ) p2
	ON p1.codigo = p2.codigo_producto
      WHERE p1.tipo = 'legumbre'
    	AND p2.codigo_producto IS NULL
);


SELECT AVG(total)
FROM (SELECT codigo_pedido, COUNT(i.codigo_producto) AS total
FROM incluyen i
GROUP BY codigo_pedido) t1;

SELECT codigo_pedido, COUNT(i.codigo_producto) AS "total"
FROM incluyen i
GROUP BY codigo_pedido;

-- en MySQL y SQLite
SELECT c.dni, c.apellido1, c.apellido2, c.nombre, SUM(tpedido.total)
FROM clientes c, pedidos p,
    (SELECT i.codigo_pedido AS pedido, 
    SUM(i.cantidad * pro.precio - i.cantidad * pro.precio * 
i.descuento/100) AS total
    FROM incluyen i, productos pro
    WHERE i.codigo_producto =  pro.codigo
    GROUP BY i.codigo_pedido ) tpedido
WHERE c.dni = p.dni 
AND p.codigo = tpedido.pedido
AND p.fecha_pedido BETWEEN '2022-01-01' AND '2022-01-31'
GROUP BY c.dni, c.apellido1, c.apellido2, c.nombre;

-- en Oracle
SELECT c.dni, c.apellido1, c.apellido2, c.nombre, SUM(tpedido.total)
FROM clientes c, pedidos p,
    (SELECT i.codigo_pedido AS pedido, 
    SUM(i.cantidad * pro.precio - i.cantidad * pro.precio * 
i.descuento/100) AS total
    FROM incluyen i, productos pro
    WHERE i.codigo_producto =  pro.codigo
    GROUP BY i.codigo_pedido ) tpedido
WHERE c.dni = p.dni 
AND p.codigo = tpedido.pedido
AND p.fecha_pedido BETWEEN DATE '2022-01-01' AND DATE'2022-01-31'
GROUP BY c.dni, c.apellido1, c.apellido2, c.nombre;

SELECT c.nombre, c.apellido1, c.apellido2, 
      (SELECT COUNT(p.codigo) from pedidos p where p.dni = c.dni) 
AS "Total pedidos"
FROM clientes c
WHERE pais = 'España';

UPDATE incluyen
SET descuento = descuento*1.10
WHERE codigo_producto IN (SELECT codigo
				FROM productos		
				WHERE tipo = 'fruta');
                
UPDATE incluyen i
SET descuento = descuento*1.10
WHERE 1 < ( SELECT COUNT(p1.codigo)
FROM pedidos p1
WHERE p1.dni = (SELECT p2.dni
				FROM pedidos p2
				WHERE i.codigo_pedido = p2.codigo)
);

                
UPDATE pedidos p
SET direccion = (SELECT direccion FROM clientes c
WHERE p.dni = c.dni), 
localidad = (SELECT localidad
	      FROM clientes c
WHERE p.dni = c.dni), 
provincia = (SELECT provincia
	      FROM clientes c
WHERE p.dni = c.dni), 
pais = 	(SELECT pais
FROM clientes c
WHERE p.dni = c.dni), 
codigo_postal = (SELECT codigo_postal
			FROM clientes c
WHERE p.dni = c.dni)
WHERE pais IS NULL;


DELETE FROM pedidos 
WHERE codigo IN (SELECT DISTINCT i.codigo_pedido
			FROM incluyen i, productos pr
WHERE i.codigo_producto = pr.codigo
AND pr.tipo = 'frutos_secos');

