
--- Get the mails of subscribed users ---------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE getUsersMails 
AS BEGIN
	BEGIN TRY
		-- Get users from ireland
		SELECT [PersonalInfo].email 
		FROM [IrelandDB].[dbo].[User]
		INNER JOIN [IrelandDB].[dbo].[PersonalInfo] ON [PersonalInfo].idPersonalInfo = [User].idPersonalInfo
		
		UNION ALL
		SELECT [PersonalInfo].email 
		FROM [ScotlandDB].[dbo].[User]
		INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] ON [PersonalInfo].idPersonalInfo = [User].idPersonalInfo

		UNION ALL
		SELECT [PersonalInfo].email 
		FROM [UnitedStatesDB].[dbo].[User]
		INNER JOIN [ScotlandDB].[dbo].[PersonalInfo] ON [PersonalInfo].idPersonalInfo = [User].idPersonalInfo
	END TRY
	BEGIN CATCH
		PRINT('Error al mostrar Usuarios')
	END CATCH
END

-- Example
EXEC getUsersMails;