# End-to-End SQL Data Analyst Project
## E-Commerce Sales Analysis | Microsoft SQL Server

A portfolio project using a synthetic e-commerce dataset to explore transactions, calculate business KPIs, analyze customer and product performance, and measure monthly revenue trends.

> **Dataset note:** All data is synthetic and created for learning and demonstration. The names and financial results do not represent a real company.

## Business scenario

An e-commerce business wants to understand sales performance and customer behavior. This analysis answers:

1. How many orders are completed, pending, and cancelled?
2. What is the revenue from completed orders?
3. Which customers generate the most revenue?
4. Which product categories contribute most to revenue?
5. Which products lead their categories?
6. How does monthly revenue change?
7. Which customers have no completed purchases?

## Tools

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL

## Repository structure

```text
sql-ecommerce-data-analytics-project/
├── README.md
├── LICENSE
├── .gitignore
├── sql/
│   ├── 01_create_database_and_tables.sql
│   ├── 02_data_exploration_and_quality_checks.sql
│   ├── 03_business_kpi_analysis.sql
│   ├── 04_customer_analysis.sql
│   ├── 05_product_and_category_analysis.sql
│   ├── 06_monthly_sales_analysis.sql
│   ├── 07_views.sql
│   └── 08_optional_business_questions.sql
└── screenshots/
    └── README.md
```

## Database schema

| Table | Description |
|---|---|
| `customers` | Customer name and city |
| `products` | Product name, category, and unit price |
| `project_orders` | Order date, customer, product, quantity, and status |

`project_orders.customer_id` references `customers.customer_id`, and `project_orders.product_id` references `products.product_id`.

**Revenue = quantity × unit_price**

Only `Completed` orders are counted as realized revenue. Pending and cancelled orders are reported separately.

## How to run

1. Install Microsoft SQL Server and SSMS.
2. Open `sql/01_create_database_and_tables.sql` in SSMS and execute it.
3. The setup script creates `SQL_Ecommerce_Analytics`, all three tables, and inserts sample data.
4. Execute scripts `02` through `08` in numerical order.
5. Review the results in SSMS.

**Warning:** The setup script drops and recreates the project tables. Run it only in a practice environment when you are comfortable resetting this database.

## Key results

| KPI | Sample result |
|---|---:|
| Total orders | 20 |
| Completed orders | 17 |
| Pending orders | 2 |
| Cancelled orders | 1 |
| Completed revenue | ₹3,92,500 |
| Average completed order value | ₹23,088.24 |
| Customers with completed purchases | 5 |

### Revenue by category

| Category | Revenue |
|---|---:|
| Electronics | ₹3,00,000 |
| Furniture | ₹64,000 |
| Accessories | ₹28,500 |

### Customer revenue

| Customer | Revenue |
|---|---:|
| Priya | ₹1,66,000 |
| Rahul | ₹69,000 |
| Vikas | ₹65,000 |
| Sneha | ₹54,500 |
| Amit | ₹38,000 |

### Monthly completed revenue

| Month | Revenue |
|---|---:|
| January 2026 | ₹1,06,000 |
| February 2026 | ₹53,000 |
| March 2026 | ₹16,000 |
| April 2026 | ₹62,500 |
| May 2026 | ₹32,000 |
| June 2026 | ₹61,000 |
| July 2026 | ₹62,000 |

## Business insights

- Electronics is the largest revenue-generating category in this sample.
- January is the highest-revenue month in the observed period.
- March shows a notable decline compared with February and merits further investigation.
- Priya is the highest-revenue customer in the sample.
- Neha has no completed purchase in this dataset and could be considered for customer-engagement analysis.

These are descriptive findings from a small synthetic dataset, not statistically validated business conclusions.

## SQL skills demonstrated

- Data exploration and data quality checks
- Filtering, sorting, and aggregation
- `GROUP BY` and conditional aggregation with `CASE`
- `INNER JOIN` and `NOT EXISTS`
- CTEs and subqueries
- Window functions: `DENSE_RANK()` and `LAG()`
- Date grouping with `DATEFROMPARTS()`, `YEAR()`, and `MONTH()`
- Month-over-month revenue analysis
- Reusable SQL Views
- Primary keys, foreign keys, and `CHECK` constraints

## Limitations and possible extensions

- This is a small synthetic dataset designed for practice.
- Each order contains one product line. A production model would commonly separate order headers and order-line items.
- `LAG()` compares the previous available month. A calendar table is needed to show months with no transactions.
- Discounts, refunds, shipping, taxes, and customer acquisition costs are not modeled.

Possible next steps:
- Add more transactions and a longer date range.
- Build a calendar table to report zero-sales months.
- Add discounts, returns, and shipping costs.
- Connect the SQL outputs to Power BI.
- Add indexes and evaluate performance on a larger dataset.

## Author

**Your Name**  
Data Analytics | SQL Server | T-SQL

## License

MIT
