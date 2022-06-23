-- Add review
CREATE OR ALTER PROCEDURE dbo.AddReview
	@idProduct INT,
	@idUser INT,
	@comment VARCHAR(500)
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		INSERT INTO Review(idProduct, idUser, comment, RevDate)
		VALUES (@idProduct, @idUser, @comment, GETDATE());
	END TRY
	BEGIN CATCH
		PRINT 'Add review error';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC AddReview
@idProduct = 11,
@idUser = 16,
@comment = 'It’s my absolute favorite drink, second to none. Great flavor, smooth and satisfying.';

 SELECT * FROM Review 