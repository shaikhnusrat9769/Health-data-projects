
-- NHS A&E Activity Analysis
-- Source: NHS England monthly A&E activity data
-- Database: HealthDataProjects
-- Table: dbo.NHS_AE_Activity_Corrected

-- 1. Annual A&E attendances
-- Exclude incomplete calendar years from annual comparisons.

SELECT
    YEAR(period) AS year,
    SUM(total_attendances) AS annual_attendances
FROM dbo.NHS_AE_Activity_Corrected
WHERE YEAR(period) BETWEEN 2011 AND 2025
GROUP BY YEAR(period)
ORDER BY year;


-- 2. Compare department activity in 2019 and 2025.

SELECT
    YEAR(period) AS year,
    SUM(type_1_departments_major_a_and_e) AS type_1_attendances,
    SUM(type_2_departments_single_specialty) AS type_2_attendances,
    SUM(type_3_departments_other_a_and_e_minor_injury_unit)
        AS type_3_attendances
FROM dbo.NHS_AE_Activity_Corrected
WHERE YEAR(period) IN (2019, 2025)
GROUP BY YEAR(period)
ORDER BY year;


-- 3. Identify the ten busiest months.

SELECT TOP 10
    period,
    total_attendances
FROM dbo.NHS_AE_Activity_Corrected
ORDER BY total_attendances DESC;


-- 4. Explore average attendance by calendar month.

SELECT
    MONTH(period) AS month_number,
    AVG(total_attendances) AS average_monthly_attendances
FROM dbo.NHS_AE_Activity_Corrected
WHERE YEAR(period) BETWEEN 2016 AND 2025
GROUP BY MONTH(period)
ORDER BY month_number;
