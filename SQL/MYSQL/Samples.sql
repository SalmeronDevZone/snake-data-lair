 -- Tabla para almacenar la información de los candidatos

create database ofertastrabajo;
use ofertastrabajo;

-- Tabla para almacenar la información de las empresas
CREATE TABLE Empresas (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL,
    direccion VARCHAR(50),
    ciudad VARCHAR(50),
    telefono VARCHAR(15),
    email VARCHAR(100) NOT NULL
);

-- Tabla para almacenar las ofertas de trabajo
CREATE TABLE Ofertas (
    id_oferta INT AUTO_INCREMENT PRIMARY KEY,
    id_empresa INT,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    salario DECIMAL(10, 2),
    ubicacion VARCHAR(100),
    fecha_publicacion DATE,
    fecha_cierre DATE,
    CONSTRAINT fk_empresa_oferta 
    FOREIGN KEY (id_empresa) REFERENCES Empresas(id_empresa)
);

CREATE TABLE Candidatos (
    id_candidato INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    dni VARCHAR(15) NOT NULL UNIQUE,
    fecha_nacimiento DATE,
    correo_electronico VARCHAR(100),
    sexo CHAR(1),
    ciudad VARCHAR(50)
);



CREATE TABLE Candidato_Oferta (
    id_candidato INT,
    id_oferta INT,
    fecha_postulacion DATE,
    PRIMARY KEY (id_candidato, id_oferta),
    FOREIGN KEY (id_candidato) REFERENCES Candidatos(id_candidato),
    FOREIGN KEY (id_oferta) REFERENCES Ofertas(id_oferta)
);

INSERT INTO Empresas (nombre_empresa, direccion,ciudad, telefono, email)
VALUES
('Tech Solutions', 'Calle Alcalá, 100', 'Madrid', '912345678', 'contacto@techsolutions.com'),
('Innovatech', 'Calle Goya, 45', 'Madrid', '912678345', 'info@innovatech.com'),
('Digital Dreams', 'Avenida Diagonal, 300', 'Barcelona', '932123456', 'info@digitaldreams.com'),
('Barcelona Labs', 'Carrer de Casanova, 123', 'Barcelona', '932654789', 'contacto@bcnlabs.com'),
('Bizkaia Soft', 'Calle Ercilla, 70', 'Bilbao', '944123456', 'info@bizkaiasoft.com'),
('Bilbao Innovación', 'Calle Iparraguirre, 5', 'Bilbao', '944789321', 'contacto@bilbaoinnovacion.com'),
('Sevilla Tech', 'Avenida de la Palmera, 40', 'Sevilla', '954123456', 'info@sevillatech.com'),
('Innovación Sur', 'Calle San Fernando, 12', 'Sevilla', '954678345', 'contacto@innovacionsur.com'),
('Madrid Solutions', 'Paseo de la Castellana, 85', 'Madrid', '911234567', 'info@madridsolutions.com'),
('Barcelona Digital', 'Carrer de Balmes, 200', 'Barcelona', '933123456', 'contacto@barcelonadigital.com');



