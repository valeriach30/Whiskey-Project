USE GeneralDB
GO;

-- Get the locations of a user
CREATE OR ALTER PROCEDURE dbo.ModifyPayment
	@inidUserxPlace INT,
	@inNameOnCard VARCHAR(60),
	@inAccountNumber BIGINT,
	@inExpirationDate DATE,
	@inCVV INT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @idUser INT, @idCode INT, @idPaymentInfo INT, @IdPayment INT;
		
		SELECT @idUser = idUser, @idCode = idCode
		FROM [GeneralDB].[dbo].[UserxPlace] 
		WHERE idUserxPlace = @inidUserxPlace;

		-- User does not exist
		IF(@idUser IS NULL) 
		BEGIN
			SELECT '0';
		END;
		
		-- User exists
		ELSE
		BEGIN
			-- User is from Ireland, get the data from there
			IF(@idCode = 1)
			BEGIN
				-- Determine if the user has a payment info
				SELECT @idPaymentInfo = [PaymentInfo].idPaymentInfo 
				FROM [IrelandDB].[dbo].[PaymentInfo]
				INNER JOIN [IrelandDB].[dbo].[User] 
				ON [User].idPaymentInfo = [PaymentInfo].idPaymentInfo
				WHERE idUser = @idUser;

				IF(@idPaymentInfo IS NOT NULL)
				BEGIN
					UPDATE [PaymentInfo]
					SET 
						nameOnCard = @inNameOnCard,
						accountNumber = @inAccountNumber,
						expirationDate = @inExpirationDate,
						CVV = @inCVV
					FROM [IrelandDB].[dbo].[User]
					INNER JOIN [IrelandDB].[dbo].[PaymentInfo] 
					ON [User].idPaymentInfo = [PaymentInfo].idPaymentInfo
					WHERE idUser = @idUser;
					SELECT '1';
				END;
				ELSE
				BEGIN
					-- Insert payment method
					INSERT INTO [IrelandDB].[dbo].[PaymentInfo](nameOnCard, accountNumber, expirationDate, CVV)
					VALUES (@inNameOnCard, @inAccountNumber, @inExpirationDate, @inCVV);
					
					-- Get the id of the inserted payment method
					SELECT TOP 1 @IdPayment =  [PaymentInfo].idPaymentInfo
					FROM [IrelandDB].[dbo].[PaymentInfo]
					ORDER BY idPaymentInfo DESC

					-- Update the info of the user
					UPDATE [User]
					SET 
						idPaymentInfo = @IdPayment
					FROM [IrelandDB].[dbo].[User]
					WHERE idUser = @idUser;
					
					-- Success
					SELECT '1';
				END;
			END;
			ELSE
			BEGIN
				-- User is from Scotland, get the data from there
				IF(@idCode = 2)
				BEGIN
					-- Determine if the user has a payment info
					SELECT @idPaymentInfo = [PaymentInfo].idPaymentInfo 
					FROM [ScotlandDB].[dbo].[PaymentInfo]
					INNER JOIN [ScotlandDB].[dbo].[User] 
					ON [User].idPaymentInfo = [PaymentInfo].idPaymentInfo
					WHERE idUser = @idUser;

					IF(@idPaymentInfo IS NOT NULL)
					BEGIN
						UPDATE [PaymentInfo]
						SET 
							nameOnCard = @inNameOnCard,
							accountNumber = @inAccountNumber,
							expirationDate = @inExpirationDate,
							CVV = @inCVV
						FROM [ScotlandDB].[dbo].[User]
						INNER JOIN [ScotlandDB].[dbo].[PaymentInfo] 
						ON [User].idPaymentInfo = [PaymentInfo].idPaymentInfo
						WHERE idUser = @idUser;
						SELECT '1';
					END;
					ELSE
					BEGIN
						-- Insert payment method
						INSERT INTO [ScotlandDB].[dbo].[PaymentInfo](nameOnCard, accountNumber, expirationDate, CVV)
						VALUES (@inNameOnCard, @inAccountNumber, @inExpirationDate, @inCVV);
						
						-- Get the id of the inserted payment method
						SELECT TOP 1 @IdPayment =  [PaymentInfo].idPaymentInfo
						FROM [ScotlandDB].[dbo].[PaymentInfo]
						ORDER BY idPaymentInfo DESC
						
						PRINT @IdPayment;
						PRINT '------------------'
						PRINT @idUser;
						-- Update the info of the user
						UPDATE [User]
						SET 
							idPaymentInfo = @IdPayment
						FROM [ScotlandDB].[dbo].[User]
						WHERE idUser = @idUser;
					
						-- Success
						SELECT '1';
					END;
				END;
				ELSE
				BEGIN
					-- User is from the United States, get the data from there
					IF(@idCode = 3)
					BEGIN;
						-- Determine if the user has a payment info
						SELECT @idPaymentInfo = [PaymentInfo].idPaymentInfo 
						FROM [UnitedStatesDB].[dbo].[PaymentInfo]
						INNER JOIN [UnitedStatesDB].[dbo].[User] 
						ON [User].idPaymentInfo = [PaymentInfo].idPaymentInfo
						WHERE idUser = @idUser;

						IF(@idPaymentInfo IS NOT NULL)
						BEGIN
							UPDATE [PaymentInfo]
							SET 
								nameOnCard = @inNameOnCard,
								accountNumber = @inAccountNumber,
								expirationDate = @inExpirationDate,
								CVV = @inCVV
							FROM [UnitedStatesDB].[dbo].[User]
							INNER JOIN [UnitedStatesDB].[dbo].[PaymentInfo] 
							ON [User].idPaymentInfo = [PaymentInfo].idPaymentInfo
							WHERE idUser = @idUser;
							SELECT '1';
						END;
						ELSE
						BEGIN
							-- Insert payment method
							INSERT INTO [UnitedStatesDB].[dbo].[PaymentInfo](nameOnCard, accountNumber, expirationDate, CVV)
							VALUES (@inNameOnCard, @inAccountNumber, @inExpirationDate, @inCVV);
					
							-- Get the id of the inserted payment method
							SELECT TOP 1 @IdPayment =  [PaymentInfo].idPaymentInfo
							FROM [IrelandDB].[dbo].[PaymentInfo]
							ORDER BY idPaymentInfo DESC


							-- Update the info of the user
							UPDATE [User]
							SET 
								idPaymentInfo = @IdPayment
							FROM [UnitedStatesDB].[dbo].[User]
							WHERE idUser = @idUser;
					
							-- Success
							SELECT '1';
						END;
					END;
					ELSE
					BEGIN
						SELECT '0';
					END;
				END;
			END;
		END;
	END TRY
	BEGIN CATCH
			PRINT 'Error ocurred while modifying the product';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC ModifyPayment
	@inidUserxPlace = 49,
	@inNameOnCard = 'Daniela Rojas',
	@inAccountNumber = 4568956761276446,
	@inExpirationDate = '2023-12-30',
	@inCVV =556;

SELECT * FROM ScotlandDB.dbo.PaymentInfo
