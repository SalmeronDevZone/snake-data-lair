create table log_actividades (
    id_log int not null,
    fecha date
    );
    
    

begin

    sys.dbms_scheduler.create_job(
    
        job_name => 'job_uno',
        job_type => 'PLSQL_BLOCK',
        job_action => declare
        
            v_conteo number := 0;
            
        begin
            
            select count(*) into v_conteo
            from log_actividades;
            
            insert into log_actividades values ( v_conteo + 1, sysdate);

            COMMIT;

        end;
    
start_date => systimestamp,
repeat_interval => 'freq=secondly ; interval = 5';
end_date => null,
enabled => true,
comments => 'log de actividades');

END;
/
