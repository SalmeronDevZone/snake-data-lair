--CREACION DEL PAQUETE
create or replace package los_productos as
    procedure caracteristicas(v_codigo productos.codigoproducto%type);
end los_productos;


--CREACION DEL CUERPO DEL PAQUETE

create or replace package body los_productos as
procedure caracteristicas (v_codigo productos.codigoproducto%type) is
    v_producto productos.nombre%type;
    v_precio productos.precioventa%type;
    
BEGIN

    select nombre, precioventa into v_producto, v_precio
        from productos where codigoproducto = v_codigo;
        
    dbms_output.put_line('Articulo: ' || v_produto);
    dbms_output.put_line('Precio: ' || v_precio);
    
    end caracteristicas;
    
end los_productos;


BEGIN
    los_productos.caracteristicas('11679');
END;
   
