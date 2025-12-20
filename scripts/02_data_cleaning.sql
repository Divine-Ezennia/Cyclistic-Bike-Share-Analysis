/* STEP 2: DATA CLEANING & STANDARDIZATION
Description: Handling missing values, trimming strings, and 
             correcting temporal inconsistencies.
*/

SELECT
    ride_id,
    rideable_type,
    
    -- TEMPORAL LOGIC: Ensuring started_at is always earlier than ended_at
    LEAST(started_at, ended_at) AS started_at,
    GREATEST(started_at, ended_at) AS ended_at,
    
    -- STRING CLEANING: Removing whitespaces and handling NULLs for stations
    IFNULL(TRIM(start_station_name), 'unknown station') AS start_station_name,
    IFNULL(start_station_id, 'unknown id') AS start_station_id,
    IFNULL(TRIM(end_station_name), 'unknown station') AS end_station_name,
    IFNULL(end_station_id, 'unknown id') AS end_station_id,
    
    -- RETAINING DIMENSIONAL DATA
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual

FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_2024_2025`;
