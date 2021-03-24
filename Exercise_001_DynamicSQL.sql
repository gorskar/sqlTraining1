-- 001 Dynamic SQL Exercise
--
-- Get the number or rows in every table in the database.
-- The results should look like this...
--
-- TABLE_SCHEMA		TABLE_NAME					NumRows
-- dbo				AWBuildVersion				1
-- dbo				DatabaseLog					1596
-- dbo				ErrorLog					0
-- HumanResources	Department					16
-- HumanResources	Employee					290
-- HumanResources	EmployeeDepartmentHistory	296
-- HumanResources	EmployeePayHistory			316
-- HumanResources	JobCandidate				13
-- HumanResources	Shift						3
-- Person			Address						19614
-- Person			AddressType					6
-- Person			BusinessEntity				20778
--
-- etc
--
-- You'll need to iterate through all the tables in the DB,
-- (using a WHILE loop or a CURSOR)
-- and inside the WHILE or CURSOR build a dynamic SQL query that SELECTS the count from that table
-- 
-- There are several ways this could be accomplished.
-- 1) You could have the dynamic SQL update data in a temp table in each iteration
-- 2) You could have the dynamic SQL output the count in an OUTPUT variable in each iteration (and then update your TABLE variable/TEMP table afterwards)
-- 3) You could use dynamic SQL to build a massive UNION statement, and then just execute it as one at the end to get the results...

-- In all 3 cases, this is a good start (although not necessary if you prefer a cursor I guess).... You could use a TEMP table instead of this table variable if you're taking the 1st approach.
--
--DECLARE @tTables TABLE(TableIndex INT IDENTITY(1,1), TABLE_SCHEMA NVARCHAR(128), TABLE_NAME NVARCHAR(128), NumRows INT)

--INSERT @tTables (TABLE_SCHEMA, TABLE_NAME)
--SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'





































-- ANSWER
/*
DECLARE @tTables TABLE(TableIndex INT IDENTITY(1,1), TABLE_SCHEMA NVARCHAR(128), TABLE_NAME NVARCHAR(128), NumRows INT)

INSERT @tTables (TABLE_SCHEMA, TABLE_NAME)
SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'

DECLARE @rn INT
DECLARE @SQL NVARCHAR(MAX)
DECLARE @count INT

SELECT @rn = COUNT(1) FROM @tTables

WHILE @rn > 0 -- easier to count down, as we know when we hit zero have done all the rows. A cursor could be another option.
BEGIN
	
	SELECT @SQL = 'SELECT @c = COUNT(1) FROM [' + TABLE_SCHEMA + '].[' + TABLE_NAME + ']' FROM @tTables WHERE TableIndex = @rn
	EXEC sp_executeSQL @SQL, N'@c INT OUTPUT', @c = @count OUTPUT
	UPDATE @tTables SET NumRows = @count WHERE TableIndex = @rn

	SELECT @rn = @rn - 1
END

SELECT TABLE_SCHEMA, TABLE_NAME, NumRows 
FROM @tTables 
ORDER BY TABLE_SCHEMA, TABLE_NAME

*/