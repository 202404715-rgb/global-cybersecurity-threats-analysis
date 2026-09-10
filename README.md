# Retail Sales Performance Analysis (SQL Server Window Functions)

## Project Overview
A synthetic but realistic **retail/e-commerce sales dataset** (6,000 orders,
350 customers, 3 years: 2022–2024, across 5 regions and 5 product categories)
analyzed entirely with **SQL Server Window Functions**. This project is built
to complement a cybersecurity-focused SQL project by showing the same
analytical toolkit (RANK, NTILE, LAG/LEAD, running totals) applied to a core
business domain: sales performance.

## Files
| File | Purpose |
|---|---|
| `retail_sales.csv` | The dataset (12 columns, 6,000 rows) |
| `generate_data.py` | Script used to generate the synthetic dataset (for transparency / reproducibility) |
| `01_setup_and_load.sql` | Creates the database/table and loads the CSV |
| `02_window_functions_analysis.sql` | The 9 analytical queries (see below) |

## Dataset Columns
`OrderID, OrderDate, CustomerID, Region, Segment, Category, Product, Quantity, UnitPrice, Discount, Sales, Profit`

- **Region**: Cairo, Alexandria, Giza, Mansoura, Aswan, Tanta
- **Segment**: Consumer, Corporate, Small Business
- **Category**: Electronics, Furniture, Clothing, Groceries, Beauty
- Sales have built-in **seasonality** (higher volume in Nov/Dec, a mid-year
  bump in Jun/Jul) so the time-based window functions (running totals,
  moving averages, YoY growth) show real, interpretable patterns.

## How to Run
1. Open `01_setup_and_load.sql` in SSMS, update the `BULK INSERT` file path
   to wherever you save `retail_sales.csv`, and run it.
   (Alternative: use SSMS's **Import Flat File** wizard, which needs no path
   editing.)
2. Run `02_window_functions_analysis.sql` — each query block (`Q1`–`Q9`) is
   self-contained and commented with the business question it answers.

## Analyses Included (mapped to Window Function concepts)

| # | Question | Window Function(s) |
|---|---|---|
| Q1 | Best-selling product per category + ties handling | `ROW_NUMBER`, `RANK`, `DENSE_RANK` |
| Q2 | Top 3 products by revenue, per region | `ROW_NUMBER` (Top-N-per-group) |
| Q3 | Cumulative revenue over time | `SUM() OVER (ORDER BY ...)` running total |
| Q4 | Month-over-month growth % | `LAG()` |
| Q5 | 3-month moving average of sales | `AVG() OVER (ROWS BETWEEN 2 PRECEDING...)` |
| Q6 | Orders above/below their category's average | `AVG() OVER (PARTITION BY ...)` |
| Q7 | Customer value segmentation (spend deciles) + drill into top decile | `NTILE(10)` |
| Q8 | Days until each customer's next order | `LEAD()` |
| Q9 | Year-over-year growth by category | `LAG()` partitioned by category |

## Suggested "Story" for Your Portfolio Write-up
1. **Overall trend** — show the running total (Q3) and moving average (Q5)
   to establish the growth trajectory across 2022–2024.
2. **What's driving it** — RANK/Top-N (Q1, Q2) to name the specific
   products/categories carrying the business.
3. **Who's driving it** — NTILE decile analysis (Q7) to identify the top
   10% of customers by spend, then break that segment down by
   Region × Segment (mirrors the "Country × Attack Type" tail-risk
   breakdown from the cybersecurity project) — this is usually the
   strongest, most "so what" insight in the whole project.
4. **Is it sustainable** — YoY growth (Q9) and MoM growth (Q4) to flag
   which categories are accelerating vs. declining.
5. **Retention angle** — LEAD-based days-until-next-order (Q8) as a proxy
   for customer engagement/churn risk.

## One-liner for your resume/portfolio
"Analyzed 6,000+ retail transactions using SQL Server window functions
(RANK, NTILE, LAG/LEAD, running totals) to identify top-decile customers
driving disproportionate revenue and flag month-over-month growth trends
across regions and product categories."
