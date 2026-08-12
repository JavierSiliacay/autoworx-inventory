import pandas as pd
import json

file_path_isuzu = r"C:\Users\User\Downloads\APC_DATABASE_ISUZU.xlsx"

try:
    xl = pd.ExcelFile(file_path_isuzu)
    print("Sheets in APC_DATABASE_ISUZU.xlsx:")
    for s in xl.sheet_names:
        print(f" - {s}")
        
    # Read SALES and ACCOUNTS RECEIVABLE
    if 'SALES' in xl.sheet_names:
        df_sales = pd.read_excel(file_path_isuzu, sheet_name='SALES')
        print(f"\nTotal ISUZU Sales rows: {len(df_sales)}")
        # Check how many are Charge or Delivery
        if 'REMARKS' in df_sales.columns:
            charge = len(df_sales[df_sales['REMARKS'].str.contains('Charge|Delivery', case=False, na=False)])
            print(f"Charge/Delivery in ISUZU Sales: {charge}")
            
    if 'ACCOUNTS RECEIVABLE' in xl.sheet_names:
        df_ar = pd.read_excel(file_path_isuzu, sheet_name='ACCOUNTS RECEIVABLE')
        print(f"\nTotal ISUZU AR rows: {len(df_ar)}")
        
except Exception as e:
    print(f"Error: {e}")
