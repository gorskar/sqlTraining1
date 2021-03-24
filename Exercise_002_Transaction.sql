-- 002 Transaction Exercise
--
-- Create a Stored procedure "uspProductListPriceUpdate" that takes 3 parameters @ProductId, @NewPrice
--
-- The procedure should 
-- 1) Update the ListPrice of the Product to @NewPrice
-- 2) Set the Enddate and Modified of the Entry in ProductListPriceHistory to TODAY's date -> SELECT CAST(GETDATE() AS DATE)
-- 3) Create a new Entry in the ProductListPriceHistory, with a StartDate And ModifiedDate of Today's date, and a NULL EndDate
--
-- That should all be in a transaction, so if anything goes wrong the whole transaction is rolled back





















































































/*
CREATE PROC dbo.uspProductListPriceUpdate
	@ProductId INT,
	@NewPrice MONEY
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @result INT = 0
	DECLARE @today DATE
	SELECT @today = CAST(GETDATE() AS DATE)

	BEGIN TRAN
	BEGIN TRY
		 UPDATE Production.Product
		 SET ListPrice = @NewPrice WHERE ProductID = @ProductId

		 UPDATE Production.ProductListPriceHistory
		 SET EndDate = @today, ModifiedDate = @today WHERE ProductID = @ProductId AND EndDate IS NULL

		 INSERT Production.ProductListPriceHistory (ProductID, StartDate, EndDate, ListPrice, ModifiedDate)
		 VALUES (@ProductId, @today, NULL, @NewPrice, @today)

		 COMMIT TRAN
		 SET @result = 1
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN;
		THROW
	END CATCH


	RETURN @result
END

GO
*/