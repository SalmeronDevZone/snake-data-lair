create or replace function f_prueba(valor number)
return number
is
begin
    
    return valor*2;
    
END;


select f_prueba(2) as total from dual;

-------------------------------------------------------------------------------------------


create or replace function f_costo (valor number)
return varchar
is
costo varchar(20);

BEGIN

    costo :='';
    
    if valor <= 500 then
        costo := 'economico';
        else costo := 'caro';
    end if;
    
    return costo;
    
END;

select f_costo(350) as coste from dual;

select titulo, autor, precio, f_costo(precio) from libros

-------------------------------------------------------------------------------------------
