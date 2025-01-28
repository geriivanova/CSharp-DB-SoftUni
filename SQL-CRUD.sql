USE [SoftUni]
--Task 2

SELECT * 
  FROM [Departments]

--Task 3
SELECT [Name]
  FROM [Departments]

--Task 4
SELECT [FirstName],
	   [LastName],
	   [Salary]
  FROM [Employees]

--Task 5
SELECT [FirstName],
	   [MiddleName],
	   [LastName]
  FROM [Employees] 

--Task 6
SELECT [FirstName] + '.' + [LastName] + '@softuni.bg'
	AS [Full Email Address]
  FROM [Employees]

--Task 7
SELECT DISTINCT [Salary]
			 AS [Salary]
           FROM [Employees]

--Task 8
SELECT * 
  FROM [Employees]
 WHERE [JobTitle] = 'Sales Representative'

--Task 9
SELECT [FirstName], 
	   [LastName],
	   [JobTitle]
  FROM [Employees]
 WHERE [Salary] BETWEEN 20000 AND 30000