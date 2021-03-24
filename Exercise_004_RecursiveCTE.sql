-- 004 Recursive CTE Exercise

-- Create a Recursive CTE that selects the first 50 Triangular numbers
-- Triangular numbers are the sequence 1, 3, 6, 10, 15, 21 etc
--
-- ie the first is 1, the 2nd adds 2 to the first (to make 3), the third adds 3 to the 2nd (to make 6), etc etc
-- 














































-- ANSWER
/*
WITH tri AS
(
	SELECT 1 AS [num], 1 AS [sequence]
	UNION ALL
	SELECT
	[num] + [sequence] + 1 AS [num], [sequence] + 1
	FROM tri
	WHERE [sequence] < 50
)
SELECT num FROM tri

*/