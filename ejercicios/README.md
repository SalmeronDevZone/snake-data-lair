# Ejercicios con corrección automática

**45 ejercicios resueltos** de ingeniería de datos en tres bancos, cada uno con su solución de referencia y un corrector que te dice al momento si tu respuesta es correcta. Sólo necesitas Python 3 (y pandas para el de pandas).

| Banco | Ejercicios | Cómo se comprueba |
| --- | --- | --- |
| [SQL](#sql-26-ejercicios-en-sql) | 26 | `python comprobar.py` |
| [pandas](#pandas-9-ejercicios-en-pandas) | 9 | `python -m unittest -v` |
| [Python + SQL](#python--sql-10-ejercicios-en-python_sql) | 10 | `python -m unittest -v` |

## SQL: 26 ejercicios en [`sql/`](sql/)

Una tienda online en SQLite (clientes, productos, pedidos, líneas, clics en la web, organigrama, inventario, eventos JSON...) con errores a propósito para practicar calidad de datos.

```bash
cd ejercicios/sql
# 1. Abre un ejercicio (por ejemplo 06_deduplicar_cargas.sql) y escribe tu consulta debajo del enunciado
# 2. Compruébalo:
python comprobar.py 06        # sólo ese
python comprobar.py           # todos
```

```
✅ 06_deduplicar_cargas
❌ 07_huecos_e_islas: el resultado no coincide
      esperado (6 filas): [['2025-01-03', '2025-01-05', 3], ...]
      obtenido (1 filas): [['2025-01-03', '2025-03-20', 16]]
⏳ 08_sesiones_web: pendiente
```

| # | Ejercicio | Nivel | Técnica |
| --- | --- | --- | --- |
| 01 | Importe por categoría | 🟢 | `JOIN` + `GROUP BY` |
| 02 | Clientes sin pedidos | 🟢 | Anti-join (`NOT EXISTS`) |
| 03 | El producto estrella de cada categoría | 🟡 | Top-N por grupo con `RANK()` |
| 04 | Ventas diarias y total acumulado | 🟡 | `SUM() OVER (ORDER BY ...)` |
| 05 | Crecimiento mes a mes | 🟡 | `LAG()` |
| 06 | Deduplicar una tabla de carga | 🟡 | `ROW_NUMBER()`: la última versión de cada registro |
| 07 | Huecos e islas: rachas de días con pedidos | 🔴 | Gaps & islands |
| 08 | Sesionizar clics web | 🔴 | `LAG()` + suma acumulada de marcas |
| 09 | Tabla dinámica por mes | 🟡 | Pivot con `CASE WHEN` |
| 10 | Informe de calidad de datos | 🟡 | Data quality checks con `UNION ALL` |
| 11 | Carga incremental con upsert | 🟡 | `INSERT ... ON CONFLICT DO UPDATE` sólo si cambia algo |
| 12 | Dimensión con historial | 🔴 | SCD tipo 2 |
| 13 | Organigrama | 🔴 | `WITH RECURSIVE` |
| 14 | Segmentar clientes en cuartiles | 🟡 | `NTILE()` con desempate reproducible |
| 15 | Análisis de cohortes | 🔴 | Retención por mes de primera compra |
| 16 | Segmentación RFM | 🟡 | Recencia, frecuencia y valor con `julianday` y `CASE` |
| 17 | Cesta de la compra | 🟡 | Auto-join: productos que se compran juntos |
| 18 | Media frente a mediana | 🟡 | Mediana sin `MEDIAN`, con `ROW_NUMBER()` |
| 19 | Media móvil | 🟡 | `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` |
| 20 | Un calendario sin huecos | 🟡 | Días generados con `WITH RECURSIVE` + `LEFT JOIN` |
| 21 | De formato ancho a largo | 🟢 | Unpivot con `UNION ALL` |
| 22 | Conciliar dos sistemas | 🟡 | `FULL OUTER JOIN` (y cómo emularlo) |
| 23 | Datos semiestructurados | 🔴 | `json_extract` y `json_each` sin duplicar importes |
| 24 | Stock al cierre de cada día | 🟡 | Suma acumulada por producto y alertas |
| 25 | Aplicar cambios capturados (CDC) | 🔴 | Última operación por clave, `DELETE` + upsert |
| 26 | Rellenar huecos con el último valor | 🔴 | Forward fill / LOCF sobre un calendario |

Las soluciones están en [`sql/soluciones/`](sql/soluciones/). Inténtalo antes de mirarlas.

## pandas: 9 ejercicios en [`pandas/`](pandas/)

Sobre [`Python/Pandas/cars.csv`](../Python/Pandas/cars.csv), un conjunto clásico de 406 coches con trampas reales: separador `;`, una fila de tipos que no es de datos y ceros que en realidad significan «dato desconocido».

```bash
cd ejercicios/pandas
pip install pandas
# Completa las funciones de ejercicios.py y comprueba:
python -m unittest -v
```

| # | Función | Nivel | Qué practicas |
| --- | --- | --- | --- |
| 1 | `cargar` | 🟢 | `read_csv` con separador y filas que saltar |
| 2 | `limpiar` | 🟢 | Valores centinela → `NaN`, no mutar la entrada |
| 3 | `anadir_metricas` | 🟢 | Columnas derivadas: l/100 km, kg, año |
| 4 | `consumo_por_origen` | 🟡 | `groupby` + orden |
| 5 | `top_potencia` | 🟡 | `nlargest` |
| 6 | `evolucion_anual` | 🟡 | Agregaciones con nombre + `pct_change` |
| 7 | `tabla_cilindros` | 🟡 | `crosstab` |
| 8 | `atipicos` | 🔴 | Detección de atípicos por IQR |
| 9 | `exportar_por_origen` | 🔴 | Escritura particionada `origen=US/coches.csv` |

## Python + SQL: 10 ejercicios en [`python_sql/`](python_sql/)

Lo que pasa cuando tu código Python habla con una base de datos. Con `sqlite3`, que viene con Python: no hay que instalar nada.

```bash
cd ejercicios/python_sql
# Completa las funciones de ejercicios.py y comprueba:
python -m unittest -v
```

| # | Función | Nivel | Qué practicas |
| --- | --- | --- | --- |
| 1 | `crear_esquema` | 🟢 | DDL con restricciones: claves foráneas, `UNIQUE`, `CHECK`, `NOT NULL` |
| 2 | `cargar_csv` | 🟡 | `executemany` en una transacción (todo o nada) y validación de identificadores |
| 3 | `clientes_de_ciudad` | 🟢 | Consultas parametrizadas: a prueba de inyección SQL |
| 4 | `upsert_clientes` | 🟡 | `ON CONFLICT DO UPDATE` contando sólo los cambios reales |
| 5 | `transferir` | 🟡 | Transacciones atómicas y *rollback* |
| 6 | `exportar_csv` | 🟢 | Del cursor a un CSV con cabecera (`cursor.description`) |
| 7 | `perfilar` | 🟡 | Perfilado de datos: nulos, distintos, mínimo y máximo por columna |
| 8 | `diferencias_sql` | 🔴 | Altas, bajas y cambios entre dos tablas con `EXCEPT` |
| 9 | `asegurar_columna` | 🟡 | Evolución de esquema idempotente (`PRAGMA table_info`, `ALTER TABLE`) |
| 10 | `cargar_por_lotes` | 🔴 | Carga por lotes desde un generador, con un commit por lote |

Las pruebas comprueban también lo que no se ve: que una carga a medias no deja datos, que una transferencia que falla se deshace y que un nombre de tabla malicioso no se ejecuta. Soluciones en [`python_sql/soluciones.py`](python_sql/soluciones.py).

## Integración continua

En cada push, GitHub Actions comprueba que las soluciones de referencia siguen dando el resultado esperado ([workflow](../.github/workflows/ejercicios.yml)).
