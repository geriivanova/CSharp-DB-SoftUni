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
 TOP (1) AVG([Salary]) AS [MinAverageSalary]
    FROM [Employees] 
GROUP BY [DepartmentID]
ORDER BY 1

--Task 11 - Second solution 
SELECT MIN([MAS].[MinAverageSalary]) AS [MinAverageSalary]
  FROM
      (
         SELECT 
            AVG([Salary]) AS [MinAverageSalary]
           FROM [Employees] 
       GROUP BY [DepartmentID]
      ) AS [MAS]

--Task 12
USE [Geography]

   SELECT [C].[CountryCode],
          [M].[MountainRange],
		  [P].[PeakName],
		  [P].[Elevation]
     FROM [Countries] AS [C]
LEFT JOIN [MountainsCountries] AS [MC]
       ON [C].[CountryCode] = [MC].[CountryCode]
LEFT JOIN [Mountains] AS [M]
       ON [M].[Id] = [MC].[MountainId]
LEFT JOIN [Peaks] AS [P]
       ON [P].[MountainId] = [M].[Id]
	WHERE [C].[CountryCode] = 'BG'
	  AND [P].[Elevation] > 2835
 ORDER BY [P].[Elevation] DESC

--Task 13
   SELECT [C].[CountryCode],
          COUNT([MC].[MountainId]) AS [MountainRanges]
     FROM [Countries] AS [C]
LEFT JOIN [MountainsCountries] AS [MC]
       ON [C].[CountryCode] = [MC].[CountryCode]
	WHERE [C].[CountryCode] IN ('BG', 'RU', 'US')
 GROUP BY [C].[CountryCode]

--Task 14
   SELECT 
  TOP (5) [C].[CountryName],
          [R].[RiverName]
     FROM [Countries] AS [C]
LEFT JOIN [CountriesRivers] AS [CR]
       ON [C].[CountryCode] = [CR].[CountryCode]
LEFT JOIN [Rivers] AS [R]
       ON [R].[Id] = [CR].[RiverId]
LEFT JOIN [Continents] AS [CONT]
       ON [C].[ContinentCode] = [CONT].[ContinentCode]
    WHERE [Cont].[ContinentName] = 'Africa'
ORDER BY [C].[CountryName] ASC


--Task 15
SELECT [ContinentCode],
       [CurrencyCode],
	   [CurrencyUsage]
  FROM(
        SELECT *,
               DENSE_RANK() OVER(PARTITION BY [ContinentCode] ORDER BY [CurrencyUsage] DESC) 
	        AS [CurrencyRakn]
       FROM(
             SELECT [CONT].[ContinentCode],
                    [C].[CurrencyCode],
		            COUNT([C].[CurrencyCode]) AS [CurrencyUsage]
               FROM [Continents] AS [CONT]
          LEFT JOIN [Countries] AS [C]
                 ON [C].[ContinentCode] = [CONT].[ContinentCode]
           GROUP BY [CONT].[ContinentCode],
                    [C].[CurrencyCode]
             HAVING COUNT([C].[CurrencyCode]) > 1
            ) 
			AS [CurrencyUsageTempTable]
      ) 
	  AS [CurrencyRankingTempTable]
   WHERE [CurrencyRakn] = 1 
ORDER BY [ContinentCode]

--Task 16
   SELECT COUNT(DISTINCT [C].[CountryCode]) AS [Count]
     FROM [Countries] 
	   AS [C]
LEFT JOIN [MountainsCountries] 
       AS [MC]
       ON [C].[CountryCode] = [MC].[CountryCode]
LEFT JOIN [Mountains] 
       AS [M]
       ON [MC].[MountainId] = [M].[Id]
    WHERE [M].[Id] IS NULL