SELECT schema_name
FROM information_schema.schemata;

SHOW databases;

SELECT schema_name AS 'Nombre de base de datos'
FROM information_schema.schemata
ORDER BY schema_name;

SELECT table_name, table_rows, table_type
FROM information_schema.tables
WHERE table_schema = 'fruteria'
ORDER BY table_name;

SELECT table_name,column_name, is_nullable, column_key, data_type, column_default
FROM information_schema.columns
WHERE table_schema = 'fruteria'
ORDER BY table_name;

SELECT constraint_name, check_clause
FROM information_schema.check_constraints
WHERE constraint_schema = 'fruteria'
ORDER BY constraint_name;

SELECT table_name, constraint_type
FROM information_schema.table_constraints
WHERE constraint_schema = 'fruteria'
ORDER BY table_name;

SELECT table_name, view_definition, is_updatable
FROM information_schema.views
WHERE table_schema = 'fruteria';

