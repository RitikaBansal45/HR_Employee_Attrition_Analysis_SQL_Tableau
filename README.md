# HR Employee Attrition Analysis  

## Overview 
HR leadership had a high attrition rate but no systematic way to identify which employees were most likely to leave and why. The business needed data-driven attrition analysis across demographics, roles, salary bands, and working conditions — plus a reusable risk-scoring model to flag employees before they resigned.

## Tools & Technologies 
1.	SQL (MS SQL Server)
  •	Aggregate attrition rates with CASE + SUM
  •	RANK and DENSE_RANK window functions	
  •	CTEs for salary banding
  •	Multi-dimensional segmentation
2.	Tableau
  •	Calculated Fields
  •	Story

## Business Questions Answered 
•	What is the overall attrition rate and which departments are most at risk? 
•	How does overtime, salary, and work-life balance correlate with attrition?
•	Which job roles have the highest attrition rates? 
•	Can we identify currently employed employees most likely to leave next?

## Key Queries Performed
•	Overall attrition rate (16%)
•	Attrition by gender, business travel, department, job role
•	Attrition by age group, salary band, distance from home
•	Overtime attrition impact
•	Department and job role risk ranking (RANK / DENSE_RANK)
•	Composite risk score: OverTime + JobSatisfaction + EnvironmentSatisfaction + WorkLifeBalance + YearsSinceLastPromotion + MonthlyIncome
•	Department-level summary View
•	Overtime summary View

## Key Findings
•	16.1% overall attrition rate — 237 out of 1,470 employees
•	Sales department: 20.6% attrition (highest), Human Resources: 19%
•	Employees doing overtime are nearly 2× more likely to leave 
•	Low salary band (<$3K/month) has the highest attrition despite being the smallest group
•	Sales Representatives ranked #1 for role-level attrition risk

## Recommendations
•	Prioritise promotion reviews for employees with 4+ years without a raise in Sales and R&D
•	Implement overtime compensation or limits — overtime is the strongest single attrition predictor
•	Introduce salary band reviews for the <$3K cohort — high risk, likely addressable with modest increases
•	Use the Risk Score model quarterly to proactively flag and engage at-risk employees
