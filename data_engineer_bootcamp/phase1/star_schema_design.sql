--dimmensions
CREATE TABLE dim_customers (
	    customer_id INT PRIMARY KEY,
	    name TEXT NOT NULL,
	    email TEXT NOT NULL
);

CREATE TABLE dim_products (
	    product_id INT PRIMARY KEY,
	    name TEXT NOT NULL,
	    category TEXT NOT NULL
);

CREATE TABLE dim_date (
	    date_id DATE PRIMARY KEY,
	    year INT,
	    month TEXT,
	    day INT
);

-- Fact table
CREATE TABLE fact_sales (
	    sale_id SERIAL PRIMARY KEY,
	    customer_id INT REFERENCES dim_customers(customer_id),
	    product_id INT REFERENCES dim_products(product_id),
	    date_id DATE REFERENCES dim_date(date_id),
	    quantity INT NOT NULL,
	    price NUMERIC(10,2) NOT NULL,
	    total_sale_amount NUMERIC(12,2) GENERATED ALWAYS AS (quantity * price) STORED
);

-- Inserts
INSERT INTO dim_customers VALUES
(1, 'Alice Smith', 'alice@example.com'),
(2, 'Bob Johnson', 'bob@example.com');

INSERT INTO dim_products VALUES
(1, 'Widget A', 'Tools'),
(2, 'Gadget X', 'Electronics');

INSERT INTO dim_date VALUES
('2024-01-01', 2024, 'January', 1),
('2024-01-02', 2024, 'January', 2);

INSERT INTO fact_sales (customer_id, product_id, date_id, quantity, price) VALUES
(1, 1, '2024-01-01', 2, 25.50),
(2, 2, '2024-01-02', 1, 99.99);

-- Sample query
SELECT d.month, p.category, SUM(f.total_sale_amount) AS total_sales
FROM fact_sales f
JOIN dim_products p ON f.product_id = p.product_id
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.month, p.category;

