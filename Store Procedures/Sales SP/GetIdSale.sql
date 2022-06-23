use SalesDB
go

CREATE OR ALTER PROCEDURE dbo.GetIdSale
	@productId int,
	@idUser int
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		SELECT TOP 1 idSale 
		FROM Sale 
		WHERE idProduct = @productId AND idUser = @idUser
		ORDER BY idSale DESC
	END TRY
	BEGIN CATCH
		PRINT 'Delete Error';
	END CATCH
	SET NOCOUNT OFF
END;
EXEC GetIdSale @productId =54, @idUser=15
EXEC GetIdSale @productId = 22, @idUser = 40;
SELECT * FROM Sale