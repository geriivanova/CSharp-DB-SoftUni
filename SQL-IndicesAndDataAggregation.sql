USE [Gringotts]

--Task 1
SELECT COUNT([Id])
    AS [Count]
  FROM [WizzardDeposits]

--Task 2
SELECT MAX([MagicWandSize])
    AS [LongestMagicWand]
  FROM [WizzardDeposits]

--Task 3
  SELECT [DepositGroup],
         MAX([MagicWandSize])
      AS [LongestMagicWand]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]

--Task 4
  SELECT 
  TOP(2) [DepositGroup]
      AS [LongestMagicWand]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]
ORDER BY AVG([MagicWandSize]) ASC

--Task 5
  SELECT [DepositGroup],
         SUM([DepositAmount])
      AS [TotalSum]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]

--Task 6
  SELECT [DepositGroup],
         SUM([DepositAmount])
      AS [TotalSum]
    FROM [WizzardDeposits]
   WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]

--Task 7
  SELECT [DepositGroup],
         SUM([DepositAmount])
      AS [TotalSum]
    FROM [WizzardDeposits]
   WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]
  HAVING SUM([DepositAmount]) < 150000
ORDER BY [TotalSum] DESC

--Task 8
  SELECT [DepositGroup],
         [MagicWandCreator],
         MIN([DepositCharge])
	  AS [MinDepositCharge]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup],
         [MagicWandCreator]
ORDER BY [MagicWandCreator] ASC,
         [DepositGroup] ASC

--Task 9
  SELECT [AgeGroup],
         COUNT(*)
	  AS [WizardCount]
    FROM (
           SELECT *,
                 CASE 
	                 WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
	                 WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
	                 WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
	                 WHEN [Age] BETWEEN 31 AND 40 THEN '[31-40]'
	                 WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
	                 WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
	                 WHEN [Age] >= 61 THEN '[61+]'
                 END
	              AS [AgeGroup]
                FROM [WizzardDeposits]
         ) 
      AS [AgeGroupTempTable]
GROUP BY [AgeGroup]

--Task 10 - 1st solution 
  SELECT 
DISTINCT LEFT([FirstName], 1) 
      AS [FirstLetter]
    FROM [WizzardDeposits]
   WHERE [DepositGroup] = 'Troll Chest'
ORDER BY [FirstLetter]

