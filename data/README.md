# 📂 Data Documentation

## 1. Data Source & Provenance
The raw data utilized in this analysis is sourced from the **Cyclistic trip data** (historical trip data from Motivate International Inc.). 

* **Access Link:** [Cyclistic Raw Data (AWS S3)](https://divvy-tripdata.s3.amazonaws.com/index.html)
* **License:** This data is made available under a [Data License Agreement](https://www.divvybikes.com/data-license-agreement).
* **Timeframe:** November 2024 to May 2025.

## 2. Data Dictionary (Schema)
The following table defines the columns found in the `Trip_Data_summary` table generated in the `scripts/` pipeline.

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| **ride_id** | STRING | Unique 16-character identifier for each individual ride. |
| **rideable_type** | STRING | Type of bike used (classic_bike, electric_bike). |
| **started_at** | TIMESTAMP | Date and time when the ride commenced. |
| **ended_at** | TIMESTAMP | Date and time when the ride concluded. |
| **start_station_name**| STRING | Name of the departure station (`IFNULL` handles missing values). |
| **end_station_name** | STRING | Name of the arrival station (`IFNULL` handles missing values). |
| **start_station_id** | STRING | Unique identifier for the departure station. |
| **end_station_id** | STRING | Unique identifier for the arrival station. |
| **member_casual** | STRING | User segmentation (Member = annual subscriber; Casual = single-ride/day-pass). |
| **trip_duration_sec** | INTEGER | Calculated ride length in seconds (`ended_at - started_at`). |
| **hour_of_day_started**| INTEGER | The hour (0-23) when the ride began. |
| **hour_of_day_ended** | INTEGER | The hour (0-23) when the ride ended. |
| **time_of_day_started**| STRING | Segment of the day started (Morning, Afternoon, Evening, Night). |
| **time_of_day_ended** | STRING | Segment of the day ended (Morning, Afternoon, Evening, Night). |
| **day_of_week_started**| STRING | Day of the week started (e.g., Monday, Sunday). |
| **day_of_week_ended** | STRING | Day of the week ended. |
| **week_part_started** | STRING | Categorical grouping (Weekday vs. Weekend) for start time. |
| **week_part_ended** | STRING | Categorical grouping (Weekday vs. Weekend) for end time. |
| **month_started** | STRING | Full month name when the ride began (e.g., November). |
| **month_ended** | STRING | Full month name when the ride ended. |
| **start_lat** | FLOAT | Latitude coordinates of the starting point. |
| **start_lng** | FLOAT | Longitude coordinates of the starting point. |
| **end_lat** | FLOAT | Latitude coordinates of the destination. |
| **end_lng** | FLOAT | Longitude coordinates of the destination. |



## 3. Data Integrity & Constraints
* **Duplicate Mitigation:** Used `UNION DISTINCT` during consolidation to ensure record uniqueness.
* **Temporal Logic:** Applied `LEAST/GREATEST` functions to ensure `started_at` precedes `ended_at`.
* **Scope Exclusion:** Filtered out October 2024 records to maintain a consistent 7-month seasonal analysis window.
