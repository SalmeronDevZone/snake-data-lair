DELETE from incluyen; -- definidas
DELETE from componen; 
DELETE from suministros;
DELETE from proveedores;
DELETE from pedidos;
DELETE from clientes;
DELETE from productos;

-- Inserciones en tabla CLIENTES --

INSERT INTO clientes VALUES ('10000001','Manuel','Perea','Sánchez','c/ Doctor Maíz, 13','Torreperogil','Jaén','España','23320','mps0001@gmail.com','953123456');
INSERT INTO clientes VALUES ('10000002','Pedro','López','López','c/ Victoria, 37','Úbeda','Jaén','España','23400','pll0005@hotmail.com','953750001');
INSERT INTO clientes VALUES ('10000003','Antonio','Jardín','Poncela','Pl/ Campeón, 2','Sevilla','Sevilla','España','23002','ajponcela@yahoo.com','953341278');
INSERT INTO clientes VALUES ('10000004','Javier','Noguera','Perejil','Av/ 20 de enero, 12','Lepe','Huelva','España','23700','janope89@gmail.com','953670003');
INSERT INTO clientes VALUES ('10000005','María','Martínez','Pérez','c/ Pajaritos, 4','Linares','Jaén','España','23700','mmpsiempre@yahoo.com','953670004');
INSERT INTO clientes VALUES ('10000006','Pedro','Lupiañez','López','c/ San Antón, 50','Granada','Granada','España','18050','pelupia@gmail.com','958509999');
INSERT INTO clientes VALUES ('10000007','Agustín','Marínez','Jiménez','c/ Pajaritos, 2','Utrera','Sevilla','España','18151','amj0013@hotmail.com','609443001');
INSERT INTO clientes VALUES ('10000008','Agustina','Noguera','Perejil','Pl/ Simón Pedro, 18','Córdoba','Córdoba','España','14006','lapinta33@gmail.com','957125690');
INSERT INTO clientes VALUES ('10000009','Daniela','Lainez','Peréz','c/ Alfonso X, 8','Almería','Almería','España','04005','lpd00012@mixmail.com','750331517');
INSERT INTO clientes VALUES ('10000010','Amparo','Delgado','Muñoz','c/Anfora, 27','Mojácar','Almería','España','04638',NULL,'950179533');


-- Inserciones en tabla PROVEEDORES

INSERT INTO proveedores VALUES (1,'Hnos. Sampedro, s.l.',null,null,'Ugíjar','Granada','España','18480','hsampedrofruta@gmail.com','678124022');
INSERT INTO proveedores VALUES (2,'Antonio Sánchez e Hijos, s.l.','Antonio Sánchez Muriel','http://www.sanchezehijosfrutas.com','Albolote','Granada','España','18220','asanchez002@yahoo.com','734123087');
INSERT INTO proveedores VALUES (3,'Frutería Paqui','Francisca Martínez','http://www.frutaspaqui.es','Armilla','Granada','España','18100','info@frutaspaqui.es','677245689');
INSERT INTO proveedores VALUES (4,'Productos El Cipri','Cipriano Flores','http://www.elcipri.com','Úbeda','Jaén','España','23400','admin@elcipri.com','787462374');


-- Inserciones en tabla PRODUCTOS

INSERT INTO productos VALUES (1,'Aguacate',null,'./imagenes/aguacate.jpeg',4.25,null,'Motril','España','fruta');
INSERT INTO productos VALUES (2,'Nuez','Nueces con cáscara de Extremadura','./imagenes/nuez.jpeg',5.95,'kg','Badajoz','España','frutos_secos');
INSERT INTO productos VALUES (3,'Fresa','Tarrina de fresas','./imagenes/fresa.jpeg',9.38,'kg','Huelva','España','fruta');
INSERT INTO productos VALUES (4,'Mandarina','Mandarinas clementinas','./imagenes/mandarina.jpeg',3.4,'kg','Valencia','España','fruta');
INSERT INTO productos  VALUES (5,'Garbanzo','Garbanzo fresco italiano','./imagenes/garbanzo.jpeg',3.7,'kg','Calenzano','Italia','legumbre');
INSERT INTO productos  VALUES (6,'Tomate','Tomate Raf','./imagenes/tomateRAF.jpeg',7,'kg','Almería','España','verdura');
INSERT INTO productos  VALUES (7,'Naranja','Naranja valenciana','./imagenes/narval.jpeg',3.15,'kg','Valencia','España','fruta');
INSERT INTO productos  VALUES (8,'Manzana','Manzana golden','./imagenes/manzana.jpeg',1.5,'kg','Zaragoza','España','fruta');
INSERT INTO productos  VALUES (9,'Plátano','Plátano de Canarias','./imagenes/platanocanarias.jpeg',2.7,'kg','Canarias','España','fruta');
INSERT INTO productos  VALUES (10,'Plátano','Banana de America','./imagenes/platano.jpeg',1.5,'kg',null,'México','fruta');
INSERT INTO productos  VALUES (11,'Kiwi','Kiwi verde español','./imagenes/kiwi.jpeg',2.0,'kg','Lugo','España','fruta');
INSERT INTO productos  VALUES (12,'Kiwi','Kiwi americano','./imagenes/kiwi.jpeg',1.5,'kg',null,'Chile','fruta');
INSERT INTO productos  VALUES (13,'Piña','Piña americana','./imagenes/pina.jpeg',3.2,'kg',null,'Colombia','fruta');
INSERT INTO productos  VALUES (14,'Lechuga','Lechuga romana','./imagenes/lechuga.jpeg',1.5,'kg',null,'España','verdura');
INSERT INTO productos  VALUES (15,'Escarola','Escarola',null,1.8,'kg',null,'Francia','verdura');
INSERT INTO productos  VALUES (16,'Almendra','Almendra marcona',null,4.2,'kg','Alicante','España','frutos_secos');


