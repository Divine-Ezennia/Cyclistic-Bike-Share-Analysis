/* STEP 3: DATA ENRICHMENT
Project: Cyclistic Bike-Share Analysis
Description: Generating calculated fields for temporal and behavioral analysis.
Metrics: Trip duration, Time of day categories, Day of Week, and Month extraction.
*/

CREATE OR REPLACE TABLE `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_summary` AS
SELECT
    ride_id,
    member_casual,
    rideable_type,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    started_at,
    ended_at,
    trip_duration_sec,
    hour_of_day_started,
    hour_of_day_ended,
    time_of_day_started,
    time_of_day_ended,
    day_of_week_started,
    day_of_week_ended,
    -- Categorizing the part of the week
    CASE
      WHEN day_of_week_started IN ('Saturday', 'Sunday') THEN 'Weekend'
      ELSE 'Weekday'
    END AS week_part_started,
    CASE
      WHEN day_of_week_ended IN ('Saturday', 'Sunday') THEN 'Weekend'
      ELSE 'Weekday'
    END AS week_part_ended,
    month_started,
    month_ended,
    start_lat,
    start_lng,
    end_lat,
    end_lng
FROM
    (
      SELECT
        ride_id,
        member_casual,
        rideable_type,
        start_station_name,
        start_station_id,
        end_station_name,
        end_station_id,
        started_at,
        ended_at,
        start_lat,
        start_lng,
        end_lat,
        end_lng,
        -- Calculating trip length in seconds
        TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS trip_duration_sec,
        -- Extracting specific time components
        EXTRACT(HOUR FROM started_at) AS hour_of_day_started,
        EXTRACT(HOUR FROM ended_at) AS hour_of_day_ended,
        -- Categorizing time segments based on 24-hour clock
        CASE
          WHEN EXTRACT(HOUR FROM started_at) BETWEEN 5 AND 11 THEN 'Morning'
          WHEN EXTRACT(HOUR FROM started_at) BETWEEN 12 AND 16 THEN 'Afternoon'
          WHEN EXTRACT(HOUR FROM started_at) BETWEEN 17 AND 20 THEN 'Evening'
          ELSE 'Night'
        END AS time_of_day_started,
        CASE
          WHEN EXTRACT(HOUR FROM ended_at) BETWEEN 5 AND 11 THEN 'Morning'
          WHEN EXTRACT(HOUR FROM ended_at) BETWEEN 12 AND 16 THEN 'Afternoon'
          WHEN EXTRACT(HOUR FROM ended_at) BETWEEN 17 AND 20 THEN 'Evening'
          ELSE 'Night'
        END AS time_of_day_ended,
        -- Formatting dates for readability
        FORMAT_DATE('%A', DATE(started_at)) AS day_of_week_started,
        FORMAT_DATE('%A', DATE(ended_at)) AS day_of_week_ended,
        FORMAT_DATE('%B', DATE(started_at)) AS month_started,
        FORMAT_DATE('%B', DATE(ended_at)) AS month_ended
      FROM
        `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_cleaned`
    )
-- METICULOUS FILTER: Ensuring the analysis window stays within Nov 2024 - May 2025
WHERE
    month_started <> 'October'
    AND month_ended <> 'October';
