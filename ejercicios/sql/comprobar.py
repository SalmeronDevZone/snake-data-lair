"""Corrector de los ejercicios SQL.

Ejecuta tu respuesta y la solución de referencia sobre una base SQLite en memoria recién creada
(esquema.sql + datos.sql) y compara los resultados. Sólo necesita Python 3.

    python comprobar.py                 comprueba todos tus ejercicios
    python comprobar.py 06 07           sólo esos
    python comprobar.py --soluciones    verifica las soluciones contra esperado.json (lo usa la CI)
    python comprobar.py --generar       regenera esperado.json a partir de las soluciones
"""
import argparse
import json
import sqlite3
import sys
from pathlib import Path

AQUI = Path(__file__).resolve().parent
SOLUCIONES = AQUI / "soluciones"
ESPERADO = AQUI / "esperado.json"
MAX_FILAS_DIFERENCIA = 5


def crear_bd() -> sqlite3.Connection:
    conexion = sqlite3.connect(":memory:")
    conexion.executescript((AQUI / "esquema.sql").read_text(encoding="utf-8"))
    conexion.executescript((AQUI / "datos.sql").read_text(encoding="utf-8"))
    return conexion


def sentencias(sql: str) -> list[str]:
    """Divide un script en sentencias completas (respeta comentarios y cadenas con ';')."""
    resultado, actual = [], ""
    for linea in sql.splitlines(keepends=True):
        actual += linea
        if sqlite3.complete_statement(actual):
            resultado.append(actual.strip())
            actual = ""
    if actual.strip() and not es_vacio(actual):
        resultado.append(actual.strip())
    return resultado


def es_vacio(sql: str) -> bool:
    """True si el texto sólo tiene comentarios y espacios."""
    lineas = [l.split("--", 1)[0] for l in sql.splitlines()]
    return not "".join(lineas).strip()


def ejecutar(sql: str) -> tuple[list[str], list[tuple]]:
    """Ejecuta un script en una base nueva y devuelve el resultado de la última consulta."""
    conexion = crear_bd()
    try:
        ultimo = None
        for sentencia in sentencias(sql):
            cursor = conexion.execute(sentencia)
            if cursor.description:
                ultimo = ([c[0] for c in cursor.description], cursor.fetchall())
        if ultimo is None:
            raise ValueError("el script no termina con ninguna consulta SELECT")
        return ultimo
    finally:
        conexion.close()


def normalizar_valor(v):
    if isinstance(v, float):
        return int(v) if v.is_integer() else round(v, 2)
    return v


def normalizar(filas, ordenado: bool) -> list[list]:
    filas = [[normalizar_valor(v) for v in fila] for fila in filas]
    return filas if ordenado else sorted(filas, key=repr)


def requiere_orden(sql_referencia: str) -> bool:
    return "ORDER BY" in sentencias(sql_referencia)[-1].upper()


def ejercicios(filtro: list[str]) -> list[Path]:
    todos = sorted(SOLUCIONES.glob("*.sql"))
    if filtro:
        todos = [p for p in todos if any(p.name.startswith(f.zfill(2)) for f in filtro)]
    return todos


def mostrar_diferencia(esperado: list, obtenido: list) -> None:
    print(f"      esperado ({len(esperado)} filas): {esperado[:MAX_FILAS_DIFERENCIA]}")
    print(f"      obtenido ({len(obtenido)} filas): {obtenido[:MAX_FILAS_DIFERENCIA]}")


def comprobar_mis_ejercicios(rutas: list[Path]) -> int:
    correctos = pendientes = 0
    for ruta in rutas:
        referencia = ruta.read_text(encoding="utf-8")
        mio_ruta = AQUI / ruta.name
        mio = mio_ruta.read_text(encoding="utf-8") if mio_ruta.exists() else ""
        if es_vacio(mio):
            print(f"⏳ {ruta.stem}: pendiente")
            pendientes += 1
            continue
        ordenado = requiere_orden(referencia)
        _, filas_ref = ejecutar(referencia)
        try:
            columnas, filas = ejecutar(mio)
        except (sqlite3.Error, ValueError) as error:
            print(f"❌ {ruta.stem}: error al ejecutar tu SQL -> {error}")
            continue
        esperado, obtenido = normalizar(filas_ref, ordenado), normalizar(filas, ordenado)
        if filas_ref and len(columnas) != len(filas_ref[0]):
            print(f"❌ {ruta.stem}: devuelve {len(columnas)} columnas y se esperaban {len(filas_ref[0])}")
        elif obtenido != esperado:
            pista = " (revisa también el ORDER BY)" if ordenado and sorted(obtenido, key=repr) == sorted(esperado, key=repr) else ""
            print(f"❌ {ruta.stem}: el resultado no coincide{pista}")
            mostrar_diferencia(esperado, obtenido)
        else:
            print(f"✅ {ruta.stem}")
            correctos += 1
    total = len(rutas)
    print(f"\n{correctos}/{total} correctos · {pendientes} {'pendiente' if pendientes == 1 else 'pendientes'}")
    return 0 if correctos + pendientes == total else 1


def comprobar_soluciones(rutas: list[Path], generar: bool) -> int:
    esperado = {} if generar or not ESPERADO.exists() else json.loads(ESPERADO.read_text(encoding="utf-8"))
    fallos = 0
    for ruta in rutas:
        sql = ruta.read_text(encoding="utf-8")
        columnas, filas = ejecutar(sql)
        resultado = {"columnas": columnas, "filas": normalizar(filas, requiere_orden(sql))}
        if generar:
            esperado[ruta.stem] = resultado
            print(f"📝 {ruta.stem}: {len(filas)} filas")
        elif esperado.get(ruta.stem) != resultado:
            fallos += 1
            print(f"❌ {ruta.stem}: la solución ya no da el resultado esperado")
            mostrar_diferencia(esperado.get(ruta.stem, {}).get("filas", []), resultado["filas"])
        else:
            print(f"✅ {ruta.stem}: {len(filas)} filas")
    if generar:
        ESPERADO.write_text(json.dumps(esperado, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    return 1 if fallos else 0


def main() -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")
    parser = argparse.ArgumentParser(description="Corrector de los ejercicios SQL")
    parser.add_argument("ejercicios", nargs="*", help="números de ejercicio (por defecto, todos)")
    grupo = parser.add_mutually_exclusive_group()
    grupo.add_argument("--soluciones", action="store_true", help="verifica las soluciones de referencia")
    grupo.add_argument("--generar", action="store_true", help="regenera esperado.json")
    args = parser.parse_args()
    rutas = ejercicios(args.ejercicios)
    if not rutas:
        print("No hay ningún ejercicio con ese número.")
        return 1
    if args.soluciones or args.generar:
        return comprobar_soluciones(rutas, args.generar)
    return comprobar_mis_ejercicios(rutas)


if __name__ == "__main__":
    sys.exit(main())
