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

--Task 10 - 2nd solution
  SELECT LEFT([FirstName], 1) 
      AS [FirstLetter]
    FROM [WizzardDeposits]
   WHERE [DepositGroup] = 'Troll Chest'
GROUP BY LEFT([FirstName], 1)
ORDER BY [FirstLetter]

--Task 11
  SELECT [DepositGroup],
	     [IsDepositExpired],
	     AVG([DepositInterest]) 
	  AS [AverageInterest]
    FROM [WizzardDeposits]
   WHERE [DepositStartDate] > '1985-01-01'
GROUP BY [DepositGroup],
	     [IsDepositExpired]
ORDER BY [DepositGroup] DESC,
         [IsDepositExpired] ASC

--Task 12 - 1st solution
SELECT SUM([Difference]) 
    AS [SumDifference]
  FROM (
SELECT [W1].[FirstName]
    AS [Host Wizard],
       [W1].[DepositAmount]
    AS [Host Wizard Deposit],
	   [W2].[FirstName]
    AS [Guest Wizard],
       [W2].[DepositAmount]
    AS [Guest Wizard Deposit],
	   ([W1].[DepositAmount] - [W2].[DepositAmount])
    AS [Difference]
  FROM [WizzardDeposits] AS [W1]
  JOIN [WizzardDeposits] AS [W2]
    ON [W2].[Id] = [W1].[Id] + 1 

	) 
	AS [DepositAmountTempTable]

--Task 12 - 2nd solution
SELECT SUM([Difference]) 
    AS [SumDifference]
  FROM (
SELECT [FirstName]
    AS [Host Wizard],
       [DepositAmount]
    AS [Host Wizard Deposit],
	   LEAD([FirstName]) OVER(ORDER BY [Id])
    AS [Guest Wizard],
       LEAD([DepositAmount]) OVER(ORDER BY [Id])
    AS [Guest Wizard Deposit],
	   [DepositAmount] - LEAD([DepositAmount]) OVER(ORDER BY [Id])
    AS [Difference]
  FROM [WizzardDeposits]
	) 
	AS [DepositAmountTempTable]

--Task 13
USE [SoftUni]

  SELECT [DepartmentID],
         SUM([Salary])
	  AS [TotalSalary]
    FROM [Employees]
GROUP BY [DepartmentID]
ORDER BY [DepartmentID]

--Task 14
  SELECT [DepartmentID],
         MIN([Salary])
	  AS [MinimumSalary]
    FROM [Employees]
   WHERE [DepartmentID] IN (2, 5, 7) 
     AND [HireDate] > '2000-01-01'
GROUP BY [DepartmentID]

--Task 15
SELECT *
  INTO [EmployeesTempTable]
  FROM [Employees]
 WHERE [Salary] > 30000

DELETE 
  FROM [EmployeesTempTable]
 WHERE [ManagerID] = 42

UPDATE [EmployeesTempTable]
   SET [Salary] += 5000
 WHERE [DepartmentID] = 1

  SELECT [DepartmentID],
         AVG([Salary])
      AS [AverageSalary]
    FROM [EmployeesTempTable]
GROUP BY [DepartmentID]

--Task 16
  SELECT [DepartmentID],
	     MAX([Salary])
	  AS [MaxSalary]
    FROM [Employees]
GROUP BY [DepartmentID]
  HAVING MAX([Salary]) NOT BETWEEN 30000 AND 70000

--Task 17
  SELECT COUNT([EmployeeID])
      AS [Count]
    FROM [Employees]
   WHERE [ManagerID] IS NULL

--Task 18
 SELECT [DepartmentID],
        [Salary] 
	 AS [ThirdHighestSalary]
   FROM (
             SELECT [DepartmentID],
                    [Salary],
			        DENSE_RANK() OVER(PARTITION BY [DepartmentID] ORDER BY [Salary] DESC)
	             AS [SalaryRank]
               FROM [Employees]
         )
      AS [TempTable]
   WHERE [SalaryRank]= 3
GROUP BY [DepartmentID],
         [Salary]

--Task 19
SELECT 
     TOP (10)
         [E1].[FirstName],
         [E1].[LastName],
         [E1].[DepartmentID]
    FROM [Employees]
      AS [E1]
   WHERE [E1].[Salary] > (
                           SELECT AVG([E2].[Salary])
                               AS [AvgSalary]
                             FROM [Employees]
                               AS [E2]
                            WHERE [E2].[DepartmentID] = [E1].[DepartmentID]
                         )
ORDER BY [E1].[DepartmentID] ASC