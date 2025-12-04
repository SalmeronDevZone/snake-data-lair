GRANT ALL ON *.* TO 'prueba'@'localhost';

GRANT ALL ON fruteria.* TO 'prueba'@'localhost' WITH GRANT OPTION;

GRANT ALL ON fruteria.clientes TO 'prueba'@'localhost' WITH GRANT OPTION;

REVOKE INSERT ON *.* FROM 'prueba'@'localhost';

REVOKE INSERT ON fruteria.* FROM 'prueba'@'localhost';

REVOKE INSERT ON fruteria.clientes FROM 'prueba'@'localhost';

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'prueba'@'localhost';
