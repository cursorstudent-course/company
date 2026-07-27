-- SeverProm · PostgreSQL-compatible schema
CREATE TABLE customers (
  customer_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  inn TEXT,
  manager_id TEXT,
  segment TEXT,
  payment_terms_days INT
);

CREATE TABLE products (
  product_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT
);

CREATE TABLE employees (
  employee_id TEXT PRIMARY KEY,
  full_name TEXT NOT NULL,
  role TEXT,
  department TEXT,
  manager_id TEXT,
  email TEXT,
  status TEXT
);

CREATE TABLE vendors (
  vendor_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  country TEXT,
  category TEXT,
  active_contract BOOLEAN
);

CREATE TABLE warehouse_bins (
  warehouse_id TEXT PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE orders (
  order_id TEXT PRIMARY KEY,
  order_date DATE,
  customer_id TEXT REFERENCES customers(customer_id),
  manager_id TEXT,
  status TEXT,
  source_system TEXT
);

CREATE TABLE order_lines (
  order_id TEXT REFERENCES orders(order_id),
  product_id TEXT REFERENCES products(product_id),
  qty INT,
  amount_rub NUMERIC,
  PRIMARY KEY (order_id, product_id)
);

CREATE TABLE inventory_balances (
  as_of DATE,
  warehouse_id TEXT REFERENCES warehouse_bins(warehouse_id),
  product_id TEXT REFERENCES products(product_id),
  qty_erp INT,
  qty_physical INT,
  PRIMARY KEY (as_of, warehouse_id, product_id)
);

CREATE TABLE payments (
  payment_id TEXT PRIMARY KEY,
  pay_date DATE,
  vendor_id TEXT REFERENCES vendors(vendor_id),
  amount_rub NUMERIC,
  purpose TEXT,
  contract_id TEXT,
  approved_by TEXT
);
