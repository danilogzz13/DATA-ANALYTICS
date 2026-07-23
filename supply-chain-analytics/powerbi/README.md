# Power BI Dashboard


This folder contains the Power BI report developed from the Gold layer of the Supply Chain Analytics project.

The dashboard is built using a star schema semantic model and provides interactive analytics for procurement, transportation, sales and profitability.

---

## Dashboard Pages

### Executive Overview

High-level KPIs and business performance.

### Procurement Analysis

- Purchase Orders
- Supplier Performance
- Material Performance

### Transportation Analysis

- Freight Cost
- Carrier Performance
- Transportation Cost

### Sales Analysis

- Revenue
- Gross Margin
- Margin %

### Business Impact

- Cost Analysis
- Profitability
- Business KPIs

---

## Key Performance Indicators

- Total Revenue
- Gross Margin
- Margin %
- Total Purchase Orders
- Freight Cost
- Landed Cost
- Material Cost
- Supplier Performance
- Customer Performance
- Plant Performance

---

## Semantic Model

The report uses a Star Schema composed of:

### Fact Tables

- FACT_PROCUREMENT
- FACT_TRANSPORTATION
- FACT_SALES
- FACT_COST_ANALYSIS
- FACT_BUSINESS_IMPACT

### Dimension Tables

- DIM_CUSTOMER
- DIM_VENDOR
- DIM_MATERIAL

---

## Included Files

| File | Description |
|------|-------------|
| Supply_Chain_Dashboard.pbix | Power BI report |
| measures.dax | DAX measures |
| data_model.md | Semantic model documentation |
| report_pages.md | Dashboard page documentation |

---

## Technologies

- Power BI Desktop
- DAX
- Power Query
- Star Schema
- Databricks SQL
