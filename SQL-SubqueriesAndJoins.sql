USE [SoftUni]

--Task 1
    SELECT 
    TOP(5) [E].[EmployeeID],
           [E].[JobTitle],
	       [E].[AddressID],
	       [A].[AddressText]
      FROM [Employees] AS [E]
INNER JOIN [Addresses] AS [A]
        ON [E].[AddressID] = [A].[AddressID]
  ORDER BY [E].[AddressID] ASC

--Task 2
    SELECT 
   TOP(50) [E].[FirstName],
	       [E].[LastName],
		   [T].[Name],
		   [A].[AddressText]
      FROM [Employees] AS [E]
INNER JOIN [Addresses] AS [A]
        ON [E].[AddressID] = [A].[AddressID]
INNER JOIN [Towns] AS [T]
        ON [A].[TownID] = [T].[TownID]
  ORDER BY [FirstName] ASC,
           [LastName] ASC

--Task 3
    SELECT [E].[EmployeeID],
	       [E].[FirstName],
		   [E].[LastName],
		   [D].[Name] AS [DepartmentName]
      FROM [Employees] AS [E]
INNER JOIN [Departments] AS [D]
        ON [E].[DepartmentID] = [D].[DepartmentID]
     WHERE [D].[Name] = 'Sales'
  ORDER BY [E].[EmployeeID] ASC

