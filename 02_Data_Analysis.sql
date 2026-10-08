-- =============================================
-- Project: Employee & Project Management
-- File: 02_Data_Analysis.sql
-- Tool: Microsoft SQL Server
-- =============================================

USE Employee_Project_Analytics;
GO


-- =============================================
-- 1. Display All Employees
-- =============================================

SELECT *
FROM Employees;


-- =============================================
-- 2. Employees from GIS Department
-- =============================================

SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Designation
FROM Employees
WHERE Department = 'GIS';


-- =============================================
-- 3. Employees with Salary Greater Than 60000
-- =============================================

SELECT
    Employee_Name,
    Department,
    Salary
FROM Employees
WHERE Salary > 60000
ORDER BY Salary DESC;


-- =============================================
-- 4. Department-wise Employee Count
-- =============================================

SELECT
    Department,
    COUNT(*) AS Employee_Count
FROM Employees
GROUP BY Department;


-- =============================================
-- 5. Department-wise Salary Analysis
-- =============================================

SELECT
    Department,
    SUM(Salary) AS Total_Salary,
    AVG(Salary) AS Average_Salary,
    MAX(Salary) AS Highest_Salary,
    MIN(Salary) AS Lowest_Salary
FROM Employees
GROUP BY Department;


-- =============================================
-- 6. Departments with Total Salary Greater Than 200000
-- =============================================

SELECT
    Department,
    SUM(Salary) AS Total_Salary
FROM Employees
GROUP BY Department
HAVING SUM(Salary) > 200000;


-- =============================================
-- 7. Employee Experience Classification
-- =============================================

SELECT
    Employee_Name,
    Experience,
    CASE
        WHEN Experience >= 5 THEN 'Senior'
        WHEN Experience >= 3 THEN 'Mid-Level'
        ELSE 'Junior'
    END AS Experience_Level
FROM Employees;


-- =============================================
-- 8. Employee Salary Classification
-- =============================================

SELECT
    Employee_Name,
    Salary,
    CASE
        WHEN Salary IS NULL THEN 'Not Available'
        WHEN Salary >= 70000 THEN 'High'
        WHEN Salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS Salary_Category
FROM Employees;


-- =============================================
-- 9. Employees and Their Projects
-- =============================================

SELECT
    e.Employee_ID,
    e.Employee_Name,
    e.Department,
    p.Project_Name,
    p.Project_Status
FROM Employees AS e
LEFT JOIN Projects AS p
    ON e.Employee_ID = p.Employee_ID;


-- =============================================
-- 10. Employees with No Project
-- =============================================

SELECT
    e.Employee_ID,
    e.Employee_Name,
    e.Department
FROM Employees AS e
LEFT JOIN Projects AS p
    ON e.Employee_ID = p.Employee_ID
WHERE p.Project_ID IS NULL;


-- =============================================
-- 11. Project Count per Employee
-- =============================================

SELECT
    e.Employee_ID,
    e.Employee_Name,
    COUNT(p.Project_ID) AS Project_Count
FROM Employees AS e
LEFT JOIN Projects AS p
    ON e.Employee_ID = p.Employee_ID
GROUP BY
    e.Employee_ID,
    e.Employee_Name;


-- =============================================
-- 12. Employees with More Than One Project
-- =============================================

SELECT
    e.Employee_ID,
    e.Employee_Name,
    COUNT(p.Project_ID) AS Project_Count
FROM Employees AS e
LEFT JOIN Projects AS p
    ON e.Employee_ID = p.Employee_ID
GROUP BY
    e.Employee_ID,
    e.Employee_Name
HAVING COUNT(p.Project_ID) > 1;


-- =============================================
-- 13. Ongoing Projects
-- =============================================

SELECT
    p.Project_ID,
    p.Project_Name,
    e.Employee_Name,
    p.Project_Status
FROM Projects AS p
JOIN Employees AS e
    ON p.Employee_ID = e.Employee_ID
WHERE p.Project_Status = 'Ongoing';


-- =============================================
-- 14. Highest Salary Employee
-- =============================================

SELECT
    Employee_Name,
    Department,
    Salary
FROM Employees
WHERE Salary = (
    SELECT MAX(Salary)
    FROM Employees
);


-- =============================================
-- 15. Employees Earning Above Company Average
-- =============================================

SELECT
    Employee_Name,
    Department,
    Salary
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);


-- =============================================
-- 16. Department-wise Highest Salary
-- =============================================

WITH Ranked_Employees AS
(
    SELECT
        Employee_Name,
        Department,
        Salary,
        DENSE_RANK() OVER (
            PARTITION BY Department
            ORDER BY Salary DESC
        ) AS Salary_Rank
    FROM Employees
)
SELECT
    Employee_Name,
    Department,
    Salary,
    Salary_Rank
FROM Ranked_Employees
WHERE Salary_Rank = 1;


-- =============================================
-- 17. Top 2 Salary Employees per Department
-- =============================================

WITH Ranked_Employees AS
(
    SELECT
        Employee_Name,
        Department,
        Salary,
        DENSE_RANK() OVER (
            PARTITION BY Department
            ORDER BY Salary DESC
        ) AS Salary_Rank
    FROM Employees
)
SELECT
    Employee_Name,
    Department,
    Salary,
    Salary_Rank
FROM Ranked_Employees
WHERE Salary_Rank <= 2;


-- =============================================
-- 18. Department Average Salary Comparison
-- =============================================

SELECT
    Employee_Name,
    Department,
    Salary,
    Department_Avg_Salary
FROM
(
    SELECT
        Employee_Name,
        Department,
        Salary,
        AVG(Salary) OVER (
            PARTITION BY Department
        ) AS Department_Avg_Salary
    FROM Employees
) AS Employee_Data
WHERE Salary > Department_Avg_Salary;


-- =============================================
-- 19. NULL Salary Handling
-- =============================================

SELECT
    Employee_Name,
    Department,
    Salary,
    COALESCE(Salary, 0) AS Salary_Available
FROM Employees;


-- =============================================
-- 20. Previous Salary and Salary Difference
-- =============================================

SELECT
    Employee_Name,
    Department,
    Salary,
    LAG(Salary) OVER (
        ORDER BY Employee_ID
    ) AS Previous_Salary,
    Salary - LAG(Salary) OVER (
        ORDER BY Employee_ID
    ) AS Salary_Difference
FROM Employees;