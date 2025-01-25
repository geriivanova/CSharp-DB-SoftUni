--Exercise 1 Database Introduction
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


--Task 8
CREATE TABLE [Users](
	[Id] BIGINT PRIMARY KEY IDENTITY NOT NULL,
	[Username] VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(30) UNIQUE NOT NULL,
	[ProfilePicture] VARBINARY(MAX),
	[LastLoginTime] DATETIME2,
	[IsDeleted] BIT
)

INSERT INTO [Users]([Username], [Password], [ProfilePicture], [LastLoginTime], [IsDeleted])
VALUES
('ivanovv2', '123I456', NULL, GETDATE(), 'false'),
('ivanovaaa3', '123abv4', NULL, GETDATE(), 'true'),
('anna8', '123aa', NULL, GETDATE(), 'false'),
('pe6o4', 'pesho56', NULL, GETDATE(), 'true'),
('raliii33', 'ralii4567', NULL, GETDATE(), 'false')


--Task 9
ALTER TABLE [Users]
DROP CONSTRAINT PK__Users__3214EC0770BF330C

ALTER TABLE [Users]
ADD CONSTRAINT [PK_Composite_ID_Username]
PRIMARY KEY ([Id], [Username])

--Task 10
ALTER TABLE [Users]
ADD CONSTRAINT [Check_Password]
CHECK (LEN([Password])>=5)

--Task 11
ALTER TABLE [Users]
ADD CONSTRAINT [Default_Value_for_Date]
DEFAULT GETDATE() FOR [LastLoginTime]

--Task 12
ALTER TABLE [Users]
DROP CONSTRAINT PK_Composite_ID_Username

ALTER TABLE [Users]
ADD CONSTRAINT [PK_ID]
PRIMARY KEY ([Id])

--Task 13
CREATE DATABASE [Movies]
USE [Movies]

CREATE TABLE [Directors](
	[Id] INT PRIMARY KEY NOT NULL, 
	[DirectorName] VARCHAR(50) NOT NULL, 
	[Notes] VARCHAR(200)
)

CREATE TABLE [Genres](
	[Id] INT PRIMARY KEY NOT NULL, 
	[GenreName] VARCHAR(50) NOT NULL,
	[Notes] VARCHAR(200)
)

CREATE TABLE [Categories](
	[Id] INT PRIMARY KEY NOT NULL, 
	[CategoryName] VARCHAR(50) NOT NULL,
	[Notes] VARCHAR(200)
)

CREATE TABLE [Movies](
	[Id] INT PRIMARY KEY NOT NULL, 
	[Title] VARCHAR(50) NOT NULL, 
	[DirectorId] INT FOREIGN KEY REFERENCES [Directors]([Id]), 
	[CopyrightYear] CHAR(4) NOT NULL, 
	[Length] VARCHAR(20) NOT NULL, 
	[GenreId] INT FOREIGN KEY REFERENCES [Genres]([Id]), 
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]),
	[Rating] VARCHAR(20), 
	[Notes] VARCHAR(200)
)

INSERT INTO [Directors]([Id], [DirectorName], [Notes])
VALUES
(1, 'David Fincher', 'American film director'),
(2, 'Steven Spielberg', 'A major figure of the New Hollywood era'),
(3, 'David Fincher', 'Paul Thomas Anderson'),
(4, 'Ridley Scott', 'English film director and producer'),
(5, 'John Ford', 'American film director and producer')


/*
UPDATE [Directors]
SET [DirectorName] = 'Paul Thomas Anderson' 
WHERE [Id]=3

UPDATE [Directors]
SET [Notes] = 'American filmmaker' 
WHERE [Id]=3
*/


INSERT INTO [Genres]([Id], [GenreName], [Notes])
VALUES
(1, 'Drama', NULL),
(2, 'Comedy', NULL),
(3, 'Fantasy', NULL),
(4, 'Horror', NULL),
(5, 'Action', NULL)


INSERT INTO [Categories]([Id], [CategoryName], [Notes])
VALUES
(1, 'Drama', NULL),
(2, 'Comedy', NULL),
(3, 'Fantasy', NULL),
(4, 'Horror', NULL),
(5, 'Action', NULL)

INSERT INTO [Movies]([Id], [Title], [DirectorId], [CopyrightYear], 
	[Length], [GenreId], [CategoryId], [Rating], [Notes])
