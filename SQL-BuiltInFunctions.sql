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

--Task 14
USE [Diablo]

  SELECT 
  TOP 50 [Name],
         FORMAT([Start], 'yyyy-MM-dd') 
	  AS [Start]
    FROM [Games]
   WHERE DATEPART(YEAR, [Start]) IN (2011, 2012)
ORDER BY [Start],
         [Name]
  
  
--Task 15
SELECT [Username],
       RIGHT([Email], LEN([Email]) - (CHARINDEX('@', [Email])))
    AS [Email Provider]
  FROM [Users]
ORDER BY [Email Provider],
         [Username]

--Task 16
  SELECT [Username],
         [IpAddress] AS [IP Address] 
    FROM [Users]
   WHERE [IpAddress] LIKE '___.1%.%.___'
ORDER BY [Username]

--Task 17
SELECT *  FROM Games

   SELECT [Name] AS [Game],
	   CASE 
           WHEN DATEPART(HH, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
		   WHEN DATEPART(HH, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
		   ELSE 'Evening'
       END AS [Part of the Day],
	   CASE 
           WHEN [Duration] <=3 THEN 'Extra Short'
		   WHEN [Duration] BETWEEN 4 AND 6 THEN 'Short'
		   WHEN [Duration] >6 THEN 'Long'
		   ELSE 'Extra Long'
       END AS [Duration]
    FROM [Games]
ORDER BY [Name] ASC,
         [Duration] ASC,
		 [Part of the Day] ASC

--Task 18
USE [Orders]

SELECT [ProductName],
       [OrderDate],
	   DATEADD(DAY, 3, [OrderDate])
    AS [Pay Due],
       DATEADD(MONTH, 1, [OrderDate])
    AS [Deliver Due]
  FROM [Orders]

--Task 19
USE EXERCISE3

CREATE TABLE [People](
	[Id] INT PRIMARY KEY IDENTITY, 
	[Name] VARCHAR(50), 
	[Birthdate] DATETIME
)

INSERT INTO [People]([Name], [Birthdate])
VALUES ('Victor', '2000-12-07 00:00:00.000'),
       ('Steven' , '1992-09-10 00:00:00.000'),
	   ('Stephen', '1910-09-19 00:00:00.000'),
	   ('John', '2010-01-06 00:00:00.000')

SELECT [Name],
       DATEDIFF(YEAR, [Birthdate], GETDATE()) AS [Age in Years],
	   DATEDIFF(MONTH, [Birthdate], GETDATE()) AS [Age in Months],
	   DATEDIFF(DAY, [Birthdate], GETDATE()) AS [Age in Days],
	   DATEDIFF(MINUTE, [Birthdate], GETDATE()) AS [Age in Minutes]
  FROM [People]