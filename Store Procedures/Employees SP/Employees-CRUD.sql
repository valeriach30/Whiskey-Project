USE GeneralDB
GO;

--------------------------------------MODIFY--------------------------------------

-- Modify Employee
CREATE OR ALTER PROCEDURE modifyEmployee
	@inIdEmployee	INT,
    @inJobID        INT,
    @inNewSallary   MONEY,
	@inNewSallaryD  MONEY
AS BEGIN
    BEGIN TRY
        EXEC ('UPDATE OPENQUERY([PROJECT-DB2],''SELECT * FROM employee WHERE idemployee =''''' + @inIdEmployee + ''''''')' 
		+'SET idjob = ' + @inJobID + ',salarylocal = '+ @inNewSallary + ',salarydollars = ' + @inNewSallaryD);
    END TRY
    BEGIN CATCH
        PRINT('Modify Employee Error')
    END CATCH
END

-- Test
EXEC modifyEmployee @inIdEmployee = 1, @inJobID = 1, @inNewSallary = 600, @inNewSallaryD = 610;

SELECT * FROM OpenQuery([PROJECT-DB2],'SELECT * From employee')


--------------------------------------ADD EMPLOYEE--------------------------------------
CREATE OR ALTER PROCEDURE addEmployee
	@inUserName VARCHAR(40),
	@inPassword VARCHAR(40),
	@inidUserType INT,
	@idCountry VARCHAR(20),
	@inEmail VARCHAR(30),
	@inName VARCHAR(20),
	@inSurname VARCHAR(40),
	@inPhone INT,
	@inIdPayMethod INT,
	@inNameOnCard VARCHAR(60),
	@inAccountNumber BIGINT,
	@inExpirationDate DATE,
	@inCVV INT,
	@inIdJob INT,
	@inSalaryLocal FLOAT,
	@inSalaryDollars FLOAT
AS BEGIN
    BEGIN TRY
		DECLARE @idEmployeePostgres INT, @idPaymentMethod INT, @idPersonalInfo INT, 
		@idEmployeeUser INT, @idUserxPlace INT;

		-------------- Create Employee --------------

		-- Insert employee in the postgres database 
		INSERT INTO OPENQUERY ([PROJECT-DB2], 'SELECT idjob, salarylocal, salarydollars, calification FROM employee')
		SELECT @inIdJob, @inSalaryLocal, @inSalaryDollars, 10
		
		-- Get the id of the employee
		SELECT TOP 1 @idEmployeePostgres = idEmployee FROM OpenQuery([PROJECT-DB2],'SELECT * From employee ORDER BY idEmployee DESC')

		--------------Create the user of the employee--------------
		
		-- Determine in which country the user must be created

		---------- IRELAND ----------
		IF(@idCountry = 1)
		BEGIN
			-- Create the payment method
			INSERT INTO [IrelandDB].[dbo].[PaymentInfo] (idPayMethod, nameOnCard, accountNumber, expirationDate, CVV)
			VALUES (@inIdPayMethod, @inNameOnCard, @inAccountNumber, @inExpirationDate, @inCVV);

			-- Get the id of the payment method
			SELECT TOP 1 @idPaymentMethod = idPaymentInfo 
			FROM [IrelandDB].[dbo].[PaymentInfo]
			ORDER BY idPaymentInfo DESC;

			-- Create the personal info 
			INSERT INTO [IrelandDB].[dbo].[PersonalInfo] (name, surname, email,	phone)
			VALUES (@inName, @inSurname, @inEmail, @inPhone);

			-- Get the id of the personal info
			SELECT TOP 1 @idPersonalInfo = idPersonalInfo 
			FROM [IrelandDB].[dbo].[PersonalInfo]
			ORDER BY idPersonalInfo DESC;

			-- Create the user
			INSERT INTO [IrelandDB].[dbo].[User] (idUserType, idPersonalInfo, username, password, idPaymentInfo, suscribed)
			VALUES (@inidUserType, @idPersonalInfo, @inUserName,
			(select [GeneralDB].[dbo].encdec(@inPassword,2,0)), @idPaymentMethod, 0);

			-- Get the id of the user
			SELECT TOP 1 @idEmployeeUser = idUser 
			FROM [IrelandDB].[dbo].[User]
			ORDER BY idUser DESC;

			-- Insert the new user into the general database
			INSERT INTO UserxPlace(idUser, idCode)
			VALUES (@idEmployeeUser, 1);

			-- Get the id of UserXPlace
			SELECT TOP 1 @idUserxPlace = idUserxPlace 
			FROM UserxPlace
			ORDER BY idUserxPlace DESC;

			-- Insert into the general database
			INSERT INTO UserxEmployee(idUser, idEmployee)
			VALUES (@idUserxPlace, @idEmployeePostgres);

		END;
		ELSE
		BEGIN
			---------- SCOTLAND ----------
			IF(@idCountry = 2)
			BEGIN
				-- Create the payment method
				INSERT INTO [ScotlandDB].[dbo].[PaymentInfo] (idPayMethod, nameOnCard, accountNumber, expirationDate, CVV)
				VALUES (@inIdPayMethod, @inNameOnCard, @inAccountNumber, @inExpirationDate, @inCVV);

				-- Get the id of the payment method
				SELECT TOP 1 @idPaymentMethod = idPaymentInfo 
				FROM [ScotlandDB].[dbo].[PaymentInfo]
				ORDER BY idPaymentInfo DESC;

				-- Create the personal info 
				INSERT INTO [ScotlandDB].[dbo].[PersonalInfo] (name, surname, email,	phone)
				VALUES (@inName, @inSurname, @inEmail, @inPhone);

				-- Get the id of the personal info
				SELECT TOP 1 @idPersonalInfo = idPersonalInfo 
				FROM [ScotlandDB].[dbo].[PersonalInfo]
				ORDER BY idPersonalInfo DESC;

				-- Create the user
				INSERT INTO [ScotlandDB].[dbo].[User] (idUserType, idPersonalInfo, username, password, idPaymentInfo, suscribed)
				VALUES (@inidUserType, @idPersonalInfo, @inUserName,
				(select [GeneralDB].[dbo].encdec(@inPassword,2,0)), @idPaymentMethod, 0);

				-- Get the id of the user
				SELECT TOP 1 @idEmployeeUser = idUser 
				FROM [ScotlandDB].[dbo].[User]
				ORDER BY idUser DESC;

				-- Insert the new user into the general database
				INSERT INTO UserxPlace(idUser, idCode)
				VALUES (@idEmployeeUser, 2);

				-- Get the id of UserXPlace
				SELECT TOP 1 @idUserxPlace = idUserxPlace 
				FROM UserxPlace
				ORDER BY idUserxPlace DESC;

				-- Insert into the general database
				INSERT INTO UserxEmployee(idUser, idEmployee)
				VALUES (@idUserxPlace, @idEmployeePostgres);
			END;
			ELSE
			BEGIN
				---------- UNITED STATES ----------
				IF(@idCountry = 3)
				BEGIN
					-- Create the payment method
					INSERT INTO [UnitedStatesDB].[dbo].[PaymentInfo] (idPayMethod, nameOnCard, accountNumber, expirationDate, CVV)
					VALUES (@inIdPayMethod, @inNameOnCard, @inAccountNumber, @inExpirationDate, @inCVV);

					-- Get the id of the payment method
					SELECT TOP 1 @idPaymentMethod = idPaymentInfo 
					FROM [UnitedStatesDB].[dbo].[PaymentInfo]
					ORDER BY idPaymentInfo DESC;

					-- Create the personal info 
					INSERT INTO [UnitedStatesDB].[dbo].[PersonalInfo] (name, surname, email,	phone)
					VALUES (@inName, @inSurname, @inEmail, @inPhone);

					-- Get the id of the personal info
					SELECT TOP 1 @idPersonalInfo = idPersonalInfo 
					FROM [UnitedStatesDB].[dbo].[PersonalInfo]
					ORDER BY idPersonalInfo DESC;

					-- Create the user
					INSERT INTO [UnitedStatesDB].[dbo].[User] (idUserType, idPersonalInfo, username, password, idPaymentInfo, suscribed)
					VALUES (@inidUserType, @idPersonalInfo, @inUserName,
					(select [GeneralDB].[dbo].encdec(@inPassword,2,0)), @idPaymentMethod, 0);

					-- Get the id of the user
					SELECT TOP 1 @idEmployeeUser = idUser 
					FROM [UnitedStatesDB].[dbo].[User]
					ORDER BY idUser DESC;

					-- Insert the new user into the general database
					INSERT INTO UserxPlace(idUser, idCode)
					VALUES (@idEmployeeUser, 3);

					-- Get the id of UserXPlace
					SELECT TOP 1 @idUserxPlace = idUserxPlace 
					FROM UserxPlace
					ORDER BY idUserxPlace DESC;

					-- Insert into the general database
					INSERT INTO UserxEmployee(idUser, idEmployee)
					VALUES (@idUserxPlace, @idEmployeePostgres);
				END;
				ELSE
				BEGIN
					SELECT 'Error when inserting employee';
				END;
			END;

		END;
    END TRY
    BEGIN CATCH
        SELECT 'Error when inserting employee';
    END CATCH
END;

-- Test
EXEC addEmployee @inUserName = 'paulros',
@inPassword = 'Contra0903',
@inidUserType = 2,
@idCountry = 1,
@inEmail = 'paulros@gmail.com',
@inName = 'Paul',
@inSurname = 'Rose',
@inPhone = 64592365,
@inIdPayMethod = 1,
@inNameOnCard = 'Paul Rose',
@inAccountNumber = 7222666611047707,
@inExpirationDate = '2024-06-30',
@inCVV = 123,
@inIdJob = 1,
@inSalaryLocal = 560,
@inSalaryDollars = 572

SELECT * FROM IrelandDB.dbo.[User]
INNER JOIN IrelandDB.dbo.[PersonalInfo] P on P.idPersonalInfo = [User].idPersonalInfo
INNER JOIN IrelandDB.dbo.PaymentInfo PA on PA.idPaymentInfo = [User].idPaymentInfo

--------------------------------------DELETE--------------------------------------
CREATE OR ALTER PROCEDURE deleteEmployee
	@inIdEmployee INT
AS BEGIN
    BEGIN TRY
		DECLARE @query VARCHAR(500),@string CHAR(5), @idUserXPlace INT, @idCode INT, @idUser INT;

		-- Delete employee from the postgres db
		SELECT @string = CAST(@inIdEmployee AS CHAR(5));
		SELECT @query = 'DELETE FROM OPENQUERY([PROJECT-DB2],''SELECT * From employee WHERE idemployee = ''''' + @string + ''''''')'
		EXEC (@query)

		
		-- Get the id of the user x place
		SELECT @idUserXPlace = idUser 
		FROM UserxEmployee
		WHERE idEmployee = @inIdEmployee;

		-- Delete from the table UserXEmployee
		DELETE FROM UserxEmployee
		WHERE idEmployee = @inIdEmployee;

		-- Get code and user id from the table userxPlace
		SELECT @idUser = idUser, @idCode = idCode
		FROM UserxPlace
		WHERE idUserxPlace = @idUserXPlace;

		IF(@idCode = 1)
		BEGIN
			-- Set the user type to user
			UPDATE [IrelandDB].[dbo].[User]
			SET idUserType = 2
			FROM [IrelandDB].[dbo].[User]
			WHERE idUser = @idUser;
		END;
		ELSE
		BEGIN
			IF(@idCode = 2)
			BEGIN
				-- Set the user type to user
				UPDATE [ScotlandDB].[dbo].[User]
				SET idUserType = 2
				FROM [ScotlandDB].[dbo].[User]
				WHERE idUser = @idUser;
			END;
			ELSE
			BEGIN
				IF(@idCode = 3)
				BEGIN
					-- Set the user type to user
					UPDATE [UnitedStatesDB].[dbo].[User]
					SET idUserType = 2
					FROM [UnitedStatesDB].[dbo].[User]
					WHERE idUser = @idUser;
				END;
				ELSE
				BEGIN
					-- Error
					SELECT '0';
				END;
			END
		END;

    END TRY
    BEGIN CATCH
        PRINT('Delete Employee Error')
    END CATCH
END
EXEC deleteEmployee @inIdEmployee =22;