# 🐍 snake-data-lair

**SQL y Python para ingeniería de datos.** SQL en cinco motores (MySQL, Oracle, SQLite, SQL Server y Microsoft Fabric), PL/SQL, modelado dimensional y **22 ejercicios con corrección automática**.

[![ejercicios](https://github.com/SalmeronDevZone/snake-data-lair/actions/workflows/ejercicios.yml/badge.svg)](https://github.com/SalmeronDevZone/snake-data-lair/actions/workflows/ejercicios.yml)
![SQL](https://img.shields.io/badge/SQL-MySQL%20%C2%B7%20Oracle%20%C2%B7%20SQLite%20%C2%B7%20T--SQL-4479A1?logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-pandas-3776AB?logo=python&logoColor=white)

## Empieza por aquí: los ejercicios

```bash
git clone https://github.com/SalmeronDevZone/snake-data-lair.git
cd snake-data-lair/ejercicios/sql
python comprobar.py           # ⏳ 13 pendientes: abre 01_importe_por_categoria.sql y a por ello
```

| Banco | Ejercicios | Lo más interesante |
| --- | --- | --- |
| [**SQL**](ejercicios/README.md#sql-13-ejercicios-en-sql) | 13 | Funciones de ventana, deduplicación de cargas, huecos e islas, sesionización, data quality checks, upsert incremental, **SCD tipo 2**, CTE recursivas |
| [**pandas**](ejercicios/README.md#pandas-9-ejercicios-en-pandas) | 9 | Limpieza de valores centinela, métricas derivadas, IQR, escritura particionada estilo data lake |

Cada ejercicio trae enunciado, pista y solución de referencia, y un corrector que compara tu resultado con el esperado. La CI comprueba en cada push que todas las soluciones siguen funcionando.

## Qué más hay

| Carpeta | Contenido |
| --- | --- |
| [`SQL/MYSQL/`](SQL/MYSQL/) | Curso completo sobre la base de datos «frutería», con versiones **MySQL, Oracle y SQLite** de cada script: creación (003), carga (005), consultas (005-006), funciones (007), vistas (008), catálogo del sistema, permisos y transacciones (009). Más la base de datos «ofertas de trabajo» (`Samples.sql`, `basics.sql`) |
| [`SQL/PL-SQL/SampleHR/`](SQL/PL-SQL/SampleHR/) | Esquema **HR de Oracle** (usuario, tablas, carga e índices) y 15 scripts de **PL/SQL**: bloques anónimos, `%ROWTYPE`, bucles, cursores, funciones, procedimientos, paquetes, triggers, jobs, tipos objeto, colecciones y consultas jerárquicas (`CONNECT BY`) |
| [`SQL/T-SQL/`](SQL/T-SQL/) | **SQL Server**: base de datos de ventas, compras y RR. HH. con carga masiva (`BULK INSERT`). `fabric1.sql`: **modelo en estrella** (`DimCustomer`, `DimDate`, `DimProduct`, `FactSalesOrder`) para un warehouse de **Microsoft Fabric** |
| [`SQL/LeetCode/`](SQL/LeetCode/) | Problemas de SQL de LeetCode resueltos: selects y joins |
| [`SQL/SimpleSampleS/`](SQL/SimpleSampleS/) | Script de creación de la base de datos Northwind |
| [`Python/NoteBooks/LowElo/`](Python/NoteBooks/LowElo/) | Notebooks de lectura y escritura de ficheros con `open()` |
| [`Python/Pandas/`](Python/Pandas/) | `cars.csv`, el conjunto de datos de los ejercicios de pandas |

## Mapa de conceptos

| Concepto | Dónde practicarlo |
| --- | --- |
| Joins, agregaciones, subconsultas | `SQL/MYSQL/006_script01_Consultas.sql`, `SQL/LeetCode/`, ejercicios 01-02 |
| Funciones de ventana | Ejercicios 03-08 |
| Modelado dimensional y SCD | `SQL/T-SQL/fabric1.sql`, ejercicio 12 |
| Cargas incrementales e idempotentes | Ejercicios 06 y 11 |
| Calidad de datos | Ejercicio 10, ejercicios de pandas 2 y 8 |
| Lógica procedimental en la base de datos | `SQL/PL-SQL/SampleHR/CodePL-SQL/` |
| Transacciones y permisos | `SQL/MYSQL/009_script03_permisos_MySQL.sql`, `009_script04_transacciones.sql` |
| Jerarquías | `Jerarquias.sql` (Oracle `CONNECT BY`) y ejercicio 13 (`WITH RECURSIVE`) |

---

**Jesús Salmerón** · Data Engineer · [GitHub](https://github.com/SalmeronDevZone) · [LinkedIn](https://www.linkedin.com/in/jesussalmeronarmario/) · Licencia MIT
