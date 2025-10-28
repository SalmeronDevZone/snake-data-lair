
create or replace function f_diasemana(numero int)
return varchar2
is
dia varchar(25);

BEGIN

    dia :='';
    
    case numero
        when 1 then dia := 'Lunes';
        when 2 then dia := 'Martes';
        when 3 then dia := 'Miercoles';
        when 4 then dia := 'Jueves';
        when 5 then dia := 'Viernes';
        when 6 then dia := 'Sabado';
        when 7 then dia := 'Domingo';
    end case;
    
    return dia;
    
END;

select f_diasemana(4) as "Dia de la semana" from dual;


-------------------------------------------------------------------------------------------



create or replace function f_trimestre (fecha date)
return varchar2
is
    mes varchar2(20);
    trimestre number;
    
BEGIN

    mes := extract(month from fecha);
    
    trimestre := 0;
    
    case mes
    
        when 1 then trimestre := 1;
        when 2 then trimestre := 1;
        when 3 then trimestre := 1;
        when 4 then trimestre := 2;
        when 5 then trimestre := 2;
        when 6 then trimestre := 2;
        when 7 then trimestre := 3;
        when 8 then trimestre := 3;
        when 9 then trimestre := 3;
        when 10 then trimestre := 4;
        when 11 then trimestre := 4;
        when 12 then trimestre := 4;
    
    end case;
    
    return trimestre;
    
END;
/

select f_trimestre (to_date( '07/01/2024', 'dd/mm/yyyy')) from dual;
