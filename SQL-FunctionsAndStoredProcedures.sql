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

EXEC [dbo].[usp_GetTownsStartingWith] 'b'

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

EXEC [dbo].[usp_GetEmployeesFromTown] 'Sofia'

--Task 5
CREATE OR ALTER FUNCTION [dbo].[ufn_GetSalaryLevel](@Salary DECIMAL(18,4))
RETURNS VARCHAR(15)
AS
  BEGIN	
       DECLARE @salaryLevel VARCHAR(15);
         IF(@Salary < 30000)
           SET @salaryLevel = 'Low'
         ELSE IF(@Salary <= 50000)
           SET @salaryLevel = 'Average'
         ELSE 
           SET @salaryLevel = 'High'

        RETURN @salaryLevel
  END

--Task 6
CREATE OR ALTER PROCEDURE [usp_EmployeesBySalaryLevel]
@SalaryLevel VARCHAR(15)
AS
  BEGIN
       IF(@SalaryLevel = 'Low')
	     BEGIN
		      SELECT [FirstName],
	                 [LastName]
	            FROM [Employees]
			   WHERE [Salary] < 30000
		 END
	   ELSE IF(@SalaryLevel = 'Average')
	        BEGIN
			     SELECT [FirstName],
	                 [LastName]
	            FROM [Employees]
			   WHERE [Salary] BETWEEN 30000 AND 50000
			END
       ELSE IF(@SalaryLevel = 'High')
	        BEGIN
			     SELECT [FirstName],
	                 [LastName]
	            FROM [Employees]
			   WHERE [Salary] > 50000
			END
  END

--Task 7
CREATE OR ALTER FUNCTION [ufn_IsWordComprised](@setOfLetters VARCHAR(100), @word VARCHAR(70))
RETURNS BIT
AS
  BEGIN
       DECLARE @wordIndex TINYINT = 1;
	     WHILE(@wordIndex <= LEN(@word))
	          BEGIN
			       DECLARE @currentLetter CHAR(1);
				   SET @currentLetter = SUBSTRING(@word, @wordIndex, 1);

			       IF(CHARINDEX(@currentLetter, @setOfLetters) = 0)
	                 BEGIN 
		                  RETURN 0;
		             END

                  SET @wordIndex += 1;
		      END
       RETURN 1;
  END

--Task 8
CREATE OR ALTER PROCEDURE [usp_DeleteEmployeesFromDepartment] (@departmentId INT)
AS
  BEGIN
         DELETE
           FROM [EmployeesProjects]
          WHERE [EmployeeID] IN (
                                 SELECT [EmployeeID]
                                   FROM [Employees]
                                  WHERE [DepartmentID] = @departmentId
                                )
         UPDATE [Employees]
            SET [ManagerID] = NULL
          WHERE [ManagerID] IN (
                                SELECT [EmployeeID]
                                  FROM [Employees]
                                 WHERE [DepartmentID] = @departmentId
                               )

         ALTER TABLE [Departments]
         ALTER COLUMN [ManagerID] INT NULL

         UPDATE [Departments]
            SET [ManagerID] = NULL
          WHERE [ManagerID] IN (
                                SELECT [EmployeeID]
                                  FROM [Employees]
                                 WHERE [DepartmentID] = @departmentId   
                              )
         DELETE
           FROM [Employees]
          WHERE [DepartmentID] = @departmentId
		  
         DELETE
           FROM [Departments]
          WHERE [DepartmentID] = @departmentId

		 SELECT COUNT(*)
		   FROM [Employees]
		  WHERE [DepartmentID] = @departmentId
  END

--Task 9
USE [Bank]

CREATE OR ALTER PROCEDURE [usp_GetHoldersFullName]
AS
  BEGIN
       SELECT CONCAT_WS(' ', [FirstName], [LastName]) 
	       AS [Full Name]
	     FROM [AccountHolders]
  END

--Task 10
CREATE OR ALTER PROCEDURE [usp_GetHoldersWithBalanceHigherThan] @Number MONEY
AS
  BEGIN
           SELECT [AH].[FirstName]
		       AS [First Name],
			      [AH].[LastName]
			   AS [Last Name]
	         FROM [AccountHolders]
		       AS [AH]
	    LEFT JOIN [Accounts] 
		       AS [A]
			   ON [A].[AccountHolderId] = [AH].[Id]
		 GROUP BY [AH].[FirstName],
		          [AH].[LastName]
		   HAVING SUM([a].[Balance]) > @Number
		 ORDER BY [AH].[FirstName],
		          [AH].[LastName]
  END

--Task 11
CREATE OR ALTER FUNCTION [ufn_CalculateFutureValue](@Sum DECIMAL (18, 4), @Rate FLOAT, @Years INT)
RETURNS DECIMAL(18, 4)
AS 
  BEGIN 
       DECLARE @InitialSum DECIMAL (18, 4) = @Sum;
	   DECLARE @YearlyInterestRate FLOAT = @Rate;
	   DECLARE @NumberOfYears INT = @Years

	   RETURN (@InitialSum * POWER((1 + @YearlyInterestRate), @NumberOfYears))
  END