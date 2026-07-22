-- ============================================================================
-- FILE: 02_bronze_ingestion.sql
-- PROJECT: Supply Chain Analytics
--
-- DESCRIPTION:
-- Loads raw CSV files from Unity Catalog Volumes into the Bronze layer.
-- Adds ingestion metadata such as timestamp and source file path.
--
-- TECHNOLOGIES:
-- - Databricks SQL
-- - Unity Catalog
-- - READ_FILES()
-- ============================================================================
--====================================================
-- BRONZE - MATERIAL
--====================================================

%sql
INSERT INTO SUPPLY_CHAIN.BRONZE.MATERIAL
SELECT
    CURRENT_TIMESTAMP() AS INGESTION_TIMESTAMP,
    _metadata.file_path AS SOURCE_FILE,
    *
FROM READ_FILES(
    '/Volumes/SUPPLY_CHAIN/BRONZE/RAW_FILES/materials/',
    FORMAT => 'CSV'
);

--====================================================
-- BRONZE - VENDOR
--====================================================
%sql
CREATE OR REPLACE TABLE SUPPLY_CHAIN.BRONZE.VENDOR AS
SELECT
    CURRENT_TIMESTAMP() AS INGESTION_TIMESTAMP,
    _metadata.file_path AS SOURCE_FILE,
    *
FROM READ_FILES(
    '/Volumes/SUPPLY_CHAIN/BRONZE/RAW_FILES/vendors.csv',
    FORMAT => 'CSV'
);

--====================================================
-- BRONZE - PURCHASE ORDERS
--====================================================
%sql
CREATE OR REPLACE SUPPLY_CHAIN.BRONZE.PURCHASE_ORDERS
INSERT INTO SUPPLY_CHAIN.BRONZE.PURCHASE_ORDERS
SELECT
    CURRENT_TIMESTAMP() AS INGESTION_TIMESTAMP,
    _metadata.file_path AS SOURCE_FILE,
    *
FROM READ_FILES(
    '/Volumes/SUPPLY_CHAIN/BRONZE/RAW_FILES/purchase_orders.csv',
    FORMAT => 'CSV'
);

--====================================================
-- BRONZE - SHIPMENTS
--====================================================
%sql
INSERT INTO SUPPLY_CHAIN.BRONZE.TRANSPORTATION
SELECT
    CURRENT_TIMESTAMP() AS INGESTION_TIMESTAMP,
    _metadata.file_path AS SOURCE_FILE,
    *
FROM READ_FILES(
    '/Volumes/SUPPLY_CHAIN/BRONZE/RAW_FILES/transportation.csv',
    FORMAT => 'CSV'
);

--====================================================
-- BRONZE - CUSTOMER
--====================================================

%sql
INSERT INTO SUPPLY_CHAIN.BRONZE.CUSTOMER
SELECT
    CURRENT_TIMESTAMP() AS INGESTION_TIMESTAMP,
    _metadata.file_path AS SOURCE_FILE,
    *
FROM READ_FILES(
    '/Volumes/SUPPLY_CHAIN/BRONZE/RAW_FILES/customers/',
    FORMAT => 'CSV'
);

--====================================================
-- BRONZE - SALES
--====================================================
%sql
INSERT INTO SUPPLY_CHAIN.BRONZE.SALES
SELECT
    CURRENT_TIMESTAMP() AS INGESTION_TIMESTAMP,
    _metadata.file_path AS SOURCE_FILE,
    *
FROM READ_FILES(
    '/Volumes/SUPPLY_CHAIN/BRONZE/RAW_FILES/sales.csv',
    FORMAT => 'CSV'
);
