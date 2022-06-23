-- Get all the purchases of a user
CREATE OR ALTER PROCEDURE dbo.GetUserPurchases
	@idUser int
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		-- Get purchases from Ireland
		SELECT Sale.idUser,
			UserPer.name,
			UserPer.surname,
			Prod.idProduct,
			Prod.name as ordername,
			Prod.productImage,
			Sale.quantity,
			Sale.total,
			EmpUser.idUser as SellerIdUser,
			EmpPer.name as SellerName,
			EmpPer.surname as SellerSurName,
			Deliver.idUser as DeliverIdUser,
			DelPer.name as DelieverName,
			DelPer.surname as DelieverSurName
		FROM Sale
			LEFT JOIN [ProductsDB].[dbo].[Product] Prod ON Prod.idProduct = Sale.idProduct
			LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UP.idUserxPlace = Sale.idUser
			LEFT JOIN [IrelandDB].[dbo].[User] UserIRL ON UserIRL.idUser = UP.idUser
			LEFT JOIN [IrelandDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserIRL.idPersonalInfo
			LEFT JOIN [SalesDB].[dbo].[Delievery] ON Delievery.idDelievery = Sale.idDelievery
			LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Del ON Del.idEmployee = Delievery.idDelieveryPerson
			LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = Sale.idSeller
			LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPEmp ON UPEmp.idUserxPlace = Emp.idUser
			LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPDel ON UPDel.idUserxPlace = Del.idUser
			LEFT JOIN [IrelandDB].[dbo].[User] EmpUser ON EmpUser.idUser = UPEmp.idUser
			LEFT JOIN [IrelandDB].[dbo].[PersonalInfo] EmpPer ON EmpPer.idPersonalInfo = EmpUser.idPersonalInfo
			LEFT JOIN [IrelandDB].[dbo].[User] Deliver ON Deliver.idUser = UPDel.idUser
			LEFT JOIN [IrelandDB].[dbo].[PersonalInfo] DelPer ON DelPer.idPersonalInfo = Deliver.idPersonalInfo
		WHERE UP.idCode = 1 AND Sale.idUser = @idUser

		-- Get puRchases from Scotland
		UNION ALL
		SELECT Sale.idUser,
			UserPer.name,
			UserPer.surname,
			Prod.idProduct,
			Prod.name as ordername,
			Prod.productImage,
			Sale.quantity,
			Sale.total,
			EmpUser.idUser as SellerIdUser,
			EmpPer.name as SellerName,
			EmpPer.surname as SellerSurName,
			Deliver.idUser as DeliverIdUser,
			DelPer.name as DelieverName,
			DelPer.surname as DelieverSurName
		FROM Sale
			LEFT JOIN [ProductsDB].[dbo].[Product] Prod ON Prod.idProduct = Sale.idProduct
			LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UP.idUserxPlace = Sale.idUser
			LEFT JOIN [ScotlandDB].[dbo].[User] UserSCO ON UserSCO.idUser = UP.idUser
			LEFT JOIN [ScotlandDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserSCO.idPersonalInfo
			LEFT JOIN [SalesDB].[dbo].[Delievery] ON Delievery.idDelievery = Sale.idDelievery
			LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Del ON Del.idEmployee = Delievery.idDelieveryPerson
			LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = Sale.idSeller
			LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPEmp ON UPEmp.idUserxPlace = Emp.idUser
			LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPDel ON UPDel.idUserxPlace = Del.idUser
			LEFT JOIN [ScotlandDB].[dbo].[User] EmpUser ON EmpUser.idUser = UPEmp.idUser
			LEFT JOIN [ScotlandDB].[dbo].[PersonalInfo] EmpPer ON EmpPer.idPersonalInfo = EmpUser.idPersonalInfo
			LEFT JOIN [ScotlandDB].[dbo].[User] Deliver ON Deliver.idUser = UPDel.idUser
			LEFT JOIN [ScotlandDB].[dbo].[PersonalInfo] DelPer ON DelPer.idPersonalInfo = Deliver.idPersonalInfo
		WHERE UP.idCode = 2 AND Sale.idUser = @idUser

		-- Get purchases from the us
		UNION ALL
		SELECT Sale.idUser,
			UserPer.name,
			UserPer.surname,
			Prod.idProduct,
			Prod.name as ordername,
			Prod.productImage,
			Sale.quantity,
			Sale.total,
			EmpUser.idUser as SellerIdUser,
			EmpPer.name as SellerName,
			EmpPer.surname as SellerSurName,
			Deliver.idUser as DeliverIdUser,
			DelPer.name as DelieverName,
			DelPer.surname as DelieverSurName
		FROM Sale
			LEFT JOIN [ProductsDB].[dbo].[Product] Prod ON Prod.idProduct = Sale.idProduct
			LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UP.idUserxPlace = Sale.idUser
			LEFT JOIN [UnitedStatesDB].[dbo].[User] UserUSA ON UserUSA.idUser = UP.idUser
			LEFT JOIN [UnitedStatesDB].[dbo].[PersonalInfo] UserPer ON UserPer.idPersonalInfo = UserUSA.idPersonalInfo
			LEFT JOIN [SalesDB].[dbo].[Delievery] ON Delievery.idDelievery = Sale.idDelievery
			LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Del ON Del.idEmployee = Delievery.idDelieveryPerson
			LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] Emp ON Emp.idEmployee = Sale.idSeller
			LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPEmp ON UPEmp.idUserxPlace = Emp.idUser
			LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UPDel ON UPDel.idUserxPlace = Del.idUser
			LEFT JOIN [UnitedStatesDB].[dbo].[User] EmpUser ON EmpUser.idUser = UPEmp.idUser
			LEFT JOIN [UnitedStatesDB].[dbo].[PersonalInfo] EmpPer ON EmpPer.idPersonalInfo = EmpUser.idPersonalInfo
			LEFT JOIN [UnitedStatesDB].[dbo].[User] Deliver ON Deliver.idUser = UPDel.idUser
			LEFT JOIN [UnitedStatesDB].[dbo].[PersonalInfo] DelPer ON DelPer.idPersonalInfo = Deliver.idPersonalInfo
		WHERE UP.idCode = 3 AND Sale.idUser = @idUser

	END TRY
	BEGIN CATCH
		SELECT 'Error when getting purchases';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC GetUserPurchases @idUser = 1;
