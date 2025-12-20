/* STEP 1: DATA MERGING & CONSOLIDATION
Project: Cyclistic Bike-Share Analysis
Description: Merging 7 months of ride data (Nov 2024 - May 2025).
Data Limitation: Analysis is focused on this specific 7-month window 
                  based on data availability and project scope within 
                  the sandbox BigQuery environment at the time of processing.
*/

-- Combining monthly ride data into one unified dataset
-- Using UNION DISTINCT to ensure 100% record uniqueness
SELECT * FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_2024_11`
UNION DISTINCT
SELECT * FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_2024_12`
UNION DISTINCT
SELECT * FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_2025_01`
UNION DISTINCT
SELECT * FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_2025_02`
UNION DISTINCT
SELECT * FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_2025_03`
UNION DISTINCT
SELECT * FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_2025_04`
UNION DISTINCT
SELECT * FROM `axiomatic-set-467921-a9.Cyclistic_Bikes.Trip_Data_2025_05`;
