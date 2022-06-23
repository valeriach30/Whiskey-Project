USE GeneralDB
GO;

-- Function that gets the name of a users suscription
CREATE PROCEDURE dbo.ReadSuscripName
	@inidUserxPlace INT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @id INT;

		
		-- If the user is not suscribed then return none
		IF NOT EXISTS(SELECT Suscription.idSuscriptionType
					FROM Suscription
					INNER JOIN SuscriptionType ON SuscriptionType.idSuscriptionType = Suscription.idSuscriptionType
					WHERE Suscription.idUser = @inidUserxPlace
		)
		BEGIN
			SELECT 'None';
		END;
		-- User is suscribed
		ELSE
		BEGIN
			-- Return the name of the suscription
			SELECT SuscriptionType.[name]
			FROM Suscription
			INNER JOIN SuscriptionType ON SuscriptionType.idSuscriptionType = Suscription.idSuscriptionType
			WHERE Suscription.idUser = @inidUserxPlace;
		END;
	END TRY
	BEGIN CATCH
		PRINT 'Error ocurred while reading the suscription name';
	END CATCH
	SET NOCOUNT OFF
END;

EXEC ReadSuscripName @inidUserxPlace = 1;

-- function that detects if a user is subscribed and its type of subscription
CREATE OR ALTER PROCEDURE dbo.ReadTypeSub
	@username  VARCHAR(20)
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @subscribed INT, @userID INT , @typeSubId INT;
		SET @subscribed = (select [User].[suscribed] from [dbo].[User]
							where [User].[username] = @username )
		SET @userID = (select [User].[idUser] from [dbo].[User]
							where [User].[username] = @username )
		if(@subscribed = 0)
			PRINT 'This user has no subscription';
		if(@subscribed = 1)
		BEGIN
			SET @typeSubId = (select [Suscription].[idSuscriptionType] from [GeneralDB].[dbo].[Suscription]
									where @userID = [Suscription].[idUser])

			Select [SuscriptionType].name from [GeneralDB].[dbo].[SuscriptionType]
			where @typeSubId = [SuscriptionType].[idSuscriptionType]
		END;
		
	END TRY
	BEGIN CATCH
		PRINT 'Error ocurred while reading the type of suscription';
	END CATCH
	SET NOCOUNT OFF
END;
EXEC ReadTypeSub @username = 'oscarvilla'; 

--- Suscribe a User 
CREATE OR ALTER PROCEDURE suscribeUser
	@inidUserxPlace		INT,
	@inSuscriptionId	INT
AS BEGIN
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
			-- Add user to suscription table
			INSERT INTO Suscription(idUser, idSuscriptionType)
			VALUES (@idUser, @inSuscriptionId);

			-- User is from Ireland, update user there
			IF(@idCode = 1)
			BEGIN
				UPDATE [IrelandDB].[dbo].[User]
				SET
					suscribed = 1
				FROM [IrelandDB].[dbo].[User]
				INNER JOIN [IrelandDB].[dbo].[PaymentInfo] 
				ON [User].idPaymentInfo = [PaymentInfo].idPaymentInfo
				WHERE idUser = @idUser;
			END;
			ELSE
			BEGIN
				-- User is from Scotland, update user there
				IF(@idCode = 2)
				BEGIN
					UPDATE [ScotlandDB].[dbo].[User]
					SET
						suscribed = 1
					FROM [ScotlandDB].[dbo].[User]
					INNER JOIN [ScotlandDB].[dbo].[PaymentInfo] 
					ON [User].idPaymentInfo = [PaymentInfo].idPaymentInfo
					WHERE idUser = @idUser;
				END;
				ELSE
				BEGIN
					-- User is from the United States, update user there
					IF(@idCode = 3)
					BEGIN;
						UPDATE [UnitedStatesDB].[dbo].[User]
						SET
							suscribed = 1 
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
EXEC suscribeUser @inidUserxPlace = 1, @inSuscriptionId = 3; 
SELECT * FROM Suscription
SELECT * FROM [IrelandDB].[dbo].[User] WHERE username = 'jaguero'