# Data Quality and Validation

## NHS A&E Activity Analysis

### 1. Dataset overview

The analysis uses publicly available monthly A&E activity data from NHS England, covering August 2010 to September 2026.

The activity dataset contains 194 monthly records, including attendance figures for Type 1, Type 2 and Type 3 A&E departments.

Data was imported into a dedicated Microsoft SQL Server database (`HealthDataProjects`) for validation and analysis.

### 2. Data-quality issue identified

During initial validation, I compared reported total A&E attendances with the sum of attendances across the three department types.

The first SQL import produced discrepancies in 52 of the 194 monthly records when checked using a tolerance of 0.01.

The largest observed discrepancy was approximately 0.117 attendances.

Further investigation showed that the original CSV retained fractional values that had lost precision during the initial SQL import.

For example, in November 2010:

- Original CSV total: 1,651,027.42857143
- Initially imported SQL value: 1,651,027.375

This demonstrated that the discrepancy arose during data import rather than necessarily representing an inconsistency in the published source data.

### 3. Investigation and correction

I inspected the original CSV values and compared them with the imported SQL values to identify where precision had been lost.

To correct the problem, I reimported the activity dataset into a new table:

`dbo.NHS_AE_Activity_Corrected`

I used `DECIMAL(18,10)` for the numerical columns to preserve the required decimal precision, rather than relying on the initial import's numeric type handling.

The original imported table was retained for comparison.

### 4. Validation after correction

I reran the attendance reconciliation check using a tolerance of 0.000001.

**Validation results:**

| Check | Result |
|---|---|
| Monthly records | 194 |
| Months exceeding reconciliation tolerance | 0 |
| Corrected numerical data type | DECIMAL(18,10) |
| Date field | DATE |

All 194 monthly records passed the reconciliation check at the specified tolerance.

This does not establish that every source value is error-free, but it confirms that the corrected attendance totals reconcile with their department components within the defined tolerance.

### 5. Source-data limitations

These limitations were identified from NHS England's published methodology and statistical commentaries, rather than inferred from the SQL results.

- **Historical estimates:** Monthly data before June 2015 was estimated by apportioning weekly totals according to the number of days falling within each calendar month. NHS England advises treating these figures as estimates.
- **Booked appointments:** From August 2020, the reporting collection included booked A&E attendances. NHS England advises caution when comparing data across this change.
- **Type 3 reporting disruption:** A cyberattack caused incomplete returns from some Type 3 sites beginning in August 2022. NHS England's February 2023 commentary confirms that the disruption was still affecting reporting at that time.
- **Geographical coverage:** The dataset represents England, not the entire United Kingdom.
- **Incomplete years:** The extracted dataset begins in August 2010 and ends in September 2026. These partial calendar years should not be directly compared with complete annual totals.

### 6. Analytical learning

This investigation demonstrated the importance of validating data after import rather than assuming that a successful import preserves every source value accurately.

The checks also reinforced the need to select appropriate numerical data types, investigate unexpected discrepancies, preserve original data for comparison and document corrections transparently.

These validation steps were completed before the corrected dataset was used for SQL analysis and Tableau visualisation.

### 7. References

1. NHS England. [A&E Attendances and Emergency Admissions — data and methodology](https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/).
2. NHS England. [A&E Attendances and Emergency Admissions 2020–21](https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/ae-attendances-and-emergency-admissions-2020-21/).
3. NHS England. [August 2022 Statistical Commentary](https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2022/09/Statistical-commentary-August-2022-edcba5-1.pdf).
4. NHS England. [February 2023 Statistical Commentary](https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2023/03/Statistical-commentary-February-2023-cftrtyy.pdf).
