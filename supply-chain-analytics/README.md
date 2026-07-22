# Supply Chain Analytics

End-to-end Supply Chain Analytics solution built with Azure Databricks, SQL and Power BI.

## Project Overview

This project transforms raw supply chain data into an analytical model designed to evaluate revenue, material costs, freight costs, landed costs, gross margin and negative-margin transactions.

The solution follows a Medallion Architecture:

- Bronze: Raw data ingestion
- Silver: Data cleaning, standardization and CDC processing
- Gold: Business-ready dimensions and fact tables
- Power BI: Semantic model, DAX measures and executive dashboard

## Technologies

- Azure Databricks
- Databricks SQL
- Delta Lake
- Unity Catalog
- Power BI
- Power Query
- DAX

## Architecture

```text
CSV Files
    ↓
Bronze Layer
    ↓
Silver Layer
    ↓
Gold Layer
    ↓
Power BI Semantic Model
    ↓
Executive Dashboard