-- Inserciones en tabla PEDIDOS (MYSQL, SQLITE)

INSERT INTO pedidos  VALUES (1,'2022-01-07','10',null,null,null,null,null,null,null,'Efectivo','0','10000001');
INSERT INTO pedidos  VALUES (2,'2022-01-19','10',null,null,null,null,null,null,null,'Efectivo','0','10000001');
INSERT INTO pedidos  VALUES (3,'2022-01-12','10','C/Real 25','Aguadulce','Almería','España','04720',null,null,'Visa','1','10000003');
INSERT INTO pedidos  VALUES (4,'2022-01-12','10','C/Madrid 45, 2B','Aguadulce','Sevilla','España','41550',null,null,'Visa','1','10000003');
INSERT INTO pedidos  VALUES (5,'2022-01-22','21','c/ Libro, 3','Jaén','Jaén','España','23004',null,null,'Bizum','0','10000005');
INSERT INTO pedidos  VALUES (6,'2022-02-02','21','c/ Libro, 3','Jaén','Jaén','España','23004',null,null,'Bizum','0','10000005');


-- Inserciones en tabla PEDIDOS (Oracle)

INSERT INTO pedidos  VALUES (1,DATE '2022-01-07','10',null,null,null,null,null,null,null,'Efectivo',0,'10000001');
INSERT INTO pedidos  VALUES (2,DATE '2022-01-19','10',null,null,null,null,null,null,null,'Efectivo',0,'10000001');
INSERT INTO pedidos  VALUES (3,DATE '2022-01-12','10','C/Real 25','Aguadulce','Almería','España','04720',null,null,'Visa',1,'10000003');
INSERT INTO pedidos  VALUES (4,DATE '2022-01-12','10','C/Madrid 45, 2B','Aguadulce','Sevilla','España','41550',null,null,'Visa',1,'10000003');
INSERT INTO pedidos  VALUES (5,DATE '2022-01-22','21','c/ Libro, 3','Jaén','Jaén','España','23004',null,null,'Bizum',0,'10000005');
INSERT INTO pedidos  VALUES (6,DATE '2022-02-02','21','c/ Libro, 3','Jaén','Jaén','España','23004',null,null,'Bizum',0,'10000005');

-- Inserciones en tabla INCLUYEN

INSERT INTO incluyen VALUES (1, 1, 1.2, 0);
INSERT INTO incluyen VALUES (1, 4, 3, 0);
INSERT INTO incluyen VALUES (1, 6, 1.5, 0);
INSERT INTO incluyen VALUES (3, 4, 5, 5);
INSERT INTO incluyen VALUES (3, 7, 5, 5);
INSERT INTO incluyen VALUES (4, 4, 5, 5);
INSERT INTO incluyen VALUES (4, 7, 5, 5);

INSERT INTO incluyen VALUES (2, 16, 0.1, 0);
INSERT INTO incluyen VALUES (5, 5, 1, 0);
INSERT INTO incluyen VALUES (6, 16, 0.250, 0);


-- Inserciones en tabla SUMINISTROS (MYSQL, SQLITE)

INSERT INTO suministros VALUES (1,'2022-01-03', 4);
INSERT INTO suministros VALUES (2,'2022-01-07', 1);
INSERT INTO suministros VALUES (3,'2022-01-15', 2);
INSERT INTO suministros VALUES (4,'2022-01-15', 3);

-- Inserciones en tabla SUMINISTROS (Oracle)

INSERT INTO suministros VALUES (1,DATE '2022-01-03', 4);
INSERT INTO suministros VALUES (2,DATE '2022-01-07', 1);
INSERT INTO suministros VALUES (3,DATE '2022-01-15', 2);
INSERT INTO suministros VALUES (4,DATE '2022-01-15', 3);

-- Inserciones en tabla COMPONEN

INSERT INTO componen VALUES (1, 1, 0.9, 5);
INSERT INTO componen VALUES (1, 4, 2.5, 15);
INSERT INTO componen VALUES (1, 6, 1.5, 12);
INSERT INTO componen VALUES (2, 4, 2.2, 20);
INSERT INTO componen VALUES (2, 7, 1.9, 20);
INSERT INTO componen VALUES (3, 1, 0.9, 7);
INSERT INTO componen VALUES (4, 5, 3, 5);
INSERT INTO componen VALUES (4, 2, 4.3, 8);


