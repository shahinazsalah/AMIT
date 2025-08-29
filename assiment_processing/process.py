import pandas as pd

# ---------------------------
# Data types
# ---------------------------
def check_dtypes(df):
    """Return data types of columns"""
    return df.dtypes

def convert_dtype(df, column, dtype):
    """Convert a specific column to a given dtype"""
    df[column] = df[column].astype(dtype)
    return df


# ---------------------------
# Missing values
# ---------------------------
def check_missing(df):
    """Return number and percentage of missing values per column"""
    null = df.isnull().sum()
    ratio = (null / df.shape[0] * 100).round(2).astype(str) + "%"
    return pd.DataFrame({"Null_sum": null, "Ratio%": ratio})


def fill_missing(df, column, method="mean"):
    """Fill missing values in a column using mean/median/mode"""
    if method == "mean":
        value = df[column].mean()
    elif method == "median":
        value = df[column].median()
    elif method == "mode":
        value = df[column].mode()[0]
    else:
        raise ValueError("Method must be 'mean', 'median', or 'mode'")

    df[column].fillna(value, inplace=True)
    return df


def drop_missing(df, axis=0, subset=None):
    """Drop rows (axis=0) or columns (axis=1) with missing values"""
    return df.dropna(axis=axis, subset=subset)
