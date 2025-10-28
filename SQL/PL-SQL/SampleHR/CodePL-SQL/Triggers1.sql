create or replace trigger tr_ingresaLibros
before insert
on libros

BEGIN

    insert into control values (user, sysdate);
    
END tr_ingresaLibros;



-------------------------------------------------------------------------------------------


create or replace trigger ingresaEmpleados
before insert
on empleados
for each row

BEGIN

    insert into control values(user, sysdate);
    
END ingresaEmpleados;


-------------------------------------------------------------------------------------------


create or replace trigger borrarAlumnos
before delete 
on alumnos 
for each row 

BEGIN 

    insert into control values(user, sysdate);

END borrarAlumnos;


-------------------------------------------------------------------------------------------

create or replace trigger actualiza 
before update 
on empleados 
for each row 

begin
  
  insert into control values(user, sysdate);
  
end actualiza;

-------------------------------------------------------------------------------------------

create or replace trigger tr_control_empleados
before insert or update or delete
on empleados

BEGIN
    
    if inserting then
        insert into control_empleados values (user, sysdate, 'ingreso');
    end if;
    
    if updating then
        insert into control_empleados values (user, sysdate, 'actualiazción');
    end if;
    
    if deleting then
        insert into control_empleados values (user, sysdate, 'borrado');
    end if;
        
END tr_control_empleados;


-------------------------------------------------------------------------------------------



CREATE OR REPLACE TRIGGER example_trigger
BEFORE INSERT OR UPDATE OR DELETE ON example_table
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        
        DBMS_OUTPUT.PUT_LINE('Se está insertando una nueva fila');
    ELSIF UPDATING THEN

        DBMS_OUTPUT.PUT_LINE('Se está actualizando una fila existente');
        DBMS_OUTPUT.PUT_LINE('Valor antiguo de la columna X: ' || :old.column_x);
        DBMS_OUTPUT.PUT_LINE('Valor nuevo de la columna X: ' || :new.column_x);
    ELSIF DELETING THEN
        
        DBMS_OUTPUT.PUT_LINE('Se está eliminando una fila existente');
        DBMS_OUTPUT.PUT_LINE('Valor antiguo de la columna Y: ' || :old.column_y);
    END IF;
END;
/


-------------------------------------------------------------------------------------------


create or replace trigger tr_ingresaLibros
before insert
on libros
for each row

BEGIN

    if(:new.precio<=30)then
        insert into ofertas values(:new.codigo, :new.precio,  user, sysdate);
    end if;

END tr_ingresaLibros;


-------------------------------------------------------------------------------------------



create or replace trigger tr_actualizaLibros
before update of precio
on libros
for each row 

BEGIN

    if(:old.precio <= 30) and (:new.precio > 30) then 
        delete from ofertas where codigo = :old.codigo;
    end if;
    
    if(:old.precio > 30) and (:new.precio <= 30) then 
        insert into ofertas values( :new.codigo, :new.precio, user, sysdate);
    end if;
    
END tr_actualizalibros;


-------------------------------------------------------------------------------------------



create or replace trigger tr_aumentaSueldo
before update of sueldo 
on empleados 
for each row when (new.sueldo>old.sueldo)

BEGIN 

    insert into control values (user, sysdate, :old.documento, :old.sueldo, :new.sueldo);

END tr_aumentaSueldo;


-------------------------------------------------------------------------------------------


create or replace trigger tr_actualiza_datos
before insert
on empleados
for each row

BEGIN

    :new.apellido := upper(:new.apellido);
    
    if :new.sueldo is null then
        :new.sueldo := 0;
    end if;
    
END tr_actualiza_datos;



-------------------------------------------------------------------------------------------



create or replace trigger tr_control_empleados
before insert or update or delete
on empleados
for each row

BEGIN

    if(:new.sueldo > 5000) then
        raise_application_error(-20000, 'SUELDO NO PUEDE SUPERAR LOS 5.000');
    end if;
    
    insert into control values( user, sysdate, 'INSERCION');
    
    if(:old.seccion = 'Gerencia') then 
        raise_application_error( -20000, 'NO SE PUEDE ELIMINAR EL PUESTO DE GERENCIA');
    end if;
    
    insert into control values (user, sysdate, 'BORRADO');
    
    if updating ('documento') then 
        raise_application_error ( -20000, 'NO SE PUEDE ACTUALIZAR NUMERO DE DOCUMENTOS');
    end if;
    
END tr_control_empeados;

-------------------------------------------------------------------------------------------


