# Documentation — MM DELFOR

## Overview

This folder contains supporting documentation for the MM DELFOR project.

The documentation complements the technical implementation documented in the Databricks, Power BI, and Power Automate sections of the repository.

---

## Documentation Scope

The documentation covers the main business and technical concepts required to understand the solution.

### Business Rules

Documents the business rules used to transform SAP purchasing data into the Material Management Delivery Forecast.

Key topics include:

- Purchase order lifecycle.
- Confirmation hierarchy.
- Goods receipt logic.
- Open quantity calculation.
- Past-due determination.
- Delivery Forecast status.
- Snapshot logic.

### Data Dictionary

Provides definitions for the main fields and business concepts used across the solution.

This includes:

- SAP source fields.
- Standardized Silver fields.
- Gold business fields.
- FACT_DELFOR attributes.
- Snapshot-related fields.
- Key business metrics.

### Data Model

Documents the analytical data model used by the solution.

The model includes:

- FACT_DELFOR.
- DIM_SNAPSHOTS.
- Supporting dimensions.
- Relationships between business entities.
- Snapshot-based analytical structure.

### Implementation Notes

Contains additional technical notes related to:

- Databricks implementation.
- Medallion Architecture.
- Snapshot processing.
- Power BI implementation.
- DAX organization.
- Power Automate workflow.
- Enterprise architecture considerations.

---

## Solution Reference

The complete solution follows:

    SAP Source Data
          ↓
       Bronze
          ↓
       Silver
          ↓
        Gold
          ↓
     FACT_DELFOR
          ↓
       Power BI
          ↓
    Power Automate

The documentation in this folder provides additional context for understanding the design decisions behind this architecture.

---

## Related Documentation

- `../README.md` — Main MM DELFOR project documentation.
- `../databricks/README.md` — Databricks architecture and processing.
- `../power-bi/README.md` — Power BI analytical layer.
- `../power-automate/README.md` — Automated monitoring and notification workflow.
