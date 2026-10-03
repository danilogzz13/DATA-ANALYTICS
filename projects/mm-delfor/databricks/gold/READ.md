# Databricks Gold Layer — MM DELFOR

## Overview

The Gold layer is the business and analytical layer of the MM DELFOR pipeline.

It combines the standardized Silver datasets and applies the business rules required to produce the Delivery Forecast dataset consumed by Power BI.

The primary analytical fact generated in this layer is:

`FACT_DELFOR`

---

## Responsibilities

The Gold layer is responsible for:

- Integrating purchasing, confirmation, and goods receipt data.
- Applying Delivery Forecast business rules.
- Determining purchase order states.
- Selecting the relevant confirmation.
- Calculating ordered, received, and open quantities.
- Identifying past-due purchase orders.
- Generating historical snapshots.
- Preparing the final analytical dataset for Power BI.

---

## Data Integration

The Gold layer combines information from the Silver datasets across the purchasing lifecycle:

    PR
    ↓
    PO
    ↓
    Confirmation
    ↓
    Goods Receipt

Key sources include:

| Source | Business Role |
|---|---|
| EKKO | Purchase Order Header |
| EKPO | Purchase Order Items |
| EKES | Vendor Confirmations |
| EKBE | Goods Receipts / PO History |
| EBAN | Purchase Requisitions |
| MARA | Material Master |
| MARC | Material / Plant Data |
| LFA1 | Vendor Master |
| PLANNERS | Planner Master |

---

## Confirmation Logic

When multiple confirmation records exist for the same purchase order item, the confirmation hierarchy is:

    LA > AB > ZE

The highest-priority applicable confirmation is selected for the Delivery Forecast.

This allows the model to represent the most relevant supplier confirmation when multiple confirmation types are available.

---

## Quantity Logic

The Gold layer establishes the main purchasing quantities used by the analytical model.

Key concepts include:

- PO Quantity
- Confirmed Quantity
- Goods Receipt Quantity
- Pending-to-GR Quantity
- PO Value
- Pending-to-GR Value

The open quantity is derived from the relationship between ordered quantity and received quantity.

---

## Delivery Status

The Gold layer determines delivery status using the expected delivery date and the snapshot date.

A purchase order can be identified as:

- Past Due
- Open
- Confirmed
- Received
- Partially Received
- Other applicable Delivery Forecast states

These states provide the business context required for Power BI analysis.

---

## Historical Snapshots

The Delivery Forecast is snapshot-based.

Each snapshot represents the state of the relevant purchase orders at a specific point in time.

Snapshots allow the analytical layer to track changes such as:

- PO quantity changes.
- PO value changes.
- Confirmation changes.
- Goods receipt progress.
- Open quantity changes.
- Past-due quantity changes.
- Delivery forecast evolution.

The historical snapshot structure enables current-versus-previous analysis in Power BI.

---

## FACT_DELFOR

`FACT_DELFOR` is the main Gold analytical fact consumed by Power BI.

It brings together the information required to analyze:

- Purchase orders.
- Materials.
- Vendors.
- Planners.
- Plants.
- Confirmations.
- Goods receipts.
- Expected delivery dates.
- PO quantities and values.
- Open quantities.
- Past-due quantities.
- Historical snapshots.

---

## State Management

The Gold layer is responsible for producing the current business state for each relevant purchase order item while preserving the historical snapshot structure required for trend analysis.

The Gold processing can rebuild the business-ready state from the latest Silver data and generate the corresponding snapshot.

This approach keeps the business logic deterministic and reproducible.

---

## Processing Pattern

The transformation flow is:

    SILVER
       ↓
    Integrate SAP Entities
       ↓
    Apply Business Rules
       ↓
    Determine PO State
       ↓
    Calculate Quantities
       ↓
    Determine Delivery Status
       ↓
    Generate Snapshot
       ↓
    FACT_DELFOR
       ↓
    Power BI

---

## Notebook Structure

Each Gold source or business dataset has a dedicated SQL notebook.

Naming convention:

    NB_GOLD_<TABLE>

Examples:

    NB_GOLD_EBAN
    NB_GOLD_EKKO
    NB_GOLD_EKPO
    NB_GOLD_EKES
    NB_GOLD_EKBE

The final analytical output is consumed by the Power BI semantic model.

---

## Layer Principle

The Gold layer answers:

**"What does the data mean from a business and Delivery Forecast perspective?"**

It converts clean Silver data into an analytical representation that can directly support business reporting and decision-making.

---

## Technologies

- Databricks
- SQL
- Delta Lake
- Medallion Architecture
- SAP
- Power BI
