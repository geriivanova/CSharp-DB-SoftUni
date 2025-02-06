USE [SoftUni]

--Task 1
CREATE OR ALTER PROCEDURE [usp_GetEmployeesSalaryAbove35000]
AS
  BEGIN
	   SELECT [FirstName], 
	          [LastName]
         FROM [Employees]
		WHERE [Salary] > 35000
  END

--Task 2
CREATE OR ALTER PROCEDURE [usp_GetEmployeesSalaryAboveNumber] 
@Salary DECIMAL(18, 4)
AS
  BEGIN
       SELECT [FirstName], 
	          [LastName]
         FROM [Employees]
		WHERE [Salary] >= @Salary
  END

--Task 3
CREATE OR ALTER PROCEDURE [usp_GetTownsStartingWith] 
@StartLetter VARCHAR(50)
AS
  BEGIN
       SELECT [Name]
	       AS [Town]
         FROM [Towns]
		WHERE [Name] LIKE @StartLetter + '%'
  END

--Task 4
CREATE OR ALTER PROCEDURE [usp_GetEmployeesFromTown]
@TownName VARCHAR(50)
AS
  BEGIN 
          SELECT [E].[FirstName],
		         [E].[LastName]
	        FROM [Employees] AS [E]
	   LEFT JOIN [Addresses] AS [A]
	          ON [A].[AddressID] = [E].[AddressID]
       LEFT JOIN [Towns] AS [T]
	          ON [T].[TownID] = [A].[TownID]
		   WHERE [T].[Name] = @TownName
  END