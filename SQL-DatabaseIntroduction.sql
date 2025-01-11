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
