/* Una consulta jerárquica es una técnica utilizada en bases de datos para recuperar 
datos organizados en una estructura jerárquica, como un árbol o una estructura de árbol en cascada. */


CREATE TABLE staff (
id_empleado int not null primary key,
nombre varchar(20) not null,
id_puesto char(20),
id_supervisor int null
);

INSERT INTO staff VALUES (100,'Miguel Gonzales','PRESIDENTE',null);           
INSERT INTO staff VALUES (101,'Federico Antillana','VICE_PRESIDENTE',100);
INSERT INTO staff VALUES (102,'Miguel Montero','GERENTE_GRAL',100);
INSERT INTO staff VALUES (103,'Manuel Saldaños','IT_GERENTE',102);
INSERT INTO staff VALUES (104,'Ana Montesinos','SOPORTE_IT',103);
INSERT INTO staff VALUES (105,'Manuel Figueroa','SOPORTE_IT',103);
INSERT INTO staff VALUES (106,'Eliana Sandoval','SOPORTE_IT',103);
INSERT INTO staff VALUES (107,'Iluminada Contreras','SOPORTE_IT',103);
INSERT INTO staff VALUES (108,'Manuela Condado','SECRETARIA',101);
INSERT INTO staff VALUES (109,'Emilia Cortinez','SECRETARIA',102);
INSERT INTO staff VALUES (110,'Denia Soler','SECRETARIA',103);
INSERT INTO staff VALUES (111,'Barbara Eleonor','SECRETARIA',101);
INSERT INTO staff VALUES (112,'Fausto Melaneo','VENDEDOR',102);
INSERT INTO staff VALUES (113,'Adalberto Mirabal','VENDEDOR',102);
INSERT INTO staff VALUES (114,'Estelvina Zorrilla','VENDEDORA',102);
INSERT INTO staff VALUES (115,'Mireya Matos','ASISTENTE_SECRETARIO',108);
INSERT INTO staff VALUES (116,'Elena Martinez','ASISTENTE_SECRETARIO',109);



 
select nombre, id_puesto, level from staff
start with nombre='Miguel Gonzales'
connect by prior id_empleado = id_supervisor;   --identifica la relacion entre el empleado y su supervisor.

select level, nombre, id_puesto, sys_connect_by_path(nombre, ' > ') JERARQUIA from staff
start with id_supervisor is null
connect by prior id_empleado = id_supervisor;
