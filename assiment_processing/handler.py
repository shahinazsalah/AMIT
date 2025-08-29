import pandas as pd
import sqlite3

# ---------------------------
# Reading files
# ---------------------------
def read_csv(file_path):
    return pd.read_csv(file_path)

def read_excel(file_path, sheet_name=0):
    return pd.read_excel(file_path, sheet_name=sheet_name)

def read_json(file_path):
    return pd.read_json(file_path)

def read_db(db_path, table_name):
    conn = sqlite3.connect(db_path)
    df = pd.read_sql(f"SELECT * FROM {table_name}", conn)
    conn.close()
    return df


# ---------------------------
# Saving files
# ---------------------------
def save_csv(df, file_path, index=False):
    df.to_csv(file_path, index=index)

def save_excel(df, file_path, sheet_name="Sheet1", index=False):
    df.to_excel(file_path, sheet_name=sheet_name, index=index)

def save_json(df, file_path, orient="records"):
    df.to_json(file_path, orient=orient)

def save_db(df, db_path, table_name, if_exists="replace"):
    conn = sqlite3.connect(db_path)
    df.to_sql(table_name, conn, if_exists=if_exists, index=False)
    conn.close()


# ---------------------------
# Example usage
# ---------------------------
if __name__ == "__main__":
    # مسار الملف الأصلي
    csv_path = "D:/AMIT/matries/sessions/code/assiment_processing/train (2).csv"

    # اقرأ CSV
    df = read_csv(csv_path)

    # حفظ بنفس الفولدر
    save_excel(df, "D:/AMIT\matries/sessions/code/assiment_processing/train_converted.xlsx")
    save_json(df, "D:/AMIT/matries/sessions/code/assiment_processing/train_converted.json")
    save_db(df, "D:/AMIT/matries/sessions/code/assiment_processing/my_database.db", "train_table")

    print("✅ save files: Excel + JSON + DB")
