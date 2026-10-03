# Databricks Bronze Layer — MM DELFOR

## Overview

The Bronze layer is the raw ingestion layer of the MM DELFOR data pipeline.

It stores SAP source data with minimal transformation while preserving source structure, traceability, and ingestion metadata.

The main objective is to provide a reliable historical representation of the source data for downstream Silver processing.

---

## Responsibilities

The Bronze layer is responsible for:

- Ingesting SAP source files.
- Preserving SAP-oriented structures and values.
- Adding ingestion metadata.
- Maintaining source traceability.
- Supporting historical ingestion tracking.
- Providing a consistent input for the Silver layer.

Transformations that belong to business logic are intentionally kept outside the Bronze layer.

---

## Source Tables

The current Bronze layer includes data from the following SAP-related sources:

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

## Ingestion Metadata

Bronze tables include ingestion metadata to support traceability and historical processing.

Typical metadata includes:

- `INGESTION_TIMESTAMP`
- `INGESTION_DATE`
- `INGESTION_BATCH`

These fields allow downstream layers to identify when source data was loaded and which ingestion represents the latest available source information.

---

## Transformation Approach

Bronze follows a **minimal-transformation principle**.

The layer does not perform:

- Business-state calculations.
- Delivery status calculations.
- Confirmation prioritization.
- Open quantity calculations.
- Snapshot comparison logic.
- Analytical aggregations.

Those transformations are handled in the Silver and Gold layers.

---

## Processing Pattern

The ingestion flow is:

    SAP Source File
          ↓
    Databricks Volume
          ↓
       BRONZE
          ↓
       SILVER

The current implementation uses Databricks Volumes for file ingestion.

In an enterprise implementation, the ingestion mechanism can be replaced by Azure Data Factory and Azure Data Lake Storage Gen2 while maintaining the same Bronze-layer concept.

---

## Notebook Structure

Each Bronze source has a dedicated SQL notebook.

Naming convention:

    NB_BRONZE_<TABLE>

Examples:

    NB_BRONZE_EBAN
    NB_BRONZE_EKKO
    NB_BRONZE_EKPO
    NB_BRONZE_EKES
    NB_BRONZE_EKBE

This structure keeps source ingestion logic separated by SAP table.

---

## Layer Principle

The Bronze layer answers:

**"What data was received from the source, and when was it ingested?"**

It does not answer:

**"What does the data mean from a business perspective?"**

Business interpretation and Delivery Forecast logic are handled downstream in Silver and Gold.

---

## Technologies

- Databricks
- SQL
- Delta Lake
- Databricks Volumes
- SAP
- Medallion Architecture
