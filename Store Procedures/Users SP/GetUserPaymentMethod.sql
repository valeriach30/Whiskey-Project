USE GeneralDB
GO;

-- Get the payment method of a user
CREATE OR ALTER PROCEDURE dbo.GetUserPayment
	@inidUserxPlace INT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @idUser INT, @idCode INT;
		
		SELECT @idUser = idUser, @idCode = idCode
		FROM [GeneralDB].[dbo].[UserxPlace] 
		WHERE idUserxPlace = @inidUserxPlace;

		-- User does not exist
		IF(@idUser IS NULL) 
		BEGIN
			SELECT 'None';
		END;

		-- User exist
		ELSE
		BEGIN
			-- User is from Ireland, get the data from there
			IF(@idCode = 1)
			BEGIN
				SELECT [PaymentInfo].accountNumber 
				FROM [IrelandDB].[dbo].[User]
				INNER JOIN [IrelandDB].[dbo].[PaymentInfo] 
				ON [User].idPaymentInfo = [PaymentInfo].idPaymentInfo
				WHERE idUser = @idUser;
			END;
			ELSE
			BEGIN
				-- User is from Scotland, get the data from there
				IF(@idCode = 2)
				BEGIN
					SELECT [PaymentInfo].accountNumber 
					FROM [ScotlandDB].[dbo].[User]
					INNER JOIN [ScotlandDB].[dbo].[PaymentInfo] 
					ON [User].idPaymentInfo = [PaymentInfo].idPaymentInfo
					WHERE idUser = @idUser;
				END;
				ELSE
				BEGIN
					-- User is from the United States, get the data from there
					IF(@idCode = 3)
					BEGIN;
						SELECT [PaymentInfo].accountNumber 
						FROM [UnitedStatesDB].[dbo].[User]
						INNER JOIN [UnitedStatesDB].[dbo].[PaymentInfo] 
						ON [User].idPaymentInfo = [PaymentInfo].idPaymentInfo
						WHERE idUser = @idUser;
					END;
					ELSE
					BEGIN
						SELECT 'None';
					END;
				END;
			END;
		END;
	END TRY
	BEGIN CATCH
			PRINT 'Error ocurred while searching the payment method';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC GetUserPayment 1;