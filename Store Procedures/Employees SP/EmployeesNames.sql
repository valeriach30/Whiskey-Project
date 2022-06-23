USE GeneralDB
GO;

CREATE OR ALTER PROCEDURE getEmployeesNames
AS BEGIN
	BEGIN TRY
		SELECT [UserInfo].[name], [UserInfo].surname
		FROM [GeneralDB].[dbo].[UserxEmployee] Emp
		INNER JOIN [GeneralDB].[dbo].[UserxPlace] Users ON Emp.idUser = Users.idUserxPlace
		INNER JOIN [IrelandDB].[dbo].[User] UserIRL ON UserIRL.idUser = Users.idUser
		INNER JOIN [IrelandDB].[dbo].[PersonalInfo] UserInfo ON UserInfo.idPersonalInfo = UserIRL.idPersonalInfo
		WHERE Users.idCode = 1

		UNION ALL
		SELECT [UserInfo].[name], [UserInfo].surname
		FROM [GeneralDB].[dbo].[UserxEmployee] Emp
		INNER JOIN [GeneralDB].[dbo].[UserxPlace] Users ON Emp.idUser = Users.idUserxPlace
		INNER JOIN [ScotlandDB].[dbo].[User] UserSCO ON UserSCO.idUser = Users.idUser
		INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] UserInfo ON UserInfo.idPersonalInfo = UserSCO.idPersonalInfo
		WHERE Users.idCode = 2

		UNION ALL
		SELECT [UserInfo].[name], [UserInfo].surname
		FROM [GeneralDB].[dbo].[UserxEmployee] Emp
		INNER JOIN [GeneralDB].[dbo].[UserxPlace] Users ON Emp.idUser = Users.idUserxPlace
		INNER JOIN [UnitedStatesDB].[dbo].[User] UserUSA ON UserUSA.idUser = Users.idUser
		INNER JOIN [UnitedStatesDB].[dbo].[PersonalInfo] UserInfo ON UserInfo.idPersonalInfo = UserUSA.idPersonalInfo
		WHERE Users.idCode = 3
	END TRY
	BEGIN CATCH
		PRINT('Error when getting names')
	END CATCH
END

-- Test 
EXEC getEmployeesNames