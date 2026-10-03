# Databricks — MM DELFOR

## Overview

The Databricks layer is responsible for data ingestion, transformation, cleansing, business logic, and preparation of the Delivery Forecast dataset consumed by Power BI.

The solution follows a **Medallion Architecture**:

SAP Source Data → Bronze → Silver → Gold

---

## Architecture

### Bronze

The Bronze layer stores raw SAP source data with minimal transformation.

Responsibilities:

- Ingest SAP source files.
- Preserve SAP-oriented column structures.
- Maintain source traceability.
- Add ingestion metadata.
- Preserve the original source information for downstream processing.

Main source tables:

- EKKO — Purchasing Documents
- EKPO — Purchasing Document Items
- EKES — Vendor Confirmations
- EKBE — Purchase Order History / Goods Receipts
- EBAN — Purchase Requisitions
- MARA — Material Master
- MARC — Material Plant Data
- LFA1 — Vendor Master
- PLANNERS — Planner Master

---

### Silver

The Silver layer prepares clean and standardized datasets for business logic.

Responsibilities:

- Standardize column names.
- Apply appropriate data types.
- Clean and normalize source data.
- Use business-friendly English column names.
- Process the latest available Bronze ingestion.
- Prepare datasets for Gold-layer business rules.

Silver does not enforce final business-state uniqueness for mutable datasets. Its purpose is data preparation and standardization.

---

### Gold

The Gold layer contains the business-ready datasets used by the analytical model.

Responsibilities:

- Apply business rules.
- Integrate purchasing, confirmation, and receipt information.
- Determine PO and delivery states.
- Calculate open quantities.
- Determine past-due status.
- Maintain historical snapshots.
- Prepare the final Delivery Forecast dataset.

The primary analytical fact is:

`FACT_DELFOR`

---

## DELFOR Business Logic

The Delivery Forecast follows the purchasing lifecycle:

    PR → PO → Confirmation → Goods Receipt

The Gold layer combines these stages to determine the current and historical delivery status of purchase orders.

### Confirmation Hierarchy

When multiple confirmation types exist, the business priority is:

    LA > AB > ZE

The highest-priority valid confirmation is used when determining the relevant confirmation state.

---

## Snapshot Processing

The Delivery Forecast uses historical snapshots to preserve the evolution of purchasing and delivery information over time.

Each snapshot represents the state of the relevant purchase orders at a specific point in time.

Snapshots allow the analytical layer to compare:

- Current vs previous snapshot
- Open quantity changes
- Confirmed quantity changes
- Goods receipt progress
- Past-due quantity changes
- PO quantity and value changes
- Delivery forecast evolution

---

## Data Processing Pattern

The processing flow is:

    SAP Source Files
          ↓
       BRONZE
          ↓
       SILVER
          ↓
        GOLD
          ↓
     FACT_DELFOR
          ↓
       Power BI

Bronze focuses on ingestion and traceability.

Silver focuses on cleansing and standardization.

Gold focuses on business logic and analytical state.

---

## Databricks Environment

The project is currently implemented using **Databricks Free Edition**.

Source files are loaded through a Databricks Volume.

Enterprise equivalent:

- Azure Data Factory for ingestion and orchestration.
- Azure Data Lake Storage Gen2 for enterprise file storage.
- Azure Databricks for transformation and processing.

The current implementation is intentionally designed so that the ingestion mechanism can later be replaced by an enterprise ingestion architecture without changing the core Bronze → Silver → Gold transformation pattern.

---

## SQL Development

The transformation logic is implemented using SQL notebooks.

Notebook naming convention:

    NB_BRONZE_<TABLE>
    NB_SILVER_<TABLE>
    NB_GOLD_<TABLE>

Examples:

    NB_BRONZE_EBAN
    NB_SILVER_EBAN
    NB_GOLD_EBAN

Each layer maintains its own notebooks to keep ingestion, transformation, and business logic separated.

---

## Repository Structure

    databricks/
    ├── README.md
    ├── bronze/
    │   ├── README.md
    │   └── NB_BRONZE_*.sql
    ├── silver/
    │   ├── README.md
    │   └── NB_SILVER_*.sql
    └── gold/
        ├── README.md
        └── NB_GOLD_*.sql

---

## Technologies

- Databricks
- SQL
- Delta Lake
- Databricks Volumes
- Medallion Architecture
- SAP
- Power BI
- GitHub

---

## Outcome

The Databricks layer transforms SAP purchasing data into a structured, historical, and business-ready Delivery Forecast dataset.

The resulting Gold layer provides the foundation for Power BI analytics and snapshot-based monitoring of purchase order delivery performance.
