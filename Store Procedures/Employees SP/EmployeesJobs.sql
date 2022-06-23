USE GeneralDB
GO;

CREATE OR ALTER PROCEDURE getEmployeesJobs
AS BEGIN
	BEGIN TRY
		SELECT [name] FROM OpenQuery([PROJECT-DB2],'SELECT * From job')
	END TRY
	BEGIN CATCH
		SELECT 'Error when getting jobs';
	END CATCH
END

-- Test 
EXEC getEmployeesJobs