select * from dictionary;

select * from tabs;

select * from cols;

select * from user_catalog;
select * from user_col_comments;
select * from user_cons_columns;
select * from user_constraints;

SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name='PRODUCTOS';


select * from user_indexes;
select * from user_objects;
select * from user_tab_columns;
select * from user_tab_comments;
select * from user_tables;
SELECT table_name, tablespace_name 
FROM user_tables;

select * from user_tablespaces;
select * from user_users;
SELECT * FROM user_views;

select * from all_catalog;
select * from all_objects;
select * from all_tables;
select * from all_users;
SELECT username, created 
FROM all_users
ORDER BY username;

select * from all_views;

select * from dba_tables;
select * from dba_catalog;
select * from dba_objects;
select * from dba_users;

select parse_item,description from dbms_metadata_parse_items where object_type='TABLE';