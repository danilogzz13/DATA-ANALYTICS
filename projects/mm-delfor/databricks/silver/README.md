# Databricks Silver Layer — MM DELFOR

## Overview

The Silver layer is the data cleansing and standardization layer of the MM DELFOR pipeline.

It transforms the raw Bronze datasets into clean, consistent, business-friendly datasets that are ready for Gold-layer business logic.

The Silver layer focuses on **data quality and standardization**, while business-state calculations remain in Gold.

---

## Responsibilities

The Silver layer is responsible for:

- Standardizing column names.
- Applying appropriate data types.
- Cleaning source data.
- Normalizing values and formats.
- Preparing datasets for business rules.
- Processing the latest available Bronze ingestion.
- Preserving the relationship between SAP source entities.

---

## Source Tables

The Silver layer processes the following sources:

| Source | Description |
|---|---|
| EKKO | Purchase Order Header |
| EKPO | Purchase Order Item |
| EKES | Vendor Confirmations |
| EKBE | Purchase Order History / Goods Receipts |
| EBAN | Purchase Requisitions |
| MARA | Material Master |
| MARC | Material Plant Data |
| LFA1 | Vendor Master |
| PLANNERS | Planner Master |

---

## Standardization

Silver converts SAP-oriented structures into business-friendly datasets.

Typical transformations include:

- Renaming technical SAP columns.
- Casting columns to appropriate data types.
- Standardizing dates.
- Standardizing quantities and values.
- Cleaning text fields.
- Handling null values where required.
- Preparing consistent keys for downstream joins.

The goal is to make the data easier to consume without introducing analytical business rules prematurely.

---

## Latest Ingestion Processing

Silver processes the latest available Bronze ingestion for each source.

Ingestion metadata from Bronze is used to identify the most recent source data.

This allows Silver to work with the current source state while maintaining the historical ingestion information required for traceability.

---

## Business Logic Boundary

Silver intentionally does **not** determine the final Delivery Forecast state.

The following logic remains in Gold:

- PO state.
- Confirmation priority.
- Open quantity.
- Past-due status.
- Goods receipt progress.
- Delivery forecast status.
- Historical snapshot logic.
- FACT_DELFOR construction.

This separation keeps data preparation independent from business interpretation.

---

## Processing Pattern

The transformation flow is:

    BRONZE
       ↓
    Clean
       ↓
    Standardize
       ↓
    Cast Data Types
       ↓
    Latest Ingestion
       ↓
    SILVER
       ↓
    GOLD

---

## Notebook Structure

Each Silver source has a dedicated SQL notebook.

Naming convention:

    NB_SILVER_<TABLE>

Examples:

    NB_SILVER_EBAN
    NB_SILVER_EKKO
    NB_SILVER_EKPO
    NB_SILVER_EKES
    NB_SILVER_EKBE

This structure keeps transformation logic separated by source table.

---

## Layer Principle

The Silver layer answers:

**"Is the source data clean, standardized, and ready for business logic?"**

It does not answer:

**"What is the current Delivery Forecast state?"**

That interpretation is handled by the Gold layer.

---

## Technologies

- Databricks
- SQL
- Delta Lake
- Medallion Architecture
- SAP
