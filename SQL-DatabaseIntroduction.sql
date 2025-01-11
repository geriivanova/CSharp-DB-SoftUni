--Task 1
CREATE DATABASE [Minions]

--Task 2
USE Minions
CREATE TABLE [Minions](
	[Id] INT PRIMARY KEY NOT NULL, 
	[Name] VARCHAR(50) NOT NULL, 
	[Age] SMALLINT
)

CREATE TABLE [Towns](
	[Id] INT PRIMARY KEY NOT NULL, 
	[Name] VARCHAR(50) NOT NULL
)

--Task 3
ALTER TABLE [Minions]
ADD [TownId] INT NOT NULL

ALTER TABLE [Minions]
ADD CONSTRAINT [FK_CONSTRAINT]
FOREIGN KEY ([TownId]) REFERENCES [Towns]([Id])

--Task 4
INSERT INTO [Towns]([Id], [Name])
VALUES 
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO [Minions]([Id], [Name],	[Age], [TownId])
VALUES 
(1, 'Kevin', 22, 1),
(2,	'Bob',	15, 3),
(3,	'Steward', NULL, 2)

--Task 5
TRUNCATE TABLE [Minions]

--Task 6
DROP TABLE [Minions]
DROP TABLE [Towns]

--Task 7
CREATE TABLE [People](
	[Id] INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY(MAX),
	[Height] DECIMAL(16, 2),
	[Weight] DECIMAL(16, 2),
	[Gender] CHAR(1) NOT NULL,
	[Birthdate] DATETIME2 NOT NULL,
	[Biography] NVARCHAR(MAX)
)

INSERT INTO [People]([Id], [Name], [Picture], 
[Height], [Weight], [Gender], [Birthdate], [Biography])
VALUES 
(1, 'Ivan Ivanov Ivanov', NULL, 1.65, 65, 'm', GETDATE(), 'Student at university'),
(2, 'Georgi Georgiev Ivanov', NULL, 1.77, 81, 'm', GETDATE(), 'Developer'),
(3, 'Mariq Petrova Stancheva', NULL, 1.67, 50, 'f', GETDATE(), 'Teacher'),
(4, 'Anna Stoyanova Petrova', NULL, 1.70, 68, 'f', GETDATE(), 'Athlete'),
(5, 'Stefan Stefanov Georgiev', NULL, 1.77, 81, 'm', GETDATE(), 'Developer')
