
--Create a product
CREATE OR ALTER PROCEDURE dbo.CreateProduct
	@quantity INT,
	@idCoin INT,
	@idProctType INT,
	@name VARCHAR(100),
	@price FLOAT,
	@visible BIT,
	@flavour VARCHAR(40),
	@year INT,
	@size INT,
	@description VARCHAR(MAX),
	@productImage NVARCHAR(MAX)
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @checkCoin INT, @checkProducType INT, @image VARBINARY(MAX), 
		@str NVARCHAR(MAX), @json1 NVARCHAR(MAX), @idProduct INT;
		
		SET @json1 = N'{ "flavour": ' + '"' + @flavour + '"' +
		', "year":' + STR(@year) + 
		', "size":' + STR(@size) + 
		', "description":' + '"' + @description + '"' + '}';

		SET @str =  N'SELECT @productImage = CAST( bulkcolumn AS VARBINARY(max) ) FROM '

		SET @str += N' OPENROWSET( BULK '''

		SET @str += @productImage

		SET @str += N''', SINGLE_BLOB ) AS x'

		EXEC sp_executeSQL @STR, N'@productImage varbinary(max) OUT', @image OUTPUT

		SET @checkCoin = (SELECT idCoin FROM [ProductsDB].[dbo].[Coin] WHERE @idCoin = idCoin);

		SET @checkProducType = (SELECT idProductType FROM [ProductsDB].[dbo].[ProductType] WHERE @idProctType = idProductType);

		if(@checkCoin is not null and @checkProducType is not null)
		BEGIN
			
			-- Insert product
			INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
			VALUES (@idCoin, @idProctType, @name, @price, @json1, @visible, @image);

			-- Get the product id
			SELECT @idProduct = idProduct
			FROM Product
			WHERE name = @name;

			-- Add to country inventory
			-- Ireland
			IF(@idCoin = 1) 
			BEGIN
				INSERT INTO [IrelandDB].[dbo].[Inventory](idProduct, quantity)
				VALUES (@idProduct, @quantity);
			END;
			ELSE
			BEGIN
				-- Scotland
				IF(@idCoin = 2) 
				BEGIN
					INSERT INTO [ScotlandDB].[dbo].[Inventory](idProduct, quantity)
					VALUES (@idProduct, @quantity);
				END;
				ELSE
				BEGIN
					-- USA
					IF(@idCoin = 3) 
					BEGIN
						INSERT INTO [UnitedStatesDB].[dbo].[Inventory](idProduct, quantity)
						VALUES (@idProduct, @quantity);
					END;
					ELSE
					BEGIN
						SELECT '0';
					END;
				END;
			END;
		END;
		ELSE
			SELECT 'Coin or Product type no exist';

	END TRY
	BEGIN CATCH
		SELECT 'Product error';
	END CATCH
	SET NOCOUNT OFF
END;

--Example
EXEC CreateProduct  @quantity = 10, @idCoin = 2 , 
@idProctType = 2 ,@name= 'Chivas Regal', 
@price= 32.99, @visible = 1, @productImage =  'C:/Images/ChivasRegal-BlendedScotch.jpg', 
@flavour = 'fruity', @year = 2010, @size = 750, @description = 'Chivas Regal is the number one super premium Scotch whisky in Europe and Asia. Produced at the oldest continuously operating distillery in the Highlands, Chivas range of exclusive whiskies matured between 10 and 25 years are timeless classics.'

---------------------------------------------------------------------------------------------------------------------------

-- Modify a product
CREATE OR ALTER PROCEDURE dbo.UpdateProduct
	@idProduct INT, 
	@idCoin INT,
	@idProctType INT,
	@name VARCHAR(100),
	@price FLOAT,
	@visible BIT,
	@flavour VARCHAR(40),
	@year INT,
	@size INT,
	@description VARCHAR(MAX),
	@productImage NVARCHAR(MAX)AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @checkCoin INT, @checkProducType INT, @image VARBINARY(MAX), @str NVARCHAR(MAX), @json1 NVARCHAR(MAX);
		
		SET @json1 = N'{ "flavour": ' + '"' + @flavour + '"' +
		', "year":' + STR(@year) + 
		', "size":' + STR(@size) + 
		', "description":' + '"' + @description + '"' + '}';

		SET @str =  N'SELECT @productImage = CAST( bulkcolumn AS VARBINARY(max) ) FROM '

		SET @str += N' OPENROWSET( BULK '''

		SET @str += @productImage

		SET @str += N''', SINGLE_BLOB ) AS x'

		EXEC sp_executeSQL @STR, N'@productImage varbinary(max) OUT', @image OUTPUT

		SET @checkCoin = (SELECT idCoin FROM [ProductsDB].[dbo].[Coin] WHERE @idCoin = idCoin);

		SET @checkProducType = (SELECT idProductType FROM [ProductsDB].[dbo].[ProductType] WHERE @idProctType = idProductType);

		if(@checkCoin is not null and @checkProducType is not null)
		BEGIN
			UPDATE [ProductsDB].[dbo].[Product] 
				SET idCoin =@idCoin, 
					idProductType = @idProctType, 
					[name]= @name, 
					price= @price, 
					charact=@json1, 
					visible = @visible, 
					productImage = @image
			WHERE idProduct = @idProduct
		END;
		ELSE
			print 'Coin or Product type no exist';

	END TRY
	BEGIN CATCH
		PRINT 'Product error';
	END CATCH
	SET NOCOUNT OFF
END;

--Example

EXEC UpdateProduct @idProduct = 73, @idCoin = 2 , 
@idProctType = 2 ,@name= 'Chivas Regal', 
@price= 40.99, @visible = 1, @productImage =  'C:/Images/ChivasRegal-BlendedScotch.jpg', 
@flavour = 'fruity', @year = 2010, @size = 750, @description = 'Chivas Regal is the number one super premium Scotch whisky in Europe and Asia. Produced at the oldest continuously operating distillery in the Highlands, Chivas range of exclusive whiskies matured between 10 and 25 years are timeless classics.'

SELECT * FROM Product


---------------------------------------------------------------------------------------------------------------------------

-- Delete product
CREATE OR ALTER PROCEDURE dbo.deleteProduct
	@idProduct int	
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		-- Delete the product 
		DELETE FROM [ProductsDB].[dbo].[Product]
		WHERE [Product].idProduct = @idProduct;

	END TRY
	BEGIN CATCH
		PRINT 'Delete Error';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test 
EXEC deleteProduct @idProduct = 73;