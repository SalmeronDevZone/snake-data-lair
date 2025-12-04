DROP view ventas;
DROP view pedidos_productos;
DROP view listado_clientes; 
DROP view frutas_tropicales;
DROP view suministros_proveedores;
DROP view ventas_visa;
DROP view ventas_efectivo;

CREATE VIEW ventas AS
SELECT DISTINCT nombre, apellido1, apellido2, email, tlf 
FROM pedidos p, clientes c 
WHERE p.dni = c.dni;

SELECT * FROM ventas;

CREATE OR REPLACE VIEW ventas AS
SELECT DISTINCT nombre, apellido1, apellido2, email, tlf, COUNT(p.codigo) AS total
FROM pedidos p, clientes c, incluyen i
WHERE p.dni = c.dni 
AND i.codigo_pedido = p.codigo
GROUP BY nombre, apellido1, apellido2, email, tlf;

SELECT * FROM ventas;

DROP VIEW ventas;

CREATE VIEW pedidos_productos (pedido, producto, precio) AS
SELECT DISTINCT i.codigo_pedido, nombre, ROUND(precio-precio* i.descuento/100,2)
FROM incluyen i, productos p, pedidos pe
WHERE i.codigo_producto = p.codigo
AND i.codigo_pedido = pe.codigo
ORDER BY i.codigo_pedido;

SELECT * FROM pedidos_productos;
-- MySQL
CREATE VIEW listado_clientes (nombre) AS
SELECT CONCAT(apellido1, ' ' , apellido2 , ', ' , nombre)
FROM clientes;
-- SQLite y Oracle
CREATE VIEW listado_clientes (nombre) AS
SELECT apellido1 || ' ' || apellido2 || ', ' || nombre
FROM clientes;

SELECT *  FROM listado_clientes;


--  1.Operaciones de manipulación de datos sobre vistas actualizables.
CREATE VIEW frutas_tropicales AS
SELECT * 
FROM productos
WHERE paisorigen IN ('México','Colombia','Chile')
AND tipo = 'fruta'
ORDER BY nombre;

SELECT * FROM frutas_tropicales ;

UPDATE frutas_tropicales
SET precio = precio * (1.1);

SELECT * FROM frutas_tropicales ;

INSERT INTO frutas_tropicales
VALUES (17,'Mango','Mango de México','./imagenes/mango.jpeg',5.15,'kg',null,'México','fruta');

DELETE FROM frutas_tropicales
WHERE codigo = 17;

SELECT * FROM frutas_tropicales ;

-- 2. Actualización de vistas con varias tablas. MYSQL

CREATE VIEW suministros_proveedores AS
SELECT nombre, fecha, codigo_producto, precio_coste, cantidad
FROM proveedores p, suministros s, componen c
WHERE p.codigo =s.codigo_proveedor
AND c.codigo_suministro = s.codigo
AND  pais = 'España' 
AND fecha >= '2022-01-15' ;

SELECT * FROM suministros_proveedores ;

UPDATE suministros_proveedores
SET cantidad = cantidad + 2
WHERE nombre = 'Frutería Paqui';

UPDATE suministros_proveedores
SET fecha = '2022-01-10'
WHERE nombre = 'Fruteria Paqui';

SELECT * FROM suministros_proveedores ;

SELECT nombre, fecha, codigo_producto, precio_coste, cantidad
FROM proveedores p, suministros s, componen c
WHERE p.codigo =s.codigo_proveedor
AND c.codigo_suministro = s.codigo
AND  pais = 'España' ;

-- 2. Actualización de vistas con varias tablas. Oracle

CREATE VIEW suministros_proveedores AS
SELECT nombre, fecha, codigo_producto, precio_coste, cantidad
FROM proveedores p, suministros s, componen c
WHERE p.codigo =s.codigo_proveedor
AND c.codigo_suministro = s.codigo
AND  pais = 'España' 
AND fecha >= DATE '2022-01-15' ;

SELECT * FROM suministros_proveedores ;

UPDATE suministros_proveedores
SET cantidad = cantidad + 2
WHERE nombre = 'Frutería Paqui';

UPDATE suministros_proveedores
SET fecha = DATE '2022-01-10'
WHERE nombre = 'Fruteria Paqui';

SELECT * FROM suministros_proveedores ;

SELECT nombre, fecha, codigo_producto, precio_coste, cantidad
FROM proveedores p, suministros s, componen c
WHERE p.codigo =s.codigo_proveedor
AND c.codigo_suministro = s.codigo
AND  pais = 'España' ;

-- 3. Controlar valores fuera del rango en actualizaciones sobre la vista.  MYSQL

CREATE OR REPLACE VIEW suministros_proveedores AS
SELECT nombre, fecha, codigo_producto, precio_coste, cantidad
FROM proveedores p, suministros s, componen c
WHERE p.codigo =s.codigo_proveedor
AND c.codigo_suministro = s.codigo
AND  pais = 'España' 
AND fecha >= '2022-01-15' 
WITH CHECK OPTION;

SELECT * FROM suministros_proveedores ;

UPDATE suministros_proveedores
SET fecha = '2022-01-10'
WHERE nombre = 'Antonio Sánchez e Hijos, s.l.';

UPDATE suministros_proveedores
SET fecha = '2022-01-16'
WHERE nombre = 'Antonio Sánchez e Hijos, s.l.';


-- 3.Controlar valores fuera del rango en actualizaciones sobre la vista.  ORACLE

CREATE OR REPLACE VIEW suministros_proveedores AS
SELECT nombre, fecha
FROM proveedores p, suministros s
WHERE p.codigo =s.codigo_proveedor
AND  pais = 'España' 
WITH CHECK OPTION;

SELECT * FROM suministros_proveedores ;

