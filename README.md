# Cyclistic Bike-Share Case Study (2019) — Customer vs Subscriber

This project analyzes **2019 Cyclistic bike-share usage** to understand how **Customers** and **Subscribers** behave differently, and to propose actions that can increase **membership conversions**.

I cleaned and prepared the data in **R**, ran analysis and aggregations in **PostgreSQL**, and built a dashboard in **Excel (Web)**.

## Quick Links (Deliverables)

- **Project Report (PDF):** [Cyclistic_Case_Study_Report.pdf](./Cyclistic_Case_Study_Report.pdf)  
- **Excel Dashboard (XLSX):** [Cyclistic_Excel_Dashboard.xlsx](./Excel/Outputs/Cyclistic_Excel_Dashboard.xlsx)  
- **Excel Dashboard (PDF):** [Cyclistic_Excel_Dashboard.pdf](./Excel/Outputs/Cyclistic_Excel_Dashboard.pdf)

---

## Business Question

**How do Customers and Subscribers differ in ride volume and ride patterns (weekday, hour, and seasonality), and what actions can increase membership conversions?**

---

## Tools Used

- **R** (tidyverse, lubridate) — cleaning, feature engineering, EDA  
- **PostgreSQL** — storage + SQL analysis + aggregations  
- **DBeaver** — database client  
- **Microsoft Excel (Web)** — PivotTables, charts, dashboard layout  
- **Arch Linux** — development environment

---

## Data

- **Period:** 2019 (Q1–Q4)
- **Input files:** quarterly CSVs (loaded into PostgreSQL as separate tables, then combined)
- **Key fields:** start/end time, trip duration, stations, user_type, etc.

> Note: Raw CSV files are **not included** in this repo (large size and/or source restrictions).  
> The workflow, scripts, and outputs are included so results can be reproduced.

---

## Workflow

### 1) R — Cleaning & Feature Engineering
- Imported and standardized quarterly files
- Cleaned column names and types
- Created derived fields used later in analysis:
  - `trip_duration_min`
  - `day_of_week` + `weekday_order`
  - `hour`
  - `month` + `month_order`

Outputs from R are stored under:
- `R/Scripts/`
- `R/Outputs/`

### 2) PostgreSQL — Data Model + Analysis
- Created quarterly tables and combined them into a single 2019 table
- Built a cleaned view used for analysis (filters + type conversions)
- Created aggregated datasets for Excel:
  - KPI summary (rides, avg duration, median duration)
  - Rides by weekday
  - Rides by hour
  - Rides by month

SQL scripts and notes are stored under:
- `SQL/Scripts/`
- `SQL/Queries_Explained.md`
- `SQL/Outputs/`

### 3) Excel (Web) — Dashboard
- Loaded aggregated outputs (not raw multi-million rows)
- Built PivotTables + charts:
  - Rides by Weekday
  - Rides by Hour
  - Rides by Month
- Assembled a single dashboard layout with KPI cards + visuals

Dashboard files:
- `Excel/Outputs/Cyclistic_Excel_Dashboard.xlsx`
- `Excel/Outputs/Cyclistic_Excel_Dashboard.pdf`

---

## Key Findings (2019)

1. **Subscribers account for the majority of rides** compared to Customers.
2. **Customers have longer average ride durations** than Subscribers.
3. Usage patterns differ by time:
   - **Hour-of-day patterns** suggest commuting vs leisure behavior.
   - **Seasonality** shows higher ridership in warmer months.

(Exact values and charts are shown in the PDF report and Excel dashboard.)

---

## Recommendations

1. **Convert Customers to Subscribers using targeted offers**
   - Discounts or trial memberships during peak leisure periods.
2. **Marketing by time-of-use**
   - Promote subscriptions around commute peaks; promote day passes around weekend peaks.
3. **Seasonal campaigns**
   - Push conversion campaigns in spring/summer when demand is highest.

---

## How to Reproduce (High Level)

1. Run the **R scripts** to clean and engineer features (outputs saved in `R/Outputs/`).
2. Load cleaned data into **PostgreSQL** and create the combined 2019 table + clean view.
3. Run **SQL aggregation queries** to export summarized outputs.
4. Load summarized outputs into **Excel** and refresh PivotTables/charts.

---

## Project Structure

```text
Cyclistic-Bike-Share-Case-Study/
├─ Cyclistic_Case_Study_Report.pdf
├─ Excel/
│  └─ Outputs/
│     ├─ Cyclistic_Excel_Dashboard.xlsx
│     └─ Cyclistic_Excel_Dashboard.pdf
├─ R/
│  ├─ Scripts/
│  ├─ Outputs/
│  ├─ Cyclistic_Case_Study.Rmd
│  ├─ Cyclistic_Case_Study.html
│  └─ README.md
└─ SQL/
   ├─ Scripts/
   ├─ Outputs/
   └─ Queries_Explained.md

```

---

## Author

**Elnur Huseynov**  
GitHub: `elnurhuseynv`
