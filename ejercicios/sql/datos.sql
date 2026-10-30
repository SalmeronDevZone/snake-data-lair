-- Datos de los ejercicios. Incluyen errores a propósito (cantidad 0, producto inexistente,
-- pedido sin líneas, email vacío y email duplicado) para el ejercicio de calidad de datos.

INSERT INTO clientes VALUES
    (1,  'Ana Torres',  'ana@ejemplo.com',    'Madrid',    '2024-01-10'),
    (2,  'Luis Pardo',  'luis@ejemplo.com',   'Sevilla',   '2024-02-05'),
    (3,  'Marta Gil',   'marta@ejemplo.com',  'Valencia',  '2024-02-20'),
    (4,  'Pedro Sanz',  'pedro@ejemplo.com',  'Madrid',    '2024-03-15'),
    (5,  'Carmen Ruiz', 'CARMEN@ejemplo.com', 'Bilbao',    '2024-04-01'),
    (6,  'Jorge Vega',  'jorge@ejemplo.com',  'Barcelona', '2024-04-18'),
    (7,  'Rosa León',   NULL,                 'Málaga',    '2024-05-02'),
    (8,  'Iván Mora',   'ivan@ejemplo.com',   'Zaragoza',  '2024-05-20'),
    (9,  'Carmen R.',   'carmen@ejemplo.com', 'Bilbao',    '2024-06-11'),
    (10, 'Sofía Díaz',  'sofia@ejemplo.com',  'Granada',   '2024-06-30');

INSERT INTO productos VALUES
    (1, 'Teclado',     'Periféricos',    50),
    (2, 'Ratón',       'Periféricos',    20),
    (3, 'Monitor',     'Monitores',      200),
    (4, 'Portátil',    'Portátiles',     900),
    (5, 'Auriculares', 'Audio',          60),
    (6, 'Altavoz',     'Audio',          80),
    (7, 'Disco SSD',   'Almacenamiento', 100),
    (8, 'Webcam',      'Periféricos',    40);

INSERT INTO pedidos VALUES
    (101, 1, '2025-01-03', 'entregado'),
    (102, 2, '2025-01-04', 'entregado'),
    (103, 1, '2025-01-05', 'entregado'),
    (104, 3, '2025-01-08', 'cancelado'),
    (105, 4, '2025-01-09', 'entregado'),
    (106, 5, '2025-01-10', 'entregado'),
    (107, 2, '2025-02-02', 'entregado'),
    (108, 6, '2025-02-03', 'entregado'),
    (109, 1, '2025-02-04', 'entregado'),
    (110, 3, '2025-02-14', 'entregado'),
    (111, 7, '2025-02-15', 'pendiente'),
    (112, 4, '2025-03-01', 'entregado'),
    (113, 9, '2025-03-02', 'entregado'),
    (114, 5, '2025-03-03', 'entregado'),
    (115, 6, '2025-03-03', 'entregado'),
    (116, 2, '2025-03-20', 'entregado');   -- no tiene líneas

INSERT INTO lineas_pedido VALUES
    (101, 1, 1, 1, 50),
    (101, 2, 2, 2, 20),
    (102, 1, 3, 1, 200),
    (103, 1, 5, 1, 60),
    (104, 1, 4, 1, 900),
    (105, 1, 4, 1, 880),
    (105, 2, 2, 1, 20),
    (106, 1, 6, 2, 80),
    (107, 1, 1, 1, 50),
    (107, 2, 8, 1, 40),
    (108, 1, 7, 2, 100),
    (109, 1, 5, 2, 60),
    (109, 2, 6, 1, 80),
    (110, 1, 3, 2, 190),
    (111, 1, 2, 3, 20),
    (112, 1, 7, 1, 100),
    (112, 2, 2, 0, 20),                    -- cantidad 0
    (113, 1, 4, 1, 900),
    (114, 1, 8, 1, 40),
    (114, 2, 99, 1, 15),                   -- el producto 99 no existe
    (115, 1, 6, 1, 80);

INSERT INTO pedidos_raw VALUES
    (201, 'pendiente', 50,  '2025-03-01 08:00:00'),
    (201, 'enviado',   50,  '2025-03-01 12:00:00'),
    (201, 'entregado', 50,  '2025-03-02 09:00:00'),
    (202, 'pendiente', 30,  '2025-03-01 08:00:00'),
    (202, 'cancelado', 30,  '2025-03-01 18:30:00'),
    (203, 'pendiente', 75,  '2025-03-02 09:00:00'),
    (203, 'pendiente', 75,  '2025-03-02 09:00:00'),
    (204, 'enviado',   120, '2025-03-02 10:15:00');

INSERT INTO eventos_web VALUES
    (1,  1, '2025-03-10 10:00:00', 'portada'),
    (2,  1, '2025-03-10 10:05:00', 'producto'),
    (3,  1, '2025-03-10 10:20:00', 'carrito'),
    (4,  1, '2025-03-10 11:30:00', 'portada'),
    (5,  1, '2025-03-10 11:40:00', 'compra'),
    (6,  2, '2025-03-10 09:00:00', 'portada'),
    (7,  2, '2025-03-10 09:50:00', 'producto'),
    (8,  2, '2025-03-10 10:10:00', 'producto'),
    (9,  2, '2025-03-10 10:15:00', 'carrito'),
    (10, 3, '2025-03-10 20:00:00', 'portada');

