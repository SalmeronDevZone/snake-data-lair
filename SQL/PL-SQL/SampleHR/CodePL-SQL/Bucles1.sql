declare

    valor number := 10;     -- SI no se espécifica, => number(38);
    
begin

    loop
        
        dbms_output.put_line(valor);
        valor := valor +10;
        
        if valor > 50 then
            exit;
        end if;
        
    end loop;
        
        dbms_output.put_line('El valor Final es = ' || valor);

END;



-------------------------------------------------------------------------------------------




DECLARE

    nombre varchar2(20);
    direccion varchar2(30);
    detalles clob;
    eleccion char(1);
    
BEGIN

    nombre := 'Pedro Perez';
    direccion := 'Calle primavera no1';
    detalles := '
        En Oracle Database, el tipo de datos CLOB (Character Large Object) se utiliza para almacenar
         datos de caracteres de longitud muy larga, como texto largo, documentos, XML, archivos de texto grandes, 
        y otros tipos de datos de caracteres que exceden el límite de longitud de los tipos de datos VARCHAR2.';
    eleccion := 'y';
    
    if eleccion = 'y' then 
    
        dbms_output.put_line(nombre);
        dbms_output.put_line(direccion);
        dbms_output.put_line(detalles);
        
    end if;

END;
/


-------------------------------------------------------------------------------------------


DECLARE

    valor number(2) := 10;

BEGIN

    while valor <= 40 loop
    
        dbms_output.put_line('El valor es: ' || valor);
        valor := valor +5;
        
    end loop;
    
END;
/


-------------------------------------------------------------------------------------------


DECLARE

    numero number := 0;
    resultado number;
    
BEGIN

    while numero <= 10 loop
    
        resultado := 3*numero;
        dbms_output.put_line('numero = ' || numero || '. Resultado = ' || resultado);
        numero := numero + 1;
        
    end loop;
    
END;
/

-------------------------------------------------------------------------------------------



declare

    numero number(2);
    
BEGIN

    for numero in 10..20 loop
    
        dbms_output.put_line(' El valor del número es: '|| numero);
        
    end loop;
    
END;
/

-------------------------------------------------------------------------------------------

BEGIN

    for f in reverse 0..5 loop
    
        dbms_output.put_line(' El valor de f es: '|| f);
        
    end loop;
    
END;
/

-------------------------------------------------------------------------------------------

BEGIN

    for f in 1..10 loop
    
        dbms_output.put_line('2 x ' || f || ' = ' || (f*2));    --tabla del 2.
        
    end loop;
    
END;
/

-------------------------------------------------------------------------------------------


declare

    bucle1 number := 0;
    bucle2 number;
    
 begin
 
    loop
        
        dbms_output.put_line('----------------------');
        dbms_output.put_line('Valor del bucle externo: ' || bucle1);
        dbms_output.put_line('----------------------');
        bucle2 := 0;
        
        loop
        
            dbms_output.put_line('Valor del segundo bucle: ' || bucle2);
            bucle2 :=  bucle2 + 1;
            
            exit when bucle2 = 5;
        
        end loop;
        
        bucle1 := bucle1 + 1;
        exit when bucle1 = 3;
        
    end loop;
    
END;
/

-------------------------------------------------------------------------------------------

declare

    type a_paises is varray(5) of varchar2(20);
    nombre a_paises;    -- nombre es de tipo array
    
begin

    nombre := a_paises('Argentina', 'Brasil', 'España', 'Mexico', 'Peru');
    for j in 1..5 loop
        
        dbms_output.put_line('Nombre: ' || nombre(j));
        
    end loop;
    
END;
/

-------------------------------------------------------------------------------------------


declare


    type matriz_nombres is varray(5) of varchar2(20);
    type matriz_edad is varray(5) of integer;
    nombres matriz_nombres;
    edad matriz_edad;
    total integer;
    
    
begin

    nombres:= matriz_nombres('Jose', 'Antonio', 'Jesus', 'Marta', 'Alberto');
    edad := matriz_edad (34,65,77,44,22);
    total := nombres.count;
    
    for j in 1..total loop
    
        dbms_output.put_line('Nombre: ' || nombres(j) || ' / Edad :' || edad(j));
        
    end loop;
    
END;
/
