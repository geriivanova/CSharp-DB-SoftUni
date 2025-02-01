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

--Task 3
SELECT [FirstName]
  FROM [Employees]
 WHERE [DepartmentID] IN (3, 10)
    AND DATEPART(YEAR, [HireDate]) BETWEEN 1995 AND 2005

--Task 4
SELECT [FirstName],
       [LastName]
  FROM [Employees]
 WHERE [JobTitle] NOT LIKE '%Engineer%'

 --Task 5
  SELECT [Name]
    FROM [Towns]
   WHERE LEN([Name]) IN (5, 6)
ORDER BY [Name]

--Task 6
  SELECT [TownID], 
         [Name]
    FROM [Towns]
   WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name]

--Task 7
SELECT [TownID], 
         [Name]
    FROM [Towns]
   WHERE LEFT([Name], 1) NOT IN ('R', 'B', 'D')
ORDER BY [Name]

--Task 8
CREATE VIEW [V_EmployeesHiredAfter2000]
         AS 
	 SELECT [FirstName],
		    [LastName]
	   FROM [Employees]
	  WHERE DATEPART(YEAR, [HireDate]) > 2000
	
SELECT * FROM [V_EmployeesHiredAfter2000]

--Task 9
SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE LEN([LastName]) = 5

--Task 10
  SELECT [EmployeeID],
         [FirstName],
	     [LastName],
	     [Salary],
	     DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID])
	  AS [Rank]
    FROM [Employees]
   WHERE [Salary] BETWEEN 10000 AND 50000
ORDER BY [Salary] DESC

--Task 11
 SELECT [D].*
   FROM (
           SELECT [EmployeeID],
                  [FirstName],
	              [LastName],
	              [Salary],
	     DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID])
	           AS [Rank]
             FROM [Employees] 
            WHERE [Salary] BETWEEN 10000 AND 50000
         ) AS [D]
   WHERE [Rank] = 2
ORDER BY [Salary] DESC

--Task 12
USE [Geography]

  SELECT [CountryName] 
      AS [Country Name],
	     [IsoCode] 
	  AS [ISO Code]
    FROM [Countries]
   WHERE [CountryName] LIKE '%a%a%a%'
ORDER BY [IsoCode]

--Task 13
  SELECT [P].[PeakName],
         [R].[RiverName],
	     LOWER((LEFT([PeakName], LEN([PeakName]) - 1)) + [RiverName])
	  AS [Mix]
    FROM [Peaks] AS [P] 
    JOIN [Rivers] AS [R]
      ON RIGHT([PeakName], 1) = LEFT([RiverName], 1)
ORDER BY [Mix]