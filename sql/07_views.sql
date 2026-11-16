USE SQL_Ecommerce_Analytics;
GO
-- CREATE OR ALTER VIEW must be the first statement in its batch.
CREATE OR ALTER VIEW dbo.vw_project_customer_sales
AS
SELECT c.customer_id, c.customer_name, c.city,
       COUNT(DISTINCT po.order_id) AS total_completed_orders,
       SUM(po.quantity * p.unit_price) AS total_completed_revenue
FROM dbo.customers c
INNER JOIN dbo.project_orders po ON c.customer_id = po.customer_id
INNER JOIN dbo.products p ON po.product_id = p.product_id
WHERE po.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name, c.city;
GO

SELECT *
FROM dbo.vw_project_customer_sales
ORDER BY total_completed_revenue DESC;
GO
