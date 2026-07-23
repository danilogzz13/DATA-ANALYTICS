# Supply Chain Analytics

End-to-end supply chain analytics project built with Databricks SQL, Delta Lake architecture and Power BI.

The project simulates a modern data platform using a Bronze, Silver and Gold architecture to process procurement, transportation, customer and sales data.

---

## Project Objectives

- Build a structured medallion architecture.
- Implement CDC, Full Load and Incremental Load patterns.
- Transform raw CSV files into analytical Delta tables.
- Create procurement, transportation, cost and profitability analytics.
- Deliver a curated Gold layer ready for Power BI.
- Apply data-quality validation across the pipeline.

---

## Architecture

```text
CSV Source Files
       |
       v
Bronze Layer
Raw ingestion with metadata and ingestion timestamps
       |
       v
Silver Layer
Cleaning, standardization, deduplication and CDC processing
       |
       v
Gold Layer
Dimensions, fact tables and business analytics
       |
       v
Power BI
Supply Chain Dashboard
```

---

## Pipeline Order

1. MATERIAL — CDC
2. VENDOR — Full Load
3. PURCHASE_ORDERS — CDC
4. TRANSPORTATION — Incremental Load
5. CUSTOMER — Full Load
6. SALES — CDC
7. COST ANALYSIS
8. BUSINESS IMPACT

---

## Data Model

### Dimensions

- DIM_MATERIAL
- DIM_VENDOR
- DIM_CUSTOMER

### Fact Tables

- FACT_PROCUREMENT
- FACT_TRANSPORTATION
- FACT_SALES
- FACT_COST_ANALYSIS
- FACT_BUSINESS_IMPACT

---

## Load Strategies

| Dataset | Strategy |
|----------|----------|
| Material | CDC |
| Vendor | Full Load |
| Purchase Orders | CDC |
| Transportation | Incremental Load |
| Customer | Full Load |
| Sales | CDC |

---

## SQL Project Structure

```text
sql/
├── 01_setup.sql
├── 02_bronze_ingestion.sql
├── 03_silver_transformation.sql
├── 04_gold.sql
└── 05_data_validation.sql
```

### 01_setup.sql

Creates the Databricks catalog, schemas and storage volume.

### 02_bronze_ingestion.sql

Loads raw CSV files into Bronze Delta tables while preserving ingestion metadata.

### 03_silver_transformation.sql

Cleans, standardizes and transforms Bronze data into curated Silver tables using CDC, Full Load and Incremental Load strategies.

### 04_gold.sql

Builds the analytical model including dimensions, operational fact tables, cost analysis and business impact calculations.

### 05_data_validation.sql

Performs validation checks across the entire pipeline, including:

- Row counts
- Duplicate business keys
- Null business keys
- CDC operation validation
- Referential integrity
- Invalid numeric values
- Revenue reconciliation
- Cost reconciliation
- Negative margin analysis

---

## Business Analytics

The Gold layer supports reporting for:

- Purchase Orders
- Supplier Performance
- Material Performance
- Transportation Performance
- Freight Cost Analysis
- Material Cost
- Landed Cost
- Sales Revenue
- Gross Margin
- Margin Percentage
- Customer Performance
- Channel Performance
- Plant Performance

---

## Technologies

- Azure Databricks
- Databricks SQL
- Delta Lake
- Power BI
- GitHub

---

## Current Status

- [x] Bronze Layer
- [x] Silver Layer
- [x] Gold Layer
- [x] Data Quality Validation
- [ ] Power BI Dashboard
- [ ] Dashboard Screenshots
- [ ] Architecture Diagram
- [ ] Data Model Diagram

---

## Repository Structure

```text
supply-chain-analytics/
│
├── sql/
│   ├── 01_setup.sql
│   ├── 02_bronze_ingestion.sql
│   ├── 03_silver_transformation.sql
│   ├── 04_gold.sql
│   └── 05_data_validation.sql
│
├── docs/
│
├── images/
│
├── sample_data/
│
└── README.md
```

---

## Project Highlights

- End-to-end ETL pipeline
- Medallion Architecture
- Delta Lake
- CDC Processing
- Incremental Loading
- Full Load Processing
- Dimensional Modeling
- Business Cost Analysis
- Profitability Analysis
- Data Quality Validation
- Power BI Reporting

---

## Disclaimer

This project uses synthetic data created exclusively for learning and portfolio purposes.
