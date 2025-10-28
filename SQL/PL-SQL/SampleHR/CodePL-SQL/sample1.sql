set serveroutput on


DECLARE

identificador integer := 50;
nombre varchar2 (25) := 'Jose Feliciano';
apodo char(10) := 'joselo';
sueldo number(5) := 30000;
comision decimal (4,2) := 50.20;
fecha_actual date := (sysdate);
fecha date := to_date('2020/07/09', 'yyyy/mm/dd');
saludo varchar2(50) default 'Buenos dias a todos';


BEGIN

dbms_output.put_line(' El valor de la variable es: ' || identificador);

dbms_output.put_line(' El nombre del usuario es: ' || nombre);

dbms_output.put_line(' El sueldo es: ' || sueldo);

END;

-------------------------------------------------------------------------------------------

set serveroutput on


DECLARE

mensaje constant varchar2(20) := 'buenos dias a todos';
numero CONSTANT number(6) := 30000;


BEGIN

dbms_output.put_line(mensaje);

END;


-------------------------------------------------------------------------------------------


DECLARE 

    a number(2) := 10;
    b number(2) := 20;


BEGIN

    if a > b then

        dbms_output.put_line(a || ' es mayor que ' || b);
    
    else    --elsif
    
        dbms_output.put_line(b || ' es mayor que ' || a);
        
    end if;
        

END;





-------------------------------------------------------------------------------------------


DECLARE

    saludo varchar2(12) := 'hola a todos';
    
BEGIN

    dbms_output.put_line(UPPER(saludo));    -- Convierte Mayúscula.
    dbms_output.put_line(LOWER(saludo));    -- Convierte Minúsculas
    dbms_output.put_line(INITCAP(saludo));  -- Convierte mayu. primera letra.
    
    dbms_output.put_line(SUBSTR(saludo, 1, 1));    -- Un valor desde la posición 1. // Se puede poner solo un parámetro.
    dbms_output.put_line(INSTR(saludo, 't'));       -- Busca la posición del valor.
    
    
END;
/


-------------------------------------------------------------------------------------------



DECLARE

    saludo2 varchar2(30) := '###hola a todos###';
    
BEGIN

    dbms_output.put_line(RTRIM(saludo2, '#'));    
    dbms_output.put_line(LTRIM(saludo2, '#'));  
    dbms_output.put_line(TRIM('#' from saludo2));    
 
    
END;
/


-------------------------------------------------------------------------------------------
