USE SQL_Ecommerce_Analytics;
GO
-- Customer revenue and completed order count
SELECT c.customer_id, c.customer_name, c.city,
       COUNT(DISTINCT po.order_id) AS completed_orders,
       SUM(po.quantity * p.unit_price) AS total_revenue
FROM dbo.customers c
INNER JOIN dbo.project_orders po ON c.customer_id = po.customer_id
INNER JOIN dbo.products p ON po.product_id = p.product_id
WHERE po.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_revenue DESC;
GO

-- Customers without a completed purchase
SELECT c.customer_id, c.customer_name, c.city
FROM dbo.customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.project_orders po
    WHERE po.customer_id = c.customer_id
      AND po.order_status = 'Completed'
)
ORDER BY c.customer_id;
GO

-- Rank customers by completed revenue
WITH customer_sales AS (
    SELECT c.customer_id, c.customer_name,
           SUM(po.quantity * p.unit_price) AS total_revenue
    FROM dbo.customers c
    INNER JOIN dbo.project_orders po ON c.customer_id = po.customer_id
    INNER JOIN dbo.products p ON po.product_id = p.product_id
    WHERE po.order_status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name, total_revenue,
       DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS customer_rank
FROM customer_sales
ORDER BY customer_rank, customer_id;
GO