INSERT INTO Ofertas (id_empresa, titulo, descripcion, salario, ubicacion, fecha_publicacion, fecha_cierre)
VALUES
(1, 'Desarrollador Full Stack', 'Desarrollo de aplicaciones web con tecnologías modernas como React y Node.js.', 35000.00, 'Madrid', '2025-09-01', '2025-10-01'),
(2, 'Analista de Datos', 'Responsable de analizar grandes volúmenes de datos para apoyar la toma de decisiones.', 40000.00, 'Barcelona', '2025-08-25', '2025-09-25'),
(3, 'Ingeniero de Software', 'Desarrollo de software a medida para diferentes sectores, utilizando Python y C#.', 45000.00, 'Valencia', '2025-09-05', '2025-10-05'),
(4, 'Administrador de Sistemas', 'Gestión y mantenimiento de la infraestructura IT, servidores y redes.', 38000.00, 'Sevilla', '2025-09-10', '2025-10-10'),
(4, 'Desarrollador Mobile', 'Creación de aplicaciones móviles nativas para iOS y Android.', 42000.00, 'Barcelona', '2025-08-30', '2025-09-30'),
(6, 'Project Manager', 'Gestión de proyectos de desarrollo tecnológico, liderando equipos multidisciplinares.', 50000.00, 'Bilbao', '2025-09-01', '2025-09-30'),
(7, 'Ingeniero de Cloud', 'Diseño y mantenimiento de soluciones en la nube utilizando AWS y Azure.', 46000.00, 'Madrid', '2025-09-03', '2025-10-03'),
(7, 'Especialista en Ciberseguridad', 'Implementación de medidas de seguridad informática y análisis de vulnerabilidades.', 48000.00, 'Madrid', '2025-09-07', '2025-10-07'),
(9, 'Consultor de Energía Renovable', 'Asesoría técnica y financiera en proyectos de energía solar y eólica.', 43000.00, 'Sevilla', '2025-08-28', '2025-09-28'),
(10, 'Diseñador UX/UI', 'Diseño de interfaces de usuario y experiencia de usuario para aplicaciones web y móviles.', 37000.00, 'Barcelona', '2025-09-05', '2025-10-05');
INSERT INTO Ofertas (id_empresa, titulo, descripcion, salario, ubicacion, fecha_publicacion, fecha_cierre)
VALUES
(1, 'Consultor SAP', 'Implementación de soluciones SAP para mejorar los procesos empresariales.', 55000.00, 'Madrid', '2025-09-10', '2025-10-10'),
(2, 'Especialista en Marketing Digital', 'Diseño e implementación de campañas de marketing digital en redes sociales y SEO.', 38000.00, 'Barcelona', '2025-09-12', '2025-10-12'),
(2, 'Desarrollador Backend', 'Desarrollo de servicios backend utilizando Node.js y bases de datos NoSQL.', 40000.00, 'Sevilla', '2025-09-15', '2025-10-15'),
(4, 'Analista Financiero', 'Análisis de estados financieros y elaboración de reportes para la toma de decisiones.', 45000.00, 'Sevilla', '2025-09-17', '2025-10-17'),
(1, 'Ingeniero DevOps', 'Automatización de procesos de desarrollo y despliegue utilizando Docker y Kubernetes.', 47000.00, 'Zaragoza', '2025-09-18', '2025-10-18'),
(6, 'Especialista en Inteligencia Artificial', 'Desarrollo de modelos de machine learning y análisis de datos con Python.', 60000.00, 'Bilbao', '2025-09-20', '2025-10-20'),
(1, 'Diseñador Gráfico', 'Creación de piezas gráficas y contenido visual para campañas publicitarias.', 35000.00, 'Madrid', '2025-09-21', '2025-10-21'),
(8, 'Técnico en Soporte IT', 'Resolución de incidencias técnicas y mantenimiento de la infraestructura informática.', 30000.00, 'Madrid', '2025-09-22', '2025-10-22'),
(9, 'Director de Recursos Humanos', 'Gestión y dirección del departamento de recursos humanos, reclutamiento y selección.', 65000.00, 'Barcelona', '2025-09-23', '2025-10-23'),
(10, 'Arquitecto de Soluciones Cloud', 'Diseño de arquitecturas en la nube para proyectos empresariales con AWS y Azure.', 62000.00, 'Barcelona', '2025-09-24', '2025-10-24');




INSERT INTO Candidatos (nombre, dni, fecha_nacimiento, correo_electronico, sexo, ciudad) VALUES
('Carlos Ruiz', '12345678A', '1989-04-12', 'carlos.ruiz@mail.com', 'M', 'Madrid'),
('Laura Gómez', '23456789B', '1992-08-25', 'laura.gomez@mail.com', 'F', 'Barcelona'),
('Andrés Pérez', '34567890C', '1985-02-18', 'andres.perez@mail.com', 'M', 'Sevilla'),
('Marta Sánchez', '45678901D', '1990-11-30', 'marta.sanchez@mail.com', 'F', 'Valencia'),
('Javier Ortega', '56789012E', '1994-06-05', 'javier.ortega@mail.com', 'M', 'Zaragoza'),
('Nuria Martín', '67890123F', '1988-01-22', 'nuria.martin@mail.com', 'F', 'Bilbao'),
('Pablo López', '78901234G', '1991-09-17', 'pablo.lopez@mail.com', 'M', 'Granada'),
('Lucía Ramos', '89012345H', '1987-07-03', 'lucia.ramos@mail.com', 'F', 'Málaga'),
('Manuel Torres', '90123456I', '1993-03-14', 'manuel.torres@mail.com', 'M', 'Alicante'),
('Sara Vidal', '01234567J', '1995-12-08', 'sara.vidal@mail.com', 'F', 'Santander');

