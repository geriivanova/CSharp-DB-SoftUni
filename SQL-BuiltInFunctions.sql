USE [SoftUni]

--Task 1
SELECT [FirstName],
       [LastName]
  FROM [Employees]
 WHERE [FirstName] LIKE 'Sa%'

--Task 2
SELECT [FirstName],
       [LastName]
  FROM [Employees]
 WHERE [LastName] LIKE '%ei%'