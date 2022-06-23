------------ Employees Report --------------------------
CREATE OR ALTER PROCEDURE employeesReport 
    @deparmentID        INT     = NULL,
    @calification       INT     = NULL,
    @salary             MONEY   = NULL
AS BEGIN
	SET NOCOUNT ON
    BEGIN TRY
		SET @salary = CAST(@salary AS money);

		CREATE TABLE temp(idemployee INT, idjob INT, salarylocal MONEY, salarydollars MONEY, calification INT);
		INSERT INTO temp 
		SELECT * FROM OPENQUERY([PROJECT-DB2],'SELECT * From employee')

		SELECT idjob, salarylocal, salarydollars, calification, username FROM temp
		LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] UE ON UE.idEmployee = temp.idemployee
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UE.idUser = UP.idUserxPlace
		LEFT JOIN [IrelandDB].[dbo].[User] EmpUser ON EmpUser.idUser = UP.idUser
		WHERE ((@deparmentID is null) or(@deparmentID = temp.idjob)) 
		AND ((@calification is null) or (temp.calification > @calification)) 
		AND ((@salary is null) or (temp.salarylocal > @salary)) 
		AND UP.idCode =1

		UNION ALL
		SELECT idjob, salarylocal, salarydollars, calification, username FROM temp
		LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] UE ON UE.idEmployee = temp.idemployee
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UE.idUser = UP.idUserxPlace
		LEFT JOIN [ScotlandDB].[dbo].[User] EmpUser ON EmpUser.idUser = UP.idUser
		WHERE ((@deparmentID is null) or(@deparmentID = temp.idjob)) 
		AND ((@calification is null) or (temp.calification > @calification)) 
		AND ((@salary is null) or (temp.salarylocal > @salary)) 
		AND UP.idCode =2

		UNION ALL
		SELECT idjob, salarylocal, salarydollars, calification, username FROM temp
		LEFT JOIN [GeneralDB].[dbo].[UserxEmployee] UE ON UE.idEmployee = temp.idemployee
		LEFT JOIN [GeneralDB].[dbo].[UserxPlace] UP ON UE.idUser = UP.idUserxPlace
		LEFT JOIN [UnitedStatesDB].[dbo].[User] EmpUser ON EmpUser.idUser = UP.idUser
		WHERE ((@deparmentID is null) or(@deparmentID = temp.idjob)) 
		AND ((@calification is null) or (temp.calification > @calification)) 
		AND ((@salary is null) or (temp.salarylocal > @salary)) 
		AND UP.idCode =3
		DROP TABLE temp

    END TRY
    BEGIN CATCH
        PRINT ('Employees Report Failed')
    END CATCH
END

EXEC employeesReport @deparmentID = NULL, @salary=NULL, @calification = NULL;