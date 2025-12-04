SELECT CURRENT_TIMESTAMP FROM DUAL;
SELECT CURRENT_TIMESTAMP() FROM DUAL;
SELECT CURRENT_TIMESTAMP;
SELECT CURRENT_TIMESTAMP();

INSERT INTO suministros VALUES (5, CURRENT_DATE, 2);
INSERT INTO suministros VALUES (6, CURRENT_DATE, 4);

SELECT CURRENT_DATE;
SELECT CURRENT_DATE FROM DUAL;

SELECT USER, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYS_CONTEXT('USERENV', 'OS_USER')
FROM DUAL;

SELECT ASCII('a');
SELECT ASCII('a') from dual;

SELECT CHR(67),CHR(117),CHR(114),
CHR(115),CHR(111),CHR(32),
CHR(83),CHR(81),CHR(76) FROM DUAL;

SELECT nombre, LENGTH(nombre) AS longitud1, 
contacto, LENGTH(contacto) AS longitud2 
FROM proveedores;

SELECT LOCATE('a','Manzana');

SELECT INSTR('Melocotonero', 'loco');

SELECT DISTINCT clientes.nombre, clientes.apellido1, proveedores.contacto
    FROM clientes, proveedores
    WHERE LOWER(clientes.email) = LOWER(proveedores.email);

SELECT QUOTE(nombre) FROM proveedores WHERE codigo=5;

SELECT TRANSLATE('Es un tema peliagudo','aeiou','AEIOU') FROM DUAL;

SELECT TRIM('   texto    ') from dual;
SELECT TRIM(LEADING 'x' FROM 'xxxtextoxxx') from dual;
SELECT TRIM(BOTH 'x' FROM 'xxxtextoxxx') from dual;
SELECT TRIM(TRAILING 'bcd' FROM 'abcdtextoabcd') from dual;

SELECT TO_DATE('2022-02-11', 'YYYY-MM-DD') FROM DUAL;

SELECT DATE '2022-03-02' FROM DUAL;
SELECT TIMESTAMP '2022-03-02 20:03:22' FROM DUAL;

SELECT LAST_DAY(CURRENT_DATE) FROM DUAL;

SELECT TRUNC(17.9) FROM DUAL;

SELECT GREATEST(1,NULL,3) FROM DUAL;
SELECT LEAST(1,2,3) FROM DUAL;

SELECT CAST('123' AS DECIMAL) FROM DUAL;

SELECT DISTINCT nombre, 
tipo, 
CASE
 	   	WHEN TIPO = 'fruta' THEN 'Es una fruta'
    	WHEN TIPO = 'verdura' THEN 'Es una verdura'
    	ELSE 'Es otro tipo de producto'
    	END AS comentario
FROM productos
ORDER BY nombre;

SELECT nombre, apellido1, 
COALESCE(email, 'Sin correo-e') AS correo_e
FROM clientes ORDER BY apellido1, nombre;

SELECT codigo, fecha_pedido, 
NULLIF(forma_pago, 'Visa') AS forma_pago
FROM pedidos
ORDER BY fecha_pedido;

