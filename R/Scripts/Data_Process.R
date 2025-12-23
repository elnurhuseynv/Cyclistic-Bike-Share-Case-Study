# -------------------------------
# Cyclistic / Divvy Case Study
# Data import + cleaning (R)
# -------------------------------

# Set working directory to my project folder
setwd("~/Downloads/Cyclistic_Bike_Share_Case_Study/R")

# Load readr for reading CSV files efficiently
library(readr)

# --- Import each quarter CSV file (raw data) ---

# Read Divvy 2019 Q1 trip data
Divvy_Trips_2019_Q1 <- read_csv("Downloads/Divvy_Trips_2019_Q1/Divvy_Trips_2019_Q1.csv")
View(Divvy_Trips_2019_Q1)  # Quick manual inspection (optional)

# Read Divvy 2019 Q2 trip data (different column naming format than Q1/Q3/Q4)
Divvy_Trips_2019_Q2 <- read_csv("Downloads/Divvy_Trips_2019_Q2/Divvy_Trips_2019_Q2.csv")
View(Divvy_Trips_2019_Q2)

# Read Divvy 2019 Q3 trip data
Divvy_Trips_2019_Q3 <- read_csv("Downloads/Divvy_Trips_2019_Q3/Divvy_Trips_2019_Q3.csv")
View(Divvy_Trips_2019_Q3)

# Read Divvy 2019 Q4 trip data
Divvy_Trips_2019_Q4 <- read_csv("Downloads/Divvy_Trips_2019_Q4/Divvy_Trips_2019_Q4.csv")
View(Divvy_Trips_2019_Q4)

# Read Divvy 2020 Q1 trip data (newer schema than 2019; columns are different)
Divvy_Trips_2020_Q1 <- read_csv("Downloads/Divvy_Trips_2020_Q1/Divvy_Trips_2020_Q1.csv")
View(Divvy_Trips_2020_Q1)

# Load tidyverse/dplyr for data manipulation
library(tidyverse)
library(dplyr)

# -------------------------------
# Standardize column names (2019)
# Goal: make Q1/Q2/Q3/Q4 consistent so I can bind_rows()
# -------------------------------

# 2019 Q1: rename columns to a consistent naming standard
DF_2019_Q1 <- Divvy_Trips_2019_Q1 %>%
  rename(
    Trip_ID = trip_id,
    Start_Time = start_time,
    End_Time = end_time,
    Bike_ID = bikeid,
    Trip_Duration = tripduration,                 # raw duration in seconds
    From_Station_ID = from_station_id,
    From_Station_Name = from_station_name,
    To_Station_ID = to_station_id,
    To_Station_Name = to_station_name,
    User_Type = usertype,                         # Customer vs Subscriber
    Gender = gender,
    Birth_Year = birthyear
  )

# Remove raw object to free memory (optional, but good practice with large data)
rm(Divvy_Trips_2019_Q1)

# 2019 Q2: rename columns (Q2 has long “01 - Rental Details ...” column names)
DF_2019_Q2 <- Divvy_Trips_2019_Q2 %>%
  rename(
    Trip_ID = `01 - Rental Details Rental ID`,
    Start_Time = `01 - Rental Details Local Start Time`,
    End_Time = `01 - Rental Details Local End Time`,
    Bike_ID = `01 - Rental Details Bike ID`,
    Trip_Duration = `01 - Rental Details Duration In Seconds Uncapped`,  # seconds
    From_Station_ID = `03 - Rental Start Station ID`,
    From_Station_Name = `03 - Rental Start Station Name`,
    To_Station_ID = `02 - Rental End Station ID`,
    To_Station_Name = `02 - Rental End Station Name`,
    User_Type = `User Type`,                     # Customer vs Subscriber
    Gender = `Member Gender`,
    Birth_Year = `05 - Member Details Member Birthday Year`
  )

rm(Divvy_Trips_2019_Q2)

# 2019 Q3: rename columns to match my standard
DF_2019_Q3 <- Divvy_Trips_2019_Q3 %>%
  rename(
    Trip_ID = trip_id,
    Start_Time = start_time,
    End_Time = end_time,
    Bike_ID = bikeid,
    Trip_Duration = tripduration,                # seconds
    From_Station_ID = from_station_id,
    From_Station_Name = from_station_name,
    To_Station_ID = to_station_id,
    To_Station_Name = to_station_name,
    User_Type = usertype,
    Gender = gender,
    Birth_Year = birthyear
  )

