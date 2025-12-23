# ------------------------------------------------------------
# VISUAL ANALYSIS: Cyclistic Bike Usage Patterns (2019)
# This section creates and saves key visualizations comparing
# casual riders and annual members.
# ------------------------------------------------------------

# 1. Ride Duration by User Type (Boxplot)
# - Filter rides longer than 120 minutes to reduce the effect of extreme outliers
# - Compare distribution of ride duration between Customer and Subscriber
Ride_Duration <- DF_2019 %>%
  filter(Trip_Duration_Min <= 120) %>%           # Remove long-duration outliers
  ggplot(aes(User_Type, Trip_Duration_Min, fill = User_Type)) +
  geom_boxplot(show.legend = FALSE) +             # Boxplot shows median, IQR, and spread
  labs(
    title = "Ride Duration by User Type (≤ 120 min)",
    y = "Duration (minutes)",
    x = ""
  )


# 2. Number of Rides by Day of Week
# - Aggregate total rides by user type and weekday
# - Helps identify commuting vs leisure behavior
Rides_By_Weekday <- DF_2019 %>%
  group_by(User_Type, Day_Of_Week) %>%            # Group by rider type and weekday
  summarise(Rides = n(), .groups = "drop") %>%    # Count number of rides
  ggplot(aes(Day_Of_Week, Rides, fill = User_Type)) +
  geom_col(position = "dodge") +                  # Side-by-side bars for comparison
  labs(title = "Rides by Day of Week")


# 3. Number of Rides by Month
# - Analyze seasonal trends in bike usage
# - Line chart highlights differences in riding patterns over the year
Rides_By_Month <- DF_2019 %>%
  group_by(User_Type, Month) %>%                  # Group by rider type and month
  summarise(Rides = n(), .groups = "drop") %>%    # Count rides per month
  ggplot(aes(Month, Rides, color = User_Type, group = User_Type)) +
  geom_line() +                                   # Line chart for trend analysis
  theme(axis.text.x = element_text(angle = 45))   # Improve readability of month labels


# 4. Number of Rides by Hour of Day
# - Examine daily usage patterns
# - Useful for identifying commute hours vs leisure riding
Rides_By_Hour <- DF_2019 %>%
  group_by(User_Type, Hour) %>%                   # Group by rider type and hour
  summarise(Rides = n(), .groups = "drop") %>%    # Count rides per hour
  ggplot(aes(Hour, Rides, color = User_Type)) +
  geom_line()                                     # Line chart shows hourly trends


# ------------------------------------------------------------
# SAVE ALL VISUALIZATIONS
# Charts are saved for use in portfolio, reports, and README
# ------------------------------------------------------------

ggsave(
  filename = "Outputs/Ride_Duration.png",
  plot = Ride_Duration,
  width = 8,
  height = 5
)

ggsave(
  filename = "Outputs/Rides_By_Weekday.png",
  plot = Rides_By_Weekday,
  width = 8,
  height = 5
)

ggsave(
  filename = "Outputs/Rides_By_Month.png",
  plot = Rides_By_Month,
  width = 8,
  height = 5
)

ggsave(
  filename = "Outputs/Rides_By_Hour.png",
  plot = Rides_By_Hour,
  width = 8,
  height = 5
)