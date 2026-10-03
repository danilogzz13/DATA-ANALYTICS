-- Databricks notebook source
INSERT INTO SUPPLY_CHAIN.BRONZE.T_LFA1
WITH DATA_INGESTION AS (
    SELECT *
    FROM READ_FILES('/Volumes/supply_chain/bronze/raw_files/MM/LFA1/', FORMAT => 'CSV')
    WHERE _metadata.file_path = (
        SELECT _metadata.file_path
        FROM READ_FILES('/Volumes/supply_chain/bronze/raw_files/MM/LFA1/', FORMAT => 'CSV')
        ORDER BY _metadata.file_modification_time DESC
        LIMIT 1
    )
),
METADATA_INGESTION AS (
    SELECT
        CURRENT_DATE() AS INGESTION_DATE,
        CURRENT_TIMESTAMP() AS INGESTION_TIMESTAMP,
        *
    FROM DATA_INGESTION
)
SELECT *
FROM METADATA_INGESTION;

SELECT *
FROM SUPPLY_CHAIN.BRONZE.T_LFA1
ORDER BY INGESTION_TIMESTAMP DESC,
         LIFNR DESC;