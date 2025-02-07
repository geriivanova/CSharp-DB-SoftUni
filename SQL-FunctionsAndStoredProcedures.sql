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