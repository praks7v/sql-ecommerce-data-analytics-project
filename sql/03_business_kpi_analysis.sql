USE SQL_Ecommerce_Analytics;
GO
-- One row per order, then aggregate order-level metrics.
WITH order_summary AS (
    SELECT po.order_id, po.customer_id, po.order_status,
           SUM(po.quantity * p.unit_price) AS order_value
    FROM dbo.project_orders po
    INNER JOIN dbo.products p ON po.product_id = p.product_id
    GROUP BY po.order_id, po.customer_id, po.order_status
)
SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_status = 'Completed' THEN 1 ELSE 0 END) AS completed_orders,
    SUM(CASE WHEN order_status = 'Pending' THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    SUM(CASE WHEN order_status = 'Completed' THEN order_value ELSE 0 END) AS total_completed_revenue,
    CAST(AVG(CASE WHEN order_status = 'Completed' THEN order_value END) AS DECIMAL(12,2))
        AS average_completed_order_value,
    COUNT(DISTINCT CASE WHEN order_status = 'Completed' THEN customer_id END)
        AS purchasing_customers
FROM order_summary;
GO
