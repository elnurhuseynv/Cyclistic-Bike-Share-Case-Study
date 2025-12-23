/* =========================================================
   ANALYSIS QUERIES
   ---------------------------------------------------------
   All queries below are executed on the cleaned dataset
   (v_df_2019_clean). These queries generate the key
   insights used in the case study.
   ========================================================= */


/* ---------------------------------------------------------
   QUERY 1: SUMMARY STATISTICS BY USER TYPE
   ---------------------------------------------------------
   Purpose:
   - Compare ride volume and duration between Customers
     and Subscribers
   - Supports the core business question:
     "How do annual members and casual riders differ?"
   Metrics:
   - Total number of rides
   - Average ride duration (minutes)
   - Median ride duration (minutes)
   --------------------------------------------------------- */
SELECT
  user_type,
  COUNT(*) AS rides,
  AVG(trip_duration_min) AS avg_duration_min,
  PERCENTILE_CONT(0.5) 
    WITHIN GROUP (ORDER BY trip_duration_min) AS median_duration_min
FROM v_df_2019_clean
GROUP BY user_type;


/* ---------------------------------------------------------
   QUERY 2: NUMBER OF RIDES BY DAY OF WEEK
   ---------------------------------------------------------
   Purpose:
   - Identify usage patterns across weekdays vs weekends
   - Detect commuting vs leisure behavior
   Notes:
   - dow_num is used to ensure correct weekday ordering
   --------------------------------------------------------- */
SELECT
  user_type,
  dow_num,
  TRIM(day_of_week) AS day_of_week,
  COUNT(*) AS rides
FROM v_df_2019_clean
GROUP BY user_type, dow_num, day_of_week
ORDER BY user_type, dow_num;


/* ---------------------------------------------------------
   QUERY 3: AVERAGE RIDE DURATION BY DAY OF WEEK
   ---------------------------------------------------------
   Purpose:
   - Compare how long Customers and Subscribers ride
     on different days
   - Complements ride-count analysis
   --------------------------------------------------------- */
SELECT
  user_type,
  dow_num,
  TRIM(day_of_week) AS day_of_week,
  AVG(trip_duration_min) AS avg_duration_min
FROM v_df_2019_clean
GROUP BY user_type, dow_num, day_of_week
ORDER BY user_type, dow_num;


/* ---------------------------------------------------------
   QUERY 4: NUMBER OF RIDES BY HOUR OF DAY
   ---------------------------------------------------------
   Purpose:
   - Identify daily usage patterns
   - Detect commuter peaks (morning / evening)
   - Contrast subscriber vs customer behavior
   --------------------------------------------------------- */
SELECT
  user_type,
  hour,
  COUNT(*) AS rides
FROM v_df_2019_clean
GROUP BY user_type, hour
ORDER BY hour, user_type;


/* ---------------------------------------------------------
   QUERY 5: NUMBER OF RIDES BY MONTH
   ---------------------------------------------------------
   Purpose:
   - Identify seasonal trends in bike usage
   - Compare how Customers and Subscribers behave
     throughout the year
   Notes:
   - month_num ensures correct chronological ordering
   --------------------------------------------------------- */
SELECT
  user_type,
  month_num,
  TRIM(month_name) AS month_name,
  COUNT(*) AS rides
FROM v_df_2019_clean
GROUP BY user_type, month_num, month_name
ORDER BY user_type, month_num;