INSERT INTO Candidato_Oferta (id_candidato, id_oferta, fecha_postulacion) VALUES
(1, 9, '2025-09-17'),
(3, 10, '2025-08-29'),
(3, 16, '2025-08-07'),
(3, 13, '2025-08-17'),
(4, 7, '2025-09-15'),
(4, 11, '2025-09-25'),
(5, 9, '2025-08-25'),
(6, 11, '2025-08-29'),
(7, 1, '2025-09-12'),
(7, 12, '2025-09-20'),
(9, 6, '2025-08-28'),
(9, 8, '2025-08-10'),
(9, 17, '2025-09-01'),
(10, 13, '2025-08-15');


-- Ofertas con salario entre 25.000 y 40.000 euros, ordenadas por salario ascendente 
select * from ofertas where salario between 25000 and 40000;

-- Ofertas cuyo título contenga la palabra 'Ingeniero'.
select * from ofertas where titulo like '%ingeniero%';

-- Ofertas cuyo título contenga la palabra 'Ingeniero'. 
select * from ofertas where titulo like '%ingeniero%'; 

-- Ofertas publicadas después del 1 de enero de 2024.  
select * from ofertas where fecha_publicacion > '2024-01-01'; 

-- Ofertas sin salario especificado (IS NULL). 
select * from ofertas where salario is null; 

-- Ofertas cuya ubicación contenga 'Madrid', ordenadas alfabéticamente.  
select * from ofertas where ubicacion like '%madrid%' order by titulo; 

-- Ofertas donde la descripción esté vacía o nula.  
select * from ofertas where descripcion is null; 

-- Candidatos cuyo correo electrónico termine en '@gmail.com'.  
select * from candidatos where correo_electronico like '%@gmail.com'; 

-- Candidatos nacidos antes de 1990, ordenados por fecha de nacimiento.  
select * from candidatos where fecha_nacimiento < '1990-01-01' order by fecha_nacimiento; 

-- Candidatos cuyo nombre contenga la letra 'a' y vivan en Barcelona.  
select * from candidatos where nombre like '%a%'and ciudad = 'Barcelona'; 

-- Lista de candidatos, ordenados por ciudad de residencia en orden descendente 
select * from candidatos order by ciudad DESC; 

 

 
-- Muestra el título de la oferta, el nombre de la empresa y su ubicación. 
select o.titulo, e.nombre_empresa, e.direccion, e.ciudad from ofertas o 
inner join empresas e on o.id_empresa = e.id_empresa; 
 
-- Muestra todas las ofertas, incluyendo aquellas que no tienen empresa asignada
select o.* from ofertas o left join empresas e on o.id_empresa = e.id_empresa;
 
 -- Lista los candidatos junto con los títulos de las ofertas en las que se ha inscrito. 
 select c.nombre , o.titulo from candidatos c 
 inner join candidato_oferta co on c.id_candidato = co.id_candidato 
 inner join ofertas o on co.id_oferta = o.id_oferta; 

-- Muestra el nombre del candidato, la ciudad, el título de la oferta y la fecha de inscripción en la oferta.
select c.nombre as 'nombre candidato' ,c.ciudad, o.titulo as 'titulo de la oferta', co.fecha_postulacion as 'inscipcion' from candidatos c 
inner join candidato_oferta co on c.id_candidato = co.id_candidato 
inner join ofertas o on co.id_oferta = o.id_oferta; 

-- Muestra todas las ofertas junto con el número de candidatos que se han interesado en cada una.  
select o.titulo, count(co.id_oferta) as 'numero de candidatos' from ofertas o 
right join candidato_oferta co on o.id_oferta = co.id_oferta group by o.titulo; 
 
-- Lista todas las empresas junto con las ofertas publicadas en la ciudad de Zaragoza.
select e.nombre_empresa, o.titulo from empresas e 
inner join ofertas o on e.id_empresa = o.id_empresa where o.ubicacion = "Zaragoza";

