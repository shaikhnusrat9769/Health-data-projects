# Born Too Soon: Maternity Outcomes in England

### Exploring Preterm Birth Patterns Across NHS England Regions | July 2026

## Project Overview

This project explores preterm birth patterns across England using NHS England's Maternity Services Monthly Statistics for July 2026.

Using SQL Server for data validation and exploratory analysis, and Tableau Public for visualisation, the project examines national preterm birth rates, regional differences and gestational-age distributions.

The objective is to transform published maternity statistics into accessible, interpretable insights while recognising the limitations of aggregate healthcare data.

**[View the Interactive Tableau Dashboard](https://public.tableau.com/app/profile/nusrat.jahan.shaikh7284/viz/Pretermbirth/BornTooSoonMaternityOutcomes)**

## 1. Research Questions

The analysis addresses four research questions:

**RQ1.** What proportion of reported births in England occurred before 37 completed weeks of gestation in July 2026?

**RQ2.** How did reported preterm birth rates vary across the seven NHS England regions in July 2026?

**RQ3.** Among reported preterm births, what proportion occurred before 32 completed weeks of gestation in each NHS England region?

**RQ4.** How did the proportion of births occurring before 32 weeks compare with the overall preterm birth rate across NHS England regions?

An additional analysis examines the national distribution of preterm births across gestational-age groups.

## 2. Data Source

**Provider:** NHS England  
**Publication:** Maternity Services Monthly Statistics, July 2026 (final)  
**Reporting period:** July 2026  
**Geographical coverage:** England and seven NHS England regions  
**Data type:** Published aggregate maternity statistics

The analysis uses two gestational-age reporting dimensions:

- `GestationLengthBirthGroup37`: Broad categories distinguishing births before and at or after 37 weeks.
- `GestationLengthBirth`: Detailed gestational-age categories.

National and regional reporting levels are analysed separately to prevent double-counting across geographical aggregation levels.

## 3. Tools and Technologies

| Tool | Purpose |
|---|---|
| SQL Server / SSMS | Data validation, exploratory analysis, conditional aggregation and percentage calculations |
| Tableau Public | Interactive dashboard development, regional comparisons and visualisation |
| GitHub | Project documentation, SQL scripts and reproducibility |

## 4. Data Preparation and Quality Assessment

The original SQL Server table contained **76,140 records across nine columns**.

Data-quality assessment included:

- Reviewing missing values across the dataset.
- Examining reporting dimensions and organisational levels.
- Checking numeric values for missing entries, decimals and negative numbers.
- Investigating source-defined missing or out-of-range reporting categories.
- Distinguishing national records from regional aggregates.
- Identifying births with missing or out-of-range gestational age.
- Reviewing the appropriate denominator for each percentage calculation.
- Checking the consistency of national and regional results.

A focused extract of **118 records** was prepared for Tableau, containing the relevant gestational-age dimensions and national and regional reporting levels.

Missing or out-of-range gestational-age categories were excluded from percentage denominators where a known gestational age was required.

## 5. Research Questions and Findings

### RQ1. What proportion of reported births in England occurred before 37 completed weeks of gestation in July 2026?

The national analysis used the broad gestational-age reporting dimension.

| Gestational-age category | Reported births |
|---|---:|
| Before 37 weeks | 3,605 |
| At or after 37 weeks | 42,975 |
| Missing or out-of-range gestational age | 165 |
| Total reported births | 46,745 |

Births with known gestational age: **46,580**

**Calculation:**

Preterm birth rate = (3,605 / 46,580) × 100

**Result: 7.74%**

Approximately 7.74% of nationally reported births with known gestational age occurred before 37 completed weeks.

### RQ2. How did reported preterm birth rates vary across the seven NHS England regions in July 2026?

Regional preterm birth rates were calculated using the broad gestational-age reporting dimension.

| NHS England region | Preterm birth rate |
|---|---:|
| North East & Yorkshire | 8.31% |
| Midlands | 8.06% |
| London | 7.87% |
| North West | 7.74% |
| South East | 7.39% |
| South West | 7.34% |
| East of England | 7.15% |

**Key findings:**

- North East & Yorkshire recorded the highest reported preterm birth rate at 8.31%.
- East of England recorded the lowest at 7.15%.
- The difference between the highest and lowest regional rates was 1.16 percentage points.

These results describe geographical variation in the published data. They do not establish why regional differences occurred.

### RQ3. Among reported preterm births, what proportion occurred before 32 completed weeks of gestation in each NHS England region?

This analysis focuses on the distribution of gestational age **within preterm births**.

The numerator includes births reported at 27 weeks and under or 28–31 weeks. The denominator includes all reported preterm births with known gestational age in the detailed reporting dimension.

| NHS England region | Percentage of preterm births occurring before 32 weeks |
|---|---:|
| Midlands | 18.88% |
| South West | 18.03% |
| North East & Yorkshire | 15.65% |
| North West | 15.63% |
| South East | 15.24% |
| London | 14.71% |
| East of England | 12.99% |

**Key finding:**

The Midlands recorded the highest proportion of births before 32 weeks among reported preterm births, while East of England recorded the lowest.

This measure describes the gestational-age distribution within the preterm population, not the percentage of all births occurring before 32 weeks.

### RQ4. How did the proportion of births occurring before 32 weeks compare with the overall preterm birth rate across NHS England regions?

This analysis compares two measures calculated from the detailed gestational-age reporting dimension:

- Births before 32 weeks as a percentage of all births with known gestational age.
- Births before 37 weeks as a percentage of all births with known gestational age.

| NHS England region | Births before 32 weeks | Births before 37 weeks |
|---|---:|---:|
| Midlands | 1.52% | 8.05% |
| South West | 1.34% | 7.44% |
| North East & Yorkshire | 1.31% | 8.36% |
| North West | 1.22% | 7.81% |
| London | 1.17% | 7.93% |
| South East | 1.13% | 7.39% |
| East of England | 0.94% | 7.23% |

**Key findings:**

- Midlands recorded the highest proportion of births before 32 weeks, at 1.52%.
- East of England recorded the lowest, at 0.94%.
- North East & Yorkshire had the highest overall preterm birth rate in this detailed-dimension comparison, but Midlands had the highest rate of births before 32 weeks.

The regional ranking therefore differs depending on which gestational-age threshold is examined.

The overall preterm rates in this table differ slightly from RQ2 because the calculations use different published reporting dimensions.

### Additional Analysis: How were nationally reported preterm births distributed across gestational-age groups?

The national detailed gestational-age records were used to examine the composition of reported preterm births.

| Gestational-age group | Reported births |
|---|---:|
| 27 weeks and under | 240 |
| 28–31 weeks | 320 |
| 32–33 weeks | 385 |
| 34–36 weeks | 2,660 |
| **Total preterm births** | **3,605** |

**Key finding:**

Of the 3,605 nationally reported preterm births, **73.79% occurred between 34 and 36 completed weeks of gestation**.

This was the largest gestational-age category among nationally reported preterm births.

## 6. Analytical Methodology

The analysis was conducted in SQL Server using descriptive aggregation techniques.

The workflow involved:

1. **Dataset exploration:** Reviewing table structure, record counts, reporting levels and available dimensions.
2. **Data-quality assessment:** Investigating missing values, numeric consistency and source-defined reporting categories.
3. **Analytical filtering:** Selecting the appropriate reporting period, organisational level and gestational-age dimension.
4. **Conditional aggregation:** Using SQL `CASE WHEN` expressions to count births meeting specified gestational-age conditions.
5. **Percentage calculations:** Dividing relevant birth counts by the appropriate denominator and multiplying by 100.
6. **Validation:** Comparing calculated figures with source records and checking for inconsistencies across reporting dimensions.
7. **Visualisation:** Preparing a focused data extract and building an interactive Tableau dashboard.

All calculations are based on published aggregate counts rather than individual patient records.

## 7. Interactive Tableau Dashboard

The dashboard presents:

- National preterm birth rate: **7.74%**
- National preterm birth count: **3,605**
- Highest regional preterm birth rate: **8.31%**
- Regional preterm birth rate comparisons
- National gestational-age distribution among preterm births
- Regional rates of births occurring before 32 weeks
- Interactive regional filtering

**[Open the Born Too Soon Tableau Dashboard](https://public.tableau.com/app/profile/nusrat.jahan.shaikh7284/viz/Pretermbirth/BornTooSoonMaternityOutcomes)**

## 8. Limitations and Interpretation

**Aggregate data:** The analysis uses published aggregate statistics and cannot examine individual-level clinical or demographic risk factors.

**Missing gestational-age information:** Births with missing or out-of-range gestational age are excluded from relevant percentage denominators. The resulting rates describe births with known gestational age.

**Differences between reporting dimensions:** Broad and detailed gestational-age aggregates can produce slightly different regional results. They are therefore identified separately.

**National and regional reconciliation:** Published national totals and the sum of regional aggregates do not reconcile exactly. The cause has not been established, so the analysis avoids assuming an explanation.

**Single reporting month:** Findings describe July 2026 only and should not be interpreted as long-term trends or evidence of seasonal patterns.

**Descriptive interpretation:** Regional differences do not establish causal relationships or statistical significance.

## 9. Skills Demonstrated

- SQL Server and SQL Server Management Studio
- Exploratory Data Analysis
- Healthcare Data Validation
- Missing-Value Assessment
- Conditional Aggregation
- Percentage and KPI Calculations
- NHS Aggregate Data Interpretation
- Tableau Dashboard Development
- Interactive Data Visualisation
- Analytical Documentation

## 10. Project Files

| File | Description |
|---|---|
| `README.md` | Project overview, methodology, findings and limitations |
| `Born_Too_Soon_Analysis.sql` | SQL queries used to investigate the research questions |
| `Born_Too_Soon_Data_Checks.sql` | SQL queries used for data exploration and quality assessment |

## Author

**Dr Nusrat Jahan Shaikh**  
MSc Health Informatics, Swansea University

[Professional Portfolio](https://shaikhnusrat9769.github.io/) | [LinkedIn](https://www.linkedin.com/in/nusrat-jahan-shaikh-30770a1aa/) | [Tableau Public](https://public.tableau.com/app/profile/nusrat.jahan.shaikh7284/)
