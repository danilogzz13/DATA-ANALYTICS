-- Databricks notebook source
INSERT INTO SUPPLY_CHAIN.BRONZE.T_EKKO
WITH DATA_INGESTION AS (
SELECT
    *
        FROM READ_FILES('/Volumes/supply_chain/bronze/raw_files/MM/EKKO/',
        FORMAT => 'CSV')
        WHERE _metadata.file_path = (
    SELECT _metadata.file_path
    FROM READ_FILES(
        '/Volumes/supply_chain/bronze/raw_files/MM/EKKO/',
        FORMAT => 'CSV'
    )
    ORDER BY _metadata.file_modification_time DESC
    LIMIT 1)
),

 METADA_INGESTION AS (
    SELECT
    CURRENT_DATE() AS INGESTION_DATE,
    CURRENT_TIMESTAMP() AS INGESTION_TIMESTAMP,
    *
        FROM DATA_INGESTION
 )
 SELECT
    *
        FROM METADA_INGESTION;
SELECT
    *
FROM SUPPLY_CHAIN.BRONZE.T_EKKO
ORDER BY INGESTION_TIMESTAMP DESC,
         BEDAT DESC,
         EBELN DESC;