USE GeneralDB
GO;

-- Function that determines if a user exists and returns the idUserxPlace

CREATE PROCEDURE dbo.UserExists
	@inUserName VARCHAR(40)
AS 
BEGIN
	
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @idUser INT;
		
		-- Determine if the user exists in ireland
		SELECT @idUser = Gen.idUserxPlace
		FROM [GeneralDB].[dbo].[UserxPlace] Gen
		JOIN [IrelandDB].[dbo].[User] Ir ON Gen.idUser = Ir.idUser
		WHERE Ir.username = @inUserName AND Gen.idCode=1;
		
		-- Determine if the user exists in ireland
		IF(@idUser IS NOT NULL) 
		BEGIN
			-- Exists, return the id
			SELECT @idUser;
		END;
		ELSE
		BEGIN
			-- It doesnt exists in Ireland, check in Scotland
			SELECT @idUser = Gen.idUserxPlace
			FROM [GeneralDB].[dbo].[UserxPlace] Gen
			JOIN [ScotlandDB].[dbo].[User] SC ON Gen.idUser = SC.idUser
			WHERE SC.username = @inUserName AND Gen.idCode=2;
			
			-- Determine if the user exists in Scotland
			IF(@idUser IS NOT NULL) 
			BEGIN
				-- Exists, return the id
				SELECT @idUser;
			END;
			ELSE
			BEGIN
				-- It doesnt exists in Scotland, check in the us
				SELECT @idUser = Gen.idUserxPlace
				FROM [GeneralDB].[dbo].[UserxPlace] Gen
				JOIN [UnitedStatesDB].[dbo].[User] USA ON Gen.idUser = USA.idUser
				WHERE USA.username = @inUserName AND Gen.idCode=3;
				
				-- Determine if the user exists in the us
				IF(@idUser IS NOT NULL) 
				BEGIN
					-- Exists, return the id
					SELECT @idUser; 
				END;
				ELSE
				BEGIN
					-- User doesnt exist in any database
					SELECT 0;
				END;
			END;
		END;
	END TRY
	BEGIN CATCH
			PRINT 'Error ocurred while searching the user';
	END CATCH
	
	SET NOCOUNT OFF
END;

-- Test
EXEC UserExists @inUserName = 'joseflor';


---------------------------------------------------------------------------------------------------

-- Function that determines if the password entered is correct
CREATE or ALTER PROCEDURE dbo.PasswordCorrect
	@inUserName VARCHAR(40),
	@inPassword VARCHAR(40),
	@inidUserxPlace INT
AS 
BEGIN
	
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @passw VARCHAR(40), @code INT;
		
		-- Determine where is the user from
		SELECT @code = idCode FROM [GeneralDB].[dbo].UserxPlace WHERE @inidUserxPlace = idUserxPlace;

		-- From Ireland
		IF(@code = 1)
		BEGIN

			-- Get the password of the user
			SELECT @passw = Ir.password
			FROM [GeneralDB].[dbo].[UserxPlace] Gen
			JOIN [IrelandDB].[dbo].[User] Ir ON Gen.idUser = Ir.idUser
			WHERE Ir.username = @inUserName AND Gen.idCode=1;
			
			set @passw  =  (select [GeneralDB].[dbo].encdec(@passw,2,1)); -- descrypt the password

			-- Determine if the passwords match
			IF(@inPassword = @passw)
			BEGIN
				-- they match
				SELECT 1;
			END;
			ELSE
			BEGIN
				-- they dont match
				SELECT 0;
			END;
		END;
		ELSE
		BEGIN
			-- From Scotland
			IF(@code = 2)
			BEGIN
				-- Get the password of the user
				SELECT @passw = SC.password
				FROM [GeneralDB].[dbo].[UserxPlace] Gen
				JOIN [ScotlandDB].[dbo].[User] SC ON Gen.idUser = SC.idUser
				WHERE SC.username = @inUserName AND Gen.idCode=2;
				
				set @passw  =  (select [GeneralDB].[dbo].encdec(@passw,2,1)); -- descrypt the password

				-- Determine if the passwords match
				IF(@inPassword = @passw)
				BEGIN
					-- they match
					SELECT 1;
				END;
				ELSE
				BEGIN
					-- they dont match
					SELECT 0;
				END;
			END;
			ELSE
			BEGIN
				IF(@code = 3)
				BEGIN
					-- From the us
					-- Get the password of the user
					SELECT @passw = USA.password
					FROM [GeneralDB].[dbo].[UserxPlace] Gen
					JOIN [UnitedStatesDB].[dbo].[User] USA ON Gen.idUser = USA.idUser
					WHERE USA.username = @inUserName AND Gen.idCode=3;
					
					set @passw  =  (select [GeneralDB].[dbo].encdec(@passw,2,1)); -- descrypt the password

					-- Determine if the passwords match
					IF(@inPassword = @passw)
					BEGIN
						-- they match
						SELECT 1;
					END;
					ELSE
					BEGIN
						-- they dont match
						SELECT 0;
					END;
				END;
				ELSE
				BEGIN
					SELECT 0;
				END;
			END;
		END;
	END TRY
	BEGIN CATCH
			PRINT 'Error ocurred while searching the password';
	END CATCH
	
	SET NOCOUNT OFF
END;

EXEC PasswordCorrect @inUserName = 'jaguero', @inPassword = 'LaFacil1234', @inidUserxPlace=1;