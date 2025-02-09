CREATE DATABASE [EuroLeagues]

USE [EuroLeagues]

--Task 1
CREATE TABLE [Players](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL,
	[Position] NVARCHAR(20) NOT NULL
)

CREATE TABLE [PlayerStats](
	[PlayerId] INT FOREIGN KEY REFERENCES [Players]([Id]) NOT NULL,
	[Goals] INT DEFAULT 0 NOT NULL,
	[Assists] INT DEFAULT 0 NOT NULL
	PRIMARY KEY ([PlayerId])
)

CREATE TABLE [Leagues](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Teams](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) UNIQUE NOT NULL,
	[City] NVARCHAR(50) NOT NULL,
	[LeagueId] INT FOREIGN KEY REFERENCES [Leagues]([Id]) NOT NULL
)

CREATE TABLE [TeamStats](
	[TeamId] INT FOREIGN KEY REFERENCES [Teams]([Id]) NOT NULL,
	[Wins] INT DEFAULT 0 NOT NULL,
	[Draws] INT DEFAULT 0 NOT NULL,
	[Losses] INT DEFAULT 0 NOT NULL,
	PRIMARY KEY ([TeamId])
)

CREATE TABLE [PlayersTeams](
	[PlayerId] INT FOREIGN KEY REFERENCES [Players]([Id]) NOT NULL,
	[TeamId] INT FOREIGN KEY REFERENCES [Teams]([Id]) NOT NULL,
	PRIMARY KEY ([PlayerId], [TeamId])
)

CREATE TABLE [Matches](
	[Id] INT PRIMARY KEY IDENTITY,
	[HomeTeamId] INT FOREIGN KEY REFERENCES [Teams]([Id]) NOT NULL,
	[AwayTeamId] INT FOREIGN KEY REFERENCES [Teams]([Id]) NOT NULL,
	[MatchDate] DATETIME2 NOT NULL,
	[HomeTeamGoals] INT DEFAULT 0 NOT NULL,
	[AwayTeamGoals] INT DEFAULT 0 NOT NULL,
	[LeagueId] INT FOREIGN KEY REFERENCES [Leagues]([Id]) NOT NULL
)

--Task 2
INSERT INTO [Leagues] ([Name])
     VALUES ('Eredivisie')

INSERT INTO [Teams] ([Name], [City], [LeagueId])
     VALUES ('PSV', 'Eindhoven', 6),
	        ('Ajax', 'Amsterdam', 6)

INSERT INTO [Players] ([Name], [Position])
     VALUES ('Luuk de Jong', 'Forward'),
	        ('Josip Sutalo', 'Defender')

INSERT INTO [PlayerStats]([PlayerId], [Goals], [Assists])
     VALUES (2305, 2, 0),
	        (2306, 2, 0)

INSERT INTO [TeamStats]([TeamId], [Wins], [Draws], [Losses])
     VALUES (97, 15, 1, 3),
	        (98, 14, 3, 2)

INSERT INTO [PlayersTeams]([PlayerId], [TeamId])
     VALUES (2305, 97),
	        (2306, 98)

INSERT INTO [Matches]([HomeTeamId], [AwayTeamId], 
[MatchDate], [HomeTeamGoals], [AwayTeamGoals], [LeagueId])
     VALUES (98, 97, '2024-11-02 20:45:00', 3, 2, 6)

--Task 3
    UPDATE [PS]
       SET [PS].[Goals] +=  1
      FROM [PlayerStats]
	    AS [PS]
INNER JOIN [Players] 
        AS [P] 
		ON [PS].[PlayerId] = [P].[Id]
INNER JOIN [PlayersTeams]
        AS [PT] 
		ON [P].[Id] = [PT].[PlayerId]
INNER JOIN [Teams] 
        AS [T] 
		ON [PT].[TeamId] = [T].[Id]
INNER JOIN [Leagues] 
        AS [L] ON [T].[LeagueId] = [L].[Id]
     WHERE [P].[Position] = 'Forward' 
	   AND [L].[Name] = 'La Liga'
 
--Task 4
DELETE 
  FROM [PlayersTeams]
 WHERE [TeamId] IN (
                       SELECT [T].[Id]
						 FROM [Teams]
						   AS [T]
					LEFT JOIN [Leagues]
						   AS [L]
						   ON [L].[Id] = [T].[LeagueId]
						WHERE [L].[Name] = 'Eredivisie'
                   )
DELETE
  FROM [Teams]
 WHERE [LeagueId] IN (
                       SELECT [Id]
						 FROM [Leagues]
						WHERE [Name] = 'Eredivisie'
                     )
DELETE 
  FROM [Players]
 WHERE [Name] IN ('Luuk de Jong', 'Josip Sutalo')

--Task 5
  SELECT FORMAT([MatchDate], 'yyyy-MM-dd')
      AS [MatchDate],
	     [HomeTeamGoals],
	     [AwayTeamGoals],
	     [HomeTeamGoals] + [AwayTeamGoals]
      AS [TotalGoals]
    FROM [Matches]
   WHERE [HomeTeamGoals] + [AwayTeamGoals] >= 5
