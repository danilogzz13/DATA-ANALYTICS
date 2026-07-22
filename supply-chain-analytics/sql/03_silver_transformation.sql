-- ============================================================================
-- FILE: 03_silver_transformation.sql
-- PROJECT: Supply Chain Analytics
--
-- DESCRIPTION:
-- Cleans, standardizes and transforms Bronze data into the Silver layer.
-- Applies full-load, incremental-load and CDC processing strategies.
--
-- LOAD STRATEGIES:
-- - MATERIAL: CDC
-- - VENDOR: Full Load
-- - PURCHASE_ORDERS: CDC
-- - SHIPMENTS: Incremental Load
-- - CUSTOMER: Full Load
-- - SALES: CDC
--
-- TECHNOLOGIES:
-- - Databricks SQL
-- - Delta Lake
-- - Unity Catalog
-- ============================================================================

-- ============================================================================
-- SILVER - MATERIAL | CDC
-- ============================================================================

%sql
INSERT INTO SUPPLY_CHAIN.SILVER.MATERIAL_CDC
SELECT
    MATERIAL_ID,
    UPPER(TRIM(MATERIAL_DESC)) AS MATERIAL_DESC,
    VENDOR_ID,
    ROUND(CAST(PRICE AS DECIMAL(18,2)),2) AS PRICE,
    UPPER(TRIM(STATUS)) AS STATUS,
    CDC_OPERATION,
    CDC_TIMESTAMP
FROM SUPPLY_CHAIN.BRONZE.MATERIAL
WHERE CDC_TIMESTAMP >
(
    SELECT COALESCE(MAX(CDC_TIMESTAMP),'1900-01-01')
    FROM SUPPLY_CHAIN.SILVER.MATERIAL_CDC
);

-- ============================================================================
-- SILVER - VENDOR | FULL LOAD
-- ============================================================================

%sql
CREATE OR REPLACE TABLE SUPPLY_CHAIN.SILVER.VENDOR AS
SELECT DISTINCT
    VENDOR_ID,
    UPPER(TRIM(VENDOR_NAME)) AS VENDOR_NAME,
    UPPER(TRIM(COUNTRY)) AS COUNTRY,
    INITCAP(TRIM(CITY)) AS CITY,
    TRIM(VENDOR_GROUP) AS VENDOR_GROUP,
    TRIM(PAYMENT_TERM) AS PAYMENT_TERM,
    CASE
        WHEN UPPER(TRIM(STATUS)) IN ('A','ACTIVE') THEN 'ACTIVE'
        ELSE 'INACTIVE'
    END AS STATUS,
    INGESTION_TIMESTAMP
FROM SUPPLY_CHAIN.BRONZE.VENDOR
WHERE VENDOR_ID IS NOT NULL;

-- ============================================================================
-- SILVER - PURCHASE ORDERS | CDC
-- ============================================================================

%sql
INSERT INTO SUPPLY_CHAIN.SILVER.PURCHASE_ORDERS
SELECT
    PO_ID,
    PO_LINE_ID,
    VENDOR_ID,
    MATERIAL_ID,
    PLANT,
    CAST(ORDER_QTY AS DECIMAL(18,2)) AS ORDER_QTY,
    CAST(RECEIVED_QTY AS DECIMAL(18,2)) AS RECEIVED_QTY,
    CAST(UNIT_PRICE AS DECIMAL(18,2)) AS UNIT_PRICE,
    UPPER(TRIM(ORDER_STATUS)) AS ORDER_STATUS,
    CDC_OPERATION,
    CDC_TIMESTAMP
FROM SUPPLY_CHAIN.BRONZE.PURCHASE_ORDERS
WHERE CDC_TIMESTAMP >
(
    SELECT COALESCE(MAX(CDC_TIMESTAMP),'1900-01-01')
    FROM SUPPLY_CHAIN.SILVER.PURCHASE_ORDERS
);

