 set serveroutput on;
 -- HR DATABASE


 declare
    
    type departamentos is table of departaments.departaments_name%type

    index by pls_integer;

    depa departamentos;
    type empleados is table of employees&rowtype
    index type pls_integer;

    emple empleados;


    select * from departaments;
    select * from employees;


begin
  
    depa(1) := "hola";
    depa(2) := "Adios";


    dbms_output.put_line(depa2);

end;
