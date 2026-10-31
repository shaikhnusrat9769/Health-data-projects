
# NHS A&E Activity Analysis | England

## Project Overview

An exploratory analysis of NHS England's monthly A&E attendance data using SQL Server and Tableau Public.

The project investigates long-term attendance trends, changes in demand across A&E department types, and data-quality challenges encountered during analysis.

**Analysis period:** August 2010 – September 2026  
**Annual comparisons:** 2011–2025 (complete calendar years)

## Interactive Dashboard

[View the NHS A&E Tableau Dashboard](https://public.tableau.com/app/profile/nusrat.jahan.shaikh7284/viz/NHSAEActivityAnalysisEngland20112025/NHSAEOverview)

## Key Findings

- **8.45% increase in total A&E attendances** between 2019 and 2025, from approximately 25.64 million to 27.80 million.
- **15.07% increase in Type 3 attendances** between 2019 and 2025, compared with approximately 4.98% for Type 1 departments.
- **Substantial decline in attendances in 2020**, followed by recovery and growth in subsequent years.
- **July 2026 recorded the highest monthly attendance** in the extracted dataset, at approximately 2.49 million.

These findings describe reported activity and should be interpreted alongside changes in reporting definitions and data coverage.

## Tools and Skills

- **SQL Server:** Data import, validation, aggregation and trend analysis.
- **SQL:** GROUP BY, SUM, AVG, CASE, date functions and filtering.
- **Tableau Public:** Interactive visualisation, calculated KPIs and dashboard design.
- **Data quality:** Precision investigation, corrected data types and reconciliation testing.

## Data Quality

During validation, I identified discrepancies introduced by numerical precision loss during the initial SQL import.

After reimporting the dataset using DECIMAL(18,10), all 194 monthly records passed the attendance reconciliation check at a tolerance of 0.000001.

[Read the data-quality investigation](data-quality-notes.md)

## SQL Analysis

[View the SQL analysis queries](analysis.sql)

## Data Source

NHS England — [A&E Attendances and Emergency Admissions](https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/)

The dataset covers England. Historical estimates, reporting changes and incomplete calendar years are documented in the data-quality notes.
