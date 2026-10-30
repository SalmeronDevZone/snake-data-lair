"""Pruebas de los ejercicios de pandas.

    python -m unittest -v                      prueba tus funciones (ejercicios.py)
    SOLUCIONES=1 python -m unittest -v         prueba las soluciones de referencia (lo usa la CI)
"""
import importlib
import os
import shutil
import tempfile
import unittest
from pathlib import Path

import pandas as pd
import pandas.testing as pdt

import soluciones as ref

CARS = Path(__file__).resolve().parents[2] / "Python" / "Pandas" / "cars.csv"
mio = importlib.import_module("soluciones" if os.environ.get("SOLUCIONES") else "ejercicios")


def intentar(funcion, *args, **kwargs):
    try:
        return funcion(*args, **kwargs)
    except NotImplementedError:
        raise unittest.SkipTest(f"pendiente: {funcion.__name__}")


class TestEjercicios(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.crudo = ref.cargar(CARS)
        cls.limpio = ref.limpiar(cls.crudo)
        cls.df = ref.anadir_metricas(cls.limpio)

    def test_01_cargar(self):
        df = intentar(mio.cargar, CARS)
        self.assertEqual(df.shape, (406, 9))
        self.assertTrue(pd.api.types.is_numeric_dtype(df["MPG"]), "MPG debería ser numérica")
        pdt.assert_frame_equal(df, self.crudo)

    def test_02_limpiar(self):
        entrada = self.crudo.copy()
        df = intentar(mio.limpiar, entrada)
        pdt.assert_frame_equal(entrada, self.crudo, obj="el DataFrame de entrada (no debe modificarse)")
        self.assertEqual(len(df), 398)
        self.assertEqual(int(df["Horsepower"].isna().sum()), 6)
        pdt.assert_frame_equal(df, self.limpio)

    def test_03_anadir_metricas(self):
        df = intentar(mio.anadir_metricas, self.limpio)
        for columna in ("l_100km", "peso_kg", "anio"):
            self.assertIn(columna, df.columns)
        pdt.assert_frame_equal(df, self.df)

    def test_04_consumo_por_origen(self):
        resultado = intentar(mio.consumo_por_origen, self.df)
        pdt.assert_series_equal(resultado, ref.consumo_por_origen(self.df), check_names=False)

    def test_05_top_potencia(self):
        resultado = intentar(mio.top_potencia, self.df, 3)
        pdt.assert_frame_equal(resultado, ref.top_potencia(self.df, 3))

    def test_06_evolucion_anual(self):
        resultado = intentar(mio.evolucion_anual, self.df)
        pdt.assert_frame_equal(resultado, ref.evolucion_anual(self.df))

    def test_07_tabla_cilindros(self):
        resultado = intentar(mio.tabla_cilindros, self.df)
        pdt.assert_frame_equal(resultado, ref.tabla_cilindros(self.df), check_names=False)

    def test_08_atipicos(self):
        resultado = intentar(mio.atipicos, self.df, "Horsepower")
        pdt.assert_frame_equal(resultado, ref.atipicos(self.df, "Horsepower"))

    def test_09_exportar_por_origen(self):
        carpeta = Path(tempfile.mkdtemp())
        try:
            rutas = intentar(mio.exportar_por_origen, self.df, carpeta)
            relativas = [p.relative_to(carpeta).as_posix() for p in rutas]
            self.assertEqual(relativas, ["origen=Europe/coches.csv", "origen=Japan/coches.csv", "origen=US/coches.csv"])
            total = sum(len(pd.read_csv(p)) for p in rutas)
            self.assertEqual(total, len(self.df))
            self.assertNotIn("Unnamed: 0", pd.read_csv(rutas[0]).columns, "no escribas el índice")
        finally:
            shutil.rmtree(carpeta, ignore_errors=True)


if __name__ == "__main__":
    unittest.main()
