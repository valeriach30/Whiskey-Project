
-------------------------------------------------CREATE-------------------------------------------------

CREATE OR ALTER PROCEDURE dbo.createCoin
	@name 	VARCHAR(20),
	@symbol	VARCHAR(10),
	@country VARCHAR(20)
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		INSERT INTO Coin(name, symbol, country) VALUES
			(@name, @symbol, @country)
	END TRY
	BEGIN CATCH
		PRINT 'Create Error';
	END CATCH
	SET NOCOUNT OFF
END;

-------------------------------------------------MODIFY-------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.modifyCoin
	@coinId int,
	@name 	VARCHAR(20),
	@symbol	VARCHAR(10),
	@country VARCHAR(20)
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		UPDATE [ProductsDB].[dbo].[Coin] 
				SET name = @name,
					symbol = @symbol,
					country = @country	
		WHERE [Coin].idCoin = @coinId;
	END TRY
	BEGIN CATCH
		PRINT 'Modify Error';
	END CATCH
	SET NOCOUNT OFF
END;

-------------------------------------------------DELETE-------------------------------------------------

--use this sp very carefully and be sure to remove any records that have previously been linked to it
CREATE OR ALTER PROCEDURE dbo.deleteCoin
	@coinId int	
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		delete from [ProductsDB].[dbo].[Coin]
		where [Coin].idCoin = @coinId;
	END TRY
	BEGIN CATCH
		PRINT 'Delete Error';
	END CATCH
	SET NOCOUNT OFF
END;

-------------------------------------------------READ-------------------------------------------------

CREATE OR ALTER PROCEDURE dbo.readCoins
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		SELECT [name] from [ProductsDB].[dbo].[Coin]
	END TRY
	BEGIN CATCH
		PRINT 'Read Error';
	END CATCH
	SET NOCOUNT OFF
END;

EXEC readCoins;