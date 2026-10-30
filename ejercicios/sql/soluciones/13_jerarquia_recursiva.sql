-- EJERCICIO 13 · Organigrama con CTE recursiva                                🔴 Difícil
-- Recorre el organigrama desde la dirección hacia abajo. Para cada empleado: su nivel
-- (la directora es el 1) y la ruta desde la cima, con los nombres separados por ' > '.
-- Columnas: id_empleado, nombre, nivel, ruta. Ordena por ruta.
-- Pista: WITH RECURSIVE: caso base (id_jefe IS NULL) UNION ALL el paso recursivo.
-- En Oracle lo mismo se hace con CONNECT BY (ver SQL/PL-SQL/SampleHR/CodePL-SQL/Jerarquias.sql).

WITH RECURSIVE organigrama AS (
    SELECT id_empleado, nombre, 1 AS nivel, nombre AS ruta
    FROM empleados
    WHERE id_jefe IS NULL
    UNION ALL
    SELECT e.id_empleado, e.nombre, o.nivel + 1, o.ruta || ' > ' || e.nombre
    FROM empleados e
    JOIN organigrama o ON e.id_jefe = o.id_empleado
)
SELECT id_empleado, nombre, nivel, ruta
FROM organigrama
ORDER BY ruta;
