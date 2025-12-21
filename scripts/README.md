# 🛠️ SQL Data Pipeline (BigQuery)

This directory contains the modular SQL scripts used to transform raw Cyclistic trip data into a structured, analysis-ready gold dataset. The pipeline follows an **ETL (Extract, Transform, Load)** architecture to ensure data integrity and reproducibility.

## 🏗️ Pipeline Architecture

The transformation process is divided into four sequential stages:

### 1. [01_data_merging.sql](./01_data_merging.sql)
* **Purpose:** Consolidates 7 months of raw CSV data (November 2024 – May 2025).
* **Key Logic:** Uses `UNION DISTINCT` to merge monthly tables while automatically removing exact duplicate records at the ingestion layer.

### 2. [02_data_cleaning.sql](./02_data_cleaning.sql)
* **Purpose:** Standardizes the schema and enforces data quality constraints.
* **Key Logic:** * **Timestamp Validation:** Utilizes `LEAST` and `GREATEST` functions to resolve "Negative Trip Durations" caused by system clock errors.
    * **String Normalization:** Cleans station names using `TRIM` and handles missing station metadata with `IFNULL` defaults.

### 3. [03_data_enrichment.sql](./03_data_enrichment.sql)
* **Purpose:** Feature engineering and final table preparation.
* **Key Logic:** * **Time-Series Features:** Extracts `hour`, `day_of_week`, and `month` from timestamps.
    * **Segment Creation:** Categorizes rides into "Time of Day" (Morning, Afternoon, Evening, Night) and "Week Part" (Weekday vs. Weekend).
    * **Filtering:** Implements the strategic exclusion of October 2024 to ensure a balanced 7-month seasonal window.

### 4. [04_analysis_queries.sql](./04_analysis_queries.sql)
* **Purpose:** Executes the business intelligence logic used for the final report.
* **Structure:** Segmented into **Category 1: Light Exploration** (Validation) and **Category 2: Key Analytics Insights** (Behavioral DNA).


## 🚀 Environment & Usage
* **Platform:** Google Cloud Platform (GCP) - BigQuery
* **Project ID:** `axiomatic-set-467921-a9`
* **Dataset:** `Cyclistic_Bikes`

To reproduce the analysis, execute the scripts in numerical order. These scripts assume the raw monthly files have been uploaded to the `Cyclistic_Bikes` dataset with standardized naming conventions.
