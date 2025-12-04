-- 5. Consultar configuración del SGBD
-- Muestra bases de datos del sistema
SHOW DATABASES;
-- Visualiza cuál es la BD activa
SELECT DATABASE();
-- Crea una nueva base de datos
CREATE DATABASE fruteria;
-- Activa una base de datos
USE fruteria;
-- SENTENCIAS DD
-- 6. Creación de tablas
-- Creación de una tabla sencilla
CREATE TABLE productos_1(
	codigo INT,
	nombre VARCHAR(100),
	descripcion TEXT,
	foto VARCHAR(256)
);
-- Restricciones de clave principal
-- Ejemplo_1
CREATE TABLE productos_2 (
	codigo INT PRIMARY KEY,
	nombre VARCHAR(100),
	descripcion TEXT
);
-- Ejemplo_2
CREATE TABLE incluyen_1 (
	codigo_pedido INT, 
      codigo_producto INT, 
    	cantidad FLOAT,
	PRIMARY KEY (codigo_pedido, codigo_producto)
);
-- Restricciones de valor único
-- Ejemplo_1
CREATE TABLE proveedores_1(
	codigo INT PRIMARY KEY, 
	nombre VARCHAR(100),
	email VARCHAR (50) UNIQUE,
	tlf VARCHAR (9) UNIQUE
);
-- Ejemplo_2
CREATE TABLE proveedores_2(
	codigo INT PRIMARY KEY, 
	nombre VARCHAR(100),
	localidad VARCHAR(100),
	provincia VARCHAR(100),
	pais VARCHAR (50),
	UNIQUE (localidad, provincia, pais)
);
-- Restricción de valores requeridos
CREATE TABLE proveedores_3(
	codigo INT PRIMARY KEY, 
	nombre VARCHAR(100) NOT NULL,
	email VARCHAR (50) NOT NULL UNIQUE
);		
-- Restricción de valores por defecto
CREATE TABLE productos_3(
	codigo INT PRIMARY KEY, 
	nombre VARCHAR(100) NOT NULL,
	precio FLOAT DEFAULT 0.0,
	unidad VARCHAR(5) DEFAULT 'kg',
	paisorigen VARCHAR(50) DEFAULT 'España' NOT NULL
);
-- Restriccion de valores de dominio
-- Ejemplo_1
CREATE TABLE productos_4(
	codigo INT PRIMARY KEY, 
	nombre VARCHAR(100) NOT NULL,
	precio FLOAT CHECK (precio >=0),
	unidad VARCHAR(5) CHECK (unidad IN ('kg', 'g', 'mg', 'otros'))
);
-- Ejemplo_2
CREATE TABLE productos_5(
	codigo INT PRIMARY KEY, 
	nombre VARCHAR(100) NOT NULL,
	precio FLOAT,
	unidad VARCHAR(5),
	CHECK (precio >=0),
 	CHECK (unidad IN ('kg', 'g', 'mg', 'otros'))
);
-- Restricción de clave ajena
-- Ejemplo_1
CREATE TABLE suministros_1(
	codigo INT PRIMARY KEY, 
	fecha DATE NOT NULL,
cantidad FLOAT NOT NULL,
codigo_proveedor INT REFERENCES proveedores (codigo)
);
-- Ejemplo_2
CREATE TABLE suministros_2(
	codigo INT PRIMARY KEY, 
	fecha DATE NOT NULL,
cantidad FLOAT NOT NULL,
codigo_proveedor INT, 
FOREIGN KEY (codigo_proveedor) REFERENCES proveedores (codigo)
	);
-- Ejemplo_3
CREATE TABLE suministros_3(
	codigo INT PRIMARY KEY, 
	fecha DATE NOT NULL,
cantidad FLOAT NOT NULL,
codigo_proveedor INT, 
FOREIGN KEY (codigo_proveedor) REFERENCES proveedores (codigo)  ON UPDATE CASCADE ON DELETE SET NULL
	);
-- Columnas virtuales
CREATE TABLE productos_6(
	codigo INT PRIMARY KEY, 
	nombre VARCHAR(100) NOT NULL,
	precio FLOAT,
	pvp 	 FLOAT AS (precio * (1+0.21)),
	CHECK (precio >=0)
);
-- Campo autoincrementado
CREATE TABLE productos_red (
	codigo INT PRIMARY KEY AUTO_INCREMENT, 
	nombre VARCHAR(100) NOT NULL,
	precio FLOAT
);
-- Conocer la estructura de la BD
-- Mostrar tablas
SHOW TABLES; 
-- Ver la estructura de una tabla
DESCRIBE productos;
-- Equivalente a 
SHOW COLUMNS FROM productos;
-- Generar el comando create table
SHOW CREATE TABLE productos;

-- Actualización de tablas
-- Añadir columnas o restricciones
-- Ejemplo_1:
ALTER TABLE productos_1 ADD (tipo VARCHAR(20) NOT NULL);
-- Ejemplo_2:
ALTER TABLE productos_1 ADD (CHECK (tipo IN ('fruta', 'verdura', 'hortalizas', 'tubérculos', 'otros')));
-- Ejemplo_3
ALTER TABLE productos_2 ADD (tipo VARCHAR(20) NOT NULL);
ALTER TABLE productos_2 ADD CONSTRAINT ck_productos2_tipo CHECK (tipo IN ('fruta', 'verdura', 'hortalizas', 'tubérculos', 'otros'));
-- Eliminar columnas o restricciones
-- Ejemplo_1
ALTER TABLE productos_1 DROP COLUMN tipo;
-- Ejemplo_2
ALTER TABLE productos_2 DROP CHECK ck_productos2_tipo;
-- Modificar atributos
ALTER TABLE productos_1 MODIFY nombre VARCHAR(50) NOT NULL;
-- Renombrar tabla
ALTER TABLE productos_1 RENAME TO inventario;
-- Renombrar columna
ALTER TABLE productos_2 RENAME COLUMN tipo TO clase;
-- Eliminación de tablas
DROP TABLE inventario;


