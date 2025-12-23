/* =========================================================
   CLEANING & FEATURE ENGINEERING VIEW
   ---------------------------------------------------------
   This view standardizes data types, cleans numeric fields,
   creates time-based features, and filters invalid rides.
   All analysis queries should be run against this view.
   ========================================================= */

CREATE OR REPLACE VIEW v_df_2019_clean AS

/* ---------------------------------------------------------
   STEP 1: TYPE CASTING & BASIC CLEANING
   ---------------------------------------------------------
   - Convert start_time and end_time from TEXT to TIMESTAMP
   - Clean trip_duration_sec by removing thousand separators
   - Convert cleaned duration to NUMERIC
   --------------------------------------------------------- */
WITH typed AS (
  SELECT
    trip_id,
    start_time::timestamp AS start_time,         -- ride start timestamp
    end_time::timestamp   AS end_time,           -- ride end timestamp
    bike_id,

    -- Remove commas from duration values (e.g. "1,783.0")
    -- Convert empty strings to NULL, then cast to numeric
    NULLIF(REPLACE(trip_duration_sec, ',', ''), '')::numeric
      AS trip_duration_sec,

    from_station_id,
    from_station_name,
    to_station_id,
    to_station_name,
    user_type,                                   -- Customer or Subscriber
    gender,
    birth_year
  FROM df_2019
),

/* ---------------------------------------------------------
   STEP 2: FEATURE ENGINEERING
   ---------------------------------------------------------
   - Convert duration from seconds to minutes
   - Extract weekday, month, and hour from start_time
   - Create numeric ordering fields for correct sorting
   --------------------------------------------------------- */
features AS (
  SELECT
    *,

    -- Trip duration in minutes (used for analysis)
    trip_duration_sec / 60.0 AS trip_duration_min,

    -- Day of week as number (0 = Sunday, 6 = Saturday)
    EXTRACT(DOW FROM start_time) AS dow_num,

    -- Day of week as text label
    TO_CHAR(start_time, 'Day') AS day_of_week,

    -- Month number (1–12) for ordering
    EXTRACT(MONTH FROM start_time) AS month_num,

    -- Month name (January, February, ...)
    TO_CHAR(start_time, 'Month') AS month_name,

    -- Hour of day (0–23) for commuting analysis
    EXTRACT(HOUR FROM start_time) AS hour
  FROM typed
),

/* ---------------------------------------------------------
   STEP 3: DATA FILTERING
   ---------------------------------------------------------
   - Remove invalid or extreme ride durations
   - Keep only relevant user types
   - Final dataset matches cleaning logic used in R
   --------------------------------------------------------- */
filtered AS (
  SELECT *
  FROM features
  WHERE trip_duration_min BETWEEN 1 AND 1440
    AND user_type IN ('Customer', 'Subscriber')
)

/* ---------------------------------------------------------
   FINAL OUTPUT
   ---------------------------------------------------------
   This cleaned view serves as the single source of truth
   for all SQL analysis and exports.
   --------------------------------------------------------- */
SELECT *
FROM filtered;