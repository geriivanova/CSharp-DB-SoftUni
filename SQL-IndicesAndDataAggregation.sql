USE [Gringotts]

--Task 1
SELECT COUNT([Id])
    AS [Count]
  FROM [WizzardDeposits]

--Task 2
SELECT MAX([MagicWandSize])
    AS [LongestMagicWand]
  FROM [WizzardDeposits]