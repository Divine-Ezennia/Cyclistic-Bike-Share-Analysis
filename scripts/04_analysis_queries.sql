/* STEP 4: COMPREHENSIVE ANALYSIS & BUSINESS INTELLIGENCE
Project: Cyclistic Bike-Share Analysis
Description: Description: This script contains the full analytical interrogation of the 
             processed dataset, segmented into Exploratory Data Analysis (EDA) 
             and Strategic Key Insights.
*/

-- =============================================================================
-- SECTION I: LIGHT EXPLORATION (Descriptive Analysis & Volume Validation)
-- =============================================================================

-- 4.1 Total cycling record
-- Validating the final consolidated row count for the 7-month window and bike inventory.
SELECT COUNT(ride_id) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`;

SELECT DISTINCT rideable_type
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`;

-- 4.2 Total ride count by user type
-- Initial segmentation of the market share between members and casual riders.
SELECT
  member_casual,
  COUNT(ride_id) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual
ORDER BY COUNT(ride_id) DESC;

-- 4.3 Total and average trip duration by user type
-- Establishing the base performance metrics for trip length.
SELECT
    member_casual,
    SUM(trip_duration_sec) AS total_trip_duration_sec,
    ROUND(AVG(trip_duration_sec), 2) AS avg_trip_duration_sec,
    MAX(trip_duration_sec) AS max_trip_duration_sec
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual
ORDER BY SUM(trip_duration_sec) DESC;

-- 4.4 Total ride count by bike type
-- Identifying the primary equipment usage across the fleet.
SELECT
  rideable_type,
  COUNT(*) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY rideable_type
ORDER BY COUNT(*) DESC;

-- 4.5 Total trip duration by bike type
-- Assessing if equipment type correlates with longer session lengths.
SELECT 
  rideable_type, 
  SUM(trip_duration_sec) AS total_trip_duration_sec
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY rideable_type
ORDER BY SUM(trip_duration_sec) DESC;


-- =============================================================================
-- SECTION II: KEY INSIGHTS (Business Intelligence & Strategic Trends)
-- =============================================================================

-- Insight 1 - Temporal Station Trend
-- Identifying high-traffic hubs for targeted infrastructure and marketing
SELECT
  member_casual,
  start_station_name,
  COUNT(*) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
WHERE start_station_name <> 'unknown station'
GROUP BY member_casual, start_station_name
ORDER BY COUNT(*) DESC;

SELECT
  member_casual,
  end_station_name,
  COUNT(*) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
WHERE end_station_name <> 'unknown station'
GROUP BY member_casual, end_station_name
ORDER BY COUNT(*) DESC

-- Insight 2 - Principal Station-to-Station Pair Structure
-- Mapping the most frequent commuter and recreational corridors.
SELECT
  member_casual,
  start_station_name,
  end_station_name,
  COUNT(*) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
WHERE start_station_name <> 'unknown station' AND end_station_name <> 'unknown station'
GROUP BY member_casual, start_station_name, end_station_name
ORDER BY COUNT(*) DESC;

-- Insight 3 - Station Trip Duration Variations
-- Analyzing how location influences time spent on the bike.
SELECT
  member_casual,
  start_station_name,
  end_station_name,
  ROUND(AVG(trip_duration_sec), 2) AS avg_trip_duration_sec
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
WHERE start_station_name <> 'unknown station' AND end_station_name <> 'unknown station'
GROUP BY member_casual, start_station_name, end_station_name
ORDER BY ROUND(AVG(trip_duration_sec), 2) DESC;

-- Insight 4 - Regular Bike Type Trend
-- Profiling user preference for bike categories.
SELECT
  member_casual,
  rideable_type,
  COUNT(*) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, rideable_type
ORDER BY COUNT(*) DESC;

