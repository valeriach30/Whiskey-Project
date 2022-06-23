USE GeneralDB
GO;

-- Read profile
CREATE OR ALTER PROCEDURE dbo.ReadProfile
	@inUserName VARCHAR(40),
	@inidUserxPlace INT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @code INT, @idUser INT;
		DECLARE @UserExists table(Id int);
		-- Determine if the user exists
		INSERT INTO @UserExists
		EXEC UserExists @inUserName = @inUserName;
		SET @idUser= (SELECT Id From @UserExists);
		IF(@idUser <> 0)
		BEGIN
			-- Determine where is the user from
			SELECT @code = idCode FROM [GeneralDB].[dbo].UserxPlace WHERE @inidUserxPlace = idUserxPlace;
			-- From Ireland
			IF(@code = 1)
			BEGIN
				-- Get the info of the user
				SELECT Ir.username, Ir.[password], Ir.suscribed, Per.email, Per.[name], Per.surname, Per.phone, Gen.idCode
				FROM [GeneralDB].[dbo].[UserxPlace] Gen
				INNER JOIN [IrelandDB].[dbo].[User] Ir ON Gen.idUser = Ir.idUser
				INNER JOIN [IrelandDB].[dbo].[PersonalInfo] Per ON Ir.idPersonalInfo = Per.idPersonalInfo
				WHERE Ir.username = @inUserName AND Gen.idCode=1;
			END;
			ELSE
			BEGIN
				-- From Scotland
				IF(@code = 2)
				BEGIN
					-- Get the info of the user
					SELECT SC.username, SC.[password], SC.suscribed, 
					Per.email, Per.[name], Per.surname, Per.phone, Gen.idCode
					FROM [GeneralDB].[dbo].[UserxPlace] Gen
					INNER JOIN [ScotlandDB].[dbo].[User] SC ON Gen.idUser = SC.idUser
					INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] Per ON SC.idPersonalInfo = Per.idPersonalInfo
					WHERE SC.username = @inUserName AND Gen.idCode=2;
				END;
				ELSE
				BEGIN
					IF(@code = 3)
					BEGIN
						-- From the us
						-- Get the info of the user
						SELECT USA.username, USA.[password], USA.suscribed, Per.[address], Per.email, 
						Per.[name], Per.surname, Per.phone, Gen.idCode
						FROM [GeneralDB].[dbo].[UserxPlace] Gen
						INNER JOIN [UnitedStatesDB].[dbo].[User] USA ON Gen.idUser = USA.idUser
						INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] Per ON USA.idPersonalInfo = Per.idPersonalInfo
						WHERE USA.username = @inUserName AND Gen.idCode=3;
					END;
					ELSE
					BEGIN
						SELECT 0;
					END;
				END;
			END;
		END;
		ELSE
		BEGIN
			-- User does not exist
			SELECT 0;
		END;
	END TRY
	BEGIN CATCH
			PRINT 'Error ocurred while searching the profile';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC ReadProfile @inUserName = 'jaguero', @inidUserxPlace = 1;

