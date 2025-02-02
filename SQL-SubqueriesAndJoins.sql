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

--Task 4
    SELECT 
    TOP(5) [E].[EmployeeID],
	       [E].[FirstName],
		   [E].[Salary],
		   [D].[Name] AS [DepartmentName]
      FROM [Employees] AS [E]
INNER JOIN [Departments] AS [D]
        ON [E].[DepartmentID] = [D].[DepartmentID]
	 WHERE [E].[Salary] > 15000
  ORDER BY [D].[DepartmentID] ASC

--Task 5
   SELECT 
  TOP (3) [E].[EmployeeID],
          [E].[FirstName]
     FROM [Employees] AS [E]
LEFT JOIN [EmployeesProjects] AS [EP]
       ON [E].[EmployeeID] = [EP].[EmployeeID]
	WHERE [EP].[ProjectID] IS NULL
 ORDER BY [E].[EmployeeID] ASC

--Task 6
    SELECT [E].[FirstName],
	       [E].[LastName],
		   [E].[HireDate],
		   [D].[Name] AS [DeptName]
      FROM [Employees] AS [E]
INNER JOIN [Departments] AS [D]
        ON [E].[DepartmentID] = [D].[DepartmentID]
     WHERE [E].[HireDate] > '1999-01-01'
	   AND [D].[Name] IN ('Sales', 'Finance')
  ORDER BY [E].[HireDate] ASC

--Task 7
   SELECT 
  TOP (5) [E].[EmployeeID],
          [E].[FirstName],
		  [P].[Name] AS [ProjectName]
     FROM [Employees] AS [E]
LEFT JOIN [EmployeesProjects] AS [EP]
       ON [E].[EmployeeID] = [EP].[EmployeeID]
LEFT JOIN [Projects] AS [P]
       ON [EP].[ProjectID] = [P].[ProjectID]
    WHERE [P].[StartDate] > '2002-08-13' 
	  AND [P].[EndDate] IS NULL
 ORDER BY [E].[EmployeeID] ASC

--Task 8
   SELECT [E].[EmployeeID],
          [E].[FirstName],
		  CASE
		      WHEN DATEPART(YEAR, [P].[StartDate]) >= 2005 THEN NULL
			  ELSE [P].[Name]
		  END AS [ProjectName]
     FROM [Employees] AS [E]
LEFT JOIN [EmployeesProjects] AS [EP]
       ON [E].[EmployeeID] = [EP].[EmployeeID]
LEFT JOIN [Projects] AS [P]
       ON [EP].[ProjectID] = [P].[ProjectID]
    WHERE [E].[EmployeeID] = 24

--Task 9
    SELECT [E].[EmployeeID],
	       [E].[FirstName],
		   [E].[ManagerID],
		   [M].[FirstName] AS [ManagerName]
      FROM [Employees] AS [E]
 LEFT JOIN [Employees] AS [M]
        ON [M].[EmployeeID] = [E].[ManagerID]
     WHERE [E].[ManagerID] IN (3, 7)
  ORDER BY [E].[EmployeeID] ASC

--Task 10 
   SELECT 
 TOP (50) [E].[EmployeeID],
          CONCAT_WS(' ', [E].[FirstName], [E].[LastName]) AS [EmployeeName],
		  CONCAT_WS(' ', [M].[FirstName], [M].[LastName]) AS [ManagerName],
		  [D].[Name] AS [DepartmentName]
     FROM [Employees] AS [E]
LEFT JOIN [Employees] AS [M]
       ON [M].[EmployeeID] = [E].[ManagerID]
LEFT JOIN [Departments] AS [D]
       ON [D].[DepartmentID] = [E].[DepartmentID]
 ORDER BY [E].[EmployeeID] ASC

--Task 11 - First solution 
  SELECT 
 TOP (1) AVG([Salary])
    FROM [Employees] 
GROUP BY [DepartmentID]
ORDER BY 1