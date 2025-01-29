--Task 1
CREATE DATABASE EXERCISE3 
USE EXERCISE3 

CREATE TABLE [Persons](
	[PersonID] INT,
	[FirstName] VARCHAR(64),
	[Salary] MONEY,
	[PassportID] INT
)

CREATE TABLE Passports(
	[PassportID] INT,
	[PassportNumber] VARCHAR(64)
)

INSERT INTO [Persons]
     VALUES (1, 'Roberto', 43300, 102),
	        (2, 'Tom', 56100, 103),
			(3, 'Yana', 60200, 101)

INSERT INTO [Passports]
	 VALUES (101, 'N34FG21B'),
	        (102, 'K65LO4R7'),
			(103, 'ZE657QP2')

ALTER TABLE [Persons]
ALTER COLUMN PersonID 
         INT NOT NULL

   ALTER TABLE [Persons]
ADD CONSTRAINT PK_Persons_PersonID 
   PRIMARY KEY (PersonID)

 ALTER TABLE [Passports]
ALTER COLUMN PassportID 
         INT NOT NULL

   ALTER TABLE [Passports]
ADD CONSTRAINT PK_Passports_PassportID 
   PRIMARY KEY (PassportID)

   ALTER TABLE [Persons]
ADD CONSTRAINT FK_Persons_Passports 
   FOREIGN KEY (PassportID) 
    REFERENCES [Passports](PassportID)

   ALTER TABLE [Persons]
ADD CONSTRAINT UQ_Person_PassportID UNIQUE (PassportID)

--Task 2

CREATE TABLE [Manufacturers](
	[ManufacturerID] INT PRIMARY KEY,
	[Name] VARCHAR(64) NOT NULL,
	[EstablishedOn] DATETIME
)

CREATE TABLE [Models](
	[ModelID] INT PRIMARY KEY,
	[Name] VARCHAR(64) NOT NULL,
	[ManufacturerID] INT FOREIGN KEY REFERENCES [Manufacturers]([ManufacturerID])
)

INSERT INTO [Manufacturers]
     VALUES (1, 'BMW', 07/03/1916),
	        (2, 'Tesla', 01/01/2003),
			(3, 'Lada', 01/05/1966)

INSERT INTO [Models]
     VALUES (101, 'X1', 1),
	        (102, 'i6', 1),
			(103, 'Model S', 2),	
			(104, 'Model X', 2),
			(105, 'Model 3', 2),
			(106, 'Nova', 3)

--Task 3
CREATE TABLE [Students](
	[StudentID] INT PRIMARY KEY,
	[Name] VARCHAR(64) NOT NULL
)

CREATE TABLE [Exams](
	[ExamID] INT PRIMARY KEY,
	[Name] VARCHAR(64) NOT NULL
)

CREATE TABLE [StudentsExams](
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]),
	[ExamID] INT FOREIGN KEY REFERENCES [Exams]([ExamID]),
	CONSTRAINT [PK_Students_Exams] PRIMARY KEY ([StudentID], [ExamID])
)

INSERT INTO [Students]
     VALUES (1, 'Mila'),
	        (2, 'Toni'),
			(3, 'Ron')

INSERT INTO [Exams]
     VALUES (101, 'SpringMVC'),
	        (102, 'Neo4j'),
			(103, 'Oracle 11g')

INSERT INTO [StudentsExams]
     VALUES (1, 101),
	        (1, 102),
			(2, 101),
			(3, 103)

--Task 4
CREATE TABLE [Teachers](
	[TeacherID] INT PRIMARY KEY,
	[Name] VARCHAR(64),
	[ManagerID] INT FOREIGN KEY REFERENCES [Teachers]([TeacherID])
)

INSERT INTO [Teachers]
     VALUES (101, 'John', NULL),
	        (102, 'Maya', 106),
			(103, 'Silvia', 106),
			(104, 'Ted', 105),
			(105, 'Mark', 105),
			(106, 'Greta', 101)

--Task 5
CREATE DATABASE [Online Store]
USE [Online Store]

CREATE TABLE [ItemTypes](
	[ItemTypeID] INT PRIMARY KEY,
	[Name] VARCHAR(64)
)

CREATE TABLE [Items](
	[ItemID] INT PRIMARY KEY,
	[Name] VARCHAR(64),
	[ItemTypeID] INT FOREIGN KEY REFERENCES [ItemTypes]([ItemTypeID])
)

CREATE TABLE [Cities](
	[CityID] INT PRIMARY KEY,
	[Name] VARCHAR(64)
)

CREATE TABLE [Customers](
	[CustomerID] INT PRIMARY KEY,
	[Name] VARCHAR(64),
	[Birthday] DATETIME2,
	[CityID] INT FOREIGN KEY REFERENCES [Cities]([CityID])
)

CREATE TABLE [Orders](
	[OrderID] INT PRIMARY KEY,
	[CustomerID] INT FOREIGN KEY REFERENCES [Customers]([CustomerID])
)

CREATE TABLE [OrderItems](
	[OrderID] INT FOREIGN KEY REFERENCES [Orders]([OrderID]),
	[ItemID] INT FOREIGN KEY REFERENCES [Items]([ItemID])
	CONSTRAINT PK_Order_Items PRIMARY KEY ([OrderID], [ItemID])
)

--Task 6
CREATE DATABASE [University]
USE [University]

CREATE TABLE [Majors](
	[MajorID] INT PRIMARY KEY,
	[Name] VARCHAR(64)
)

CREATE TABLE [Students](
	[StudentID] INT PRIMARY KEY,
	[StudentNumber] VARCHAR(10),
	[StudentName] VARCHAR(64),
	[MajorID] INT FOREIGN KEY REFERENCES [Majors]([MajorID])
)

CREATE TABLE [Subjects](
	[SubjectID] INT PRIMARY KEY,
	[SubjectName] VARCHAR(64)
)

CREATE TABLE [Agenda](
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]),
	[SubjectID] INT FOREIGN KEY REFERENCES [Subjects]([SubjectID]),
	CONSTRAINT PK_StudentID_SubjectID PRIMARY KEY ([StudentID],[SubjectID])
)

CREATE TABLE [Payments](
	[PaymentaID] INT PRIMARY KEY,
	[PaymentDate] DATETIME2,
	[PaymentAmount] INT,
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID])
)

--Task 9*
USE Geography
  SELECT M.[MountainRange], P.[PeakName], P.[Elevation]
    FROM [Mountains] AS M JOIN [Peaks] AS P 
      ON M.Id = P.MountainId
   WHERE M.[MountainRange] = 'Rila'
ORDER BY P.[Elevation] DESC