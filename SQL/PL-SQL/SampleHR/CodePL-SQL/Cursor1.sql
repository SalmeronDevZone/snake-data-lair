set serveroutput on;


DECLARE
    filas NUMBER(2);
BEGIN
    UPDATE empleados4 
        SET sueldo = sueldo + 500 WHERE sueldo >= 9000;
    
    IF SQL%ROWCOUNT = 0 THEN 
        DBMS_OUTPUT.PUT_LINE(' -- NO HAY EMPLEADOS DISPONIBLES -- ');
    ELSE
        filas := SQL%ROWCOUNT;
        DBMS_OUTPUT.PUT_LINE(filas || ' : EMPLEADOS ACTUALIZADOS');
    END IF;
END;
/

-------------------------------------------------------------------------------------------



DECLARE

    v_docu empleados4.documento%type;
    v_nom empleados4.nombre%type;
    v_ape empleados4.apellido%type;
    v_suel empleados4.sueldo%type;
    
    cursor c_cursor2 is
    
        select documento, nombre, apellido, sueldo
            from empleados4 where documento = 22222222;
            
BEGIN

    open c_cursor2; --Abrir cursor
    fetch c_cursor2 into v_docu, v_nom, v_ape, v_suel;   --Extraemos los registros del cursor 
    close c_cursor2;    --Cerrar el cursor, un cursor explícito nunca debe quedar abierto.
    
    dbms_output.put_line('Documento : ' || v_docu);
    dbms_output.put_line('Nombre : ' || v_nom);
    dbms_output.put_line('Apellido : ' || v_ape);
    dbms_output.put_line('Sueldo : ' || v_suel);
    
END;
/


-------------------------------------------------------------------------------------------



DECLARE

    v_empleados empleados4%rowtype;
    
BEGIN

    for v_empleados in( select * from empleados4 ) loop
    
        dbms_output.put_line( v_empleados.sueldo );
        
    end loop;
    
END;
/


-------------------------------------------------------------------------------------------


DECLARE

    v_nom productos.nombre_producto%type;
    v_pre productos.precio%type;
    
    cursor c_productos (idprod productos.id_producto%type)
    
    is
    
        select nombre_producto, precio from productos where id_producto = idprod;
        
BEGIN

    open c_productos(2);
    loop
        fetch c_productos into v_nom, v_pre;
        exit when c_productos%notfound;
        dbms_output.put_line(' Articulo: ' || v_nom || ', precio: ' || v_pre);
    end loop;
    close c_productos;
    
END;
/


-------------------------------------------------------------------------------------------


-- REF CURSORS

create or replace function f_datoempleados (v_documento in number)
return sys_refcursor
is
    v_ref sys_refcursor;
    
BEGIN
    
    open v_ref for select * from empleados
        where documento = v_documento;
    
    return v_ref;
    
END;
