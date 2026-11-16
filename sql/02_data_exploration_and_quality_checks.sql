USE SQL_Ecommerce_Analytics;
GO
-- Table size and date range
SELECT COUNT(*) AS total_orders,
       COUNT(DISTINCT customer_id) AS customers_with_orders,
       MIN(order_date) AS first_order_date,
       MAX(order_date) AS last_order_date
FROM dbo.project_orders;
GO

-- Duplicate IDs (expected: no rows; order_id is a primary key)
SELECT order_id, COUNT(*) AS duplicate_count
FROM dbo.project_orders
GROUP BY order_id
HAVING COUNT(*) > 1;
GO

-- Missing or invalid values
SELECT *
FROM dbo.project_orders
WHERE customer_id IS NULL OR product_id IS NULL
   OR order_date IS NULL OR quantity IS NULL
   OR quantity <= 0 OR order_status IS NULL;
GO

-- Unexpected status values
SELECT *
FROM dbo.project_orders
WHERE order_status NOT IN ('Completed', 'Pending', 'Cancelled');
GO

-- Referential integrity checks (expected: no rows)
SELECT po.*
FROM dbo.project_orders po
LEFT JOIN dbo.customers c ON po.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
GO
SELECT po.*
FROM dbo.project_orders po
LEFT JOIN dbo.products p ON po.product_id = p.product_id
WHERE p.product_id IS NULL;
GO

-- Status breakdown
SELECT order_status, COUNT(*) AS order_count
FROM dbo.project_orders
GROUP BY order_status
ORDER BY order_count DESC;
GO
