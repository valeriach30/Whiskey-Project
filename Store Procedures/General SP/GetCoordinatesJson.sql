USE GeneralDB
GO

CREATE OR ALTER PROCEDURE dbo.GetCoordinates
	@inidUserxPlace INT,
	@inLocationName VARCHAR(40)
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @idUser INT, @idCode INT, 
		@newNameX VARCHAR(50),  @newNameY VARCHAR(50);
		
		-- Set new name
		SET @newNameX = '$.' + @inLocationName + '[0].X'
		SET @newNameY = '$.' + @inLocationName + '[0].Y'

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
				SELECT 
					JSON_VALUE(UserPI.address, @newNameX) AS 'X', 
					JSON_VALUE(UserPI.address, @newNameY) AS 'Y'
				FROM [IrelandDB].[dbo].[User] TUser
				INNER JOIN [IrelandDB].[dbo].[PersonalInfo] UserPI
				ON TUser.idPersonalInfo = UserPI.[idPersonalInfo]
				WHERE idUser = @idUser
			END;
			ELSE
			BEGIN
				-- User is from Scotland, get the data from there
				IF(@idCode = 2)
				BEGIN
					SELECT 
						JSON_VALUE(UserPI.address, @newNameX) AS 'X', 
						JSON_VALUE(UserPI.address, @newNameY) AS 'Y'
					FROM [ScotlandDB].[dbo].[User] TUser
					INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] UserPI
					ON TUser.idPersonalInfo = UserPI.[idPersonalInfo]
					WHERE idUser = @idUser
				END;
				ELSE
				BEGIN
					-- User is from the United States, get the data from there
					IF(@idCode = 3)
					BEGIN;
						SELECT 
							JSON_VALUE(UserPI.address, @newNameX) AS 'X', 
							JSON_VALUE(UserPI.address, @newNameY) AS 'Y'
						FROM [UnitedStatesDB].[dbo].[User] TUser
						INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] UserPI
						ON TUser.idPersonalInfo = UserPI.[idPersonalInfo]
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
			PRINT 'Error ocurred while getting the coordinates';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC GetCoordinates @inidUserxPlace = 1, @inLocationName = 'house'