INSERT INTO staging_clientes VALUES
    (4,  'Pedro Sanz', 'pedro@ejemplo.com', 'Valencia', '2024-03-15'),  -- se ha mudado
    (8,  'Iván Mora',  'ivan@ejemplo.com',  'Zaragoza', '2024-05-20'),  -- sin cambios
    (11, 'Elena Ríos', 'elena@ejemplo.com', 'Madrid',   '2025-03-01');  -- cliente nuevo

INSERT INTO dim_cliente_scd2 (id_cliente, ciudad, valido_desde, valido_hasta, es_actual)
SELECT id_cliente, ciudad, fecha_alta, NULL, 1 FROM clientes ORDER BY id_cliente;

INSERT INTO empleados VALUES
    (1, 'Laura', NULL, 'Dirección'),
    (2, 'Diego', 1,    'Datos'),
    (3, 'Paula', 1,    'Plataforma'),
    (4, 'Hugo',  2,    'Datos'),
    (5, 'Alba',  2,    'Datos'),
    (6, 'Raúl',  3,    'Plataforma'),
    (7, 'Nerea', 4,    'Datos');

-- ---------------------------------------------------------------- segunda tanda (ejercicios 14-26)

INSERT INTO tickets VALUES
    (1, 'pan'), (1, 'leche'), (1, 'huevos'),
    (2, 'pan'), (2, 'leche'),
    (3, 'café'), (3, 'leche'),
    (4, 'pan'), (4, 'huevos'),
    (5, 'pan'), (5, 'leche'), (5, 'café'),
    (6, 'cerveza'), (6, 'patatas'),
    (7, 'cerveza'), (7, 'patatas'), (7, 'pan'),
    (8, 'leche'), (8, 'huevos');

INSERT INTO ventas_ancho VALUES
    ('Madrid',  100, 120, NULL),
    ('Sevilla', 80,  NULL, 95),
    ('Bilbao',  60,  70,  75);

INSERT INTO facturas_erp VALUES
    ('F1', 100), ('F2', 250), ('F3', 75), ('F4', 300), ('F5', 60);

INSERT INTO cobros_banco VALUES
    ('F1', 100), ('F2', 240), ('F4', 300), ('F5', 60), ('F6', 90);

INSERT INTO eventos_json VALUES
    (1, '2025-03-10 09:00:00', '{"tipo": "compra", "cliente": {"id": 1, "pais": "ES"}, "importe": 49.9, "items": [{"sku": "A1", "uds": 1}]}'),
    (2, '2025-03-10 09:05:00', '{"tipo": "compra", "cliente": {"id": 2, "pais": "PT"}, "importe": 120, "items": [{"sku": "B2", "uds": 2}, {"sku": "C3", "uds": 1}]}'),
    (3, '2025-03-10 09:07:00', '{"tipo": "visita", "cliente": {"id": 1, "pais": "ES"}}'),
    (4, '2025-03-10 09:30:00', '{"tipo": "compra", "cliente": {"id": 3, "pais": "ES"}, "importe": 15.5, "items": []}'),
    (5, '2025-03-10 10:00:00', '{"tipo": "compra", "cliente": {"id": 2, "pais": "PT"}, "importe": 30, "items": [{"sku": "A1", "uds": 3}]}');

INSERT INTO movimientos_stock VALUES
    (1,  1, '2025-03-01', 10),
    (2,  1, '2025-03-02', -3),
    (3,  1, '2025-03-03', -4),
    (4,  1, '2025-03-05', -5),
    (5,  1, '2025-03-06', 8),
    (6,  2, '2025-03-01', 5),
    (7,  2, '2025-03-02', -5),
    (8,  2, '2025-03-04', 2),
    (9,  7, '2025-03-02', 3),
    (10, 7, '2025-03-03', -1),
    (11, 7, '2025-03-03', -1);

INSERT INTO productos_replica SELECT id_producto, nombre, categoria, precio FROM productos;

INSERT INTO cambios_productos VALUES
    (1, 'U', 2,  'Ratón',               'Periféricos', 22),
    (2, 'I', 9,  'Tableta',             'Portátiles',  300),
    (3, 'D', 6,  NULL,                  NULL,          NULL),
    (4, 'U', 9,  'Tableta 10 pulgadas', 'Portátiles',  280),
    (5, 'U', 2,  'Ratón',               'Periféricos', 21),
    (6, 'I', 10, 'Micrófono',           'Audio',       70),
    (7, 'D', 10, NULL,                  NULL,          NULL);

INSERT INTO precios VALUES
    (1, '2025-03-01', 50),
    (1, '2025-03-04', 45),
    (5, '2025-03-02', 60),
    (5, '2025-03-05', 55);
