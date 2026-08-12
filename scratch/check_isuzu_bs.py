import pandas as pd
import json

file_path_isuzu = r"C:\Users\User\Downloads\APC_DATABASE_ISUZU.xlsx"

try:
    xl = pd.ExcelFile(file_path_isuzu)
    
    if 'BILLING STATEMENT' in xl.sheet_names:
        df_bs = pd.read_excel(file_path_isuzu, sheet_name='BILLING STATEMENT')
        print(f"\nTotal ISUZU Billing Statement rows: {len(df_bs)}")
        print("\nColumns:")
        print(df_bs.columns.tolist())
        print("\nFirst 5 rows:")
        print(df_bs.head(5).to_string())
    else:
        print("No BILLING STATEMENT sheet in ISUZU Excel.")
        
except Exception as e:
    print(f"Error: {e}")
