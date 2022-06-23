
-----------------------------------------CREATE-----------------------------------------

CREATE OR ALTER PROCEDURE dbo.createSubType
	@inname					VARCHAR(30),
	@indicosuntBuy			INT,							
	@indiscountShipping		INT,							
	@incanSee				BIT,
	@inpresent				BIT,
	@inemailNotifications	BIT,
	@inprice				FLOAT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		INSERT INTO SuscriptionType(name, dicosuntBuy, discountShipping, canSee, present, emailNotifications, price) 
		VALUES (@inname, @indicosuntBuy,@indiscountShipping, @incanSee, @inpresent, @inemailNotifications,@inprice);
	END TRY
	BEGIN CATCH
		PRINT 'Add Suscription Type Error';
	END CATCH
	SET NOCOUNT OFF
END;

-----------------------------------------MODIFY-----------------------------------------

CREATE OR ALTER PROCEDURE dbo.ModifySubType
	@inname					VARCHAR(30),
	@indicosuntBuy			INT,							
	@indiscountShipping		INT,							
	@incanSee				BIT,
	@inpresent				BIT,
	@inemailNotifications	BIT,
	@inprice				FLOAT,
	@inIdSubType			INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		UPDATE SuscriptionType
		SET
			name = @inname,
			dicosuntBuy = @indicosuntBuy, 
			discountShipping = @indiscountShipping, 
			canSee = @incanSee, 
			present = @inpresent, 
			emailNotifications = @inemailNotifications,
			price = @inprice
		WHERE SuscriptionType.idSuscriptionType = @inIdSubType;
	END TRY
	BEGIN CATCH
		PRINT 'Modify Suscription Type Error';
	END CATCH
	SET NOCOUNT OFF
END;

-----------------------------------------DELETE-----------------------------------------
CREATE OR ALTER PROCEDURE dbo.DeleteSubType
	@inIdSubType			INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DELETE FROM SuscriptionType
		WHERE SuscriptionType.idSuscriptionType = @inIdSubType;
	END TRY
	BEGIN CATCH
		PRINT 'Delete Suscription Type Error';
	END CATCH
	SET NOCOUNT OFF
END;


-----------------------------------------READ-----------------------------------------
CREATE OR ALTER PROCEDURE dbo.readSuscriptions
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		SELECT * FROM SuscriptionType;
	END TRY
	BEGIN CATCH
		SELECT 'error when reading suscription';
	END CATCH
	SET NOCOUNT OFF
END;

EXEC readSuscriptions

------Suscriptions Names----------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.readSuscriptionsNames
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		SELECT name FROM SuscriptionType;
	END TRY
	BEGIN CATCH
		SELECT 'error when reading suscription';
	END CATCH
	SET NOCOUNT OFF
END;

EXEC readSuscriptionsNames