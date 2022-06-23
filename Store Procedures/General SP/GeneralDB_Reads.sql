
--- get all the evaluations of a product-------------------------------------
CREATE OR ALTER PROCEDURE dbo.readEvaluation
	@productId int
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		select idUser,idDelieveryPerson,idSeller,comment,calification from [GeneralDB].[dbo].[Evaluation]
		where [Evaluation].[idProduct] = @productId
	END TRY
	BEGIN CATCH
		PRINT 'Product error';
	END CATCH
	SET NOCOUNT OFF
END;

-- Example
exec readEvaluation @productId =1;


--- get all the reviews of a product-------------------------------------

CREATE OR ALTER PROCEDURE dbo.ReadReview
	@productId int
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		-- Reviews from Ireland
		SELECT idReview, idProduct, UserIRL.username, UserPer.name, UserPer.surname,comment, RevDate  
		FROM Review
		INNER JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UP.idUserxPlace = Review.idUser
		INNER JOIN [IrelandDB].[dbo].[User] UserIRL ON UserIRL.idUser = UP.idUser
		INNER JOIN [IrelandDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserIRL.idPersonalInfo
		WHERE UP.idCode =1  AND Review.idProduct = @productId
		
		-- Reviews from Scotland
		UNION ALL
		SELECT idReview, idProduct, UserSCO.username, UserPer.name, UserPer.surname,comment, RevDate   
		FROM Review
		INNER JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UP.idUserxPlace = Review.idUser
		INNER JOIN [ScotlandDB].[dbo].[User] UserSCO ON UserSCO.idUser = UP.idUser
		INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserSCO.idPersonalInfo
		WHERE UP.idCode =2 AND Review.idProduct = @productId
		
		-- Reviews from the us
		UNION ALL
		SELECT idReview, idProduct, UserUSA.username, UserPer.name, UserPer.surname,comment, RevDate 
		FROM Review
		INNER JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UP.idUserxPlace = Review.idUser
		INNER JOIN [UnitedStatesDB].[dbo].[User] UserUSA ON UserUSA.idUser = UP.idUser
		INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserUSA.idPersonalInfo
		WHERE UP.idCode =3 AND Review.idProduct = @productId
	END TRY
	BEGIN CATCH
		PRINT 'Error when reading review';
	END CATCH
	SET NOCOUNT OFF
END;

-- Example
exec ReadReview @productId = 13;


--- get all the response of a evaluation-------------------------------------
CREATE OR ALTER PROCEDURE dbo.ReadResponseEV
	@evaluationId int
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
		WHERE ResEv.[idEvaluation] = @evaluationId

		-- Employee is from Ireland
		IF(@idCountryEmp = 1)
		BEGIN
			SELECT idResponse, description, UserPer.name, UserPer.surname, dateResp
			FROM [GeneralDB].[dbo].[ResponseEV] ResEv
			INNER JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = ResEv.idEmployee
			INNER JOIN [GeneralDB].[dbo].[UserxPlace] UserEmp ON UserEmp.idUserxPlace = Emp.idUser
			INNER JOIN [IrelandDB].[dbo].[User] UserIrl ON UserIrl.idUser = UserEmp.idUser
			INNER JOIN [IrelandDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserIrl.idPersonalInfo
			WHERE ResEv.[idEvaluation] = @evaluationId
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
				WHERE ResEv.[idEvaluation] = @evaluationId
			END;
			ELSE
			BEGIN
				SELECT idResponse, description, UserPer.name, UserPer.surname, dateResp
				FROM [GeneralDB].[dbo].[ResponseEV] ResEv
				INNER JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = ResEv.idEmployee
				INNER JOIN [GeneralDB].[dbo].[UserxPlace] UserEmp ON UserEmp.idUserxPlace = Emp.idUser
				INNER JOIN [UnitedStatesDB].[dbo].[User] UserUSA ON UserUSA.idUser = UserEmp.idUser
				INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserUSA.idPersonalInfo
				WHERE ResEv.[idEvaluation] = @evaluationId
			END;
		END;
	END TRY
	BEGIN CATCH
		PRINT 'Product error';
	END CATCH
	SET NOCOUNT OFF
END;

-- Example
exec ReadResponseEV @evaluationId = 4;


--- get all the evaluations-------------------------------------
CREATE OR ALTER PROCEDURE dbo.GetAllEvaluations
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
		WHERE UP.idCode = 1
		

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
		WHERE UP.idCode = 2
		

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
		WHERE UP.idCode = 3
		
	END TRY
	BEGIN CATCH
		PRINT 'Product error';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC GetAllEvaluations;
SELECT * FROM Evaluation
