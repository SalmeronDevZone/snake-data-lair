BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE control_empleados';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;




CREATE TABLE control_empleados (
    usuario VARCHAR2(20),
    fecha DATE,
    accion VARCHAR2(20)
);

-- En Pl/Sql no se puede hacer 'create or replace table'.





DECLARE

   v_sql VARCHAR2(200);

BEGIN

   FOR t IN (SELECT table_name FROM user_tables) LOOP
      v_sql := 'DROP TABLE ' || t.table_name;
      EXECUTE IMMEDIATE v_sql;
   END LOOP;
   
END;
/

-- Ojo que este script puede ser una liada.
-- Solo necesitas los privilegios, no es necesario algo como 'set sql.safe_updates=0;''







SELECT trigger_name, triggering_event, table_name ,status
from user_triggers
where table_name = 'EMPLEADOS';

alter trigger tr_aumentasueldo disable;







 drop table empleados;

 create table empleados(
  documento char(8),
  apellido varchar2(30),
  nombre varchar2(30),
  domicilio varchar2(30),
  seccion varchar2(20),
  sueldo number(8,2)
 );


 insert into empleados values('22222222','Acosta','Ana','Avellaneda 11','Secretaria',1800);
 insert into empleados values('23333333','Bustos','Betina','Bulnes 22','Gerencia',5000);
 insert into empleados values('24444444','Caseres','Carlos','Colon 333','Contabilidad',3000);
 insert into empleados values('32323255','Gonzales','Miguel','Calle 4ta No.90','Contabilidad',8000);
 insert into empleados values('56565555','Suarez','Tomas','Atarazana 78','Cobros',1500);









create table productos(
id_producto int not null,
nombre_producto VARCHAR2(25),
precio NUMBER(6,2),
descripcion VARCHAR2(50));

insert into productos values(1,'Abrazadera',560,'Abrazadera de media pulgada');
insert into productos values(2,'Destornillador',120,'destornillador cabeza plana');
insert into productos values(3,'Martillo',300,'Martillo con ganzua'); 
insert into productos values(4,'Llave inglesa',200,'Llave inglesa de plomeria');
insert into productos values(5,'Pasadores RTR',935,'Tuerca exagonal de Almenada');
insert into productos values(6,'Tornillo exagonal',90,'Tornillo exagonal de baja o tuerca');
