USE fruteria;

-- consultar todos los datos de clientes
SELECT * FROM clientes;

-- nombre, apellidos, provincia, dirección de correo electrónico y tlfn de todos los clientes
SELECT nombre, apellido1, apellido2, provincia, email, tlf FROM clientes;
-- igual pero cambiando el orden de los apellidos y nombre
SELECT apellido1, apellido2, nombre, provincia, email, tlf FROM clientes;
SELECT apellido1, apellido2, nombre, provincia, email, tlf 
FROM clientes;

-- ejemplo de alias
SELECT apellido1, apellido2, nombre, provincia, email AS "Correo electrónico", tlf AS "Teléfono"
FROM clientes;

-- ejemplos de ALL y DISTINCT
SELECT ALL apellido1, apellido2
FROM clientes;

SELECT DISTINCT apellido1, apellido2
FROM clientes;

-- Columnas calculadas y uso de expresiones
SELECT nombre, precio, precio+precio*0.10
FROM productos;

SELECT nombre, precio, precio+precio*0.10 AS "Precio incrementado"
FROM productos;

SELECT cantidad, descuento, (1.20*cantidad)-(1.20*descuento) AS "Precio producto en pedido"
FROM incluyen;

-- ejemplos del WHERE
SELECT apellido1, apellido2, nombre, email, localidad
FROM clientes 
WHERE localidad='Granada';

SELECT apellido1, apellido2, nombre, email
FROM clientes 
WHERE localidad!='Granada';

SELECT nombre,unidad,precio
FROM productos
WHERE precio<=3;

SELECT codigo,fecha_pedido,dni
FROM pedidos
WHERE fecha_pedido>='2022/02/01';
-- EN ORACLE cambia el formato de fecha
SELECT codigo,fecha_pedido,dni 
FROM pedidos
WHERE fecha_pedido>='01/02/2022';

SELECT codigo,fecha_pedido,dni 
FROM pedidos
WHERE forma_pago IN ('Visa','Efectivo');

SELECT codigo,fecha_pedido,dni 
FROM pedidos
WHERE forma_pago NOT IN ('Visa','Paypal');

SELECT nombre, apellido1, apellido2, tlf
FROM clientes
WHERE email IS NULL;

SELECT nombre, apellido1, apellido2, tlf
FROM clientes
WHERE email IS NOT NULL;

SELECT nombre,unidad,precio
FROM productos
WHERE precio BETWEEN 3.5 AND 5.95;

SELECT nombre,unidad,precio
FROM productos
WHERE precio NOT BETWEEN 3.5 AND 5.95;

SELECT nombre, contacto, email, provincia
FROM proveedores
WHERE provincia LIKE 'G%';

SELECT nombre, precio, unidad
FROM productos
WHERE unidad LIKE '_g';

SELECT nombre, contacto, email, provincia
FROM proveedores
WHERE provincia NOT LIKE 'G%';

SELECT nombre, precio, ciudadorigen
FROM productos
WHERE tipo='fruta' AND precio<4;

SELECT apellido1, apellido2, nombre, email, provincia
FROM clientes
WHERE provincia='Granada' OR provincia='Huelva' OR provincia='Sevilla';

SELECT nombre, descripcion, tipo, precio
FROM productos
WHERE ((tipo='fruta' AND precio>=5) OR (tipo='verdura' AND precio>=4));

-- consultas de agrupamientos
SELECT COUNT(*) FROM productos;
SELECT COUNT(DISTINCT ciudadorigen) FROM productos;
SELECT COUNT(ALL ciudadorigen) FROM productos;
SELECT SUM(cantidad) FROM componen WHERE codigo_producto=2;
SELECT AVG(precio) FROM productos;
SELECT MIN(precio) FROM productos;
SELECT MAX(precio) FROM productos;

-- ejemplos de agrupamiento
SELECT tipo
FROM productos;

SELECT tipo
FROM productos
GROUP BY tipo;

SELECT tipo, COUNT(*) AS "Cuenta" 
    FROM productos
    GROUP BY tipo
    HAVING tipo!='legumbre';

SELECT tipo, COUNT(*) FROM productos GROUP BY tipo;
SELECT tipo, COUNT(*) AS "Cuenta", MAX(precio) AS "Precio máximo", MIN(precio) AS "Precio mínimo" FROM productos GROUP BY tipo;

-- ejemplos de ORDER by
SELECT DISTINCT tipo
FROM productos 
ORDER BY tipo ASC;

SELECT DISTINCT tipo
FROM productos 
ORDER BY tipo;

SELECT nombre, descripcion, precio
FROM productos
WHERE tipo='verdura'
ORDER BY precio DESC;

SELECT apellido1, apellido2, nombre, tlf
FROM clientes
WHERE localidad='Granada'
ORDER BY apellido1 DESC, apellido2 DESC, nombre DESC;

SELECT apellido1, apellido2, nombre, tlf
FROM clientes
WHERE localidad='Granada'
ORDER BY 1 DESC, 2 DESC, 3 DESC;

-- ejemplo de LIMIT en MySQL y SQLite
SELECT nombre, precio 
    FROM productos
    ORDER BY precio DESC;

SELECT nombre, precio 
    FROM productos
    ORDER BY precio DESC
    LIMIT 3;
-- limitar los resultados en Oracle
SELECT nombre, precio 
    FROM productos
    WHERE ROWNUM<=3
    ORDER BY precio DESC;