ORDER BY [TotalGoals] DESC,
         [MatchDate] ASC

--Task 6
   SELECT [P].[Name],
          [T].[City]
     FROM [Players]
       AS [P]
LEFT JOIN [PlayersTeams]
       AS [PT]
       ON [P].[Id] = [PT].[PlayerId]
LEFT JOIN [Teams] 
       AS [T]
       ON [T].[Id] = [PT].[TeamId]
    WHERE [P].[Name] LIKE '%Aaron%'
 ORDER BY [P].[Name]

--Task 7
   SELECT [P].[Id],
          [P].[Name],
		  [P].[Position]
     FROM [Players]
       AS [P]
LEFT JOIN [PlayersTeams]
       AS [PT]
       ON [P].[Id] = [PT].[PlayerId]
LEFT JOIN [Teams] 
       AS [T]
	   ON [T].[Id] = [PT].[TeamId]
    WHERE [T].[City] = 'London'
 ORDER BY [P].[Name] ASC

--Task 8
 SELECT 
 TOP (10) [T1].[Name]
       AS [HomeTeamName],
	      [T2].[Name] 
       AS [AwayTeamName],
	      [L].[Name]
	   AS [LeagueName],
	      FORMAT([MatchDate], 'yyyy-MM-dd')
       AS [MatchDate]
     FROM [Matches]
       AS [M]
INNER JOIN [Teams]
       AS [T1]
	   ON [T1].[Id] = [M].[HomeTeamId]
INNER JOIN [Teams]
       AS [T2]
	   ON [T2].[Id] = [M].[AwayTeamId]
INNER JOIN [Leagues]
        AS [L]
		ON [L].[Id] = [T1].[LeagueId]
    WHERE [M].[MatchDate] BETWEEN '2024-09-01' AND '2024-09-15'
      AND [L].[Id] % 2  = 0
 ORDER BY [M].[MatchDate] ASC,
          [HomeTeamName] ASC

--Task 9
    SELECT [M].[AwayTeamId] AS [Id],
           [T].[Name],
           COALESCE(SUM(M.AwayTeamGoals), 0) AS TotalAwayGoals
      FROM [Teams] 
	    AS [T]
INNER JOIN [Matches]
        AS [M] 
		ON [M].[AwayTeamId] = [T].[Id]
  GROUP BY [M].[AwayTeamId],
           [T].[Name]
    HAVING COALESCE(SUM([M].[AwayTeamGoals]), 0) >= 6
  ORDER BY [TotalAwayGoals] DESC, 
           [T].[Name] ASC;

--Task 10
    SELECT [L].[Name] 
        AS [LeagueName],
           ROUND(CAST(SUM([M].[HomeTeamGoals] + [M].[AwayTeamGoals]) AS FLOAT) / COUNT([M].[Id]), 2) 
	    AS [AvgScoringRate]
      FROM [Leagues] 
	    AS [L]
INNER JOIN [Matches] 
        AS [M] 
		ON [M].[LeagueId] = [L].[Id]
  GROUP BY [L].[Name]
  ORDER BY [AvgScoringRate] DESC

--Task 11
CREATE FUNCTION [dbo].[udf_LeagueTopScorer](@nameLeague NVARCHAR(50))
RETURNS TABLE AS
 RETURN (
			
			SELECT [PlayerName],
			       [TotalGoals]
			  FROM  (SELECT 
			       [P].[Name] AS [PlayerName],
			       [PS].[Goals] AS [TotalGoals],
			DENSE_RANK() OVER(PARTITION BY [L].[Id] ORDER BY [PS].[Goals] DESC)
            AS [RANKS]
			FROM [Players] AS [P]
			INNER JOIN [PlayerStats] AS [PS]
			ON [P].[Id] = [PS].[PlayerId]
			INNER JOIN [PlayersTeams] AS [PT]
			ON [P].[Id] = [PT].[PlayerId]
			INNER JOIN [Teams] AS [T]
			ON [PT].[TeamId] = [T].[Id]
			INNER JOIN [Leagues] AS [L]
			ON [L].[Id] = [T].[LeagueId]
			WHERE [L].[Name] = @nameLeague
			)
		AS [RankingTempTable]
			WHERE [RANKS] = '1'
         )
--Task 12
CREATE PROCEDURE [usp_SearchTeamsByCity]
@City NVARCHAR(50)
AS
BEGIN
    SELECT [T].[Name] 
		AS [TeamName],
           [L].[Name] 
		AS [LeagueName],
           [T].[City]
      FROM [Teams] 
	    AS [T]
      JOIN [Leagues] 
	    AS [L] 
	    ON [T].[LeagueId] = [L].[Id]
    WHERE [T].[City] = @City
    ORDER BY [T].[Name] ASC;
END