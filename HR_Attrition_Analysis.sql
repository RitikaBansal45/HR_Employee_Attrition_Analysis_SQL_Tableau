create database HR_Employee_Attrition

use HR_Employee_Attrition

Create table employees (

	EmployeeID INT PRIMARY KEY,
	Age	INT,
	Attrition VARCHAR(5),
	BusinessTravel VARCHAR(30),
	DailyRate INT,
	Department  VARCHAR(30),
	DistanceFromHome INT,
	Education INT,
	EducationField VARCHAR(50),
	EmployeeCount INT,
	EmployeeNumber INT,
	EnvironmentSatisfaction	INT,
	Gender VARCHAR(10),
	HourlyRate INT,
	JobInvolvement INT,
	JobLevel INT,
	JobRole	VARCHAR(30),
	JobSatisfaction	INT,
	MaritalStatus VARCHAR(30),
	MonthlyIncome INT,	
	MonthlyRate	INT,
	NumCompaniesWorked INT,
	Over18 VARCHAR(5),
	OverTime VARCHAR(5),
	PercentSalaryHike INT,
	PerformanceRating INT,
	RelationshipSatisfaction INT,
	StandardHours INT,
	StockOptionLevel INT,
	TotalWorkingYears INT,
	TrainingTimesLastYear INT,
	WorkLifeBalance INT,
	YearsAtCompany INT,
	YearsInCurrentRole INT,
	YearsSinceLastPromotion	INT,
	YearsWithCurrManager INT)

	SELECT * FROM HR_Employee_Attrition


-- Verify the import
SELECT COUNT(*) AS TotalRows FROM HR_Employee_Attrition
SELECT TOP 5 * FROM HR_Employee_Attrition

-- EDA
SELECT
Attrition,
COUNT (*) AS Employee_Count,
COUNT (*) * 100 / SUM(COUNT(*)) OVER() AS Percenatge
FROM
HR_Employee_Attrition
GROUP BY
Attrition

-- Employee Attrition is 16%

-- By Gender
SELECT 
Gender,
COUNT (*) AS Employee_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100 / COUNT (*) As Attrition_rate
FROM
HR_Employee_Attrition
GROUP BY
Gender

-- By Business Travel
SELECT 
BusinessTravel,
COUNT (*) AS Employee_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100 / COUNT (*) As Attrition_rate
FROM
HR_Employee_Attrition
GROUP BY
BusinessTravel

-- Attrition by Dept.

SELECT 
Department,
COUNT (*) AS Employee_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100 / COUNT (*) As Attrition_rate
FROM
HR_Employee_Attrition
GROUP BY
Department

-- Attrition by Job Role
SELECT 
JobRole,
COUNT (*) AS Employee_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100 / COUNT (*) As Attrition_rate
FROM
HR_Employee_Attrition
GROUP BY
JobRole
ORDER BY
Attrition_rate DESC

-- Attrition by Age Group
SELECT 
CASE 
	WHEN Age < 25 THEN 'Under 25'
	WHEN Age BETWEEN 25 AND 34 THEN 'Under 25 - 34'
	WHEN Age BETWEEN 35 AND 44 THEN 'Under 35 - 44'
	WHEN Age BETWEEN 45 AND 55 THEN 'Under 45 - 55'
	ELSE '55+' END AS Age_group,
COUNT (*) AS Employee_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100 / COUNT (*) As Attrition_rate
FROM
HR_Employee_Attrition
GROUP BY
CASE 
	WHEN Age < 25 THEN 'Under 25'
	WHEN Age BETWEEN 25 AND 34 THEN 'Under 25 - 34'
	WHEN Age BETWEEN 35 AND 44 THEN 'Under 35 - 44'
	WHEN Age BETWEEN 45 AND 55 THEN 'Under 45 - 55'
	ELSE '55+'END
ORDER BY
Attrition_rate DESC

-- Attrition by Salary group

SELECT * FROM HR_Employee_Attrition

WITH Salary_bands AS (
	SELECT *,
	CASE
		WHEN MonthlyIncome < 3000 THEN 'low'
		WHEN MonthlyIncome < 7000 THEN 'Mid'
		WHEN MonthlyIncome < 12000 THEN 'High'
		ELSE 'Very high' END AS Salary_band
	FROM
	HR_Employee_Attrition )