VALUES 
(1, 'The Godfather', 1 , '1972', '2 h 55 min', 1, 1, NULL, NULL),
(2, 'The Lord of the Rings: The Fellowship of the Ring', 2 , '2001', ' 2 h 58 min', 2, 2, NULL, NULL),
(3, '12 Angry Men', 3 , '1957', '1 h 36 min', 3, 3, NULL, NULL),
(4, 'Avatar', 4 , '2009', '2 h 42 min', 4, 4, NULL, NULL),
(5, 'The Matrix', 5 , '1999', '2 h 16 min', 5, 5, NULL, NULL)

--Task 14
CREATE DATABASE [CarRental]
USE [CarRental]

CREATE TABLE [Categories](
	[Id] INT PRIMARY KEY NOT NULL, 
	[CategoryName] VARCHAR(100) NOT NULL,
	[DailyRate]	INT, 
	[WeeklyRate] INT,
	[MonthlyRate] INT, 
	[WeekendRate] INT
)

CREATE TABLE [Cars] (
	[Id] INT PRIMARY KEY NOT NULL,
	[PlateNumber] VARCHAR(10) NOT NULL, 
	[Manufacturer] VARCHAR(100) NOT NULL, 
	[Model] VARCHAR(100) NOT NULL, 
	[CarYear] CHAR(4) NOT NULL, 
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]),  
	[Doors] TINYINT, 
	[Picture] VARBINARY(MAX), 
	[Condition] VARCHAR(100), 
	[Available] BIT
)

CREATE TABLE [Employees] (
	[Id] INT PRIMARY KEY NOT NULL, 
	[FirstName] VARCHAR(50) NOT NULL, 
	[LastName] VARCHAR(50) NOT NULL,
	[Title] VARCHAR(50) NOT NULL,
	[Notes] VARCHAR(100)
)

CREATE TABLE [Customers] (
	[Id] INT PRIMARY KEY NOT NULL, 
	[DriverLicenceNumber] CHAR(9) NOT NULL, 
	[FullName] VARCHAR(200) NOT NULL, 
	[Address] VARCHAR(100),
	[City] VARCHAR(100), 
	[ZIPCode] CHAR(4), 
	[Notes] VARCHAR(100)
)

CREATE TABLE [RentalOrders] (
	[Id] INT PRIMARY KEY NOT NULL, 
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees]([Id]),
	[CustomerId] INT FOREIGN KEY REFERENCES [Customers]([Id]),
	[CarId] INT FOREIGN KEY REFERENCES [Cars]([Id]), 
	[TankLevel] INT, 
	[KilometrageStart] INT, 
	[KilometrageEnd] INT, 
	[TotalKilometrage] INT,
	[StartDate] DATETIME2, 
	[EndDate] DATETIME2, 
	[TotalDays] SMALLINT,
	[RateApplied] VARCHAR(15),
	[TaxRate] VARCHAR(15), 
	[OrderStatus] VARCHAR(50), 
	[Notes] VARCHAR(100)
)

INSERT INTO [Categories]([Id], [CategoryName], [DailyRate], [WeeklyRate], [MonthlyRate], [WeekendRate]) 
VALUES 
(1, 'Car', 10, 70, 310, 20),
(2, 'Bus', 20, 140, 620, 40),
(3, 'Truck', 30, 210, 930, 60)

INSERT INTO [Cars] ([Id], [PlateNumber], [Manufacturer], 
[Model], [CarYear], [CategoryId], [Doors], [Picture], [Condition], [Available])
VALUES 
(1, 'H 7293 BH', 'OPEL', 'CORSA', '2011', 2, 4, NULL, NULL, NULL),
(2, 'BH 7583 BA', 'VW', 'GOLF', '2001', 1, 2, NULL, NULL, NULL),
(3, 'A 1785 KA', 'TOYOTA', 'COROLLA', '2025', 3, 4, NULL, NULL, NULL)

INSERT INTO [Employees]([Id], [FirstName], [LastName], [Title], [Notes])
VALUES 
(1, 'Ana', 'Ivanova', 'CEO', NULL),
(2, 'Ivan', 'Petrov', 'Web Developer', NULL),
(3, 'Sisa', 'Stoyanova', 'Vet', NULL)

