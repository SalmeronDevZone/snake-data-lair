"""Pruebas de los ejercicios de Python + SQL.

    python -m unittest -v                  prueba tus funciones (ejercicios.py)
    SOLUCIONES=1 python -m unittest -v     prueba las soluciones de referencia (lo usa la CI)
"""
import csv
import importlib
import os
import shutil
import sqlite3
import tempfile
import unittest
from pathlib import Path

m = importlib.import_module("soluciones" if os.environ.get("SOLUCIONES") else "ejercicios")


def llamar(funcion, *args, **kwargs):
    try:
        return funcion(*args, **kwargs)
    except NotImplementedError:
        raise unittest.SkipTest(f"pendiente: {funcion.__name__}")


def base_con_clientes() -> sqlite3.Connection:
    con = sqlite3.connect(":memory:")
    con.executescript(
        """
        CREATE TABLE clientes (id INTEGER PRIMARY KEY, nombre TEXT NOT NULL, email TEXT UNIQUE, ciudad TEXT);
        INSERT INTO clientes VALUES
            (1, 'Ana', 'ana@ejemplo.com', 'Madrid'),
            (2, 'Luis', 'luis@ejemplo.com', 'Sevilla'),
            (3, 'Marta', NULL, 'Madrid');
        """
    )
    return con


class ConCarpeta(unittest.TestCase):
    def setUp(self):
        self.tmp = Path(tempfile.mkdtemp())

    def tearDown(self):
        shutil.rmtree(self.tmp, ignore_errors=True)


class T01Esquema(unittest.TestCase):
    def test_restricciones(self):
        con = sqlite3.connect(":memory:")
        llamar(m.crear_esquema, con)
        llamar(m.crear_esquema, con)  # idempotente
        con.execute("INSERT INTO clientes (id, nombre, email) VALUES (1, 'Ana', 'ana@ejemplo.com')")
        con.execute("INSERT INTO pedidos VALUES (10, 1, 25.5, '2025-03-01')")
        casos = {
            "importe negativo": "INSERT INTO pedidos VALUES (11, 1, -1, '2025-03-01')",
            "cliente inexistente (clave foránea)": "INSERT INTO pedidos VALUES (12, 99, 10, '2025-03-01')",
            "email repetido": "INSERT INTO clientes (id, nombre, email) VALUES (2, 'Otra', 'ana@ejemplo.com')",
            "nombre obligatorio": "INSERT INTO clientes (id, email) VALUES (3, 'x@ejemplo.com')",
            "fecha obligatoria": "INSERT INTO pedidos (id, id_cliente, importe) VALUES (13, 1, 5)",
        }
        for caso, sql in casos.items():
            with self.subTest(caso), self.assertRaises(sqlite3.IntegrityError):
                con.execute(sql)


class T02CargarCsv(ConCarpeta):
    def escribir(self, nombre, filas):
        ruta = self.tmp / nombre
        with open(ruta, "w", newline="", encoding="utf-8") as f:
            csv.writer(f).writerows(filas)
        return ruta

    def test_carga_y_nulos(self):
        con = base_con_clientes()
        ruta = self.escribir("nuevos.csv", [["id", "nombre", "email", "ciudad"], [4, "Pedro", "", "Bilbao"], [5, "Sofía", "sofia@ejemplo.com", ""]])
        self.assertEqual(llamar(m.cargar_csv, con, ruta, "clientes"), 2)
        self.assertEqual(con.execute("SELECT email, ciudad FROM clientes WHERE id IN (4, 5) ORDER BY id").fetchall(), [(None, "Bilbao"), ("sofia@ejemplo.com", None)])

    def test_todo_o_nada(self):
        con = base_con_clientes()
        ruta = self.escribir("malo.csv", [["id", "nombre"], [6, "Nuevo"], [1, "Id repetido"]])
        with self.assertRaises(sqlite3.IntegrityError):
            llamar(m.cargar_csv, con, ruta, "clientes")
        self.assertEqual(con.execute("SELECT COUNT(*) FROM clientes").fetchone()[0], 3)

    def test_identificadores_peligrosos(self):
        con = base_con_clientes()
        ruta = self.escribir("ok.csv", [["id", "nombre"], [7, "X"]])
        with self.assertRaises(ValueError):
            llamar(m.cargar_csv, con, ruta, "clientes; DROP TABLE clientes")
        ruta_mala = self.escribir("cabecera.csv", [["id", "nombre) VALUES (1, 'x'); --"], [8, "Y"]])
        with self.assertRaises(ValueError):
            llamar(m.cargar_csv, con, ruta_mala, "clientes")
        self.assertEqual(con.execute("SELECT COUNT(*) FROM clientes").fetchone()[0], 3)


