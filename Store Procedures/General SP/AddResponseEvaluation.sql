-- Add response to evaluation
CREATE OR ALTER PROCEDURE dbo.AddResponse
	@idEvaluation INT,
	@idEmployee INT,
	@idUser INT,
	@description VARCHAR(500)
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @idUserEmployee INT;

		-- Determine the idUserXEmployee of the employee
		SELECT @idUserEmployee = idUserxEmployee 
		FROM UserxEmployee 
		WHERE idUser=@idEmployee

		INSERT INTO ResponseEV(idEvaluation, idEmployee, idUser, dateResp,description)
		VALUES (@idEvaluation, @idUserEmployee, @idUser, GETDATE(), @description);
	END TRY
	BEGIN CATCH
		PRINT 'Error when inserting';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC AddResponse
@idEvaluation = 2,
@idEmployee = 11,
@idUser = 5,
@description = 'Thank you for your review. Im sorry to hear you had a frustrating experience, but I really appreciate you bringing this issue to my attention';

SELECT * FROM ResponseEV
DELETE FROM ResponseEV WHERE idEmployee=1

