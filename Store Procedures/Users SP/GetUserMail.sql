USE GeneralDB
GO;

CREATE OR ALTER PROCEDURE getUsersMail
	@inIdUserXPlace INT
AS BEGIN
	BEGIN TRY
		DECLARE @idCode INT, @idUser INT, @idPersonalInfo INT;
		-- Get the code and the id of the user
		SELECT @idCode = idCode, @idUser = idUser
		FROM [GeneralDB].[dbo].[UserXPlace]
		WHERE UserXPlace.idUserXPlace = @inIdUserXPlace;
		IF(@idCode=1)
		BEGIN
			-- Ireland
			SET @idPersonalInfo = (SELECT [PersonalInfo].idPersonalInfo 
								FROM [IrelandDB].[dbo].[User]
								INNER JOIN [IrelandDB].[dbo].[PersonalInfo] 
								ON [PersonalInfo].idPersonalInfo = [User].idPersonalInfo
								WHERE [User].idUser = @idUser);
			-- Get the email
			SELECT email 
			FROM [IrelandDB].[dbo].[PersonalInfo] 
			WHERE idPersonalInfo =@idPersonalInfo;
		END;
		ELSE
		BEGIN
			-- Scotland
			IF(@idCode=2)
			BEGIN
				SET @idPersonalInfo = (SELECT [PersonalInfo].idPersonalInfo 
									FROM [ScotlandDB].[dbo].[User]
									INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] 
									ON [PersonalInfo].idPersonalInfo = [User].idPersonalInfo
									WHERE [User].idUser = @idUser);
				-- Get the email
				SELECT email 
				FROM [ScotlandDB].[dbo].[PersonalInfo] 
				WHERE idPersonalInfo =@idPersonalInfo;
			END;
			ELSE
			BEGIN
				IF(@idCode=3)
				BEGIN
					SET @idPersonalInfo = (SELECT [PersonalInfo].idPersonalInfo 
										FROM [UnitedStatesDB].[dbo].[User]
										INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] 
										ON [PersonalInfo].idPersonalInfo = [User].idPersonalInfo
										WHERE [User].idUser = @idUser);
					-- Get the email
					SELECT email 
					FROM [UnitedStatesDB].[dbo].[PersonalInfo] 
					WHERE idPersonalInfo =@idPersonalInfo;
				END;
				ELSE
				BEGIN
					SELECT '0';
				END;
			END;
		END;
	END TRY
	BEGIN CATCH
		PRINT('Error when searchign email')
	END CATCH
END

EXEC getUsersMail @inIdUserXPlace = 21;