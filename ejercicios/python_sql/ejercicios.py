"""Python + SQL: 10 ejercicios con sqlite3 (incluido en Python, no hay que instalar nada).

Lo que hace un data engineer cuando su código habla con una base de datos: crear el esquema,
cargar ficheros, consultar sin abrir la puerta a la inyección SQL, transacciones, upserts,
exportar, perfilar tablas, comparar versiones, evolucionar el esquema y cargar por lotes.

Completa cada función y comprueba con:   python -m unittest -v      (desde esta carpeta)
Las funciones que sigan lanzando NotImplementedError salen como "pendientes" (skipped).
Las soluciones están en soluciones.py: inténtalo antes de mirarlas.
"""
import csv  # noqa: F401
import re  # noqa: F401
import sqlite3
from itertools import islice  # noqa: F401
from pathlib import Path


def crear_esquema(con: sqlite3.Connection) -> None:
    """1 · 🟢 Activa las claves foráneas y crea, si no existen, estas dos tablas:
    clientes (id INTEGER PK, nombre TEXT obligatorio, email TEXT único, ciudad TEXT)
    pedidos  (id INTEGER PK, id_cliente obligatorio que referencia a clientes(id),
              importe NUMERIC obligatorio y >= 0, fecha TEXT obligatoria)
    Llamarla dos veces no debe fallar."""
    raise NotImplementedError


def cargar_csv(con: sqlite3.Connection, ruta: Path, tabla: str) -> int:
    """2 · 🟡 Carga un CSV con cabecera en `tabla` (las columnas se llaman como la cabecera) y
    devuelve cuántas filas ha insertado. Las celdas vacías se guardan como NULL.
    - Todo o nada: si una fila falla (por ejemplo, un id repetido), no debe quedar ninguna insertada.
    - El nombre de la tabla y de las columnas no pueden ir como parámetros '?': valida que sean
      identificadores simples (letras, números y _) y lanza ValueError si no lo son."""
    raise NotImplementedError


def clientes_de_ciudad(con: sqlite3.Connection, ciudad: str) -> list[str]:
    """3 · 🟢 Nombres de los clientes de una ciudad, ordenados. La ciudad la escribe un usuario:
    con "Madrid' OR '1'='1" no debe devolver todos los clientes (inyección SQL)."""
    raise NotImplementedError


def upsert_clientes(con: sqlite3.Connection, filas: list[dict]) -> tuple[int, int]:
    """4 · 🟡 Inserta los clientes nuevos y actualiza los existentes (por id) sólo si algo ha cambiado.
    Cada fila es un dict con id, nombre, email y ciudad. Devuelve (insertados, actualizados): un
    cliente que llega idéntico no cuenta como actualizado."""
    raise NotImplementedError


def transferir(con: sqlite3.Connection, origen: int, destino: int, importe: float) -> None:
    """5 · 🟡 Mueve `importe` de la cuenta `origen` a `destino` en la tabla cuentas(id, saldo).
    ValueError si el importe no es positivo, si una cuenta no existe o si no hay saldo suficiente.
    Debe ser ATÓMICO: si la segunda actualización falla, la primera se deshace (rollback)."""
    raise NotImplementedError


def exportar_csv(con: sqlite3.Connection, sql: str, ruta: Path, parametros: tuple = ()) -> int:
    """6 · 🟢 Ejecuta una consulta (con parámetros) y escribe el resultado en un CSV UTF-8 con una
    cabecera con los nombres de las columnas. Devuelve el número de filas de datos escritas."""
    raise NotImplementedError


def perfilar(con: sqlite3.Connection, tabla: str) -> dict:
    """7 · 🟡 Perfil de datos de una tabla: para cada columna, en el orden de la tabla,
    {"nulos": n, "distintos": n, "min": valor, "max": valor}.
    Pista: PRAGMA table_info. ValueError si la tabla no existe o el nombre no es un identificador válido."""
    raise NotImplementedError


def diferencias_sql(con: sqlite3.Connection, antes: str, despues: str, clave: str) -> dict:
    """8 · 🔴 Dos tablas con las mismas columnas (una foto de ayer y otra de hoy). Devuelve
    {"altas": [...], "bajas": [...], "cambios": [...]} con los valores de `clave` ordenados.
    Hazlo en SQL, no trayendo las tablas a Python. Pista: EXCEPT."""
    raise NotImplementedError


def asegurar_columna(con: sqlite3.Connection, tabla: str, columna: str, tipo: str) -> bool:
    """9 · 🟡 Evolución de esquema idempotente: añade la columna si no existe (True) o no hace nada
    si ya existe (False). `tipo` sólo puede ser TEXT, INTEGER, REAL, NUMERIC o BLOB (si no, ValueError)."""
    raise NotImplementedError


def cargar_por_lotes(con: sqlite3.Connection, filas, tamano: int) -> int:
    """10 · 🔴 Inserta (id, tipo) en la tabla eventos por lotes de `tamano` filas, con un commit por
    lote, y devuelve cuántos lotes ha hecho. `filas` puede ser un generador enorme: no lo conviertas
    en lista. Si un lote falla, los anteriores ya deben estar guardados. ValueError si tamano < 1."""
    raise NotImplementedError
