import requests
import json
import os

url = "https://frwzgrturowolbumwsnu.supabase.co"
key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZyd3pncnR1cm93b2xidW13c251Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzEzODE3MTcsImV4cCI6MjA4Njk1NzcxN30.Gzw83kS07LYqPh3h7lreqryVQmZxyM_XHTwQCJEf25A"

headers = {
    "apikey": key,
    "Authorization": f"Bearer {key}",
    "Content-Type": "application/json"
}

# 1. Get ISUZU branch id
res = requests.get(f"{url}/rest/v1/branches?name=ilike.*isuzu*&select=id", headers=headers)
branches = res.json()
if not branches:
    print("Could not find Isuzu branch")
    exit()
isuzu_id = branches[0]['id']
print(f"ISUZU Branch ID: {isuzu_id}")

# 2. Get ISUZU Sales
res = requests.get(f"{url}/rest/v1/sales?branch_id=eq.{isuzu_id}&select=invoice_no,payment_type,remarks", headers=headers)
sales = res.json()
print(f"Total ISUZU Sales items in DB: {len(sales)}")

# 3. Get unique invoices
invoices = list(set([s['invoice_no'] for s in sales]))
print(f"Total unique ISUZU Invoices: {len(invoices)}")

# Check payment types in sales
payment_types = set([s.get('payment_type') for s in sales])
print(f"Payment Types found in ISUZU Sales: {payment_types}")

# 4. Get AR for ISUZU
res = requests.get(f"{url}/rest/v1/accounts_receivable?branch_id=eq.{isuzu_id}&select=id,invoice_no,total_amount_due", headers=headers)
ar = res.json()
print(f"Total ISUZU AR records in DB: {len(ar)}")

# Check missing AR
ar_invoices = set([a['invoice_no'] for a in ar])
missing = [inv for inv in invoices if inv not in ar_invoices]
print(f"ISUZU Invoices missing from AR: {len(missing)}")
if len(missing) > 0:
    print(f"Examples of missing: {missing[:5]}")

