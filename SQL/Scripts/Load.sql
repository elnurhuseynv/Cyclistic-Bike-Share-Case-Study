/* =========================================================
   STEP 1: CREATE QUARTERLY TABLES FOR 2019
   ---------------------------------------------------------
   Each table represents one quarter of Divvy trip data.
   Column names are standardized across quarters to allow
   UNION ALL later.
   Raw data types are kept as TEXT where cleaning is needed.
   ========================================================= */

CREATE TABLE df_2019_q1 (
  trip_id INT,
  start_time TEXT,               -- ride start timestamp (raw)
  end_time TEXT,                 -- ride end timestamp (raw)
  bike_id INT,
  trip_duration_sec TEXT,        -- duration in seconds (may contain commas)
  from_station_id INT,
  from_station_name TEXT,
  to_station_id INT,
  to_station_name TEXT,
  user_type TEXT,                -- Customer or Subscriber
  gender TEXT,
  birth_year INT
);

CREATE TABLE df_2019_q2 (
  trip_id INT,
  start_time TEXT,
  end_time TEXT,
  bike_id INT,
  trip_duration_sec TEXT,
  from_station_id INT,
  from_station_name TEXT,
  to_station_id INT,
  to_station_name TEXT,
  user_type TEXT,
  gender TEXT,
  birth_year INT
);

CREATE TABLE df_2019_q3 (
  trip_id INT,
  start_time TEXT,
  end_time TEXT,
  bike_id INT,
  trip_duration_sec TEXT,
  from_station_id INT,
  from_station_name TEXT,
  to_station_id INT,
  to_station_name TEXT,
  user_type TEXT,
  gender TEXT,
  birth_year INT
);

CREATE TABLE df_2019_q4 (
  trip_id INT,
  start_time TEXT,
  end_time TEXT,
  bike_id INT,
  trip_duration_sec TEXT,
  from_station_id INT,
  from_station_name TEXT,
  to_station_id INT,
  to_station_name TEXT,
  user_type TEXT,
  gender TEXT,
  birth_year INT
);

/* =========================================================
   STEP 2: COMBINE ALL QUARTERS INTO A SINGLE 2019 TABLE
   ---------------------------------------------------------
   UNION ALL is used (not UNION) to preserve all records
   and avoid unnecessary duplicate checks.
   ========================================================= */

CREATE TABLE df_2019 AS
SELECT * FROM df_2019_q1
UNION ALL
SELECT * FROM df_2019_q2
UNION ALL
SELECT * FROM df_2019_q3
UNION ALL
SELECT * FROM df_2019_q4;

/* =========================================================
   STEP 3: VALIDATE ROW COUNT AFTER MERGE
   ---------------------------------------------------------
   This check ensures that all quarterly data was loaded
   successfully into the combined table.
   ========================================================= */

SELECT COUNT(*) AS total_rows  -- 3818004 rows
FROM df_2019;              

/* =========================================================
   STEP 4: DROP INTERMEDIATE QUARTER TABLES
   ---------------------------------------------------------
   Quarterly tables are removed to:
   - reduce clutter
   - prevent accidental use of partial data
   - enforce use of the consolidated table
   ========================================================= */

DROP TABLE df_2019_q1;
DROP TABLE df_2019_q2;
DROP TABLE df_2019_q3;
DROP TABLE df_2019_q4;