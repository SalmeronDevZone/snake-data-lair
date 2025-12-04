-- 5. Consultar configuración del SGBD
-- Devuelve nombre de la base de datos con privilegios DBA
SELECT NAME FROM v$database; 
-- Devuelve nombre de la base de datos sobre la que se está trabajando
SELECT * FROM global_name;
-- Devuelve los esquemas/usuarios disponibles en la base de datos
SELECT * FROM sys.all_users; 
-- Devuelve los esquemas disponibles con privilegios DBA 
SELECT * FROM dba_users;
-- Devuelve los espacios de tablas definidos para la base de datos
SELECT * FROM dba_users;
-- Devuelve el esquema al que estamos conectados
SELECT sys_context( 'userenv', 'current_schema' ) FROM dual;
-- SENTENCIAS DDL
-- 6. Creación de tablas
-- Creación de una tabla sencilla
CREATE TABLE productos_1(
	codigo NUMBER,
	nombre VARCHAR2(100),
	descripcion VARCHAR2(256),
	foto VARCHAR(256)
);
-- Restricciones de clave principal
-- Ejemplo_1
CREATE TABLE productos_2 (
	codigo NUMBER PRIMARY KEY,
	nombre VARCHAR2(100),
	descripcion VARCHAR2(256)
);
-- Ejemplo_2
CREATE TABLE incluyen_1 (
	codigo_pedido NUMBER, 
        codigo_producto NUMBER, 
    	cantidad NUMBER(7,2),
	PRIMARY KEY (codigo_pedido, codigo_producto)
);
-- Restricciones de valor único
-- Ejemplo_1
CREATE TABLE proveedores_1(
	codigo NUMBER PRIMARY KEY, 
	nombre VARCHAR2(100),
	email VARCHAR2 (50) UNIQUE,
	tlf VARCHAR2(9) UNIQUE
);
-- Ejemplo_2
CREATE TABLE proveedores_2(
	codigo NUMBER PRIMARY KEY, 
	nombre VARCHAR2(100),
	localidad VARCHAR2(100),
	provincia VARCHAR2(100),
	pais VARCHAR2(50),
	UNIQUE (localidad, provincia, pais)
);
-- Restricción de valores requeridos
CREATE TABLE proveedores_3(
	codigo NUMBER PRIMARY KEY, 
	nombre VARCHAR2(100) NOT NULL,
	email VARCHAR2(50) NOT NULL UNIQUE
);	
-- Restricción de valores por defecto
CREATE TABLE productos_3(
	codigo NUMBER PRIMARY KEY, 
	nombre VARCHAR2(100) NOT NULL,
	precio NUMBER(7,2) DEFAULT 0.0,
	unidad VARCHAR2(5) DEFAULT 'kg',
	paisorigen VARCHAR2(50) DEFAULT 'España' NOT NULL 
);
-- Restriccion de valores de dominio
-- Ejemplo_1
CREATE TABLE productos_4(
	codigo NUMBER PRIMARY KEY, 
	nombre VARCHAR2(100) NOT NULL,
	precio NUMBER(7,2) CHECK (precio >=0),
	unidad VARCHAR2(5) CHECK (unidad IN ('kg', 'g', 'mg', 'otros'))
);
-- Ejemplo_2
CREATE TABLE productos_5(
	codigo NUMBER PRIMARY KEY, 
	nombre VARCHAR2(100) NOT NULL,
	precio NUMBER(7,2),
	unidad VARCHAR2(5),
	CHECK (precio >=0),
 	CHECK (unidad IN ('kg', 'g', 'mg', 'otros'))
);
-- Restricción de clave ajena
-- Ejemplo_1
CREATE TABLE suministros_1(
	codigo NUMBER PRIMARY KEY, 
	fecha DATE NOT NULL,
	codigo_proveedor NUMBER REFERENCES proveedores (codigo)
);
-- Ejemplo_2
CREATE TABLE suministros_2(
	codigo NUMBER PRIMARY KEY, 
	fecha DATE NOT NULL,
	codigo_proveedor NUMBER, 
	FOREIGN KEY (codigo_proveedor) REFERENCES proveedores (codigo)
	);
-- Ejemplo_3
CREATE TABLE suministros_3(
	codigo NUMBER PRIMARY KEY, 
	fecha DATE NOT NULL,
	codigo_proveedor NUMBER, 
	FOREIGN KEY (codigo_proveedor) REFERENCES proveedores (codigo)  ON DELETE SET NULL
	);
-- Columnas virtuales
CREATE TABLE productos_6(
	codigo NUMBER PRIMARY KEY, 
	nombre VARCHAR2(100) NOT NULL,
	precio NUMBER(7,2),
	pvp 	 NUMBER(7,2) AS (precio * (1+0.21)),
	CHECK (precio >=0)
);
-- Campo autoincrementado
CREATE TABLE productos_red (
	codigo NUMBER GENERATED ALWAYS AS IDENTITY, 
	nombre VARCHAR2(100) NOT NULL,
	precio NUMBER(7,2)
);
-- Conocer la estructura de la BD
-- Mostrar tablas
SELECT table_name FROM user_tables;
-- Mostrar tablas con acceso
SELECT table_name FROM all_tables;
-- Listado de todas las tablas (solo con permisos DBA)
SELECT table_name  FROM dba_tables;
-- Ver la estructura de una tabla
DESCRIBE productos;
INFO productos;
-- Actualización de tablas
-- Añadir columnas o restricciones
-- Ejemplo_1
ALTER TABLE productos_1 ADD (tipo VARCHAR2(20) NOT NULL);
-- Ejemplo_2
ALTER TABLE productos_1 ADD (CHECK (tipo IN ('fruta', 'verdura', 'hortalizas', 'tubérculos', 'otros')));
-- Ejemplo_3
ALTER TABLE productos_2 ADD (tipo VARCHAR2(20) NOT NULL);
ALTER TABLE productos_2 ADD CONSTRAINT ck_productos2_tipo CHECK (tipo IN ('fruta', 'verdura', 'hortalizas', 'tubérculos', 'otros'));
-- Eliminar columnas o restricciones
-- Ejemplo_1
ALTER TABLE productos_1 DROP COLUMN tipo;
-- Ejemplo_2
ALTER TABLE productos_2 DROP CONSTRAINT ck_productos2_tipo;
-- Modificar atributos
ALTER TABLE productos_1 MODIFY nombre VARCHAR2(50) NOT NULL;
-- Renombrar tabla
ALTER TABLE productos_1 RENAME TO inventario;
-- Renombrar columna
ALTER TABLE productos_2 RENAME COLUMN tipo TO clase;
-- Eliminación de tablas
DROP TABLE inventario;


