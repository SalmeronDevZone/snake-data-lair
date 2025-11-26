
-- 1


INSERT INTO ofertas (
    id_empresa,
    titulo,
    descripcion,
    salario,
    ubicacion,
    fecha_publicacion,
    fecha_cierre
) VALUES
(7, 'Ingeniero DevOps',
 'Implementación de pipelines CI/CD, automatización, contenedores Docker, Kubernetes y despliegues en cloud.',
 44000.00, 'Sevilla', '2025-09-20', '2025-10-20'),

(7, 'Ingeniero de Datos',
 'Diseño y construcción de pipelines ETL, modelado de datos, optimización de sistemas analíticos y big data.',
 48000.00, 'Sevilla', '2025-09-22', '2025-10-22');


-- 2


UPDATE Ofertas SET salario = salario * 1.05 WHERE ubicacion = 'Barcelona';



-- 3


DELETE FROM Ofertas WHERE salario < 27000 AND ubicacion <> 'Madrid';



-- 4


SET SQL_SAFE_UPDATES = 0;

UPDATE Ofertas SET ubicacion = 'Zaragoza' WHERE titulo LIKE 'Diseñador%';



-- 5


ALTER TABLE candidato_oferta DROP FOREIGN KEY candidato_oferta_ibfk_2;

ALTER TABLE candidato_oferta ADD CONSTRAINT candidato_oferta_ibfk_2
FOREIGN KEY (id_oferta) REFERENCES Ofertas(id_oferta) ON DELETE CASCADE;

DELETE FROM Ofertas WHERE YEAR(fecha_publicacion) = 2025 AND MONTH(fecha_publicacion) = 8;



-- 6


UPDATE Empresas SET email = REPLACE(email, SUBSTRING_INDEX(email, '@', -1), 'gmail.com')
WHERE id_empresa = 2;



-- 7 


INSERT INTO Ofertas 
   ( id_empresa, titulo, descripcion, salario, ubicacion, fecha_publicacion, fecha_cierre)
VALUES 
    (7, 'Analista Power BI', 'Encargado de reporting', NULL, 'Sevilla', '2025-11-15', '2025-12-01');



-- 8


DELETE FROM Ofertas WHERE ubicacion = 'Valencia' AND NOT EXISTS (
      SELECT 1 FROM Candidato_Oferta co WHERE co.id_oferta = Ofertas.id_oferta );



-- 9


UPDATE Ofertas SET salario = salario * 1.10
WHERE ubicacion = 'Madrid' AND titulo LIKE 'Desarrollador%';



-- 10


INSERT INTO Ofertas (id_empresa, titulo, descripcion, salario, ubicacion, fecha_publicacion, fecha_cierre) 
VALUES
   (7, 'Especialista en Marketing Digital', 'Gestión de campañas de marketing online, SEO, SEM y redes sociales.', 35000.00, 'Sevilla', '2025-11-01', '2025-12-01'),
   (7, 'Content Manager', 'Creación y gestión de contenidos digitales, blogs, newsletters y redes sociales.', 32000.00, 'Sevilla', '2025-11-03', '2025-12-03'),
   (7, 'Analista de Marketing Digital', 'Monitorización y análisis de KPIs, generación de informes y optimización de campañas.', 37000.00, 'Sevilla', '2025-11-05', '2025-12-05');



-- 1

START TRANSACTION;

INSERT INTO Ofertas (id_empresa, titulo, descripcion, salario, ubicacion, fecha_publicacion, fecha_cierre)
VALUES (7, 'Ingeniero DevOps Junior', 'Implementación de pipelines y automatización en entornos cloud.', 40000.00, 'Sevilla', '2025-11-26', '2025-12-26');


SET @nuevo_id_oferta = LAST_INSERT_ID();

INSERT INTO Candidato_Oferta (id_candidato, id_oferta, fecha_postulacion) VALUES
(1, @nuevo_id_oferta, '2025-11-26'),
(2, @nuevo_id_oferta, '2025-11-26'),
(3, @nuevo_id_oferta, '2025-11-26');


COMMIT;



-- 2


START TRANSACTION;

UPDATE Ofertas
SET salario = salario * 1.15;

SELECT id_oferta, titulo, salario
FROM Ofertas;

ROLLBACK;



-- 3 


START TRANSACTION;


INSERT INTO Ofertas (id_empresa, titulo, descripcion, salario, ubicacion, fecha_publicacion, fecha_cierre)
VALUES (7, 'Ingeniero Azure', 'Despliegue y gestión de infraestructuras cloud.', 45000.00, 'Sevilla', '2025-11-26', '2025-12-26');

INSERT INTO Ofertas (id_empresa, titulo, descripcion, salario, ubicacion, fecha_publicacion, fecha_cierre)
VALUES (7, 'Pentester', 'Realizar ataques de pentesting.', 40000.00, 'Sevilla', '2025-11-26', '2025-12-26');

SAVEPOINT antes_eliminar_empresa;

DELETE FROM Empresas
WHERE id_empresa = 7;

ROLLBACK TO SAVEPOINT antes_eliminar_empresa;

COMMIT;



-- 4


START TRANSACTION;

DELETE FROM Ofertas
WHERE ubicacion = 'Valencia';

SELECT * FROM Ofertas WHERE ubicacion = 'Valencia';
-- Resultado esperado: 0 filas en esta sesión.

-- SELECT * FROM Ofertas
-- WHERE ubicacion = 'Valencia';
-- Resultado esperado: los registros todavía son visibles en otras sesiones hasta que se haga COMMIT

COMMIT;


SELECT * FROM Ofertas
WHERE ubicacion = 'Valencia';