class T03Inyeccion(unittest.TestCase):
    def test_consulta_parametrizada(self):
        con = base_con_clientes()
        self.assertEqual(llamar(m.clientes_de_ciudad, con, "Madrid"), ["Ana", "Marta"])
        self.assertEqual(llamar(m.clientes_de_ciudad, con, "Madrid' OR '1'='1"), [])
        self.assertEqual(llamar(m.clientes_de_ciudad, con, "Toledo"), [])


class T04Upsert(unittest.TestCase):
    def test_cuenta_inserciones_y_cambios_reales(self):
        con = base_con_clientes()
        filas = [
            {"id": 1, "nombre": "Ana", "email": "ana@ejemplo.com", "ciudad": "Madrid"},  # idéntico
            {"id": 2, "nombre": "Luis", "email": "luis@ejemplo.com", "ciudad": "Valencia"},  # cambia
            {"id": 4, "nombre": "Elena", "email": "elena@ejemplo.com", "ciudad": "Bilbao"},  # nuevo
        ]
        self.assertEqual(llamar(m.upsert_clientes, con, filas), (1, 1))
        self.assertEqual(con.execute("SELECT ciudad FROM clientes WHERE id = 2").fetchone()[0], "Valencia")
        self.assertEqual(con.execute("SELECT COUNT(*) FROM clientes").fetchone()[0], 4)
        self.assertEqual(llamar(m.upsert_clientes, con, filas), (0, 0))


class T05Transaccion(unittest.TestCase):
    def setUp(self):
        self.con = sqlite3.connect(":memory:")
        self.con.executescript(
            """
            CREATE TABLE cuentas (id INTEGER PRIMARY KEY, saldo NUMERIC NOT NULL CHECK (saldo BETWEEN 0 AND 1000));
            INSERT INTO cuentas VALUES (1, 800), (2, 900), (3, 100);
            """
        )

    def saldos(self):
        return dict(self.con.execute("SELECT id, saldo FROM cuentas"))

    def test_transferencia_correcta(self):
        llamar(m.transferir, self.con, 1, 3, 300)
        self.assertEqual(self.saldos(), {1: 500, 2: 900, 3: 400})

    def test_errores_de_negocio(self):
        for origen, destino, importe in [(3, 1, 500), (1, 99, 10), (1, 2, 0)]:
            with self.subTest(origen=origen, destino=destino, importe=importe), self.assertRaises(ValueError):
                llamar(m.transferir, self.con, origen, destino, importe)
        self.assertEqual(self.saldos(), {1: 800, 2: 900, 3: 100})

    def test_es_atomica(self):
        # La cuenta 2 no puede pasar de 1000: la segunda actualización falla y la primera debe deshacerse.
        with self.assertRaises(sqlite3.IntegrityError):
            llamar(m.transferir, self.con, 1, 2, 500)
        self.assertEqual(self.saldos(), {1: 800, 2: 900, 3: 100})


