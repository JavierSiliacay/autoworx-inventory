import os

files = [
    'src/app/admin/inventory/stock-in/page.tsx',
    'src/app/admin/inventory/stock-out/page.tsx',
    'src/app/admin/inventory/purchase-orders/page.tsx',
    'src/app/admin/receivable/billing-statements/page.tsx',
    'src/app/admin/receivable/checks/page.tsx'
]

replacements = {
    'â‚±': '₱',
    'â€”': '—',
    'â†’': '→',
    'â”€': '─',
    'Ã¢â€šÂ±': '₱',
    'â,±': '₱',
    'â€¢': '•'
}

for filepath in files:
    if os.path.exists(filepath):
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        for k, v in replacements.items():
            content = content.replace(k, v)
            
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
