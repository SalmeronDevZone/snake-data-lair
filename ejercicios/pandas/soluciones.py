"""Soluciones de referencia de los ejercicios de pandas (no mires antes de intentarlo)."""
from pathlib import Path

import numpy as np
import pandas as pd

KM_POR_MILLA = 1.609344
LITROS_POR_GALON = 3.785411784
KG_POR_LIBRA = 0.45359237


def cargar(ruta: Path) -> pd.DataFrame:
    # Separador ';' y una segunda fila con los tipos de cada columna que hay que saltarse.
    return pd.read_csv(ruta, sep=";", skiprows=[1])


def limpiar(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    df[["MPG", "Horsepower"]] = df[["MPG", "Horsepower"]].replace(0, np.nan)
    df = df.dropna(subset=["MPG"])
    df["Car"] = df["Car"].str.strip()
    return df.reset_index(drop=True)


def anadir_metricas(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    df["l_100km"] = (100 * LITROS_POR_GALON / (df["MPG"] * KM_POR_MILLA)).round(2)
    df["peso_kg"] = (df["Weight"] * KG_POR_LIBRA).round(1)
    df["anio"] = 1900 + df["Model"]
    return df


def consumo_por_origen(df: pd.DataFrame) -> pd.Series:
    return df.groupby("Origin")["l_100km"].mean().round(2).sort_values()


def top_potencia(df: pd.DataFrame, n: int = 5) -> pd.DataFrame:
    return df.nlargest(n, "Horsepower")[["Car", "Horsepower", "anio"]].reset_index(drop=True)


def evolucion_anual(df: pd.DataFrame) -> pd.DataFrame:
    resultado = df.groupby("anio").agg(coches=("Car", "count"), l_100km_medio=("l_100km", "mean")).round(2).reset_index()
    resultado["variacion_pct"] = (resultado["l_100km_medio"].pct_change() * 100).round(1)
    return resultado


def tabla_cilindros(df: pd.DataFrame) -> pd.DataFrame:
    return pd.crosstab(df["Origin"], df["Cylinders"])


def atipicos(df: pd.DataFrame, columna: str) -> pd.DataFrame:
    q1, q3 = df[columna].quantile([0.25, 0.75])
    rango = q3 - q1
    fuera = (df[columna] < q1 - 1.5 * rango) | (df[columna] > q3 + 1.5 * rango)
    return df.loc[fuera, ["Car", columna]].reset_index(drop=True)


def exportar_por_origen(df: pd.DataFrame, carpeta: Path) -> list[Path]:
    rutas = []
    for origen, grupo in df.groupby("Origin"):
        destino = Path(carpeta) / f"origen={origen}" / "coches.csv"
        destino.parent.mkdir(parents=True, exist_ok=True)
        grupo.to_csv(destino, index=False)
        rutas.append(destino)
    return sorted(rutas)
