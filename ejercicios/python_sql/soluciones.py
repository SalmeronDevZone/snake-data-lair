"""Soluciones de referencia de los ejercicios de Python + SQL (sqlite3). Inténtalo antes de mirarlas."""
import csv
import re
import sqlite3
from itertools import islice
from pathlib import Path

IDENTIFICADOR = re.compile(r"[A-Za-z_][A-Za-z0-9_]*")


def comprobar_identificador(nombre: str) -> str:
    """Los nombres de tablas y columnas no admiten parámetros '?': hay que validarlos a mano."""
    if not IDENTIFICADOR.fullmatch(nombre or ""):
        raise ValueError(f"identificador no válido: {nombre!r}")
    return nombre


def crear_esquema(con: sqlite3.Connection) -> None:
    con.execute("PRAGMA foreign_keys = ON")
    con.executescript(
        """
        CREATE TABLE IF NOT EXISTS clientes (
            id     INTEGER PRIMARY KEY,
            nombre TEXT NOT NULL,
            email  TEXT UNIQUE,
            ciudad TEXT
        );
        CREATE TABLE IF NOT EXISTS pedidos (
            id         INTEGER PRIMARY KEY,
            id_cliente INTEGER NOT NULL REFERENCES clientes (id),
            importe    NUMERIC NOT NULL CHECK (importe >= 0),
            fecha      TEXT NOT NULL
        );
        """
    )


def cargar_csv(con: sqlite3.Connection, ruta: Path, tabla: str) -> int:
    with open(ruta, newline="", encoding="utf-8") as f:
        lector = csv.reader(f)
        columnas = [comprobar_identificador(c.strip()) for c in next(lector)]
        filas = [tuple(v if v != "" else None for v in fila) for fila in lector]
    sql = f'INSERT INTO "{comprobar_identificador(tabla)}" ({", ".join(columnas)}) VALUES ({", ".join("?" * len(columnas))})'
    with con:  # una transacción: o entran todas las filas o ninguna
        con.executemany(sql, filas)
    return len(filas)


def clientes_de_ciudad(con: sqlite3.Connection, ciudad: str) -> list[str]:
    filas = con.execute("SELECT nombre FROM clientes WHERE ciudad = ? ORDER BY nombre", (ciudad,))
    return [nombre for (nombre,) in filas]


def upsert_clientes(con: sqlite3.Connection, filas: list[dict]) -> tuple[int, int]:
    insertados = actualizados = 0
    with con:
        for fila in filas:
            actual = con.execute("SELECT nombre, email, ciudad FROM clientes WHERE id = ?", (fila["id"],)).fetchone()
            nuevo = (fila["nombre"], fila.get("email"), fila.get("ciudad"))
            if actual is None:
                insertados += 1
            elif tuple(actual) != nuevo:
                actualizados += 1
            else:
                continue
            con.execute(
                """INSERT INTO clientes (id, nombre, email, ciudad) VALUES (?, ?, ?, ?)
                   ON CONFLICT (id) DO UPDATE SET nombre = excluded.nombre, email = excluded.email, ciudad = excluded.ciudad""",
                (fila["id"], *nuevo),
            )
    return insertados, actualizados


def transferir(con: sqlite3.Connection, origen: int, destino: int, importe: float) -> None:
    if importe <= 0:
        raise ValueError("el importe debe ser positivo")
    with con:  # si algo falla dentro, se deshace todo (rollback)
        saldo = con.execute("SELECT saldo FROM cuentas WHERE id = ?", (origen,)).fetchone()
        if saldo is None or con.execute("SELECT 1 FROM cuentas WHERE id = ?", (destino,)).fetchone() is None:
            raise ValueError("cuenta inexistente")
        if saldo[0] < importe:
            raise ValueError("saldo insuficiente")
        con.execute("UPDATE cuentas SET saldo = saldo - ? WHERE id = ?", (importe, origen))
        con.execute("UPDATE cuentas SET saldo = saldo + ? WHERE id = ?", (importe, destino))


def exportar_csv(con: sqlite3.Connection, sql: str, ruta: Path, parametros: tuple = ()) -> int:
    cursor = con.execute(sql, parametros)
    filas = cursor.fetchall()
    with open(ruta, "w", newline="", encoding="utf-8") as f:
        escritor = csv.writer(f)
        escritor.writerow([c[0] for c in cursor.description])
        escritor.writerows(filas)
    return len(filas)


def perfilar(con: sqlite3.Connection, tabla: str) -> dict:
    tabla = comprobar_identificador(tabla)
    columnas = [fila[1] for fila in con.execute(f'PRAGMA table_info("{tabla}")')]
    if not columnas:
        raise ValueError(f"la tabla {tabla} no existe")
    perfil = {}
    for col in columnas:
        nulos, distintos, minimo, maximo = con.execute(
            f'SELECT SUM("{col}" IS NULL), COUNT(DISTINCT "{col}"), MIN("{col}"), MAX("{col}") FROM "{tabla}"'
        ).fetchone()
        perfil[col] = {"nulos": nulos or 0, "distintos": distintos, "min": minimo, "max": maximo}
    return perfil


def diferencias_sql(con: sqlite3.Connection, antes: str, despues: str, clave: str) -> dict:
    antes, despues, clave = (comprobar_identificador(x) for x in (antes, despues, clave))

    def claves(sql: str) -> list:
        return [fila[0] for fila in con.execute(sql)]

    return {
        "altas": claves(f'SELECT "{clave}" FROM "{despues}" EXCEPT SELECT "{clave}" FROM "{antes}" ORDER BY 1'),
        "bajas": claves(f'SELECT "{clave}" FROM "{antes}" EXCEPT SELECT "{clave}" FROM "{despues}" ORDER BY 1'),
        "cambios": claves(
            f'SELECT "{clave}" FROM (SELECT * FROM "{despues}" EXCEPT SELECT * FROM "{antes}") '
            f'WHERE "{clave}" IN (SELECT "{clave}" FROM "{antes}") ORDER BY 1'
        ),
    }


def asegurar_columna(con: sqlite3.Connection, tabla: str, columna: str, tipo: str) -> bool:
    tabla, columna = comprobar_identificador(tabla), comprobar_identificador(columna)
    if tipo.upper() not in {"TEXT", "INTEGER", "REAL", "NUMERIC", "BLOB"}:
        raise ValueError(f"tipo no permitido: {tipo}")
    existentes = {fila[1].lower() for fila in con.execute(f'PRAGMA table_info("{tabla}")')}
    if columna.lower() in existentes:
        return False
    con.execute(f'ALTER TABLE "{tabla}" ADD COLUMN "{columna}" {tipo.upper()}')
    return True


def cargar_por_lotes(con: sqlite3.Connection, filas, tamano: int) -> int:
    if tamano < 1:
        raise ValueError("el tamaño del lote debe ser al menos 1")
    iterador, lotes = iter(filas), 0
    while lote := list(islice(iterador, tamano)):
        with con:  # un commit por lote: si falla el lote 3, los dos primeros ya están guardados
            con.executemany("INSERT INTO eventos (id, tipo) VALUES (?, ?)", lote)
        lotes += 1
    return lotes
