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
