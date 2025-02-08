CREATE DATABASE [ShoesApplicationDatabase]

USE [ShoesApplicationDatabase]

--Task 1

CREATE TABLE [Users](
	[Id] INT PRIMARY KEY IDENTITY,
	[Username] NVARCHAR(50) UNIQUE NOT NULL,
	[FullName] NVARCHAR(100) NOT NULL,
	[PhoneNumber] NVARCHAR(15),
	[Email] NVARCHAR(100) UNIQUE NOT NULL
)

CREATE TABLE [Brands](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) UNIQUE NOT NULL
)

CREATE TABLE [Sizes] (
	[Id] INT PRIMARY KEY IDENTITY,
	[EU] DECIMAL(5, 2) NOT NULL,
	[US] DECIMAL(5, 2) NOT NULL,
	[UK] DECIMAL(5, 2) NOT NULL,
	[CM] DECIMAL(5, 2) NOT NULL,
	[IN] DECIMAL(5, 2) NOT NULL
)

CREATE TABLE [Shoes](
	[Id] INT PRIMARY KEY IDENTITY,
	[Model] NVARCHAR(30) NOT NULL,
	[Price] DECIMAL(10, 2) NOT NULL,
	[BrandId] INT FOREIGN KEY REFERENCES [Brands]([Id]) NOT NULL
)

CREATE TABLE [ShoesSizes](
	[ShoeId] INT FOREIGN KEY REFERENCES [Shoes]([Id]) NOT NULL,
	[SizeId] INT FOREIGN KEY REFERENCES [Sizes]([Id]) NOT NULL,
	PRIMARY KEY ([ShoeId], [SizeId])
)

CREATE TABLE [Orders](
	[Id] INT PRIMARY KEY IDENTITY,
	[ShoeId] INT FOREIGN KEY REFERENCES [Shoes]([Id]) NOT NULL,
	[SizeId] INT FOREIGN KEY REFERENCES [Sizes]([Id]) NOT NULL,
	[UserId] INT FOREIGN KEY REFERENCES [Users]([Id]) NOT NULL
)

--Task 2
INSERT INTO [Brands]([Name])
     VALUES ('Timberland'),
	        ('Birkenstock')

INSERT INTO [Shoes]([Model], [Price], [BrandId])
     VALUES ('Reaxion Pro', 150.00, 12),
	        ('Laurel Cort Lace-Up', 160.00, 12),
			('Perkins Row Sandal', 170.00, 12),
			('Arizona', 80.00, 13),
			('Ben Mid Dip', 85.00, 13),
			('Gizeh', 90.00, 13)

INSERT INTO [ShoesSizes]([ShoeId], [SizeId])
     VALUES (70, 1),
	        (70, 2),
			(70, 3),
			(71, 2),
			(71, 3),
			(71, 4),
			(72, 4),
			(72, 5),
			(72, 6),
			(73, 1),
			(73, 3),
			(73, 5),
			(74, 2),
			(74, 4),
			(74, 6),
			(75, 1),
			(75, 2),
			(75, 3)


INSERT INTO [Orders]([ShoeId], [SizeId], [UserId])
     VALUES (70, 2, 15),
	        (71, 3, 17),
			(72, 6, 18),
			(73, 5, 4),
			(74, 4, 7),
			(75, 1, 11)

--Task 3
UPDATE [Shoes]
SET [Price] = [Price] + [Price] * 0.15
WHERE [BrandId] IN ( 
                     SELECT [Id]
		               FROM [Brands]
		              WHERE [Name] = 'Nike'
                   )

--Task 4
DELETE 
  FROM [Orders]
 WHERE [ShoeId] IN (
                      SELECT [Id]  
					    FROM [Shoes]
					   WHERE [Model] = 'Joyride Run Flyknit'
                   )
DELETE 
  FROM [ShoesSizes]
 WHERE [ShoeId] IN (
                      SELECT [Id]  
					    FROM [Shoes]
					   WHERE [Model] = 'Joyride Run Flyknit'
                   )
DELETE  
  FROM [Shoes]
 WHERE [Model] = 'Joyride Run Flyknit'

--Task 5
   SELECT [S].[Model] 
       AS [ShoeModel],
	      [S].[Price]
     FROM [Orders]
	   AS [O]
