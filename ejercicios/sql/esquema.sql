-- Esquema de los ejercicios: una tienda online pequeña (SQLite).
-- Lo crea comprobar.py en una base de datos en memoria; no hace falta instalar nada.

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre     TEXT NOT NULL,
    email      TEXT,
    ciudad     TEXT NOT NULL,
    fecha_alta TEXT NOT NULL
);

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre      TEXT NOT NULL,
    categoria   TEXT NOT NULL,
    precio      NUMERIC NOT NULL
);

CREATE TABLE pedidos (
    id_pedido  INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    fecha      TEXT NOT NULL,
    estado     TEXT NOT NULL            -- entregado | cancelado | pendiente
);

-- Sin claves foráneas a propósito: así pueden colarse errores de calidad (ejercicio 10).
CREATE TABLE lineas_pedido (
    id_pedido       INTEGER NOT NULL,
    num_linea       INTEGER NOT NULL,
    id_producto     INTEGER NOT NULL,
    cantidad        INTEGER NOT NULL,
    precio_unitario NUMERIC NOT NULL,
    PRIMARY KEY (id_pedido, num_linea)
);

-- Lo que deja un proceso de carga que se ejecuta varias veces al día: versiones repetidas (ejercicio 6).
CREATE TABLE pedidos_raw (
    id_pedido  INTEGER NOT NULL,
    estado     TEXT NOT NULL,
    importe    NUMERIC NOT NULL,
    cargado_en TEXT NOT NULL
);

-- Clics en la web (ejercicio 8).
CREATE TABLE eventos_web (
    id_evento  INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    momento    TEXT NOT NULL,           -- 'YYYY-MM-DD HH:MM:SS'
    tipo       TEXT NOT NULL
);

-- Extracción nueva de clientes que hay que integrar (ejercicios 11 y 12).
CREATE TABLE staging_clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre     TEXT NOT NULL,
    email      TEXT,
    ciudad     TEXT NOT NULL,
    fecha_alta TEXT NOT NULL
);

-- Dimensión de clientes con historial (SCD tipo 2, ejercicio 12).
CREATE TABLE dim_cliente_scd2 (
    clave_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    ciudad        TEXT NOT NULL,
    valido_desde  TEXT NOT NULL,
    valido_hasta  TEXT,                 -- NULL = versión vigente
    es_actual     INTEGER NOT NULL
);

-- Organigrama (ejercicio 13).
CREATE TABLE empleados (
    id_empleado  INTEGER PRIMARY KEY,
    nombre       TEXT NOT NULL,
    id_jefe      INTEGER,
    departamento TEXT NOT NULL
);

-- ---------------------------------------------------------------- segunda tanda (ejercicios 14-26)

-- Tickets de un supermercado: un producto por fila (ejercicio 17).
CREATE TABLE tickets (
    id_ticket INTEGER NOT NULL,
    producto  TEXT NOT NULL,
    PRIMARY KEY (id_ticket, producto)
);

-- Ventas en formato ancho, como llegan de una hoja de cálculo (ejercicio 21).
CREATE TABLE ventas_ancho (
    tienda TEXT PRIMARY KEY,
    ene    NUMERIC,
    feb    NUMERIC,
    mar    NUMERIC
);

-- Dos sistemas que deberían cuadrar (ejercicio 22).
CREATE TABLE facturas_erp (
    id_factura TEXT PRIMARY KEY,
    importe    NUMERIC NOT NULL
);

CREATE TABLE cobros_banco (
    id_factura TEXT PRIMARY KEY,
    importe    NUMERIC NOT NULL
);

-- Eventos tal cual los manda una API, en JSON (ejercicio 23).
CREATE TABLE eventos_json (
    id          INTEGER PRIMARY KEY,
    recibido_en TEXT NOT NULL,
    payload     TEXT NOT NULL
);

-- Entradas (+) y salidas (-) de almacén (ejercicio 24).
CREATE TABLE movimientos_stock (
    id_movimiento INTEGER PRIMARY KEY,
    id_producto   INTEGER NOT NULL,
    fecha         TEXT NOT NULL,
    cantidad      INTEGER NOT NULL
);

-- Copia de productos en otro sistema, y los cambios capturados del origen en orden (CDC, ejercicio 25).
CREATE TABLE productos_replica (
    id_producto INTEGER PRIMARY KEY,
    nombre      TEXT NOT NULL,
    categoria   TEXT NOT NULL,
    precio      NUMERIC NOT NULL
);

CREATE TABLE cambios_productos (
    secuencia   INTEGER PRIMARY KEY,
    operacion   TEXT NOT NULL CHECK (operacion IN ('I', 'U', 'D')),
    id_producto INTEGER NOT NULL,
    nombre      TEXT,                   -- en 'U' viene la fila completa tras el cambio; en 'D', vacía
    categoria   TEXT,
    precio      NUMERIC
);

-- Precios: sólo se publica una fila cuando el precio cambia (ejercicio 26).
CREATE TABLE precios (
    id_producto INTEGER NOT NULL,
    fecha       TEXT NOT NULL,
    precio      NUMERIC NOT NULL,
    PRIMARY KEY (id_producto, fecha)
);
