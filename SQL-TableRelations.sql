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