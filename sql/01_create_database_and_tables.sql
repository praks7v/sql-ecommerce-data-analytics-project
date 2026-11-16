/*
Standalone SQL Server setup. WARNING: drops and recreates project tables.
Run only in a practice environment.
*/
IF DB_ID('SQL_Ecommerce_Analytics') IS NULL
    CREATE DATABASE SQL_Ecommerce_Analytics;
GO
USE SQL_Ecommerce_Analytics;
GO

IF OBJECT_ID('dbo.project_orders', 'U') IS NOT NULL DROP TABLE dbo.project_orders;
IF OBJECT_ID('dbo.products', 'U') IS NOT NULL DROP TABLE dbo.products;
IF OBJECT_ID('dbo.customers', 'U') IS NOT NULL DROP TABLE dbo.customers;
GO

CREATE TABLE dbo.customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(50)
);
GO
CREATE TABLE dbo.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0)
);
GO
CREATE TABLE dbo.project_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    order_date DATE NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    order_status VARCHAR(20) NOT NULL
        CHECK (order_status IN ('Completed', 'Pending', 'Cancelled')),
    CONSTRAINT FK_project_orders_customers FOREIGN KEY (customer_id)
        REFERENCES dbo.customers(customer_id),
    CONSTRAINT FK_project_orders_products FOREIGN KEY (product_id)
        REFERENCES dbo.products(product_id)
);
GO

INSERT INTO dbo.customers VALUES
(1, 'Rahul', 'Mumbai'),
(2, 'Priya', 'Pune'),
(3, 'Amit', 'Delhi'),
(4, 'Sneha', 'Bangalore'),
(5, 'Vikas', 'Hyderabad'),
(6, 'Neha', 'Chennai');
GO

INSERT INTO dbo.products VALUES
(101, 'Laptop', 'Electronics', 50000),
(102, 'Mobile', 'Electronics', 25000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Keyboard', 'Accessories', 1500),
(105, 'Office Chair', 'Furniture', 8000),
(106, 'Desk', 'Furniture', 12000);
GO

INSERT INTO dbo.project_orders VALUES
(1001, 1, 101, '2026-01-05', 1, 'Completed'),
(1002, 2, 102, '2026-01-10', 2, 'Completed'),
(1003, 3, 103, '2026-01-15', 3, 'Completed'),
(1004, 1, 104, '2026-02-03', 2, 'Completed'),
(1005, 4, 105, '2026-02-12', 1, 'Pending'),
(1006, 2, 101, '2026-02-18', 1, 'Completed'),
(1007, 5, 106, '2026-03-05', 1, 'Completed'),
(1008, 3, 102, '2026-03-10', 1, 'Cancelled'),
(1009, 1, 103, '2026-03-15', 2, 'Completed'),
(1010, 4, 104, '2026-04-01', 3, 'Completed'),
(1011, 2, 105, '2026-04-10', 1, 'Completed'),
(1012, 5, 101, '2026-04-20', 1, 'Completed'),
(1013, 3, 106, '2026-05-02', 2, 'Completed'),
(1014, 1, 102, '2026-05-08', 1, 'Pending'),
(1015, 2, 103, '2026-05-15', 4, 'Completed'),
(1016, 4, 101, '2026-06-01', 1, 'Completed'),
(1017, 5, 104, '2026-06-10', 2, 'Completed'),
(1018, 3, 105, '2026-06-20', 1, 'Completed'),
(1019, 1, 106, '2026-07-05', 1, 'Completed'),
(1020, 2, 102, '2026-07-12', 2, 'Completed');
GO

SELECT * FROM dbo.customers;
SELECT * FROM dbo.products;
SELECT * FROM dbo.project_orders;
GO