-- Muestra los candidatos que no se han interesado en ninguna oferta.
select c.nombre from candidatos c 
left join candidato_oferta co on c.id_candidato = co.id_candidato where co.id_candidato is null;

-- Muestra todas las ofertas de las empresas de Barcelona Las ofertas mostradas no pueden ser de la ciudad de Barcelona.
select o.titulo from ofertas o inner join empresas e on o.id_empresa = e.id_empresa 
where e.ciudad = 'Barcelona'
and o.ubicacion != 'Barcelona'




-- Número total de ofertas publicadas en la tabla Ofertas de cada empresa
select id_empresa, count(id_empresa) from ofertas group by id_empresa;

-- Número de ofertas por ciudad (ubicación), ordenadas de mayor a menor cantidad.
select ubicacion, count(id_oferta) from ofertas group by ubicacion order by count(id_oferta) DESC;

-- Salario promedio de las ofertas por ubicación.
select ubicacion , round(avg(salario),0) from ofertas group by ubicacion;

--  Número total de candidatos registrados en la tabla Candidatos de cada ciudad.
select count(id_candidato) as Total, ciudad from candidatos group by ciudad;

-- Candidatos agrupados por sexo, mostrando cuántos hay de cada tipo.
select sexo, count(id_candidato) from candidatos group by sexo;

-- Salario máximo y mínimo ofrecido en las ofertas de empleo.
select round(max(salario),0) as Salario_Maximo, round(min(salario),0) as Salario_Minimo 
from ofertas;

-- Mostrar las ubicaciones donde el salario promedio de las ofertas sea superior a 30.000 euros
select ubicacion from ofertas group by ubicacion having avg(salario) > 30000;

-- Mostrar las empresas que han publicado más de 2 ofertas, con el número de ofertas por cada una.
select id_empresa, count(id_empresa) from ofertas group by id_empresa having count(id_empresa) > 2;

 



-- En WHERE: Mostrar todas las ofertas cuyo salario sea superior al salario promedio de todas las ofertas.
select * from ofertas where salario > (select avg(salario) from ofertas);

--  En WHERE: Listar los candidatos que viven en ciudades donde se han publicado ofertas
select c.* from candidatos c inner join candidato_oferta co on c.id_candidato = co.id_candidato
where co.id_oferta in (select o.id_oferta from ofertas o where o.ubicacion is not null);

--  En SELECT: Mostrar todas las ofertas junto con una columna adicional que indique el salario promedio general, en cada fila
select *, (select round(avg(salario),0) from ofertas) as Promedio_General from ofertas;
 



-- Vista 1 (actualizable): Crear una vista que muestre solo las ofertas con salario superior a 30000. Esta vista debe permitir UPDATE y DELETE sobre sus registros.
CREATE OR REPLACE VIEW vista_1 AS
SELECT * FROM ofertas WHERE salario > 30000 WITH CHECK OPTION;

-- Vista 2: Crear una vista que muestre para cada ubicación el número total de ofertas y el salario promedio
CREATE OR REPLACE VIEW vista_2 AS
SELECT ubicacion, COUNT(*) AS Total_Ofertas, AVG(salario) AS Salario_Promedio FROM ofertas GROUP BY ubicacion;

-- Vista 3: Crear una vista que muestre los títulos de las ofertas junto con el nombre de la empresa y el salario, ordenadas por salario descendente.
CREATE OR REPLACE VIEW vista_3 AS
select o.titulo, o.salario, e.nombre_empresa from ofertas o 
inner join empresas e on o.id_empresa = e.id_empresa order by o.salario DESC;




-- Muestra las empresas y las ofertas de la ubicación de Madrid. Analiza la consulta con explain.
explain
SELECT e.nombre_empresa AS empresa, e.ciudad, o.titulo AS oferta, o.salario, o.ubicacion FROM empresas e
JOIN ofertas o ON e.id_empresa = o.id_empresa WHERE e.ciudad = 'Madrid' AND o.ubicacion = 'Madrid';

-- Añade un índice a la ubicación y repite la misma consulta. Analiza el resultado con explain. Justifica los resultados.
CREATE INDEX indice_1 ON ofertas(ubicacion);


