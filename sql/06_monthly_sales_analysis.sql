USE SQL_Ecommerce_Analytics;
GO
-- Monthly completed revenue and month-over-month comparison.
WITH monthly_sales AS (
    SELECT DATEFROMPARTS(YEAR(po.order_date), MONTH(po.order_date), 1) AS sales_month,
           SUM(po.quantity * p.unit_price) AS total_revenue
    FROM dbo.project_orders po
    INNER JOIN dbo.products p ON po.product_id = p.product_id
    WHERE po.order_status = 'Completed'
    GROUP BY YEAR(po.order_date), MONTH(po.order_date)
),
monthly_comparison AS (
    SELECT sales_month, total_revenue,
           LAG(total_revenue) OVER (ORDER BY sales_month) AS previous_month_revenue
    FROM monthly_sales
)
SELECT sales_month, total_revenue, previous_month_revenue,
       total_revenue - previous_month_revenue AS revenue_difference,
       CAST(
           100.0 * (total_revenue - previous_month_revenue)
           / NULLIF(previous_month_revenue, 0)
           AS DECIMAL(10,2)
       ) AS mom_growth_percentage
FROM monthly_comparison
ORDER BY sales_month;
GO

/*
LAG compares with the previous available month. This sample has completed
sales in every month from January through July 2026. For missing months in a
real dataset, use a calendar table and LEFT JOIN the monthly aggregates.
*/
