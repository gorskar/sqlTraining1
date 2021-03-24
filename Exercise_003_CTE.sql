-- 003 CTE Exercise


-- Get the most popular product in each category for each year
-- This one is actually fairly involved, and is most easily done using the ROW_NUMBER() Window function (which assigns a sequential number to each row in a result set partitioned/ordered as you choose)
--
-- The results should look like this:

--Year	ProductCategoryName	ProductName							TotalOrdered
--2011	Accessories			Sport-100 Helmet, Blue				360
--2011	Bikes				Road-650 Black, 52					415
--2011	Clothing			Mountain Bike Socks, M				608
--2011	Components			LL Road Frame - Red, 44				185
--2012	Accessories			Sport-100 Helmet, Blue				1519
--2012	Bikes				Road-650 Red, 60					1384
--2012	Clothing			Full-Finger Gloves, L				2380
--2012	Components			ML Mountain Frame - Black, 48		671
--2013	Accessories			Water Bottle - 30 oz.				3913
--2013	Bikes				Mountain-200 Black, 38				1470
--2013	Clothing			AWC Logo Cap						3768
--2013	Components			ML Mountain Handlebars				728
--2014	Accessories			Water Bottle - 30 oz.				2902
--2014	Bikes				Mountain-200 Black, 38				619
--2014	Clothing			AWC Logo Cap						1950
--2014	Components			ML Mountain Frame-W - Silver, 40	278




-- HINT....
-- here is a partial answer
--
--WITH ppy AS
--(
--	SELECT ......
--	FROM Sales.SalesOrderHeader soh
--		JOIN ....
--	GROUP BY psc.ProductCategoryID, d.ProductID, YEAR(soh.OrderDate)
--)
--,
--mp AS
--(
--	SELECT ProductCategoryId, [Year], ProductID, ROW_NUMBER() OVER (PARTITION BY ProductCategoryId, [Year] ORDER BY TotalOrdered DESC) AS [rn]
--	FROM ppy 
--)
-- SELECT ...














































































-- ANSWER
/*

WITH ppy AS
(
	SELECT psc.ProductCategoryID, d.ProductID, YEAR(soh.OrderDate) AS [Year], SUM(d.OrderQty) AS [TotalOrdered] 
	FROM Sales.SalesOrderHeader soh
		JOIN Sales.SalesOrderDetail d ON soh.SalesOrderID = d.SalesOrderID
		JOIN Production.Product p ON d.ProductID = p.ProductID
		JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
	GROUP BY psc.ProductCategoryID, d.ProductID, YEAR(soh.OrderDate)
)
,
mp AS
(
	SELECT ProductCategoryId, [Year], ProductID, ROW_NUMBER() OVER (PARTITION BY ProductCategoryId, [Year] ORDER BY TotalOrdered DESC) AS [rn]
	FROM ppy 
)
SELECT 
	ppy.[Year],
	pc.[Name] AS [ProductCategoryName],
	p.[Name] AS [ProductName],
	ppy.[TotalOrdered]
FROM ppy
	JOIN mp ON ppy.ProductID = mp.ProductID AND ppy.[Year] = mp.[Year] 
	JOIN Production.ProductCategory pc ON ppy.ProductCategoryID = pc.ProductCategoryID
	JOIN Production.Product p ON ppy.ProductID = p.ProductID
WHERE 
	mp.rn = 1
ORDER BY 
	ppy.[Year], pc.[Name]


*/

















































