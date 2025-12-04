DROP TABLE componen;
DROP TABLE incluyen;
DROP TABLE suministros;
DROP TABLE proveedores;
DROP TABLE productos;
DROP TABLE pedidos;
DROP TABLE clientes;
CREATE TABLE clientes (
	dni TEXT PRIMARY KEY, 
	nombre TEXT NOT NULL,
	apellido1 TEXT NOT NULL,
	apellido2 TEXT,
	direccion TEXT,
	localidad TEXT,
	provincia TEXT,
	pais TEXT DEFAULT 'España',
	codigo_postal TEXT,
	email TEXT,
	tlf TEXT NOT NULL );
CREATE TABLE pedidos (
	codigo INTEGER PRIMARY KEY,
	fecha_pedido TEXT NOT NULL,
	tasas REAL,
	direccion TEXT,
	localidad TEXT,
	provincia TEXT,
	pais TEXT,
    codigo_postal TEXT,
    umtx INTEGER, 
    umty INTEGER, 
    forma_pago TEXT,
    urgente INTEGER DEFAULT 0,
    dni TEXT,
	CONSTRAINT ck_pedidos_fecha_pedido CHECK (fecha_pedido >'2021-01-01'),
	CONSTRAINT ck_pedidos_tasas CHECK (tasas >=0),
    CONSTRAINT ck_pedidos_forma_pago CHECK (forma_pago IN ('Visa', 'PayPal', 'Efectivo', 'Bizum', 'Otros')),
    CONSTRAINT fk_pedidos_dni FOREIGN KEY (dni) REFERENCES clientes (dni)  ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE TABLE productos (
	codigo INTEGER PRIMARY KEY, 
	nombre TEXT NOT NULL,
	descripcion TEXT,
	foto TEXT,
	precio REAL,
	unidad TEXT DEFAULT 'kg',
	ciudadorigen TEXT,
	paisorigen TEXT NOT NULL DEFAULT 'España',
	tipo TEXT NOT NULL,
	CONSTRAINT ck_productos_precio CHECK (precio >=0),
    CONSTRAINT ck_productos_unidad CHECK (unidad IN ('kg', 'g', 'mg', 'lb', 'oz', 'otros')),
    CONSTRAINT ck_productos_tipo CHECK (tipo IN ('fruta', 'verdura', 'semillas', 'hortalizas', 'tubérculos', 'especias', 'legumbre', 'frutos_secos', 'fruta_deshidratada', 'otros'))
);
CREATE TABLE proveedores(
	codigo INT PRIMARY KEY, 
	nombre TEXT NOT NULL,
	contacto TEXT,
	url TEXT,
	localidad TEXT,
	provincia TEXT,
	pais TEXT DEFAULT 'España',
	codigo_postal TEXT,
	email TEXT,
	tlf TEXT  
);
CREATE TABLE suministros (
	codigo INTEGER PRIMARY KEY, 
	fecha TEXT NOT NULL,
    codigo_proveedor INTEGER,
	CONSTRAINT ck_suministros_fecha CHECK (fecha >'2021-01-01'),
    CONSTRAINT fk_suministros_codigo_proveedor FOREIGN KEY (codigo_proveedor) REFERENCES proveedores (codigo)  ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE TABLE incluyen (
	codigo_pedido INTEGER, 
    codigo_producto INTEGER, 
    cantidad REAL NOT NULL,
    descuento REAL DEFAULT 0, 
	CONSTRAINT pk_incluyen PRIMARY KEY (codigo_pedido, codigo_producto),
    CONSTRAINT ck_incluyen_cantidad CHECK (cantidad >=0),
	CONSTRAINT ck_incluyen_descuento CHECK (descuento >=0),
    CONSTRAINT fk_incluyen_codigo_pedido FOREIGN KEY (codigo_pedido) REFERENCES pedidos (codigo)  ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_incluyen_codigo_producto FOREIGN KEY (codigo_producto) REFERENCES productos (codigo)  ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE componen (
	codigo_suministro INTEGER, 
    codigo_producto INTEGER, 
    precio_coste REAL, 
    cantidad REAL NOT NULL,
	CONSTRAINT pk_componen PRIMARY KEY (codigo_suministro, codigo_producto),
    CONSTRAINT ck_componen_precio_coste CHECK (precio_coste >=0),
	CONSTRAINT ck_componen_cantidad CHECK (cantidad >=0),
     CONSTRAINT fk_componen_codigo_suministro FOREIGN KEY (codigo_suministro) REFERENCES suministros (codigo)  ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_componen_codigo_producto FOREIGN KEY (codigo_producto) REFERENCES productos (codigo)  ON UPDATE CASCADE ON DELETE CASCADE
);