USE SQL_Ecommerce_Analytics;
GO
-- Revenue and units sold by category
SELECT p.category, SUM(po.quantity) AS units_sold,
       SUM(po.quantity * p.unit_price) AS total_revenue
FROM dbo.project_orders po
INNER JOIN dbo.products p ON po.product_id = p.product_id
WHERE po.order_status = 'Completed'
GROUP BY p.category
ORDER BY total_revenue DESC;
GO

-- Product-level performance
SELECT p.product_id, p.product_name, p.category,
       SUM(po.quantity) AS units_sold,
       SUM(po.quantity * p.unit_price) AS total_revenue
FROM dbo.project_orders po
INNER JOIN dbo.products p ON po.product_id = p.product_id
WHERE po.order_status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC;
GO

-- Top revenue-generating product(s) in each category
WITH product_sales AS (
    SELECT p.product_id, p.product_name, p.category,
           SUM(po.quantity) AS units_sold,
           SUM(po.quantity * p.unit_price) AS total_revenue
    FROM dbo.project_orders po
    INNER JOIN dbo.products p ON po.product_id = p.product_id
    WHERE po.order_status = 'Completed'
    GROUP BY p.product_id, p.product_name, p.category
),
product_ranking AS (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY category ORDER BY total_revenue DESC
           ) AS product_rank
    FROM product_sales
)
SELECT *
FROM product_ranking
WHERE product_rank = 1
ORDER BY category;
GO
