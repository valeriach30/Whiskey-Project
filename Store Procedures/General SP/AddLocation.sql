Use GeneralDB
GO;

-- Add location for a user
CREATE OR ALTER PROCEDURE dbo.AddLocation
	@inidUserxPlace INT, 
	@locationName VARCHAR(20),
	@locationX FLOAT, --coordinates of the users selected location  
	@locationY FLOAT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @newName VARCHAR(40), @jsonLocations NVARCHAR(MAX), @idUser INT, @idCode INT;
		-- Get the country and the id of the user
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
			-- User is from Ireland, modify the data in there
			IF(@idCode = 1)
			BEGIN
				SELECT @jsonLocations = [PersonalInfo].[address] 
				FROM [IrelandDB].[dbo].[User]
				INNER JOIN [IrelandDB].[dbo].[PersonalInfo] 
				ON [User].idPersonalInfo = [PersonalInfo].idPersonalInfo
				WHERE idUser = @idUser;

				-- Set the new name
				SET @newName = '$.' + @locationName;
				
				-- Modify the json to add new location
				SET @jsonLocations = 
				JSON_MODIFY(@jsonLocations,@newName,JSON_Query('[ {"X" : ' 
				+ STR(@locationX, 25, 15) +', "Y":'+ STR(@locationY, 25, 15) + '} ]'));

				-- Update the json in the database
				UPDATE [PersonalInfo]
				SET  
					[address] = @jsonLocations
				FROM [IrelandDB].[dbo].[User]
				INNER JOIN [IrelandDB].[dbo].[PersonalInfo] 
				ON [User].idPersonalInfo = [PersonalInfo].idPersonalInfo
				WHERE idUser = @idUser;
			END;
			ELSE
			BEGIN
				-- User is from Scotland, get the data from there
				IF(@idCode = 2)
				BEGIN
					SELECT @jsonLocations = [PersonalInfo].[address] 
					FROM [ScotlandDB].[dbo].[User]
					INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] 
					ON [User].idPersonalInfo = [PersonalInfo].idPersonalInfo
					WHERE idUser = @idUser;

					-- Set the new name
					SET @newName = '$.' + @locationName;
				
					-- Modify the json to add new location
					SET @jsonLocations = 
					JSON_MODIFY(@jsonLocations,@newName,JSON_Query('[ {"X" : ' 
					+ STR(@locationX, 25, 15) +', "Y":'+ STR(@locationY, 25, 15) + '} ]'));

					-- Update the json in the database
					UPDATE [PersonalInfo]
					SET  
						[address] = @jsonLocations
					FROM [ScotlandDB].[dbo].[User]
					INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] 
					ON [User].idPersonalInfo = [PersonalInfo].idPersonalInfo
					WHERE idUser = @idUser;
				END;
				ELSE
				BEGIN
					-- User is from the United States, get the data from there
					IF(@idCode = 3)
					BEGIN;
						SELECT @jsonLocations = [PersonalInfo].[address] 
						FROM [UnitedStatesDB].[dbo].[User]
						INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] 
						ON [User].idPersonalInfo = [PersonalInfo].idPersonalInfo
						WHERE idUser = @idUser;

						-- Set the new name
						SET @newName = '$.' + @locationName;
				
						-- Modify the json to add new location
						SET @jsonLocations = 
						JSON_MODIFY(@jsonLocations,@newName,JSON_Query('[ {"X" : ' 
						+ STR(@locationX, 25, 15) +', "Y":'+ STR(@locationY, 25, 15) + '} ]'));

						-- Update the json in the database
						UPDATE [PersonalInfo]
						SET  
							[address] = @jsonLocations
						FROM [UnitedStatesDB].[dbo].[User]
						INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] 
						ON [User].idPersonalInfo = [PersonalInfo].idPersonalInfo
						WHERE idUser = @idUser;

						SELECT '1';
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
		SELECT 'UpdateLocation error';
	END CATCH
	SET NOCOUNT OFF
END;


EXEC AddLocation @inidUserxPlace = 1, @locationName = 'MomsHouse', 
@locationX = 53.22222222222, @locationY = -6.11111111111;

SELECT address FROM IrelandDB.dbo.[User] 
INNER JOIN IrelandDB.dbo.PersonalInfo 
ON [User].idPersonalInfo = [PersonalInfo].idPersonalInfo
WHERE idUser = 1;