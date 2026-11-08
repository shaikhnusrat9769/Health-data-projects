USE [HealthDataProjects];
GO

-- BORN TOO SOON: MATERNITY OUTCOMES
-- RESEARCH QUESTION 1: NATIONAL PRETERM BIRTHS
-- REPORTING PERIOD: JULY 2026

SELECT
    SUM(CASE
        WHEN [Measure] = '<37 weeks'
        THEN [Final_value]
        ELSE 0
    END) AS PRETERM_BIRTHS,

    SUM(CASE
        WHEN [Measure] = '>=37 weeks'
        THEN [Final_value]
        ELSE 0
    END) AS BIRTHS_37_PLUS,

    SUM(CASE
        WHEN [Measure] = 'Missing Value / Value outside reporting parameters'
        THEN [Final_value]
        ELSE 0
    END) AS MISSING_AGE,

    SUM(CASE
        WHEN [Measure] = '<37 weeks'
          OR [Measure] = '>=37 weeks'
        THEN [Final_value]
        ELSE 0
    END) AS KNOWN_AGE,

    SUM([Final_value]) AS TOTAL_REPORTED,

    ROUND(
        100.0 *
        SUM(CASE
            WHEN [Measure] = '<37 weeks'
            THEN [Final_value]
            ELSE 0
        END)
        /
        NULLIF(
            SUM(CASE
                WHEN [Measure] = '<37 weeks'
                   OR [Measure] = '>=37 weeks'
                THEN [Final_value]
                ELSE 0
            END),
            0
        ),
        2
    ) AS PRETERM_PERCENTAGE

FROM [dbo].[Born_too_soon_data]
WHERE [Org_Level] = 'National'
AND [Dimension] = 'GestationLengthBirthGroup37'AND [ReportingPeriodStartDate] = '2026-07-01';




GO

-- RESEARCH QUESTION 2:
-- HOW DO PRETERM BIRTH PROPORTIONS VARY ACROSS NHS ENGLAND REGIONS?
-- REPORTING PERIOD: JULY 2026

SELECT
    [Org_Name] AS REGION,

    SUM(
        CASE
            WHEN [Measure] = '<37 weeks'
            THEN [Final_value]
            ELSE 0
        END
    ) AS PRETERM_BIRTHS,

    SUM(
        CASE
            WHEN [Measure] = '<37 weeks'
              OR [Measure] = '>=37 weeks'
            THEN [Final_value]
            ELSE 0
        END
    ) AS KNOWN_GESTATIONAL_AGE,

    ROUND(
        100.0 *
        SUM(CASE
            WHEN [Measure] = '<37 weeks'
            THEN [Final_value]
            ELSE 0
        END)
        /
        NULLIF(
            SUM(CASE
                WHEN [Measure] = '<37 weeks'
                  OR [Measure] = '>=37 weeks'
                THEN [Final_value]
                ELSE 0
            END),
            0
        ),
        2
    ) AS PRETERM_PERCENTAGE

FROM [dbo].[Born_too_soon_data]

WHERE [Org_Level] = 'NHS England (Region)'
AND [Dimension] = 'GestationLengthBirthGroup37'
AND [ReportingPeriodStartDate] = '2026-07-01'

GROUP BY [Org_Name]

ORDER BY PRETERM_PERCENTAGE DESC;


-- RESEARCH QUESTION 3--

GO

-- ==========================================
-- RESEARCH QUESTION 3:
-- Does the overall preterm birth percentage
-- hide differences in the severity of
-- prematurity across NHS England regions?
-- REPORTING PERIOD: JULY 2026
-- ==========================================

SELECT
    [Org_Name] AS REGION,

    SUM(CASE
        WHEN [Measure] = '27 weeks and under'
          OR [Measure] = '28 to 31 weeks'
        THEN [Final_value]
        ELSE 0
    END) AS BIRTHS_BEFORE_32_WEEKS,

    SUM([Final_value]) AS TOTAL_PRETERM_BIRTHS,

    CAST(
        ROUND(
            100.0 *
            SUM(CASE
                WHEN [Measure] = '27 weeks and under'
                  OR [Measure] = '28 to 31 weeks'
                THEN [Final_value]
                ELSE 0
            END)
            /
            NULLIF(SUM([Final_value]), 0),
            2
        )
        AS DECIMAL(10,2)
    ) AS BEFORE_32_WEEKS_PERCENTAGE

FROM [dbo].[Born_too_soon_data]

WHERE [Org_Level] = 'NHS England (Region)'
AND [Dimension] = 'GestationLengthBirth'
AND [ReportingPeriodStartDate] = '2026-07-01'
AND (
    [Measure] = '27 weeks and under'
    OR [Measure] = '28 to 31 weeks'
    OR [Measure] = '32 to 33 weeks'
    OR [Measure] = '34 to 36 weeks'
)

GROUP BY [Org_Name]

ORDER BY BEFORE_32_WEEKS_PERCENTAGE DESC;

GO

-- ==========================================
-- RESEARCH QUESTION 4:
-- Do regional rankings change when comparing
-- overall preterm births and births before
-- 32 weeks using the same denominator?
-- REPORTING PERIOD: JULY 2026
-- ==========================================

SELECT
    [Org_Name] AS REGION,

    SUM(CASE
        WHEN [Measure] = '27 weeks and under'
          OR [Measure] = '28 to 31 weeks'
        THEN [Final_value]
        ELSE 0
    END) AS BIRTHS_BEFORE_32_WEEKS,

    SUM(CASE
        WHEN [Measure] = '27 weeks and under'
          OR [Measure] = '28 to 31 weeks'
          OR [Measure] = '32 to 33 weeks'
          OR [Measure] = '34 to 36 weeks'
        THEN [Final_value]
        ELSE 0
    END) AS ALL_PRETERM_BIRTHS,

    SUM(CASE
        WHEN [Measure] <> 'Missing Value / Value outside reporting parameters'
        THEN [Final_value]
        ELSE 0
    END) AS KNOWN_GESTATIONAL_AGE,

    CAST(
        100.0 *
        SUM(CASE
            WHEN [Measure] = '27 weeks and under'
              OR [Measure] = '28 to 31 weeks'
            THEN [Final_value]
            ELSE 0
        END)
        /
        NULLIF(
            SUM(CASE
                WHEN [Measure] <> 'Missing Value / Value outside reporting parameters'
                THEN [Final_value]
                ELSE 0
            END),
            0
        )
        AS DECIMAL(10,2)
    ) AS BEFORE_32_WEEKS_PERCENTAGE,

    CAST(
        100.0 *
        SUM(CASE
            WHEN [Measure] = '27 weeks and under'
              OR [Measure] = '28 to 31 weeks'
              OR [Measure] = '32 to 33 weeks'
              OR [Measure] = '34 to 36 weeks'
            THEN [Final_value]
            ELSE 0
        END)
        /
        NULLIF(
            SUM(CASE
                WHEN [Measure] <> 'Missing Value / Value outside reporting parameters'
                THEN [Final_value]
                ELSE 0
            END),
            0
        )
        AS DECIMAL(10,2)
    ) AS OVERALL_PRETERM_PERCENTAGE

FROM [dbo].[Born_too_soon_data]

WHERE [Org_Level] = 'NHS England (Region)'
AND [Dimension] = 'GestationLengthBirth'
AND [ReportingPeriodStartDate] = '2026-07-01'

GROUP BY [Org_Name]

ORDER BY BEFORE_32_WEEKS_PERCENTAGE DESC;
