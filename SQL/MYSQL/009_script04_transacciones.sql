START TRANSACTION;
INSERT INTO clientes 
VALUES ('10000020','Laura','Olmo','Serrano','c/ Estrella, 12','Motril','Granada','España',NULL,NULL,'667112233');

BEGIN;
INSERT INTO clientes 
VALUES ('10000020','Laura','Olmo','Serrano','c/ Estrella, 12','Motril','Granada','España',NULL,NULL,'667112233');

select * from clientes;
rollback;
commit;

use fruteria;
-- ejemplo con puntos de recuperación
START TRANSACTION;
INSERT INTO clientes 
VALUES ('10000020','Laura','Olmo','Serrano','c/ Estrella, 12','Motril','Granada','España',NULL,NULL,'667112233');
SAVEPOINT puntoIntermedio;
INSERT INTO clientes 
VALUES ('10000021','David','Garrido','Antequera','c/ Lucero, 7','Lepe','Huelva','España',NULL,NULL,'667332211');

select * from clientes;
ROLLBACK TO puntoIntermedio;
