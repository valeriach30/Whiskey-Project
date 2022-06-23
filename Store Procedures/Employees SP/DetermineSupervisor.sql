USE GeneralDB
GO;

CREATE OR ALTER PROCEDURE determineSupervisor
	@idUser INT
AS BEGIN
	BEGIN TRY
		DECLARE @salary INT;

		SELECT @salary = Emp.salarylocal 
		FROM OpenQuery([PROJECT-DB2],'SELECT * From employee') Emp
		INNER JOIN  [GeneralDB].[dbo].[UserxEmployee] UE ON Emp.idEmployee = UE.idEmployee
		INNER JOIN OpenQuery([PROJECT-DB2],'SELECT * From job') Job ON Emp.idjob = Job.idjob
		WHERE Job.name = 'Supervisor' AND UE.idUser = @idUser

		IF(@salary IS NOT NULL)
		BEGIN 
			-- User is a supervisor
			SELECT '1';
		END;
		ELSE
		BEGIN
			-- User is not a supervisor
			SELECT '0';
		END;
	END TRY
	BEGIN CATCH
		SELECT 'Error determining if the user is a supervisor';
	END CATCH
END

EXEC determineSupervisor 15;

DECLARE @isSupervisor INT;