---------------------------------------------------------------------------------------------------------------------------------
-- Modify profile
CREATE OR ALTER PROCEDURE dbo.ModifyProfile
	@inUserName VARCHAR(40),
	@inPassword VARCHAR(40),
	@inEmail VARCHAR(30),
	@inName VARCHAR(20),
	@inSurname VARCHAR(40),
	@inPhone INT,
	@inidUserxPlace INT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @code INT, @idUser INT;
		DECLARE @UserExists table(Id int);
		-- Determine if the user exists
		INSERT INTO @UserExists
		EXEC UserExists @inUserName = @inUserName;
		SET @idUser= (SELECT Id From @UserExists);
		IF(@idUser <> 0)
		BEGIN
			-- Determine where is the user from
			SELECT @code = idCode FROM [GeneralDB].[dbo].UserxPlace WHERE @inidUserxPlace = idUserxPlace;
			-- From Ireland
			IF(@code = 1)
			BEGIN
				-- Update the personal info of the person
				UPDATE [IrelandDB].[dbo].[PersonalInfo]
				SET [name] = @inName, surname = @inSurname, email = @inEmail, phone = @inPhone
				FROM [GeneralDB].[dbo].[UserxPlace] Gen
				INNER JOIN [IrelandDB].[dbo].[User] Ir ON Gen.idUser = Ir.idUser
				INNER JOIN [IrelandDB].[dbo].[PersonalInfo] Per ON Ir.idPersonalInfo = Per.idPersonalInfo
				WHERE  Ir.username = @inUserName AND Gen.idCode=1;

				-- Update the user info of the person
				UPDATE [IrelandDB].[dbo].[User]
				SET username = @inUserName, [password] = @inPassword
				FROM [GeneralDB].[dbo].[UserxPlace] Gen
				INNER JOIN [IrelandDB].[dbo].[User] Ir ON Gen.idUser = Ir.idUser
				INNER JOIN [IrelandDB].[dbo].[PersonalInfo] Per ON Ir.idPersonalInfo = Per.idPersonalInfo
				WHERE  Ir.username = @inUserName AND Gen.idCode=1;
			END;
			ELSE
			BEGIN
				-- From Scotland
				IF(@code = 2)
				BEGIN
					-- Update the personal info of the person
					UPDATE [ScotlandDB].[dbo].[PersonalInfo]
					SET [name] = @inName, surname = @inSurname, email = @inEmail, phone = @inPhone
					FROM [GeneralDB].[dbo].[UserxPlace] Gen
					INNER JOIN [ScotlandDB].[dbo].[User] SC ON Gen.idUser = SC.idUser
					INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] Per ON SC.idPersonalInfo = Per.idPersonalInfo
					WHERE SC.username = @inUserName AND Gen.idCode=2;

					-- Update the user info of the person
					UPDATE [ScotlandDB].[dbo].[User]
					SET username = @inUserName, [password] = @inPassword
					FROM [GeneralDB].[dbo].[UserxPlace] Gen
					INNER JOIN [ScotlandDB].[dbo].[User] SC ON Gen.idUser = SC.idUser
					INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] Per ON SC.idPersonalInfo = Per.idPersonalInfo
					WHERE SC.username = @inUserName AND Gen.idCode=2;
				END;
				ELSE
				BEGIN
					IF(@code = 3)
					BEGIN
						-- From the us

						-- Update the personal info of the person
						UPDATE [UnitedStatesDB].[dbo].[PersonalInfo]
						SET [name] = @inName, surname = @inSurname, email = @inEmail, phone = @inPhone
						FROM [GeneralDB].[dbo].[UserxPlace] Gen
						INNER JOIN [UnitedStatesDB].[dbo].[User] USA ON Gen.idUser = USA.idUser
						INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] Per ON USA.idPersonalInfo = Per.idPersonalInfo
						WHERE USA.username = @inUserName AND Gen.idCode=3;

						-- Update the user info of the person
						UPDATE [UnitedStatesDB].[dbo].[User]
						SET username = @inUserName, [password] = @inPassword
						FROM [GeneralDB].[dbo].[UserxPlace] Gen
						INNER JOIN [UnitedStatesDB].[dbo].[User] USA ON Gen.idUser = USA.idUser
						INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] Per ON USA.idPersonalInfo = Per.idPersonalInfo
						WHERE USA.username = @inUserName AND Gen.idCode=3;
					END;
					ELSE
					BEGIN
						SELECT 0;
					END;
				END;
			END;
		END;
		ELSE
		BEGIN
			-- User does not exist
			SELECT 0;
		END;
	END TRY
	BEGIN CATCH
			PRINT 'Error ocurred while updating the profile';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC ModifyProfile 
	@inUserName = 'jaguero',
	@inPassword ='LaFacil1234',
	@inEmail  = 'aguerojavit@gmail.com',
	@inName  = 'Javith',
	@inSurname  = 'Aguero Hernandez',
	@inPhone = 85343413,
	@inidUserxPlace = 1;
EXEC ReadProfile @inUserName = 'jaguero', @inidUserxPlace = 1;