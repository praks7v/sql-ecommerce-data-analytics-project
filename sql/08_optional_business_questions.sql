USE SQL_Ecommerce_Analytics;
GO
-- Completed revenue by customer city
SELECT c.city, SUM(po.quantity * p.unit_price) AS total_revenue
FROM dbo.customers c
INNER JOIN dbo.project_orders po ON c.customer_id = po.customer_id
INNER JOIN dbo.products p ON po.product_id = p.product_id
WHERE po.order_status = 'Completed'
GROUP BY c.city
ORDER BY total_revenue DESC;
GO

-- Average number of units per completed order
WITH order_quantities AS (
    SELECT order_id, SUM(quantity) AS total_units
    FROM dbo.project_orders
    WHERE order_status = 'Completed'
    GROUP BY order_id
)
SELECT CAST(AVG(1.0 * total_units) AS DECIMAL(10,2))
       AS average_units_per_completed_order
FROM order_quantities;
GO

-- Category share of completed revenue
WITH category_revenue AS (
    SELECT p.category,
           SUM(po.quantity * p.unit_price) AS category_revenue
    FROM dbo.project_orders po
    INNER JOIN dbo.products p ON po.product_id = p.product_id
    WHERE po.order_status = 'Completed'
    GROUP BY p.category
)
SELECT category, category_revenue,
       CAST(100.0 * category_revenue /
            NULLIF(SUM(category_revenue) OVER (), 0) AS DECIMAL(10,2))
            AS revenue_contribution_pct
FROM category_revenue
ORDER BY category_revenue DESC;
GO
