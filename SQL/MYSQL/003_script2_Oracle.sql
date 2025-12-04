-- CREATE DATABASE fruteria; 
-- USE fruteria;
-- borrado de tablas para reiniciar la base de datos
DROP TABLE incluyen;
DROP TABLE componen;
DROP TABLE pedidos;
DROP TABLE suministros;
DROP TABLE clientes;
DROP TABLE productos;
DROP TABLE proveedores;

CREATE TABLE clientes (
	dni VARCHAR2(9) CONSTRAINT pk_clientes PRIMARY KEY, 
	nombre VARCHAR2(100) CONSTRAINT nn_clientes_nombre NOT NULL,
	apellido1 VARCHAR2(100) CONSTRAINT nn_clientes_apellido1 NOT NULL,
	apellido2 VARCHAR2(100),
	direccion VARCHAR2(200),
	localidad VARCHAR2(100),
	provincia VARCHAR2(100),
	pais VARCHAR2(50) DEFAULT 'España',
	codigo_postal VARCHAR2(6),
	email VARCHAR2(50),
	tlf VARCHAR2(9) CONSTRAINT nn_clientes_tlf NOT NULL 
);
    
CREATE TABLE pedidos (
	codigo NUMBER CONSTRAINT pk_pedidos PRIMARY KEY,
	fecha_pedido DATE CONSTRAINT nn_pedidos_fecha_pedido NOT NULL,
	tasas NUMBER(5,2),
	direccion VARCHAR2(200),
	localidad VARCHAR2(100),
	provincia VARCHAR2(100),
	pais VARCHAR2(50),
  codigo_postal VARCHAR2(6),
  umtx NUMBER, 
  umty NUMBER, 
  forma_pago VARCHAR2(10),
  urgente NUMBER(1) DEFAULT 0,
  dni VARCHAR(9),
	CONSTRAINT ck_pedidos_fecha_pedido CHECK (fecha_pedido > DATE '2021-01-01'),
	CONSTRAINT ck_pedidos_tasas CHECK (tasas >=0),
  CONSTRAINT ck_pedidos_forma_pago CHECK (forma_pago IN ('Visa', 'PayPal', 'Efectivo', 'Bizum', 'Otros')),
  CONSTRAINT fk_pedidos_dni FOREIGN KEY (dni) REFERENCES clientes (dni) ON DELETE SET NULL
);

CREATE TABLE productos (
	codigo NUMBER CONSTRAINT pk_productos PRIMARY KEY, 
	nombre VARCHAR2(100) CONSTRAINT nn_productos_nombre NOT NULL,
	descripcion VARCHAR2(256),
	foto VARCHAR2(256),
	precio NUMBER(7,2),
	unidad VARCHAR2(5),
	ciudadorigen VARCHAR2(100),
	paisorigen VARCHAR2(50) DEFAULT 'España' CONSTRAINT nn_productos_paisorigen NOT NULL,
	tipo VARCHAR2(20) CONSTRAINT nn_productos_tipo NOT NULL,
	CONSTRAINT ck_productos_precio CHECK (precio >=0),
  CONSTRAINT ck_productos_unidad CHECK (unidad IN ('kg', 'g', 'mg', 'lb', 'oz', 'otros')),
  CONSTRAINT ck_productos_tipo CHECK (tipo IN ('fruta', 'verdura', 'semillas', 'hortalizas', 'tubérculos', 'especias', 'legumbre', 'frutos_secos', 'fruta_deshidratada', 'otros'))
);

CREATE TABLE proveedores(
	codigo NUMBER CONSTRAINT pk_proveedores PRIMARY KEY, 
	nombre VARCHAR2(100) CONSTRAINT nn_proveedores_nombre NOT NULL,
	contacto VARCHAR2(200),
	url VARCHAR2(255),
	localidad VARCHAR2(100),
	provincia VARCHAR2(100),
	pais VARCHAR2(50) DEFAULT 'España',
	codigo_postal VARCHAR2(6),
	email VARCHAR2(50),
	tlf VARCHAR2(9)    
);

CREATE TABLE suministros (
	codigo NUMBER CONSTRAINT pk_suministros PRIMARY KEY, 
	fecha DATE CONSTRAINT nn_suministros_fecha NOT NULL,
  codigo_proveedor NUMBER,
	CONSTRAINT ck_suministros_fecha CHECK (fecha > DATE '2021-01-01'),
    CONSTRAINT fk_suministros_cod_proveedor FOREIGN KEY (codigo_proveedor) REFERENCES proveedores (codigo) ON DELETE SET NULL
);

CREATE TABLE incluyen (
	codigo_pedido NUMBER, 
    codigo_producto NUMBER, 
    cantidad NUMBER(7,2) CONSTRAINT pk_incluyen_cantidad NOT NULL,
    descuento NUMBER(5,2) DEFAULT 0, 
	CONSTRAINT pk_incluyen PRIMARY KEY (codigo_pedido, codigo_producto),
    CONSTRAINT ck_incluyen_cantidad CHECK (cantidad >=0),
	CONSTRAINT ck_incluyen_descuento CHECK (descuento >=0),
    CONSTRAINT fk_incluyen_codigo_pedido FOREIGN KEY (codigo_pedido) REFERENCES pedidos (codigo) ON DELETE CASCADE,
    CONSTRAINT fk_incluyen_codigo_producto FOREIGN KEY (codigo_producto) REFERENCES productos (codigo) ON DELETE CASCADE
);

CREATE TABLE componen (
	codigo_suministro NUMBER, 
    codigo_producto NUMBER, 
    precio_coste NUMBER(7,2),
   cantidad NUMBER(7,2) CONSTRAINT nn_suministros_cantidad NOT NULL,
	CONSTRAINT pk_componen PRIMARY KEY (codigo_suministro, codigo_producto),
    CONSTRAINT ck_componen_precio_coste CHECK (precio_coste >=0),
	CONSTRAINT ck_componen_cantidad CHECK (cantidad >=0),
    CONSTRAINT fk_componen_codigo_suministro FOREIGN KEY (codigo_suministro) REFERENCES suministros (codigo) ON DELETE CASCADE,
    CONSTRAINT fk_componen_codigo_producto FOREIGN KEY (codigo_producto) REFERENCES productos (codigo) ON DELETE CASCADE
);
