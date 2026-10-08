-- =============================================
-- Project: Employee & Project Management
-- File: 03_Advanced_SQL.sql
-- Tool: Microsoft SQL Server
-- =============================================

USE Employee_Project_Analytics;
GO


-- =============================================
-- 1. ROW_NUMBER - Duplicate Identification
-- =============================================

WITH Duplicate_Check AS
(
    SELECT
        Employee_ID,
        Employee_Name,
        Department,
        Designation,
        Experience,
        Salary,
        ROW_NUMBER() OVER (
            PARTITION BY Employee_Name
            ORDER BY Employee_ID
        ) AS Row_Num
    FROM Employees
)
SELECT *
FROM Duplicate_Check
WHERE Row_Num > 1;


-- =============================================
-- 2. RANK - Overall Salary Ranking
-- =============================================

SELECT
    Employee_Name,
    Department,
    Salary,
    RANK() OVER (
        ORDER BY Salary DESC
    ) AS Salary_Rank
FROM Employees;


-- =============================================
-- 3. DENSE_RANK - Overall Salary Ranking
-- =============================================

SELECT
    Employee_Name,
    Department,
    Salary,
    DENSE_RANK() OVER (
        ORDER BY Salary DESC
    ) AS Salary_Rank
FROM Employees;


-- =============================================
-- 4. Third Highest Salary
-- =============================================

WITH Ranked_Employees AS
(
    SELECT
        Employee_Name,
        Salary,
        DENSE_RANK() OVER (
            ORDER BY Salary DESC
        ) AS Salary_Rank
    FROM Employees
)
SELECT
    Employee_Name,
    Salary
FROM Ranked_Employees
WHERE Salary_Rank = 3;


-- =============================================
-- 5. Employees with Multiple Projects
-- =============================================

SELECT
    e.Employee_ID,
    e.Employee_Name,
    COUNT(p.Project_ID) AS Project_Count
FROM Employees AS e
JOIN Projects AS p
    ON e.Employee_ID = p.Employee_ID
GROUP BY
    e.Employee_ID,
    e.Employee_Name
HAVING COUNT(p.Project_ID) > 1;


-- =============================================
-- 6. Employees with At Least One Project
-- =============================================

SELECT
    e.Employee_ID,
    e.Employee_Name
FROM Employees AS e
WHERE EXISTS
(
    SELECT 1
    FROM Projects AS p
    WHERE p.Employee_ID = e.Employee_ID
);


-- =============================================
-- 7. Employees with No Projects
-- =============================================

SELECT
    e.Employee_ID,
    e.Employee_Name
FROM Employees AS e
WHERE NOT EXISTS
(
    SELECT 1
    FROM Projects AS p
    WHERE p.Employee_ID = e.Employee_ID
);


-- =============================================
-- 8. CTE - Department Salary Analysis
-- =============================================

WITH Department_Salary AS
(
    SELECT
        Department,
        AVG(Salary) AS Department_Avg_Salary,
        SUM(Salary) AS Department_Total_Salary
    FROM Employees
    GROUP BY Department
)
SELECT *
FROM Department_Salary;


-- =============================================
-- 9. CTE + JOIN - Above Department Average
-- =============================================

WITH Department_Salary AS
(
    SELECT
        Department,
        AVG(Salary) AS Department_Avg_Salary
    FROM Employees
    GROUP BY Department
)
SELECT
    e.Employee_Name,
    e.Department,
    e.Salary,
    d.Department_Avg_Salary
FROM Employees AS e
JOIN Department_Salary AS d
    ON e.Department = d.Department
WHERE e.Salary > d.Department_Avg_Salary;


-- =============================================
-- 10. CTE + Window Function
-- =============================================

WITH Employee_Data AS
(
    SELECT
        Employee_Name,
        Department,
        Salary
    FROM Employees
)
SELECT
    Employee_Name,
    Department,
    Salary,
    DENSE_RANK() OVER (
        PARTITION BY Department
        ORDER BY Salary DESC
    ) AS Salary_Rank
FROM Employee_Data;


-- =============================================
-- 11. LAG - Previous Salary
-- =============================================

SELECT
    Employee_Name,
    Salary,
    LAG(Salary) OVER (
        ORDER BY Employee_ID
    ) AS Previous_Salary
FROM Employees;


-- =============================================
-- 12. LEAD - Next Salary
-- =============================================

SELECT
    Employee_Name,
    Salary,
    LEAD(Salary) OVER (
        ORDER BY Employee_ID
    ) AS Next_Salary
FROM Employees;


-- =============================================
-- 13. Salary Difference from Previous Employee
-- =============================================

SELECT
    Employee_Name,
    Salary,
    Salary - LAG(Salary) OVER (
        ORDER BY Employee_ID
    ) AS Salary_Difference
FROM Employees;


-- =============================================
-- 14. Running Total of Salary
-- =============================================

SELECT
    Employee_Name,
    Salary,
    SUM(Salary) OVER (
        ORDER BY Employee_ID
    ) AS Running_Total_Salary
FROM Employees;


-- =============================================
-- 15. Department-wise Running Salary
-- =============================================

SELECT
    Employee_Name,
    Department,
    Salary,
    SUM(Salary) OVER (
        PARTITION BY Department
        ORDER BY Employee_ID
    ) AS Department_Running_Salary
FROM Employees;


-- =============================================
-- 16. NULL Handling with ISNULL
-- =============================================

SELECT
    Employee_Name,
    ISNULL(Salary, 0) AS Salary
FROM Employees;


-- =============================================
-- 17. NULL Handling with NULLIF
-- =============================================

SELECT
    Employee_Name,
    NULLIF(Salary, 0) AS Salary
FROM Employees;


-- =============================================
-- 18. Department-wise Average Including NULL as 0
-- =============================================

SELECT
    Department,
    AVG(COALESCE(Salary, 0)) AS Average_Salary
FROM Employees
GROUP BY Department;


-- =============================================
-- 19. Create View for Data Employees
-- =============================================

CREATE VIEW Data_Employees_View
AS
SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Designation,
    Experience,
    Salary
FROM Employees
WHERE Department = 'Data';
GO


-- =============================================
-- 20. Query the View
-- =============================================

SELECT *
FROM Data_Employees_View;