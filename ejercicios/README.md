# Ejercicios con corrección automática

Dos bancos de ejercicios de ingeniería de datos, con solución de referencia y un corrector que te dice al momento si tu respuesta es correcta. Sólo necesitas Python 3 (y pandas para el segundo).

## SQL: 13 ejercicios en [`sql/`](sql/)

Una tienda online en SQLite (clientes, productos, pedidos, líneas, clics en la web, organigrama...) con errores a propósito para practicar calidad de datos.

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

## Integración continua

En cada push, GitHub Actions comprueba que las soluciones de referencia siguen dando el resultado esperado ([workflow](../.github/workflows/ejercicios.yml)).
