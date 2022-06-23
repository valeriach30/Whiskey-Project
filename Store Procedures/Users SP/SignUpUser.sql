CREATE OR ALTER PROCEDURE dbo.SignUpUser
	@idCode INT,
	@name VARCHAR(50),
	@surname VARCHAR(50),
	@email	VARCHAR(100),
	@username VARCHAR(40),
	@password VARCHAR(20)
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @personalInfo INT, @idUser INT;
		IF(@idCode=1)
		BEGIN
			-- Insert personal info
			INSERT INTO [IrelandDB].[dbo].[PersonalInfo](name, surname,  email)
			VALUES (@name, @surname, @email)

			-- Get the id of the personal info
			SET @personalInfo = (SELECT TOP 1 idPersonalInfo 
								FROM [IrelandDB].[dbo].[PersonalInfo] 
								ORDER BY [PersonalInfo].idPersonalInfo DESC);
		
			-- Encrypt the password 
			SET @password =  (select [GeneralDB].[dbo].encdec(@password,2,0));

			-- Insert user
			INSERT INTO [IrelandDB].[dbo].[User](username, password, idUserType, idPersonalInfo, suscribed)
			VALUES (@username, @password, 2, @personalInfo, 0)

			-- Get the id of the user
			SET @idUser = (SELECT TOP 1 idUser 
								FROM [IrelandDB].[dbo].[User] 
								ORDER BY [User].idUser DESC);
			
			-- Insert into general db
			INSERT INTO [GeneralDB].[dbo].[UserxPlace] (idUser, idCode) 
			VALUES (@idUser, @idCode);

			SELECT '1';
		END;
		ELSE
		BEGIN
			IF(@idCode=2)
			BEGIN
				-- Insert personal info
				INSERT INTO [ScotlandDB].[dbo].[PersonalInfo](name, surname,  email)
				VALUES (@name, @surname, @email)

				-- Get the id of the personal info
				SET @personalInfo = (SELECT TOP 1 idPersonalInfo 
									FROM [ScotlandDB].[dbo].[PersonalInfo] 
									ORDER BY [PersonalInfo].idPersonalInfo DESC);

				-- Encrypt the password 
				SET @password =  (select [GeneralDB].[dbo].encdec(@password,2,0));

				-- Insert user
				INSERT INTO [ScotlandDB].[dbo].[User](username, password, idUserType, idPersonalInfo, suscribed)
				VALUES (@username, @password, 2, @personalInfo, 0)

				-- Get the id of the user
				SET @idUser = (SELECT TOP 1 idUser 
									FROM [ScotlandDB].[dbo].[User] 
									ORDER BY [User].idUser DESC);
			
				-- Insert into general db
				INSERT INTO [GeneralDB].[dbo].[UserxPlace] (idUser, idCode) 
				VALUES (@idUser, @idCode);

				SELECT '1';
			END;
			ELSE
			BEGIN
				IF(@idCode=3)
				BEGIN
					-- Insert personal info
					INSERT INTO [UnitedStatesDB].[dbo].[PersonalInfo](name, surname,  email)
					VALUES (@name, @surname, @email)

					-- Get the id of the personal info
					SET @personalInfo = (SELECT TOP 1 idPersonalInfo 
										FROM [UnitedStatesDB].[dbo].[PersonalInfo] 
										ORDER BY [PersonalInfo].idPersonalInfo DESC);

					-- Encrypt the password 
					SET @password =  (select [GeneralDB].[dbo].encdec(@password,2,0));


					-- Insert user
					INSERT INTO [UnitedStatesDB].[dbo].[User](username, password, idUserType, idPersonalInfo, suscribed)
					VALUES (@username, @password, 2, @personalInfo, 0)

					-- Get the id of the user
					SET @idUser = (SELECT TOP 1 idUser 
										FROM [UnitedStatesDB].[dbo].[User] 
										ORDER BY [User].idUser DESC);
			
					-- Insert into general db
					INSERT INTO [GeneralDB].[dbo].[UserxPlace] (idUser, idCode) 
					VALUES (@idUser, @idCode);

					SELECT '1';
				END;
				ELSE
				BEGIN
					SELECT '0';
				END;
			END;
		END;
	END TRY
	BEGIN CATCH
		PRINT 'Sign up Error';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC SignUpUser
	@idCode = 1,
	@name = 'Max',
	@surname= 'Orozco',
	@email	= 'maxor@gmail.com',
	@username= 'maxor',
	@password= 'LaContra56';
SELECT * FROM IrelandDB.dbo.[User]