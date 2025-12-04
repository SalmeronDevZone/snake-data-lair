CREATE DATABASE fruteria; 
USE fruteria;
DROP TABLE componen;
DROP TABLE incluyen;
DROP TABLE suministros;
DROP TABLE proveedores;
DROP TABLE productos;
DROP TABLE pedidos;
DROP TABLE clientes;
CREATE TABLE clientes (
	dni VARCHAR(9) PRIMARY KEY, 
	nombre VARCHAR(100) NOT NULL,
	apellido1 VARCHAR(100) NOT NULL,
	apellido2 VARCHAR(100),
	direccion VARCHAR(200),
	localidad VARCHAR(100),
	provincia VARCHAR(100),
	pais VARCHAR (50) DEFAULT 'España',
	codigo_postal VARCHAR (6),
	email VARCHAR (50),
	tlf VARCHAR (9) NOT NULL );
CREATE TABLE pedidos (
	codigo INT PRIMARY KEY,
	fecha_pedido DATE NOT NULL,
	tasas FLOAT,
	direccion VARCHAR(200),
	localidad VARCHAR(100),
	provincia VARCHAR(100),
	pais VARCHAR (50),
    codigo_postal VARCHAR(6),
    umtx INT, 
    umty INT, 
    forma_pago VARCHAR(10),
    urgente BOOLEAN DEFAULT FALSE,
    dni VARCHAR(9),
	CONSTRAINT ck_pedidos_fecha_pedido CHECK (fecha_pedido >'2021-01-01'),
	CONSTRAINT ck_pedidos_tasas CHECK (tasas >=0),
    CONSTRAINT ck_pedidos_forma_pago CHECK (forma_pago IN ('Visa', 'PayPal', 'Efectivo', 'Bizum', 'Otros')),
    CONSTRAINT fk_pedidos_dni FOREIGN KEY (dni) REFERENCES clientes (dni)  ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE TABLE productos (
	codigo INT PRIMARY KEY, 
	nombre VARCHAR(100) NOT NULL,
	descripcion TEXT,
	foto VARCHAR(256),
	precio FLOAT,
	unidad VARCHAR(5) DEFAULT 'kg',
	ciudadorigen VARCHAR(100),
	paisorigen VARCHAR(50) NOT NULL DEFAULT 'España',
	tipo VARCHAR(20) NOT NULL,
	CONSTRAINT ck_productos_precio CHECK (precio >=0),
    CONSTRAINT ck_productos_unidad CHECK (unidad IN ('kg', 'g', 'mg', 'lb', 'oz', 'otros')),
    CONSTRAINT ck_productos_tipo CHECK (tipo IN ('fruta', 'verdura', 'semillas', 'hortalizas', 'tubérculos', 'especias', 'legumbre', 'frutos_secos', 'fruta_deshidratada', 'otros'))
);
CREATE TABLE proveedores(
	codigo INT PRIMARY KEY, 
	nombre VARCHAR(100) NOT NULL,
	contacto VARCHAR(200),
	url VARCHAR(255),
	localidad VARCHAR(100),
	provincia VARCHAR(100),
	pais VARCHAR (50) DEFAULT 'España',
	codigo_postal VARCHAR (6),
	email VARCHAR (50),
	tlf VARCHAR (9)  
);
CREATE TABLE suministros (
	codigo INT PRIMARY KEY, 
	fecha DATE NOT NULL,
    	codigo_proveedor INT,
	CONSTRAINT ck_suministros_fecha CHECK (fecha >'2021-01-01'),
    CONSTRAINT fk_suministros_codigo_proveedor FOREIGN KEY (codigo_proveedor) REFERENCES proveedores (codigo)  ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE TABLE incluyen (
	codigo_pedido INT, 
    codigo_producto INT, 
    cantidad FLOAT NOT NULL,
    descuento FLOAT DEFAULT 0, 
	CONSTRAINT pk_incluyen PRIMARY KEY (codigo_pedido, codigo_producto),
    CONSTRAINT ck_incluyen_cantidad CHECK (cantidad >=0),
	CONSTRAINT ck_incluyen_descuento CHECK (descuento >=0),
    CONSTRAINT fk_incluyen_codigo_pedido FOREIGN KEY (codigo_pedido) REFERENCES pedidos (codigo)  ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_incluyen_codigo_producto FOREIGN KEY (codigo_producto) REFERENCES productos (codigo)  ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE componen (
	codigo_suministro INT, 
    codigo_producto INT, 
    precio_coste FLOAT, 
    cantidad FLOAT NOT NULL,
	CONSTRAINT pk_componen PRIMARY KEY (codigo_suministro, codigo_producto),
    CONSTRAINT ck_componen_precio_coste CHECK (precio_coste >=0),
    CONSTRAINT ck_componen_cantidad CHECK (cantidad >=0),
    CONSTRAINT fk_componen_codigo_suministro FOREIGN KEY (codigo_suministro) REFERENCES suministros (codigo)  ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_componen_codigo_producto FOREIGN KEY (codigo_producto) REFERENCES productos (codigo)  ON UPDATE CASCADE ON DELETE CASCADE
);