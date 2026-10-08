-- =============================================
-- Project: Employee & Project Management
-- Database Setup
-- Tool: Microsoft SQL Server
-- =============================================

-- Create Database
CREATE DATABASE Employee_Project_Analytics;
GO

USE Employee_Project_Analytics;
GO

-- =============================================
-- Employees Table
-- =============================================

CREATE TABLE Employees
(
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100),
    Department VARCHAR(50),
    Designation VARCHAR(50),
    Experience INT,
    Salary DECIMAL(10,2)
);
GO


-- =============================================
-- Insert Employee Data
-- =============================================

INSERT INTO Employees
(
    Employee_ID,
    Employee_Name,
    Department,
    Designation,
    Experience,
    Salary
)
VALUES
(101, 'Amit Patil', 'GIS', 'GIS Analyst', 3, 45000),
(102, 'Sneha Joshi', 'GIS', 'GIS Engineer', 5, 60000),
(103, 'Rahul Shinde', 'GIS', 'Team Leader', 7, 85000),
(104, 'Priya Kulkarni', 'Data', 'Data Analyst', 2, 50000),
(105, 'Vikas More', 'Data', 'Data Engineer', 4, 70000),
(106, 'Neha Deshmukh', 'GIS', 'GIS Analyst', 6, 65000),
(107, 'Akash Jadhav', 'Data', 'Data Analyst', 3, 55000),
(108, 'Pooja Pawar', 'GIS', 'GIS Engineer', 2, 42000),
(109, 'Rohit Kale', 'GIS', NULL, 4, NULL);
GO


-- =============================================
-- Projects Table
-- =============================================

CREATE TABLE Projects
(
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(100),
    Employee_ID INT,
    Project_Status VARCHAR(50)
);
GO


-- =============================================
-- Insert Project Data
-- =============================================

INSERT INTO Projects
(
    Project_ID,
    Project_Name,
    Employee_ID,
    Project_Status
)
VALUES
(201, 'GIS Mapping', 101, 'Completed'),
(202, 'Land Records', 102, 'Ongoing'),
(203, 'Telecom GIS', 103, 'Ongoing'),
(204, 'Power BI Dashboard', 104, 'Completed'),
(205, 'Data Pipeline', 105, 'Ongoing'),
(206, 'Cadastral Mapping', 106, 'Completed'),
(207, 'SQL Analysis', 107, 'Ongoing'),
(208, 'Urban Mapping', 101, 'Ongoing');
GO


-- =============================================
-- Verify Data
-- =============================================

SELECT * FROM Employees;

SELECT * FROM Projects;