-- Insight 5 - Bike Type Trip Duration Contrast
-- Contrasting duration performance between electric and classic fleets
SELECT
  member_casual,
  rideable_type,
  SUM(trip_duration_sec) AS total_trip_duration_sec,
  ROUND(AVG(trip_duration_sec), 2) AS avg_trip_duration_sec
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, rideable_type
ORDER BY SUM(trip_duration_sec) DESC;

-- Insight 6 - Peak Ride Hours Trend
-- Determining the most active hours for conversion opportunities.
SELECT
  member_casual,
  hour_of_day_started,
  hour_of_day_ended,
  COUNT(*) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, hour_of_day_started, hour_of_day_ended
ORDER BY COUNT(*) DESC;

-- Insight 7 - Hourly Trip Duration Differences
-- Tracking how ride length fluctuates throughout the 24-hour cycle
SELECT
  member_casual,
  hour_of_day_started,
  hour_of_day_ended,
  ROUND(AVG(trip_duration_sec), 2) AS avg_trip_duration_sec
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, hour_of_day_started, hour_of_day_ended
ORDER BY ROUND(AVG(trip_duration_sec), 2) DESC;

-- Insight 8 - Prime Time of Day Pattern
-- Aggregating demand by Morning, Afternoon, Evening, and Night segments.
SELECT
  member_casual,
  time_of_day_started,
  time_of_day_ended,
  COUNT(*) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, time_of_day_started, time_of_day_ended
ORDER BY COUNT(*) DESC;

-- Insight 9 - DayTime Trip Duration Variation
-- Highlighting behavioral changes across specific daytime windows.
SELECT
  member_casual,
  time_of_day_started,
  time_of_day_ended,
  ROUND(AVG(trip_duration_sec), 2) AS avg_trip_duration_sec
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, time_of_day_started, time_of_day_ended
ORDER BY ROUND(AVG(trip_duration_sec), 2) DESC;

-- Insight 10 - Rush day of Week Trend
-- Identifying 'Power Days' for member usage vs. casual peaks
SELECT
  member_casual,
  day_of_week_started,
  day_of_week_ended,
  COUNT(*) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, day_of_week_started, day_of_week_ended
ORDER BY COUNT(*) DESC;

-- Insight 11 - Daily Trip Duration Distinctions
-- Contrasting weekend leisure with weekday utility trip lengths.
SELECT
  member_casual,
  day_of_week_started,
  day_of_week_ended,
  ROUND(AVG(trip_duration_sec), 2) AS avg_trip_duration_sec
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, day_of_week_started, day_of_week_ended
ORDER BY ROUND(AVG(trip_duration_sec), 2) DESC;

-- Insight 12 - Highest Demand Week Part Trend
-- Segmenting data into Weekday vs. Weekend for macro-trend analysis.
SELECT
  member_casual,
  week_part_started,
  week_part_ended,
  COUNT(*) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, week_part_started, week_part_ended
ORDER BY COUNT(*) DESC;

-- Insight 13 - Weekly Trip Duration Contrast
-- Identifying time-on-bike differences between work days and rest days.
SELECT
  member_casual,
  week_part_started,
  week_part_ended,
  ROUND(AVG(trip_duration_sec), 2) AS avg_trip_duration_sec
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, week_part_started, week_part_ended
ORDER BY ROUND(AVG(trip_duration_sec), 2) DESC;

-- Insight 14 - Busiest Month Pattern
-- Tracking the seasonal surge (Winter decline to Spring peak)
SELECT
  member_casual,
  month_started,
  month_ended,
  COUNT(*) AS total_ride_count
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, month_started, month_ended
ORDER BY COUNT(*) DESC;

-- Insight 15 - Monthly Trip Duration Differences
-- Observing how seasonality impacts ride length across users
SELECT
  member_casual,
  month_started,
  month_ended,
  ROUND(AVG(trip_duration_sec), 2) AS avg_trip_duration_sec
FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary`
GROUP BY member_casual, month_started, month_ended
ORDER BY ROUND(AVG(trip_duration_sec), 2) DESC;
