-- 5. Consultar configuración del SGBD
-- Guardar el archivo que contendrá la BD
.save frutería.db;
-- Visualizar la base de datos actual
.databases
-- Incluir otra base de datos en la gestión
ATTACH DATABASE “test.db” AS dbtest;
-- SENTENCIAS DDL
-- 6. Creación de tablas
-- Creación de una tabla sencilla
CREATE TABLE productos_1(
	codigo INTEGER,
	nombre TEXT,
	descripcion TEXT,
	foto TEXT
);
-- Restricciones de clave principal
-- Ejemplo _1
CREATE TABLE productos_2 (
	codigo INTEGER PRIMARY KEY,
	nombre TEXT,
	descripcion TEXT
);
-- Ejemplo_2
CREATE TABLE incluyen_1 (
	codigo_pedido INTEGER, 
      codigo_producto INTEGER, 
    	cantidad REAL,
	PRIMARY KEY (codigo_pedido, codigo_producto)
);
-- Restricciones de valor único
-- Ejemplo_1
CREATE TABLE proveedores_1(
	codigo INTEGER PRIMARY KEY, 
	nombre TEXT,
	email TEXT UNIQUE,
	tlf TEXT UNIQUE
);
-- Ejemplo_2
CREATE TABLE proveedores_2(
	codigo INTEGER PRIMARY KEY, 
	nombre TEXT,
	localidad TEXT,
	provincia TEXT,
	pais TEXT,
	UNIQUE (localidad, provincia, pais)
);
-- Restricción de valores requeridos
CREATE TABLE proveedores_3(
	codigo INTEGER PRIMARY KEY, 
	nombre TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE
);	
-- Restricción de valores por defecto
CREATE TABLE productos_3(
	codigo INTEGER PRIMARY KEY, 
	nombre TEXT NOT NULL,
	precio REAL DEFAULT 0.0,
	unidad TEXT DEFAULT 'kg',
	paisorigen TEXT DEFAULT 'España' NOT NULL 
);
-- Restriccion de valores de dominio
-- Ejemplo_1
CREATE TABLE productos_4(
	codigo INTEGER PRIMARY KEY, 
	nombre TEXT NOT NULL,
	precio REAL CHECK (precio >=0),
	unidad TEXT CHECK (unidad IN ('kg', 'g', 'mg', 'otros'))
);
-- Ejemplo_2
CREATE TABLE productos_5(
	codigo INTEGER PRIMARY KEY, 
	nombre TEXT NOT NULL,
	precio REAL,
	unidad TEXT,
	CHECK (precio >=0),
 	CHECK (unidad IN ('kg', 'g', 'mg', 'otros'))
);
-- Restricción de clave ajena
-- Ejemplo_1
CREATE TABLE suministros_1(
	codigo INTEGER PRIMARY KEY, 
	fecha TEXT NOT NULL,
	codigo_proveedor INTEGER REFERENCES proveedores (codigo)
);
-- Ejemplo_2
CREATE TABLE suministros_2(
	codigo INTEGER PRIMARY KEY, 
	fecha TEXT NOT NULL,
	codigo_proveedor INTEGER, 
	FOREIGN KEY (codigo_proveedor) REFERENCES proveedores (codigo)
);
-- Ejemplo_3
CREATE TABLE suministros_3(
	codigo INTEGER PRIMARY KEY, 
	fecha TEXT NOT NULL,
	codigo_proveedor INTEGER, 
	FOREIGN KEY (codigo_proveedor) REFERENCES proveedores (codigo)  ON UPDATE CASCADE 	ON DELETE SET NULL
	);
-- Columnas virtuales
CREATE TABLE productos_6(
	codigo INTEGER PRIMARY KEY, 
	nombre TEXT NOT NULL,
	precio REAL,
	pvp REAL AS (precio*(1+0.21)),
	CHECK (precio >=0)
);
-- Campo autoincrementado
CREATE TABLE productos_red(
	codigo INTEGER PRIMARY KEY AUTOINCREMENT, 
	nombre TEXT NOT NULL,
	precio REAL
);
-- Conocer la estructura de la BD
-- Mostrar tablas
.tables
-- Mostrar tablas que comiencen por 'p'
.tables 'p%'
-- Ver la estructura de una tabla
.header on
.mode column
PRAGMA table_info(productos);
-- Generar el comando create table
.schema productos
-- Actualización de tablas
-- Añadir columnas o restricciones
-- Ejemplo_1:
ALTER TABLE productos_1 ADD tipo VARCHAR(20) DEFAULT 0 NOT NULL;
-- Ejemplo_2:
ALTER TABLE productos_2 ADD tipo CHECK (tipo IN ('fruta', 'verdura', 'hortalizas', 'tubérculos', 'otros')));
-- Eliminar atributos
ALTER TABLE productos_1 DROP COLUMN tipo;
-- Renombrar tabla
ALTER TABLE productos_1 RENAME TO inventario;
-- Renombrar columna
ALTER TABLE productos_2 RENAME COLUMN tipo TO clase;
-- Eliminación de tablas
DROP TABLE inventario;


