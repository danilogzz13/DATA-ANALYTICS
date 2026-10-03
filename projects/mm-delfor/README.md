# MM DELFOR — Material Management Delivery Forecast

## Business Problem

Material Management teams need visibility into what materials are expected to arrive, when they are expected to arrive, and how reliable the delivery forecast is.

This project transforms SAP purchasing, confirmation, and goods receipt data into a historical snapshot-based Delivery Forecast solution that allows users to monitor:

- Purchase orders and value
- Ordered, confirmed, received, and open quantities
- Past-due orders
- Expected delivery dates
- Confirmation changes
- Delivery progress
- Trends across historical snapshots
- Supplier and material information

The objective is to provide a single analytical view of purchasing commitments and delivery execution.

---

## Architecture

The solution follows a layered data architecture:

    SAP Source Data
           ↓
        BRONZE
           ↓
        SILVER
           ↓
         GOLD
           ↓
       POWER BI
           ↓
    POWER AUTOMATE

The architecture separates raw ingestion, data transformation, business logic, analytics, and automated delivery.

**Architecture diagram:** `architecture/MM_DELFOR_Architecture.vsdx`

---

## Data Flow

SAP source datasets include:

- EKKO — Purchase Order Header
- EKPO — Purchase Order Items
- EKES — Purchase Order Confirmations
- EKBE — Purchase Order History / Goods Receipts
- EBAN — Purchase Requisitions
- MARA — Material Master
- MARC — Material/Plant Data
- LFA1 — Vendor Master
- PLANNERS — Planner Master

### Bronze

Raw ingestion layer focused on source preservation and traceability.

- SAP-oriented structures
- Ingestion metadata
- Source traceability
- Minimal transformations

### Silver

Cleaned and standardized layer prepared for business logic.

- Standardized column names
- Data type transformations
- Data cleansing
- Business-friendly naming
- Latest ingestion processing
- Preparation for business rules

### Gold

Business-ready analytical layer.

- Business rules
- Purchase order state
- Purchasing / confirmation / receipt integration
- Open quantity calculations
- Delivery status
- Historical snapshots
- Final DELFOR fact table

**Primary analytical table:** `FACT_DELFOR`

---

## DELFOR Business Logic

The solution tracks the procurement lifecycle:

    PR
     ↓
    PO
     ↓
    Confirmation
     ↓
    Goods Receipt

Supported scenarios include:

- Completely received POs
- Partially received POs
- Open POs
- Past-due POs
- Future confirmations
- Multiple confirmations
- POs without confirmations
- Modified confirmations
- Materials with multiple vendors
- Materials assigned to different planners

Confirmation priorities follow the defined hierarchy:

    LA > AB > ZE

The solution calculates:

- PO quantity
- Confirmed quantity
- Goods receipt quantity
- Pending / open quantity
- PO value
- Past-due quantity
- Past-due value

---

## Snapshot-Based Analysis

The Gold model maintains historical snapshots of the DELFOR state.

Snapshots allow comparison of the current state against the previous snapshot for:

- PO count
- PO quantity
- PO value
- Confirmed quantity
- Goods receipt quantity
- Open quantity
- Past-due quantity

The Power BI model includes:

- Previous-snapshot measures
- Growth percentages
- Average values per snapshot
- Past-due analysis
- Delivery progress
- Historical trend analysis

---

## Power BI

Power BI provides the analytical layer for business users.

The report includes:

- Executive KPIs
- Purchase order analysis
- Quantity and value analysis
- Confirmation monitoring
- Goods receipt progress
- Open quantity monitoring
- Past-due analysis
- Snapshot comparisons
- Historical trends

### DAX Structure

DAX measures are organized by dependency:

    01_BASE
       ↓
    02_BASE_WITH_CONTEXT
       ↓
    03_PREV_SNAPSHOT
       ↓
    04_GROWTH_PCT_FROM_PREV_SNAPSHOT
       ↓
    05_SNAPSHOT_AVERAGE

Each measure is maintained as an individual `.dax` file to provide granular version control.

---

## Power Automate

Power Automate extends the solution from analytics to automated delivery.

### Workflow

    Daily Trigger
          ↓
    Validate Latest Power BI Snapshot
          ↓
    Compare Against Stored Snapshot Date
          ↓
       Same ─────────→ Do Nothing
          │
       Higher
          ↓
    Execute Customized DAX Queries
          ↓
    Identify Relevant Results
          ↓
    Send Outlook Notification
          ↓
    Update Snapshot Date in SharePoint

The stored snapshot date is maintained in a **SharePoint List**.

The workflow only continues when the Power BI snapshot date is higher than the date stored in SharePoint.

The objective is to automatically deliver relevant DELFOR insights to stakeholders.

---

## Technologies

### Source Systems

- SAP
- Supply Chain / Material Management

### Data Engineering

- Databricks
- SQL
- Delta Lake
- Databricks Volumes
- Medallion Architecture

### Business Intelligence

- Power BI
- DAX
- Power Query
- Dimensional Modeling
- Star Schema

### Automation

- Power Automate
- Microsoft 365
- Outlook
- SharePoint

### Version Control

- Git
- GitHub

---

## Project Outcomes

The project demonstrates an end-to-end analytics solution covering:

- SAP data ingestion
- Data engineering
- Bronze / Silver / Gold architecture
- SQL transformation
- Business-rule implementation
- Historical snapshot management
- Dimensional data modeling
- DAX development
- Power BI reporting
- Automated business notifications
- Git-based version control

The final solution provides a structured approach to transforming purchasing and delivery data into an actionable **Material Management Delivery Forecast**.

---

## Repository Structure

    mm-delfor/
    │
    ├── README.md
    │
    ├── architecture/
    │   └── MM_DELFOR_Architecture.vsdx
    │
    ├── databricks/
    │   ├── README.md
    │   ├── bronze/
    │   ├── silver/
    │   └── gold/
    │
    ├── power-bi/
    │   ├── README.md
    │   │
    │   ├── dax/
    │   │   ├── 01_BASE/
    │   │   ├── 02_BASE_WITH_CONTEXT/
    │   │   ├── 03_PREV_SNAPSHOT/
    │   │   ├── 04_GROWTH_PCT_FROM_PREV_SNAPSHOT/
    │   │   └── 05_SNAPSHOT_AVERAGE/
    │   │
    │   └── report/
    │       └── MM_DELFOR_Report.pbix
    │
    ├── power-automate/
    │   └── README.md
    │
    └── docs/
        └── README.md