UPDATE suministros_proveedores
SET fecha = DATE '2022-01-10'
WHERE nombre = 'Antonio Sánchez e Hijos, s.l.';

UPDATE suministros_proveedores
SET fecha = DATE '2022-01-16'
WHERE nombre = 'Antonio Sánchez e Hijos, s.l.';


-- 4. Inserciones en vistas formadas por varias tablas. MYSQL
CREATE OR REPLACE VIEW ventas AS
SELECT DISTINCT nombre, apellido1, apellido2, email, tlf 
FROM pedidos p, clientes c 
WHERE p.dni = c.dni;

INSERT INTO ventas VALUES ('Juan', 'Moreno', 'Cruz', 'jcruz@blabla.com','654444333');

CREATE OR REPLACE VIEW ventas AS
SELECT  c.*
FROM pedidos p, clientes c 
WHERE p.dni = c.dni;

INSERT INTO ventas (dni, nombre, apellido1, apellido2, direccion, localidad, provincia, pais, codigo_postal, email, tlf)
VALUES ('10000011','Fernando','Colgado','Ruiz','Av/ Matarife, 9','Armilla','Granada','España','18100','crf0003@mixmail.com','719345234');

SELECT * from clientes;

SELECT * from ventas;

-- 4. Inserciones en vistas formadas por varias tablas. ORACLE
CREATE OR REPLACE VIEW ventas AS
SELECT DISTINCT nombre, apellido1, apellido2, email, tlf 
FROM pedidos p, clientes c 
WHERE p.dni = c.dni;

INSERT INTO ventas VALUES ('Juan', 'Moreno', 'Cruz', 'jcruz@blabla.com','654444333');

CREATE OR REPLACE VIEW ventas AS
SELECT  c.*
FROM pedidos p, clientes c 
WHERE p.dni = c.dni;

INSERT INTO ventas (dni, nombre, apellido1, apellido2, direccion, localidad, provincia, pais, codigo_postal, email, tlf)
VALUES ('10000011','Fernando','Colgado','Ruiz','Av/ Matarife, 9','Armilla','Granada','España','18100','crf0003@mixmail.com','719345234');

SELECT * from clientes;

SELECT * from ventas;


CREATE OR REPLACE VIEW ventas AS
SELECT  c.*
FROM clientes c 
WHERE dni IN (SELECT dni from pedidos);

SELECT * from clientes;


-- 5. Inserciones en vistas con control de valores. MySQL
CREATE OR REPLACE VIEW ventas_visa AS 
SELECT p.*
FROM pedidos p
WHERE forma_pago LIKE 'Visa' 
WITH CHECK OPTION;

INSERT INTO ventas_visa (codigo, fecha_pedido, tasas, direccion, localidad, provincia, pais, codigo_postal, umtx, umty, forma_pago, urgente, dni)
VALUES (7,'2022-01-07','10','C/Carreta 23, 4º-2','Dos Hermanas','Sevilla','España','41702',null,null,'Visa',0,'10000011');

SELECT * from ventas_visa;

INSERT INTO ventas_visa (codigo, fecha_pedido, tasas, direccion, localidad, provincia, pais, codigo_postal, umtx, umty, forma_pago, urgente, dni)
VALUES (8,'2022-01-07','10','C/Jaén 2, 1º-2','Sevilla','Sevilla','España','41002',null,null,'Efectivo',0,'10000004');

-- 5. Inserciones en vistas con control de valores.  ORACLE

CREATE OR REPLACE VIEW ventas_visa AS 
SELECT p.*
FROM pedidos p
WHERE forma_pago LIKE 'Visa' 
WITH CHECK OPTION;

INSERT INTO ventas_visa (codigo, fecha_pedido, tasas, direccion, localidad, provincia, pais, codigo_postal, umtx, umty, forma_pago, urgente, dni)
VALUES (7, DATE '2022-01-07','10','C/Carreta 23, 4º-2','Dos Hermanas','Sevilla','España','41702',null,null,'Visa',0,'10000002');

SELECT * from ventas_visa;

INSERT INTO ventas_visa (codigo, fecha_pedido, tasas, direccion, localidad, provincia, pais, codigo_postal, umtx, umty, forma_pago, urgente, dni)
VALUES (8,DATE '2022-01-07','10','C/Jaén 2, 1º-2','Sevilla','Sevilla','España','41002',null,null,'Efectivo',0,'10000002');


-- 6. Eliminación de filas.  MySQL y ORACLE

DELETE FROM ventas_visa
WHERE codigo = 7;

DELETE FROM ventas_visa;

DELETE FROM ventas
WHERE dni = '10000011';


-- 7. Consultas al diccionario de datos. MySQL
SELECT IS_UPDATABLE
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_NAME = 'ventas';

-- 7. Consultas al diccionario de datos. Oracle
SELECT IS_UPDATABLE
FROM USER.UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'ventas';

-- ----

SELECT * FROM productos;

CREATE VIEW frutas AS
SELECT codigo, nombre, precio, unidad
FROM productos
WHERE tipo = 'fruta';

SELECT * FROM frutas;


CREATE VIEW productos_sp AS
SELECT codigo, nombre, precio, unidad
FROM productos
WHERE paisorigen = 'España';

SELECT * FROM productos_sp;

CREATE OR REPLACE VIEW max_precio_fruta AS
SELECT MAX(precio) AS preci 
FROM productos;

SELECT * FROM max_precio_fruta;

CREATE OR REPLACE VIEW frutas_mas_caras_sp AS
SELECT f.*
FROM frutas f, productos_sp p
WHERE f.codigo = p.codigo 
AND f.precio >= (SELECT preci/2 FROM precio_caro);

SELECT * FROM frutas_mas_caros;