SELECT 
Salary_band,
COUNT (*) AS Employee_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100 / COUNT (*) As Attrition_rate
FROM
Salary_bands
GROUP BY
Salary_band
ORDER BY
Attrition_rate DESC

SELECT * FROM HR_Employee_Attrition

WITH Travel_distance AS (
	SELECT *,
	CASE WHEN DistanceFromHome < 10 THEN 'Near' ELSE 'Far' END AS Distance
	FROM
	HR_Employee_Attrition )
SELECT 
Distance,
COUNT (*) AS Employee_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100 / COUNT (*) As Attrition_rate
FROM
Travel_distance
GROUP BY
Distance
ORDER BY
Attrition_rate DESC

-- Attrition rate by overtime

SELECT 
OverTime,
COUNT (*) AS Employee_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100 / COUNT (*) As Attrition_rate
FROM
HR_Employee_Attrition
GROUP BY
OverTime
ORDER BY
Attrition_rate DESC

-- Department Rank
WITH Dept AS (
SELECT
Department,
Count (*) as Employee_count,
SUM(CASE WHEN Attrition = 'yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'yes' THEN 1 ELSE 0 END) * 100 / COUNT(*) AS Attrition_rate
FROM
HR_Employee_Attrition
GROUP BY
Department )

SELECT
Department,
Employee_count,
Attrition_count,
Attrition_rate,
RANK () OVER ( ORDER BY Attrition_rate DESC) As Risk_rank
FROM
Dept

-- Job Role Rank
WITH Dept AS (
SELECT
JobRole,
Count (*) as Employee_count,
SUM(CASE WHEN Attrition = 'yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'yes' THEN 1 ELSE 0 END) * 100 / COUNT(*) AS Attrition_rate
FROM
HR_Employee_Attrition
GROUP BY
JobRole )

SELECT
JobRole,
Employee_count,
Attrition_count,
Attrition_rate,
DENSE_RANK () OVER ( ORDER BY Attrition_rate DESC) As Risk_rank
FROM
Dept

SELECT * FROM HR_Employee_Attrition

-- Risk Score
WITH Risk_score AS (
SELECT
Department, JobRole, Attrition, MonthlyIncome, OverTime, JobSatisfaction, WorkLifeBalance, YearsSinceLastPromotion, EnvironmentSatisfaction,
CASE WHEN OverTime = 'Yes' THEN 3 ELSE 0 END +
CASE WHEN JobSatisfaction <= 2 THEN 2 ELSE 0 END +
CASE WHEN EnvironmentSatisfaction <= 2 THEN 2 ELSE 0 END +
CASE WHEN WorkLifeBalance <= 2 THEN 2 ELSE 0 END +
CASE WHEN YearsSinceLastPromotion > 4 THEN 2 ELSE 0 END +
CASE WHEN MonthlyIncome < 3000 THEN 1 ELSE 0 END AS Risk_Category
FROM
HR_Employee_Attrition
GROUP BY
Department, JobRole, Attrition, MonthlyIncome, OverTime, JobSatisfaction, WorkLifeBalance, YearsSinceLastPromotion, EnvironmentSatisfaction )

SELECT
Department, JobRole, Attrition, MonthlyIncome, OverTime, JobSatisfaction, WorkLifeBalance, YearsSinceLastPromotion, EnvironmentSatisfaction, Risk_Category,
CASE WHEN Risk_Category > 5 THEN 'High' ELSE 'Low' END AS Risk_level
FROM
Risk_score
WHERE
Attrition = 'No' AND Risk_Category > 5
GROUP BY
Department, JobRole, Attrition, MonthlyIncome, OverTime, JobSatisfaction, WorkLifeBalance, YearsSinceLastPromotion, EnvironmentSatisfaction,Risk_Category
ORDER BY
Risk_Category DESC


-- Views

-- Department Level 

SELECT * FROM HR_Employee_Attrition

CREATE VIEW Dept_Summary AS
SELECT
Department,
COUNT (*) AS Employee_counts,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) *100 / COUNT (*) AS Percentage
FROM
HR_Employee_Attrition
GROUP BY
Department

CREATE VIEW Overtime_summary AS
SELECT
Department,
OverTime,
COUNT (*) AS Employee_counts,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_count,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) *100 / COUNT (*) AS Percentage
FROM
HR_Employee_Attrition
GROUP BY
Department,
OverTime
