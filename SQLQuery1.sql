USE CybersecurityDB;
GO

SELECT TOP 10
    Country,
    Target_Industry,
    Attack_Type,
    COUNT(*) AS Incident_Count,
    AVG(Financial_Loss_in_Million) AS Avg_Loss
FROM [dbo].[Global_Cybersecurity_Threats_2015-2024]
GROUP BY
    Country,
    Target_Industry,
    Attack_Type
HAVING COUNT(*) >= 3
ORDER BY Avg_Loss DESC;


SELECT
    Severity_Level,
    COUNT(*) AS Incident_Count,
    AVG(Financial_Loss_in_Million) AS Avg_Loss,
    STDEV(Financial_Loss_in_Million) AS StdDev_Loss,
    MIN(Financial_Loss_in_Million) AS Min_Loss,
    MAX(Financial_Loss_in_Million) AS Max_Loss
FROM [dbo].[Global_Cybersecurity_Threats_2015-2024]
GROUP BY Severity_Level
ORDER BY Avg_Loss DESC;


WITH Ranked AS (
    SELECT
        Country,
        Attack_Type,
        Financial_Loss_in_Million,
        NTILE(10) OVER (
            ORDER BY Financial_Loss_in_Million DESC
        ) AS Loss_Decile
    FROM [dbo].[Global_Cybersecurity_Threats_2015-2024]
)
SELECT
    Country,
    Attack_Type,
    COUNT(*) AS Count_in_Top10Percent
FROM Ranked
WHERE Loss_Decile = 1
GROUP BY
    Country,
    Attack_Type
ORDER BY Count_in_Top10Percent DESC;


WITH Overall_Avg AS (
    SELECT
        AVG(Financial_Loss_in_Million) AS Global_Avg
    FROM [dbo].[Global_Cybersecurity_Threats_2015-2024]
)
SELECT
    d.Defense_Mechanism_Used,
    COUNT(*) AS Usage_Count,
    AVG(d.Financial_Loss_in_Million) AS Avg_Loss,
    ROUND(
        AVG(d.Financial_Loss_in_Million) / o.Global_Avg,
        3
    ) AS Loss_Ratio_vs_Global_Avg
FROM [dbo].[Global_Cybersecurity_Threats_2015-2024] d
CROSS JOIN Overall_Avg o
GROUP BY
    d.Defense_Mechanism_Used,
    o.Global_Avg
ORDER BY Loss_Ratio_vs_Global_Avg ASC;

SELECT
    [Year],
    COUNT(*) AS Incident_Count,
    SUM(Financial_Loss_in_Million) AS Total_Loss,
    AVG(Financial_Loss_in_Million) AS Avg_Loss
FROM [dbo].[Global_Cybersecurity_Threats_2015-2024]
GROUP BY [Year]
ORDER BY [Year];

WITH Yearly_Attack_Loss AS (
    SELECT
        [Year],
        Attack_Type,
        SUM(Financial_Loss_in_Million) AS Total_Loss,
        RANK() OVER (PARTITION BY [Year] ORDER BY SUM(Financial_Loss_in_Million) DESC) AS Loss_Rank
    FROM [dbo].[Global_Cybersecurity_Threats_2015-2024]
    GROUP BY [Year], Attack_Type
)
SELECT [Year], Attack_Type, Total_Loss, Loss_Rank
FROM Yearly_Attack_Loss
WHERE Loss_Rank <= 3
ORDER BY [Year], Loss_Rank;

WITH Overall AS (
    SELECT AVG(Financial_Loss_in_Million) AS Global_Avg
    FROM [dbo].[Global_Cybersecurity_Threats_2015-2024]
),
Attack_Avg AS (
    SELECT
        Attack_Type,
        AVG(Financial_Loss_in_Million) AS Avg_Loss_per_Type
    FROM [dbo].[Global_Cybersecurity_Threats_2015-2024]
    GROUP BY Attack_Type
)
SELECT
    a.Attack_Type,
    a.Avg_Loss_per_Type,
    o.Global_Avg,
    CASE
        WHEN a.Avg_Loss_per_Type > o.Global_Avg THEN 'Above Average'
        WHEN a.Avg_Loss_per_Type < o.Global_Avg THEN 'Below Average'
        ELSE 'Equal'
    END AS Relative_Position
FROM Attack_Avg a
CROSS JOIN Overall o
ORDER BY a.Avg_Loss_per_Type DESC;


WITH Industry_Attack_Combo AS (
    SELECT
        Target_Industry,
        Attack_Type,
        COUNT(*) AS Incident_Count,
        AVG(Financial_Loss_in_Million) AS Avg_Loss
    FROM Incidents_Enriched
    GROUP BY Target_Industry, Attack_Type
),
Industry_Total AS (
    SELECT
        Target_Industry,
        SUM(Incident_Count) AS Industry_Total_Incidents
    FROM Industry_Attack_Combo
    GROUP BY Target_Industry
)
SELECT
    c.Target_Industry,
    c.Attack_Type,
    c.Incident_Count,
    ROUND(100.0 * c.Incident_Count / t.Industry_Total_Incidents, 1) AS Pct_of_Industry_Incidents,
    c.Avg_Loss
FROM Industry_Attack_Combo c
JOIN Industry_Total t ON c.Target_Industry = t.Target_Industry
ORDER BY c.Target_Industry, Pct_of_Industry_Incidents DESC;

SELECT
    Severity_Level,
    COUNT(*) AS Incident_Count,
    AVG(Incident_Resolution_Time_in_Hours) AS Avg_Resolution_Time_Hours,
    AVG(Incident_Resolution_Time_in_Hours / NULLIF(Severity_Score, 0)) AS Avg_Resolution_Efficiency,
    STDEV(Incident_Resolution_Time_in_Hours) AS StdDev_Resolution_Time
FROM Incidents_Enriched
GROUP BY Severity_Level;

SELECT
    Attack_Type,
    COUNT(*) AS Incident_Count,
    AVG(Incident_Resolution_Time_in_Hours) AS Avg_Resolution_Time_Hours,
    AVG(Incident_Resolution_Time_in_Hours / NULLIF(Severity_Score, 0)) AS Avg_Resolution_Efficiency
FROM Incidents_Enriched
GROUP BY Attack_Type
ORDER BY Avg_Resolution_Time_Hours DESC;

SELECT
    Defense_Mechanism_Used,
    COUNT(*) AS Incident_Count,
    AVG(Incident_Resolution_Time_in_Hours) AS Avg_Resolution_Time_Hours,
    AVG(Incident_Resolution_Time_in_Hours / NULLIF(Severity_Score, 0)) AS Avg_Resolution_Efficiency
FROM Incidents_Enriched
GROUP BY Defense_Mechanism_Used
ORDER BY Avg_Resolution_Time_Hours DESC;


SELECT @@SERVERNAME AS ServerName;


