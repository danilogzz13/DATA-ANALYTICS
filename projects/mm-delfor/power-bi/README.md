# Power BI — MM DELFOR

## Overview

The Power BI layer provides the analytical and visualization component of the MM DELFOR solution.

The report consumes the Gold-layer `FACT_DELFOR` dataset and provides visibility into purchase orders, quantities, confirmations, goods receipts, open quantities, past-due orders, and historical snapshot changes.

---

## Report Objectives

The report is designed to answer key Material Management questions:

- How many purchase orders are currently open?
- What is the total PO value and quantity?
- How much quantity has been confirmed?
- How much quantity has been received?
- How much quantity remains open?
- How much quantity is past due?
- How are these metrics changing between snapshots?
- What is the historical delivery forecast trend?

---

## Data Model

The report is based on a dimensional model centered around:

- `FACT_DELFOR`

`FACT_DELFOR` contains the business-ready DELFOR data and historical snapshot information.

---

## Snapshot Analysis

The report uses historical snapshots to compare the current state of the delivery forecast against previous snapshots.

The model tracks:

- PO count
- PO quantity
- PO value
- Confirmed quantity
- Goods receipt quantity
- Open quantity
- Past-due quantity

This allows the report to identify changes in purchasing and delivery execution over time.

---

## DAX Structure

DAX measures are organized according to their calculation dependencies:

    01_BASE
       ↓
    02_BASE_WITH_CONTEXT
       ↓
    03_PREV_SNAPSHOT
       ↓
    04_GROWTH_PCT_FROM_PREV_SNAPSHOT
       ↓
    05_SNAPSHOT_AVERAGE

### 01_BASE

Core measures used as the foundation for the analytical calculations.

### 02_BASE_WITH_CONTEXT

Measures that apply additional business context, such as past-due status.

### 03_PREV_SNAPSHOT

Measures used to retrieve the corresponding value from the previous available snapshot.

### 04_GROWTH_PCT_FROM_PREV_SNAPSHOT

Measures that calculate percentage changes between the current and previous snapshots.

### 05_SNAPSHOT_AVERAGE

Measures that calculate average values across the available snapshots.

Each measure is stored as an individual `.dax` file to provide granular version control.

---

## Key Metrics

The report includes metrics for:

- Total PO count
- Total PO value
- Total PO quantity
- Confirmed quantity
- Goods receipt quantity
- Open quantity
- Past-due quantity
- Past-due value
- Growth versus previous snapshot
- Average per snapshot

---

## Report

The Power BI report is available at:

`report/MM_DELFOR_Report.pbix`

The PBIX file is version-controlled through GitHub, allowing previous report versions to be recovered through the repository history.

---

## Repository Structure

    power-bi/
    │
    ├── README.md
    │
    ├── dax/
    │   ├── 01_BASE/
    │   ├── 02_BASE_WITH_CONTEXT/
    │   ├── 03_PREV_SNAPSHOT/
    │   ├── 04_GROWTH_PCT_FROM_PREV_SNAPSHOT/
    │   └── 05_SNAPSHOT_AVERAGE/
    │
    └── report/
        └── MM_DELFOR_Report.pbix
