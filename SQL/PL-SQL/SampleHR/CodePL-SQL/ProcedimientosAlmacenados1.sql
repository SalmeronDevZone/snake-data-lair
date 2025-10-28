set setveroutput on;



create or replace procedure saludo
as
begin
    dbms_output.put_line('Hola a todos');
end saludo;
    
    
begin
    
    saludo;

end;
/

-------------------------------------------------------------------------------------------


create or replace PROCEDURE aumenta_precio
as
    begin
        update libros set precio = precio + (precio*0.5);
end aumenta_precio;

select * from libros;

execute aumenta_precio;




select * from user_objects where object_type = 'PROCEDURE';

select * from user_objects where object_type LIKE '%SALUDO%';


-------------------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE aumenta_sueldo(anio IN NUMBER, porcentaje IN NUMBER)
AS
BEGIN
    UPDATE empleados 
    SET sueldo = sueldo + (sueldo * porcentaje / 100)
    WHERE (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM fechaingreso)) < anio;
END aumenta_sueldo;


execure aumenta_sueldo(10,20) -- Los empleados con mas de 10 años en la empresa tendran un aumento del 20%
                                    -- en su salario.

-------------------------------------------------------------------------------------------

create or replace procedure ingresoemple(docu in char, nom in varchar2, ape in varchar2)
as
begin
    insert into empleados2 values(docu, nom, ape, null, null);
end ingresoemple;


select * from empleados2;

execute ingresoemple ('123456', 'Emilio', 'Perez');

drop procedure ingresoemple;


-------------------------------------------------------------------------------------------



create or replace procedure autorlibro (articulo in varchar2)
as
v_autor VARCHAR2(20);
begin

    select autor into v_autor from libros where titulo = articulo;
    
    insert into tabla1
    select titulo,precio from libros
        where autor = v_autor;
        
END autorlibro;

execute autorlibro('El quijote');

select * from tabla1;



