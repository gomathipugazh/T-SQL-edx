--Challenge 1: Logging Errors

--1.Throw an error for non-exsisting orders

DECLARE @SalesOrderID int = 0

-- uncomment the following line to delete an existing record
-- SELECT @SalesOrderID = MIN(SalesOrderID) FROM SalesLT.SalesOrderHeader; 

BEGIN TRY
	IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader
				   WHERE SalesOrderID = @SalesOrderID)
	BEGIN
		-- Throw a custom error if the specified order doesn't exist
		DECLARE @error varchar(25);
		SET @error = 'Order #' + cast(@SalesOrderID as varchar) + ' does not exist';
		THROW 50001, @error, 0
	END
	ELSE
	BEGIN
		DELETE FROM SalesLT.SalesOrderDetail
		WHERE SalesOrderID = @SalesOrderID;

		DELETE FROM SalesLT.SalesOrderHeader
		WHERE SalesOrderID = @SalesOrderID;
	END
END TRY
BEGIN CATCH
	-- 2.Handle error : Catch and print the error
	PRINT  ERROR_MESSAGE();
END CATCH


--Challenge 2: Ensuring Data Consistency

--1.Implementing a transaction

DECLARE @SalesOrderID int = 0

-- uncomment the following line to specify an existing order
-- SELECT @SalesOrderID = MIN(SalesOrderID) FROM SalesLT.SalesOrderHeader; 

BEGIN TRY
	IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader
				   WHERE SalesOrderID = @SalesOrderID)
	BEGIN
		-- Throw a custom error if the specified order doesn't exist
		DECLARE @error varchar(25);
		SET @error = 'Order #' + cast(@SalesOrderID as varchar) + ' does not exist';
		THROW 50001, @error, 0
	END
	ELSE
	BEGIN
	  BEGIN TRANSACTION
		DELETE FROM SalesLT.SalesOrderDetail
		WHERE SalesOrderID = @SalesOrderID;

		-- THROW 50001, 'Unexpected error', 0 --Uncomment to test transaction

		DELETE FROM SalesLT.SalesOrderHeader
		WHERE SalesOrderID = @SalesOrderID;
	  COMMIT TRANSACTION
	END
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
	BEGIN
		-- Rollback the transaction and re-throw the error
		ROLLBACK TRANSACTION;
		THROW;
	END
	ELSE
	BEGIN
		-- Report the error
		PRINT  ERROR_MESSAGE();
	END
END CATCH

