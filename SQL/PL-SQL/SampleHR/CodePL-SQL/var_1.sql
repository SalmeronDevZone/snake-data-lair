-- Variables compuestas basadas en una tabla:

DECLARE

    reg_productos productos%rowtype;
    
BEGIN

    select * into reg_productos from productos where codigoproducto = '11679';

    dbms_output.put_line('Caracteristicas del producto');
    dbms_output.put_line('Articulo: ' || reg_productos.nombre);
    dbms_output.put_line('Gama: ' || reg_productos.gama);
    dbms_output.put_line('Precio del producto: ' || reg_productos.precioventa || '€.');
    dbms_output.put_line('Proveedor: ' || reg_productos.proveedor);

END;
/

-------------------------------------------------------------------------------------------


-- variable compuesta a nivel de cursor


DECLARE

    cursor cu_productos is
        select * from productos;
        
    var_productos cu_productos%rowtype;
    
BEGIN

    open cu_productos;
    
    loop
        fetch cu_productos into var_productos;
        exit when cu_productos%notfound;
        dbms_output.put_line(var_productos.codigoproducto || ' ' || var_productos.nombre);
    end loop;
    
END;
/
