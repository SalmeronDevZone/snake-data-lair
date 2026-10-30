"""Ejercicios de pandas sobre Python/Pandas/cars.csv (406 coches de 1970 a 1982).

Completa cada función y comprueba con:   python -m unittest -v      (desde esta carpeta)
Las pruebas comparan tu resultado con el de la solución de referencia; las funciones
que sigan lanzando NotImplementedError aparecen como "pendientes" (skipped).
"""
from pathlib import Path

import numpy as np  # noqa: F401  (te hará falta)
import pandas as pd

KM_POR_MILLA = 1.609344
LITROS_POR_GALON = 3.785411784
KG_POR_LIBRA = 0.45359237


def cargar(ruta: Path) -> pd.DataFrame:
    """1 · 🟢 Lee el CSV. Ojo: el separador es ';' y la SEGUNDA fila no son datos, sino el tipo
    de cada columna (STRING, DOUBLE...). Las columnas numéricas deben quedar como números."""
    raise NotImplementedError


def limpiar(df: pd.DataFrame) -> pd.DataFrame:
    """2 · 🟢 En este conjunto un 0 en MPG o en Horsepower significa "dato desconocido".
    Conviértelos en NaN, elimina los coches sin MPG (no sirven para medir consumo), quita
    los espacios sobrantes de Car y renumera el índice desde 0. No modifiques el df de entrada."""
    raise NotImplementedError


def anadir_metricas(df: pd.DataFrame) -> pd.DataFrame:
    """3 · 🟢 Añade tres columnas en unidades europeas:
    - l_100km: litros a los 100 km = 100 × LITROS_POR_GALON / (MPG × KM_POR_MILLA), con 2 decimales
    - peso_kg: Weight (libras) × KG_POR_LIBRA, con 1 decimal
    - anio: año completo (Model 70 -> 1970)"""
    raise NotImplementedError


def consumo_por_origen(df: pd.DataFrame) -> pd.Series:
    """4 · 🟡 Consumo medio (l_100km) por Origin, con 2 decimales, del más eficiente al que más gasta.
    Recibe el df con las métricas del ejercicio 3."""
    raise NotImplementedError


def top_potencia(df: pd.DataFrame, n: int = 5) -> pd.DataFrame:
    """5 · 🟡 Los n coches más potentes: columnas Car, Horsepower y anio, índice desde 0."""
    raise NotImplementedError


def evolucion_anual(df: pd.DataFrame) -> pd.DataFrame:
    """6 · 🟡 Una fila por anio con: coches (cuántos), l_100km_medio (2 decimales) y
    variacion_pct: % de variación del consumo medio respecto al año anterior (1 decimal, NaN el primero)."""
    raise NotImplementedError


def tabla_cilindros(df: pd.DataFrame) -> pd.DataFrame:
    """7 · 🟡 Tabla cruzada: cuántos coches hay de cada Origin (filas) con cada número de Cylinders (columnas)."""
    raise NotImplementedError


def atipicos(df: pd.DataFrame, columna: str) -> pd.DataFrame:
    """8 · 🔴 Valores atípicos de una columna por el método del rango intercuartílico (IQR):
    fuera de [Q1 − 1,5·IQR, Q3 + 1,5·IQR]. Devuelve Car y esa columna, índice desde 0."""
    raise NotImplementedError


def exportar_por_origen(df: pd.DataFrame, carpeta: Path) -> list[Path]:
    """9 · 🔴 Escribe un CSV por Origin con particionado estilo data lake:
    carpeta/origen=US/coches.csv, carpeta/origen=Japan/coches.csv... (sin la columna de índice).
    Devuelve la lista ordenada de rutas escritas."""
    raise NotImplementedError
