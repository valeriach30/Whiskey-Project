USE GeneralDB
GO;

-- Get the locations of a user
CREATE OR ALTER PROCEDURE dbo.GetUserLocations
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
		
		-- User exists
		ELSE
		BEGIN
			-- User is from Ireland, get the data from there
			IF(@idCode = 1)
			BEGIN
				SELECT [key]
				FROM [IrelandDB].[dbo].[User] TUser
				INNER JOIN [IrelandDB].[dbo].[PersonalInfo] UserPI
				ON TUser.idPersonalInfo = UserPI.[idPersonalInfo]
				CROSS APPLY (
					SELECT [key] [key]
					FROM OPENJSON((SELECT UserPI.[address])) x
				) Keys
				WHERE idUser = @idUser
			END;
			ELSE
			BEGIN
				-- User is from Scotland, get the data from there
				IF(@idCode = 2)
				BEGIN
					SELECT [key]
					FROM [ScotlandDB].[dbo].[User] TUser
					INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] UserPI
					ON TUser.idPersonalInfo = UserPI.[idPersonalInfo]
					CROSS APPLY (
						SELECT [key] [key]
						FROM OPENJSON((SELECT UserPI.[address])) x
					) Keys
					WHERE idUser = @idUser
				END;
				ELSE
				BEGIN
					-- User is from the United States, get the data from there
					IF(@idCode = 3)
					BEGIN;
						SELECT [key]
						FROM [UnitedStatesDB].[dbo].[User] TUser
						INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] UserPI
						ON TUser.idPersonalInfo = UserPI.[idPersonalInfo]
						CROSS APPLY (
							SELECT [key] [key]
							FROM OPENJSON((SELECT UserPI.[address])) x
						) Keys
						WHERE idUser = @idUser
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
			PRINT 'Error ocurred while searching the locations';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC GetUserLocations 1;