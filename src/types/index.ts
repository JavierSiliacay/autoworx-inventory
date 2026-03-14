export type Profile = {
  id: string;
  full_name: string;
  role: 'admin' | 'staff';
  updated_at: string;
};

export type Part = {
  id: string;
  name: string;
  category: string;
  brand: string;
  supplier: string;
  compatible_vehicles: string[];
  stock_quantity: number;
  unit_price: number;
  reorder_threshold: number;
  status: 'in_stock' | 'low_stock' | 'out_of_stock';
  created_at: string;
  updated_at: string;
};

export type Paint = {
  id: string;
  name: string;
  color_code: string;
  batch_number: string;
  quantity: number;
  supplier: string;
  created_at: string;
};

export type Truck = {
  id: string;
  name: string;
  plate_number: string;
  driver: string;
  route: string;
  destination: string;
  status: 'pending' | 'dispatched' | 'delivered';
  created_at: string;
};

export type Transaction = {
  id: string;
  item_id: string;
  module_type: 'parts' | 'paints';
  transaction_type: 'inbound' | 'outbound' | 'adjustment' | 'transfer';
  quantity: number;
  performed_by: string;
  remarks: string;
  timestamp: string;
};