-- ============================================================================
-- SILVER - TRANSPORTATION | INCREMENTAL LOAD
-- ============================================================================

%sql
INSERT INTO SUPPLY_CHAIN.SILVER.TRANSPORTATION
SELECT
    SHIPMENT_ID,
    PO_ID,
    VENDOR_ID,
    PLANT,
    UPPER(TRIM(INCOTERM)) AS INCOTERM,
    UPPER(TRIM(TRANSPORT_MODE)) AS TRANSPORT_MODE,
    UPPER(TRIM(CARRIER)) AS CARRIER,
    UPPER(TRIM(ORIGIN_COUNTRY)) AS ORIGIN_COUNTRY,
    UPPER(TRIM(DESTINATION_COUNTRY)) AS DESTINATION_COUNTRY,
    CAST(DISTANCE_KM AS DECIMAL(10,2)) AS DISTANCE_KM,
    CAST(FREIGHT_COST AS DECIMAL(18,2)) AS FREIGHT_COST,
    UPPER(TRIM(SHIPMENT_STATUS)) AS SHIPMENT_STATUS,
    UPDATE_TIMESTAMP
FROM SUPPLY_CHAIN.BRONZE.TRANSPORTATION
WHERE UPDATE_TIMESTAMP >
(
    SELECT COALESCE(MAX(UPDATE_TIMESTAMP),'1900-01-01')
    FROM SUPPLY_CHAIN.SILVER.TRANSPORTATION
);

-- ============================================================================
-- SILVER - CUSTOMER | FULL LOAD
-- ============================================================================

%sql
CREATE OR REPLACE TABLE SUPPLY_CHAIN.SILVER.CUSTOMER AS
SELECT DISTINCT
    CUSTOMER_ID,
    UPPER(TRIM(CUSTOMER_NAME)) AS CUSTOMER_NAME,
    UPPER(TRIM(CUSTOMER_GROUP)) AS CUSTOMER_GROUP,
    UPPER(TRIM(COUNTRY)) AS COUNTRY,
    INITCAP(TRIM(CITY)) AS CITY,
    UPPER(TRIM(CHANNEL)) AS CHANNEL,
    CASE
        WHEN UPPER(TRIM(STATUS)) IN ('A','ACTIVE') THEN 'ACTIVE'
        ELSE 'INACTIVE'
    END AS STATUS,
    INGESTION_TIMESTAMP
FROM SUPPLY_CHAIN.BRONZE.CUSTOMER
WHERE CUSTOMER_ID IS NOT NULL;

-- ============================================================================
-- SILVER - SALES | CDC
-- ============================================================================

%sql
INSERT INTO SUPPLY_CHAIN.SILVER.SALES
SELECT
    SALES_ORDER_ID,
    SALES_LINE_ID,
    CUSTOMER_ID,
    MATERIAL_ID,
    PLANT,
    CAST(ORDER_DATE AS DATE) AS ORDER_DATE,
    CAST(QUANTITY AS DECIMAL(18,2)) AS QUANTITY,
    CAST(UNIT_PRICE AS DECIMAL(18,2)) AS UNIT_PRICE,
    CAST(DISCOUNT AS DECIMAL(18,2)) AS DISCOUNT,
    ROUND(
        (CAST(QUANTITY AS DECIMAL(18,2)) *
         CAST(UNIT_PRICE AS DECIMAL(18,2))) -
         CAST(DISCOUNT AS DECIMAL(18,2)),
        2
    ) AS SALES_AMOUNT,
    UPPER(TRIM(STATUS)) AS STATUS,
    CDC_OPERATION,
    CDC_TIMESTAMP
FROM SUPPLY_CHAIN.BRONZE.SALES
WHERE CDC_TIMESTAMP >
(
    SELECT COALESCE(MAX(CDC_TIMESTAMP),'1900-01-01')
    FROM SUPPLY_CHAIN.SILVER.SALES
);
