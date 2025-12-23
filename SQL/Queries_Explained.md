# SQL Analysis – Cyclistic Bike-Share Case Study

## SQL Environment
- Database: PostgreSQL
- Client: DBeaver
- OS: Linux (Arch Linux)

## Data Loading
Quarterly trip data for 2019 was loaded into separate tables and combined using UNION ALL.
Column names were standardized before merging.

## Data Cleaning
A reusable SQL VIEW (`v_df_2019_clean`) was created using CTEs to:
- Convert trip duration from seconds to minutes
- Remove invalid rides (<1 min or >1440 min)
- Handle numeric formatting issues (thousands separators)
- Cast timestamps correctly
- Create time-based features (weekday, month, hour)

## Analysis Approach
All analysis queries were executed on the cleaned view to ensure consistency and data integrity.

Key aggregations include:
- Ride counts by user type
- Average and median ride duration by user type
- Ride distribution by weekday
- Ride distribution by hour
- Seasonal (monthly) usage patterns

## Key Findings (from SQL)
- Casual riders take longer trips on average
- Subscribers ride significantly more often
- Subscriber rides peak during commuting hours
- Casual rides are more frequent on weekends

## Why PostgreSQL
PostgreSQL was chosen due to its wide adoption in European companies and strong support for analytical SQL features such as CTEs and window functions.