class T06Exportar(ConCarpeta):
    def test_csv_con_cabecera(self):
        con = base_con_clientes()
        ruta = self.tmp / "madrid.csv"
        n = llamar(m.exportar_csv, con, "SELECT id, nombre FROM clientes WHERE ciudad = ? ORDER BY id", ruta, ("Madrid",))
        self.assertEqual(n, 2)
        with open(ruta, newline="", encoding="utf-8") as f:
            self.assertEqual(list(csv.reader(f)), [["id", "nombre"], ["1", "Ana"], ["3", "Marta"]])


class T07Perfilar(unittest.TestCase):
    def test_perfil(self):
        con = base_con_clientes()
        perfil = llamar(m.perfilar, con, "clientes")
        self.assertEqual(list(perfil), ["id", "nombre", "email", "ciudad"])
        self.assertEqual(perfil["email"], {"nulos": 1, "distintos": 2, "min": "ana@ejemplo.com", "max": "luis@ejemplo.com"})
        self.assertEqual(perfil["ciudad"], {"nulos": 0, "distintos": 2, "min": "Madrid", "max": "Sevilla"})
        with self.assertRaises(ValueError):
            llamar(m.perfilar, con, "no_existe")
        with self.assertRaises(ValueError):
            llamar(m.perfilar, con, 'clientes"; DROP TABLE clientes; --')


class T08Diferencias(unittest.TestCase):
    def test_altas_bajas_cambios(self):
        con = sqlite3.connect(":memory:")
        con.executescript(
            """
            CREATE TABLE ayer (id INTEGER, ciudad TEXT);
            CREATE TABLE hoy (id INTEGER, ciudad TEXT);
            INSERT INTO ayer VALUES (1, 'Madrid'), (2, 'Sevilla'), (3, 'Bilbao');
            INSERT INTO hoy VALUES (3, 'Bilbao'), (1, 'Valencia'), (4, 'Málaga');
            """
        )
        self.assertEqual(llamar(m.diferencias_sql, con, "ayer", "hoy", "id"), {"altas": [4], "bajas": [2], "cambios": [1]})


class T09EvolucionEsquema(unittest.TestCase):
    def test_idempotente(self):
        con = base_con_clientes()
        self.assertTrue(llamar(m.asegurar_columna, con, "clientes", "telefono", "TEXT"))
        self.assertFalse(llamar(m.asegurar_columna, con, "clientes", "telefono", "TEXT"))
        self.assertFalse(llamar(m.asegurar_columna, con, "clientes", "EMAIL", "TEXT"))
        columnas = [fila[1] for fila in con.execute("PRAGMA table_info(clientes)")]
        self.assertEqual(columnas, ["id", "nombre", "email", "ciudad", "telefono"])
        with self.assertRaises(ValueError):
            llamar(m.asegurar_columna, con, "clientes", "x", "TEXT; DROP TABLE clientes")


class T10Lotes(unittest.TestCase):
    def setUp(self):
        self.con = sqlite3.connect(":memory:")
        self.con.execute("CREATE TABLE eventos (id INTEGER PRIMARY KEY, tipo TEXT NOT NULL)")

    def test_lotes_desde_un_generador(self):
        filas = ((i, "clic") for i in range(2500))
        self.assertEqual(llamar(m.cargar_por_lotes, self.con, filas, 1000), 3)
        self.assertEqual(self.con.execute("SELECT COUNT(*) FROM eventos").fetchone()[0], 2500)

    def test_los_lotes_anteriores_quedan_guardados(self):
        filas = [(i, "clic") for i in range(250)] + [(0, "duplicado")]  # el último lote falla
        with self.assertRaises(sqlite3.IntegrityError):
            llamar(m.cargar_por_lotes, self.con, iter(filas), 100)
        self.assertEqual(self.con.execute("SELECT COUNT(*) FROM eventos").fetchone()[0], 200)

    def test_tamano_invalido(self):
        with self.assertRaises(ValueError):
            llamar(m.cargar_por_lotes, self.con, [], 0)


if __name__ == "__main__":
    unittest.main()
