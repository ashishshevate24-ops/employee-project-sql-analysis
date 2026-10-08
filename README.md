Employee & Project Management – SQL Data Analysis
Project Overview
This project demonstrates practical SQL data analysis using Microsoft SQL Server and T-SQL.
The project uses a relational database containing employee and project information to perform salary analysis, employee analysis, project tracking, data cleaning, ranking and business-oriented reporting.
Tools & Technologies
•	Microsoft SQL Server
•	T-SQL
•	SQL Server Management Studio (SSMS)
Database Structure
Employees Table
Column	Description
Employee_ID	Unique employee identifier
Employee_Name	Employee name
Department	Employee department
Designation	Employee designation
Experience	Years of experience
Salary	Employee salary
Projects Table
Column	Description
Project_ID	Unique project identifier
Project_Name	Project name
Employee_ID	Employee assigned to the project
Project_Status	Current project status
SQL Concepts Used
Basic SQL
•	SELECT
•	WHERE
•	ORDER BY
•	DISTINCT
•	IN / NOT IN
•	LIKE
•	NULL handling
Aggregation
•	COUNT
•	SUM
•	AVG
•	MIN
•	MAX
•	GROUP BY
•	HAVING
Conditional Logic
•	CASE WHEN
Joins
•	INNER JOIN
•	LEFT JOIN
•	RIGHT JOIN
Advanced SQL
•	Subqueries
•	CTEs
•	EXISTS
•	NOT EXISTS
•	Window Functions
•	ROW_NUMBER
•	RANK
•	DENSE_RANK
•	LAG
•	LEAD
Data Cleaning & NULL Handling
•	COALESCE
•	ISNULL
•	NULLIF
•	Duplicate identification using ROW_NUMBER()
Database Objects
•	SQL Views
Key Analysis Performed
•	Department-wise employee count and salary analysis
•	Total, average, highest and lowest salary analysis
•	Employees earning above company average
•	Employees earning above department average
•	Department-wise salary ranking
•	Top salary employees by department
•	Employee project assignment analysis
•	Project count per employee
•	Employees without assigned projects
•	Employees with multiple projects
•	Ongoing project analysis
•	Duplicate record identification
•	Previous and next salary comparison
•	Running salary totals
•	NULL salary handling
Project Files
01_Database_Setup.sql
02_Data_Analysis.sql
03_Advanced_SQL.sql
README.md
Learning Outcome
This project demonstrates hands-on experience in writing SQL queries for data analysis, relational data handling, data cleaning, salary analysis, project tracking and advanced SQL operations using Microsoft SQL Server.
Author
Ashish Shewte