LEFT JOIN [Shoes]
       AS [S]
	   ON [S].[Id] = [O].[ShoeId]
ORDER BY [S].[Price] DESC,
         [S].[Model] ASC

--Task 6
   SELECT [B].[Name]
       AS [BrandName],
	      [S].[Model]
	   AS [ShoeModel]
     FROM [Shoes]
       AS [S]
LEFT JOIN [Brands]
       AS [B]
       ON [B].[Id] = [S].[BrandId]
 ORDER BY [B].[Name] ASC,
          [S].[Model] ASC

--Task 7
  SELECT 
 TOP (10) [U].[Id]
       AS [UserId],
	      [U].[FullName],
		  SUM([S].[Price])
	   AS [TotalSpent]
     FROM [Users] 
       AS [U]
LEFT JOIN [Orders]
       AS [O]
       ON [U].[Id] = [O].[UserId]
LEFT JOIN [Shoes]
       AS [S]
	   ON [S].[Id] = [O].[ShoeId]
 GROUP BY [U].[Id],
          [U].[FullName]
 ORDER BY [TotalSpent] DESC,
          [U].[FullName] ASC

--Task 8
   SELECT [U].[Username],
	      [U].[Email],
		  CAST(AVG([S].[Price]) AS DECIMAL(10,2))
	   AS [AvgPrice]
     FROM [Users] 
       AS [U]
LEFT JOIN [Orders]
       AS [O]
       ON [U].[Id] = [O].[UserId]
LEFT JOIN [Shoes]
       AS [S]
	   ON [S].[Id] = [O].[ShoeId]
 GROUP BY [U].[Username],
	      [U].[Email]
   HAVING COUNT([O].[Id]) > 2
 ORDER BY [AvgPrice] DESC

--Task 9
   SELECT [S].[Model],
          COUNT([SS].[Id])
	   AS [CountOfSizes],
	      [B].[Name]
	   AS [BrandName]
     FROM [Shoes]
       AS [S]
LEFT JOIN [Brands]
       AS [B]
       ON [B].[Id] = [S].[BrandId]
LEFT JOIN [ShoesSizes] 
       AS [SZ]
	   ON [S].[Id] = [SZ].[ShoeId]
LEFT JOIN [Sizes]
       AS [SS]
	   ON [SS].[Id] = [SZ].[SizeId]
    WHERE [S].[Model] LIKE '%Run%'
	  AND [B].[Name] = 'Nike'
 GROUP BY [S].[Model],
          [B].[Name]
   HAVING COUNT([SS].[Id]) > 5
 ORDER BY [S].[Model] DESC

--Task 10
   SELECT [U].[FullName],
          [U].[PhoneNumber],
		  [S].[Price]
	   AS [OrderPrice],
	      [S].[Id]
	   AS [ShoeId],
	      [B].[Id]
	   AS [BrandId],
	      CONCAT_WS('/', CONCAT([SS].[EU], 'EU'), CONCAT([SS].[US], 'US'), CONCAT([SS].[UK], 'UK'))
       AS [ShoeSize]
     FROM [Users]
       AS [U]
LEFT JOIN [Orders]
       AS [O]
	   ON [O].[UserId] = [U].[Id]
LEFT JOIN [Shoes]
       AS [S]
	   ON [S].[Id] = [O].[ShoeId]
LEFT JOIN [Brands] 
       AS [B]
	   ON [B].[Id] = [S].[BrandId]
LEFT JOIN [ShoesSizes] 
       AS [SZ]
	   ON [SZ].[ShoeId] = [S].[Id] AND [SZ].[SizeId] = [O].[SizeId] 
LEFT JOIN [Sizes]
       AS [SS]
	   ON [SS].[Id] = [SZ].[SizeId] 
    WHERE [U].[PhoneNumber] LIKE '%345%'
 ORDER BY [S].[Model] ASC

--Task 11
CREATE OR ALTER FUNCTION [udf_OrdersByEmail](@email NVARCHAR(100))
RETURNS INT 
AS
BEGIN 
     DECLARE @result INT;
         SELECT @result = COUNT(*)
	       FROM [Orders]
	         AS [O]
	  LEFT JOIN [Users]
	         AS [U]
	         ON [U].[Id] = [O].[UserId]
	      WHERE [U].[Email] = @email
     RETURN @result
END