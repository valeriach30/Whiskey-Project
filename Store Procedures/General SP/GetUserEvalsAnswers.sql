-- Get Evaluations of a product and a user

CREATE OR ALTER PROCEDURE dbo.GetUserEvaluations
	@idUser INT,
	@idProduct INT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		
		-- Get all the evaluations connected with ireland
		
		SELECT EV.idEvaluation, 
			EV.idUser,
			UserPer.name as userName, 
			UserPer.surname,
			PROD.[name],
			EV.comment, 
			EV.calification, 
			EmpPer.name AS sellerName,
			EmpPer.surname AS sellerSurname,
			DelPer.name AS DeliverName,
			DelPer.surname AS DeliverSurname,
			EV.evDate
		FROM [GeneralDB].[dbo].[Evaluation] EV
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UP.idUserxPlace = EV.idUser
		LEFT JOIN [IrelandDB].[dbo].[User] UserIRL ON UserIRL.idUser = UP.idUser
		LEFT JOIN [IrelandDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserIRL.idPersonalInfo
		LEFT JOIN [ProductsDB].[dbo].[Product] PROD ON PROD.idProduct = EV.idProduct
		LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Del ON Del.idEmployee = EV.idDelieveryPerson
		LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = EV.idSeller
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPEmp ON UPEmp.idUserxPlace = Emp.idUser
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPDel ON UPDel.idUserxPlace = Del.idUser
		LEFT JOIN [IrelandDB].[dbo].[User] EmpUser ON EmpUser.idUser = UPEmp.idUser
		LEFT JOIN [IrelandDB].[dbo].[PersonalInfo] EmpPer ON EmpPer.idPersonalInfo = EmpUser.idPersonalInfo
		LEFT JOIN [IrelandDB].[dbo].[User] Deliver ON Deliver.idUser = UPDel.idUser
		LEFT JOIN [IrelandDB].[dbo].[PersonalInfo] DelPer ON DelPer.idPersonalInfo = Deliver.idPersonalInfo
		WHERE UP.idCode = 1 AND EV.idUser = @idUser AND EV.idProduct = @idProduct
		

		-- Get all the evaluations connected with scotland
		UNION ALL
		SELECT EV.idEvaluation, 
			EV.idUser, 
			UserPer.name as userName, 
			UserPer.surname,
			PROD.[name],
			EV.comment, 
			EV.calification, 
			EmpPer.name AS sellerName,
			EmpPer.surname AS sellerSurname,
			DelPer.name AS DeliverName,
			DelPer.surname AS DeliverSurname,
			EV.evDate
		FROM [GeneralDB].[dbo].[Evaluation] EV
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UP.idUserxPlace = EV.idUser
		LEFT JOIN [ScotlandDB].[dbo].[User] UserSCO ON UserSCO.idUser = UP.idUser
		LEFT JOIN [ScotlandDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserSCO.idPersonalInfo
		LEFT JOIN [ProductsDB].[dbo].[Product] PROD ON PROD.idProduct = EV.idProduct
		LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Del ON Del.idEmployee = EV.idDelieveryPerson
		LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = EV.idSeller
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPEmp ON UPEmp.idUserxPlace = Emp.idUser
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPDel ON UPDel.idUserxPlace = Del.idUser
		LEFT JOIN [ScotlandDB].[dbo].[User] EmpUser ON EmpUser.idUser = UPEmp.idUser
		LEFT JOIN [ScotlandDB].[dbo].[PersonalInfo] EmpPer ON EmpPer.idPersonalInfo = EmpUser.idPersonalInfo
		LEFT JOIN [ScotlandDB].[dbo].[User] Deliver ON Deliver.idUser = UPDel.idUser
		LEFT JOIN [ScotlandDB].[dbo].[PersonalInfo] DelPer ON DelPer.idPersonalInfo = Deliver.idPersonalInfo
		WHERE UP.idCode = 2 AND EV.idUser = @idUser AND EV.idProduct = @idProduct
		

		-- Get all the evaluations connected with the us
		UNION ALL
		SELECT EV.idEvaluation, 
			EV.idUser, 
			UserPer.name as userName, 
			UserPer.surname, 
			PROD.[name],
			EV.comment, 
			EV.calification, 
			EmpPer.name AS sellerName,
			EmpPer.surname AS sellerSurname,
			DelPer.name AS DeliverName,
			DelPer.surname AS DeliverSurname,
			EV.evDate
		FROM [GeneralDB].[dbo].[Evaluation] EV
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UP.idUserxPlace = EV.idUser
		LEFT JOIN [UnitedStatesDB].[dbo].[User] UserUSA ON UserUSA.idUser = UP.idUser
		LEFT JOIN [UnitedStatesDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserUSA.idPersonalInfo
		LEFT JOIN [ProductsDB].[dbo].[Product] PROD ON PROD.idProduct = EV.idProduct
		LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Del ON Del.idEmployee = EV.idDelieveryPerson
		LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = EV.idSeller
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPEmp ON UPEmp.idUserxPlace = Emp.idUser
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPDel ON UPDel.idUserxPlace = Del.idUser
		LEFT JOIN [UnitedStatesDB].[dbo].[User] EmpUser ON EmpUser.idUser = UPEmp.idUser
		LEFT JOIN [UnitedStatesDB].[dbo].[PersonalInfo] EmpPer ON EmpPer.idPersonalInfo = EmpUser.idPersonalInfo
		LEFT JOIN [UnitedStatesDB].[dbo].[User] Deliver ON Deliver.idUser = UPDel.idUser
		LEFT JOIN [UnitedStatesDB].[dbo].[PersonalInfo] DelPer ON DelPer.idPersonalInfo = Deliver.idPersonalInfo
		WHERE UP.idCode = 3 AND EV.idUser = @idUser AND EV.idProduct = @idProduct
		
	END TRY
	BEGIN CATCH
		PRINT 'Error when getting users evaluations';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC GetUserEvaluations @idUser = 1, @idProduct = 53;

--- Get Responses of Evaluations of a product and a user-------------------------------------
CREATE OR ALTER PROCEDURE dbo.GetUserResponsesEv
	@evaluationId INT,
	@idUser INT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @idCountryEmp INT;
		-- Determine where is the employee who responded to get the user name
		
		SELECT @idCountryEmp = UserEmp.idCode
		FROM [GeneralDB].[dbo].[ResponseEV] ResEv
		INNER JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = ResEv.idEmployee
		INNER JOIN [GeneralDB].[dbo].[UserxPlace] UserEmp ON UserEmp.idUserxPlace = Emp.idUser
		WHERE ResEv.[idEvaluation] = @evaluationId AND ResEv.idUser = @idUser

		-- Employee is from Ireland
		IF(@idCountryEmp = 1)
		BEGIN
			SELECT idResponse, description, UserPer.name, UserPer.surname, dateResp
			FROM [GeneralDB].[dbo].[ResponseEV] ResEv
			INNER JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = ResEv.idEmployee
			INNER JOIN [GeneralDB].[dbo].[UserxPlace] UserEmp ON UserEmp.idUserxPlace = Emp.idUser
			INNER JOIN [IrelandDB].[dbo].[User] UserIrl ON UserIrl.idUser = UserEmp.idUser
			INNER JOIN [IrelandDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserIrl.idPersonalInfo
			WHERE ResEv.[idEvaluation] = @evaluationId AND ResEv.idUser = @idUser
		END;
		ELSE
		BEGIN
			IF(@idCountryEmp = 2)
			BEGIN
				SELECT idResponse, description, UserPer.name, UserPer.surname, dateResp
				FROM [GeneralDB].[dbo].[ResponseEV] ResEv
				INNER JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = ResEv.idEmployee
				INNER JOIN [GeneralDB].[dbo].[UserxPlace] UserEmp ON UserEmp.idUserxPlace = Emp.idUser
				INNER JOIN [ScotlandDB].[dbo].[User] UserSCO ON UserSCO.idUser = UserEmp.idUser
				INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserSCO.idPersonalInfo
				WHERE ResEv.[idEvaluation] = @evaluationId  AND ResEv.idUser = @idUser
			END;
			ELSE
			BEGIN
				SELECT idResponse, description, UserPer.name, UserPer.surname, dateResp
				FROM [GeneralDB].[dbo].[ResponseEV] ResEv
				INNER JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = ResEv.idEmployee
				INNER JOIN [GeneralDB].[dbo].[UserxPlace] UserEmp ON UserEmp.idUserxPlace = Emp.idUser
				INNER JOIN [UnitedStatesDB].[dbo].[User] UserUSA ON UserUSA.idUser = UserEmp.idUser
				INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserUSA.idPersonalInfo
				WHERE ResEv.[idEvaluation] = @evaluationId AND ResEv.idUser = @idUser
			END;
		END;
	END TRY
	BEGIN CATCH
		PRINT 'Error when getting user responses';
	END CATCH
	SET NOCOUNT OFF
END;

-- Example
exec GetUserResponsesEv @evaluationId = 15, @idUser = 1;
SELECT * FROM Evaluation