# ------------------------------------------------------------
# SUMMARY ANALYSIS: MEMBER VS CASUAL RIDER BEHAVIOR (2019)
# This section creates summary statistics used for analysis,
# visualization, and portfolio outputs.
# ------------------------------------------------------------

# 1. Overall ride behavior by user type
# Calculates mean and median ride duration (in minutes)
# and total number of rides for each user group
DF_2019 %>%
  group_by(User_Type) %>%
  summarise(
    Mean_Duration   = mean(Trip_Duration_Min, na.rm = TRUE),
    Median_Duration = median(Trip_Duration_Min, na.rm = TRUE),
    Rides           = n()
  )


# 2. Ride behavior by user type and day of week
# Helps identify weekday vs weekend usage patterns
# Useful for understanding commuting vs leisure behavior
DF_2019 %>%
  group_by(User_Type, Day_Of_Week) %>%
  summarise(
    Avg_Duration = mean(Trip_Duration_Min, na.rm = TRUE),
    Ride_Count   = n()
  ) %>%
  View()


# 3. Ride volume by user type and month
# Used to analyze seasonal trends and demand patterns
DF_2019 %>%
  group_by(User_Type, Month) %>%
  summarise(
    Rides = n()
  ) %>%
  View()


# 4. Ride volume by user type and hour of day
# Helps detect peak commuting hours and daily usage patterns
DF_2019 %>%
  group_by(User_Type, Hour) %>%
  summarise(
    Rides = n()
  ) %>%
  View()


# 5. Final summary table for reporting and export
# This table is used for portfolio reporting and sharing
Summary_Table <- DF_2019 %>%
  group_by(User_Type) %>%
  summarise(
    Rides        = n(),
    Avg_Duration = mean(Trip_Duration_Min, na.rm = TRUE)
  )


# 6. Export summary table to CSV
# This file will be included in the portfolio outputs folder
write.csv(
  Summary_Table,
  "Outputs/Summary_Table.csv",
  row.names = FALSE
)