INSERT INTO [Customers] ([Id], [DriverLicenceNumber], [FullName], [Address], [City], [ZIPCode], [Notes])
VALUES
(1, '203245789', 'Jane Haris', 'Knqz Boris 2', 'Varna', '9000', NULL),
(2, '903247789', 'Anna Stoicheva', 'Marica 22', 'Shumen', '9700', NULL),
(3, '273245139', 'Sava Savov', 'Ruja Teneva 12', 'Sofia', '1789', NULL)

INSERT INTO [RentalOrders] ([Id], [EmployeeId], [CustomerId], [CarId], [TankLevel], [KilometrageStart],
[KilometrageEnd], [TotalKilometrage], [StartDate], [EndDate], [TotalDays], [RateApplied], [TaxRate],
[OrderStatus], [Notes]) 
VALUES 
(1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 2, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 3, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)

--Task 15
CREATE DATABASE Hotel
USE Hotel

CREATE TABLE [Employees] (
	[Id] INT PRIMARY KEY NOT NULL, 
	[FirstName] VARCHAR(100) NOT NULL, 
	[LastName] VARCHAR(100) NOT NULL, 
	[Title] VARCHAR(100), 
	[Notes] VARCHAR(100)
)

CREATE TABLE [Customers](
	[Id] INT PRIMARY KEY NOT NULL,
	[AccountNumber] CHAR(10),
	[LastName] VARCHAR(100) NOT NULL, 
	[PhoneNumber] CHAR(10), 
	[EmergencyName] VARCHAR(50),
	[EmergencyNumber] CHAR(10), 
	[Notes] VARCHAR(100)
)

CREATE TABLE [RoomStatus] (
	[RoomStatus] INT PRIMARY KEY NOT NULL,
	[Notes] VARCHAR(100)
)

CREATE TABLE [RoomTypes] (
	[RoomType] INT PRIMARY KEY NOT NULL,
	[Notes] VARCHAR(100)
)

CREATE TABLE [BedTypes] (
	[BedType] INT PRIMARY KEY NOT NULL,
	[Notes] VARCHAR(100)
)

CREATE TABLE [Rooms](
	[RoomNumber] INT PRIMARY KEY NOT NULL,
	[RoomType] INT FOREIGN KEY REFERENCES [RoomTypes]([RoomType]),
	[BedType] INT FOREIGN KEY REFERENCES [BedTypes]([BedType]),
	[Rate] CHAR(7),
	[RoomStatus] INT FOREIGN KEY REFERENCES [RoomStatus]([RoomStatus]),
	[Notes] VARCHAR(100)
)

CREATE TABLE [Payments](
	[Id] INT PRIMARY KEY NOT NULL, 
	[EmployeeId] INT FOREIGN KEY REFERENCES[Employees]([Id]), 
	[PaymentDate] DATETIME2, 
	[AccountNumber] CHAR(10), 
	[FirstDateOccupied] DATETIME2, 
	[LastDateOccupied] DATETIME2, 
	[TotalDays] INT, 
	[AmountCharged] INT , 
	[TaxRate] INT, 
	[TaxAmount] INT,
	[PaymentTotal] MONEY,
	[Notes] VARCHAR(100)
)

CREATE TABLE [Occupancies](
	[Id] INT PRIMARY KEY NOT NULL, 
	[EmployeeId] INT FOREIGN KEY REFERENCES[Employees]([Id]), 
	[DateOccupied] DATETIME2, 
	[AccountNumber] CHAR(10), 
	[RoomNumber] INT FOREIGN KEY REFERENCES[Rooms]([RoomNumber]), 
	[RateApplied] VARCHAR(50),  
	[PhoneCharge] VARCHAR(50), 
	[Notes] VARCHAR(100)
)

--Task 19
USE SoftUni

SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees

--Task 20
SELECT * FROM Towns
ORDER BY [Name] ASC
SELECT * FROM Departments
ORDER BY [Name] ASC
SELECT * FROM Employees
ORDER BY [Salary] DESC

--Task 21
SELECT [Name] FROM Towns
ORDER BY  [Name] ASC
SELECT [Name] FROM Departments
ORDER BY [Name] ASC
SELECT [FirstName], [LastName], [JobTitle], [Salary] FROM Employees
ORDER BY [Salary] DESC

--Task 22
UPDATE Employees
	SET [Salary] = [Salary] + [Salary]*0.1

SELECT [Salary] FROM Employees

--Task 23
USE Hotel

UPDATE [Payments]
	SET [TaxRate] = [TaxRate] - [TaxRate]*0.03
SELECT [TaxRate] FROM [Payments]