rm(Divvy_Trips_2019_Q3)

# 2019 Q4: rename columns to match my standard
DF_2019_Q4 <- Divvy_Trips_2019_Q4 %>%
  rename(
    Trip_ID = trip_id,
    Start_Time = start_time,
    End_Time = end_time,
    Bike_ID = bikeid,
    Trip_Duration = tripduration,                # seconds
    From_Station_ID = from_station_id,
    From_Station_Name = from_station_name,
    To_Station_ID = to_station_id,
    To_Station_Name = to_station_name,
    User_Type = usertype,
    Gender = gender,
    Birth_Year = birthyear
  )

rm(Divvy_Trips_2019_Q4)

# -------------------------------
# Standardize column names (2020 Q1)
# Note: 2020 Q1 has a different schema (ride_id, started_at, member_casual, lat/lng, etc.)
# I'll rename to align with our naming style where possible.
# -------------------------------

DF_2020_Q1 <- Divvy_Trips_2020_Q1 %>%
  rename(
    Trip_ID = ride_id,
    Trip_Type = rideable_type,
    Start_Time = started_at,
    End_Time = ended_at,
    From_Station_Name = start_station_name,
    From_Station_ID = start_station_id,
    To_Station_Name = end_station_name,
    To_Station_ID = end_station_id,
    Start_Lat = start_lat,
    Start_Lng = start_lng,
    End_Lat = end_lat,
    End_Lng = end_lng,
    User_Type = member_casual                  # member vs casual (different values than 2019)
  )

rm(Divvy_Trips_2020_Q1)

# -------------------------------
# Combine 2019 quarters into a single 2019 dataset
# -------------------------------

# Bind rows because columns now match across 2019 quarters
DF_2019 <- bind_rows(DF_2019_Q1, DF_2019_Q2, DF_2019_Q3, DF_2019_Q4)

# -------------------------------
# Clean and engineer features (2019)
# -------------------------------

# 1) Convert Trip_Duration from seconds to minutes
DF_2019 <- DF_2019 %>%
  mutate(Trip_Duration_Min = Trip_Duration / 60)

# Move Trip_Duration_Min next to Trip_Duration for readability
DF_2019 <- DF_2019 %>%
  relocate(Trip_Duration_Min, .after = Trip_Duration)

# Rename Trip_Duration to make it clear it is seconds (avoid confusion later)
DF_2019 <- DF_2019 %>%
  rename(Trip_Duration_Sec = Trip_Duration)

# 2) Filter out invalid/outlier rides
#    - < 1 minute: likely test/incorrect records
#    - > 1440 minutes (24 hours): likely abandoned bikes or system errors
DF_2019 <- DF_2019 %>%
  filter(
    Trip_Duration_Min >= 1,
    Trip_Duration_Min <= 1440
  )

# 3) Convert Start_Time and End_Time into proper datetime objects
DF_2019 <- DF_2019 %>%
  mutate(
    Start_Time = as.POSIXct(Start_Time),
    End_Time   = as.POSIXct(End_Time)
  )

# 4) Create time-based features for analysis (weekday/month/hour/weekend flag)
DF_2019 <- DF_2019 %>%
  mutate(
    Day_Of_Week = weekdays(Start_Time),          # Monday...Sunday
    Month = format(Start_Time, "%B"),            # January...December
    Hour = as.numeric(format(Start_Time, "%H")), # 0-23 (hour of day)
    Is_Weekend = Day_Of_Week %in% c("Saturday", "Sunday")
  )

# 5) Set weekday order for correct plotting (instead of alphabetical order)
DF_2019$Day_Of_Week <- factor(
  DF_2019$Day_Of_Week,
  levels = c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")
)

# -------------------------------
# Save cleaned/intermediate datasets (optional but great for portfolio + reproducibility)
# -------------------------------

# Use data.table::fwrite for fast CSV export
library(data.table)

# Export combined and quarter-level files (useful for backups and SQL/Excel later)
fwrite(DF_2019,    "Data/DF_2019.csv")
fwrite(DF_2019_Q1, "Data/DF_2019_Q1.csv")
fwrite(DF_2019_Q2, "Data/DF_2019_Q2.csv")
fwrite(DF_2019_Q3, "Data/DF_2019_Q3.csv")
fwrite(DF_2019_Q4, "Data/DF_2019_Q4.csv")
fwrite(DF_2020_Q1, "Data/DF_2020_Q1.csv")
