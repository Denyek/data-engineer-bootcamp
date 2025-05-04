reate Tables
CREATE TABLE customers (
	    customer_id SERIAL PRIMARY KEY,
	    name TEXT NOT NULL,
	    email TEXT UNIQUE NOT NULL,
	    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
	    product_id SERIAL PRIMARY KEY,
	    name TEXT NOT NULL,
	    category TEXT,
	    price NUMERIC(10, 2)
);

CREATE TABLE orders (
	    order_id SERIAL PRIMARY KEY,
	    customer_id INT REFERENCES customers(customer_id),
	    product_id INT REFERENCES products(product_id),
	    quantity INT NOT NULL,
	    order_date DATE DEFAULT CURRENT_DATE
);

-- Insert Data
INSERT INTO customers (name, email) VALUES 
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com');

INSERT INTO products (name, category, price) VALUES 
('Widget A', 'Tools', 25.50),
('Widget B', 'Tools', 35.75),
('Gadget X', 'Electronics', 99.99);

INSERT INTO orders (customer_id, product_id, quantity) VALUES 
(1, 1, 2),
(1, 3, 1),
(2, 2, 5);

-- Example Queries
SELECT c.name, p.name, o.quantity
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

SELECT c.name, SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name;

SELECT o.*, RANK() OVER (ORDER BY quantity DESC) AS rank
FROM orders o;

