-- Add Evaluation
CREATE OR ALTER PROCEDURE dbo.AddEvaluation
	@idProduct INT,
	@idUser INT,
	@idDeliever INT,
	@idSeller INT,
	@calification INT,
	@comment VARCHAR(500)
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		INSERT INTO Evaluation(idProduct, idUser, idDelieveryPerson, idSeller, comment, evDate, calification)
		VALUES (@idProduct, @idUser, @idDeliever, @idSeller, @comment, GETDATE(), @calification);
	END TRY
	BEGIN CATCH
		PRINT 'Add evaluation error';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC AddEvaluation
@idProduct =17,
@idUser = 10,
@idDeliever = 9,
@idSeller = 1, 
@calification = 10,
@comment = 'Excelente service from everyone';

SELECT * FROM Evaluation