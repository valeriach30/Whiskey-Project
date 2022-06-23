use SalesDB
go

CREATE OR ALTER PROCEDURE dbo.createInvoice
	@saleId int	
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		--verify if the sale exist
		DECLARE @checkSale INT =(SELECT idSale 
								FROM [SalesDB].[dbo].[Sale] 
								WHERE idSale = @saleId);
		IF(@checkSale is not null)
		BEGIN
			--gets the name and product price
			DECLARE @productId INT = (SELECT idProduct 
									 FROM [SalesDB].[dbo].[Sale]  
									 WHERE idSale = @saleId);

			DECLARE @productName VARCHAR(100) = (SELECT [name] 
												FROM [ProductsDB].[dbo].[Product] 
												WHERE idProduct = @productId);
			DECLARE @productCost float = (SELECT price 
										 FROM [ProductsDB].[dbo].[Product] 
										 WHERE idProduct = @productId);
			
			SELECT @productName AS Product_Name,
			@productCost AS Individual_Price, 
			quantity,deliveryCost, total 
			FROM [SalesDB].[dbo].[Sale]
			WHERE [Sale].idSale = @saleId ;

		END;

	END TRY
	BEGIN CATCH
		PRINT 'Delete Error';
	END CATCH
	SET NOCOUNT OFF
END;
--example
EXEC createInvoice @saleId=12