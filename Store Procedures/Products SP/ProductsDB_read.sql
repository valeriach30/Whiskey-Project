--- Get all the products of the database ---------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE ReadProducts
	@visibleId INT
AS BEGIN
	BEGIN TRY
		-- User can see only the visible products
		IF(@visibleId = 0)
		BEGIN

			-- Get products from Ireland
			SELECT 
				[Product].idProduct,
				[ProductType].[name] as category, 
				[Product].productImage,  
				[Product].name,
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip,
				[Coin].country, 
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM 
				[ProductsDB].[dbo].[Product]
				INNER JOIN [IrelandDB].[dbo].[Inventory] on [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] on [ProductType].idProductType = [Product].idProductType
			WHERE visible=1

			-- Get products from Scotland
			UNION ALL 
			SELECT 
				[Product].idProduct,
				[ProductType].[name] as category, 
				[Product].productImage,  
				[Product].name,
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip,
				[Coin].country, 
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM 
				[ProductsDB].[dbo].[Product]
				INNER JOIN [ScotlandDB].[dbo].[Inventory] on [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] on [ProductType].idProductType = [Product].idProductType
			WHERE visible=1

			-- Get products from United States
			UNION ALL 
			SELECT 
				[Product].idProduct,
				[ProductType].[name] as category, 
				[Product].productImage,  
				[Product].name,
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip,
				[Coin].country, 
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM 
				[ProductsDB].[dbo].[Product]
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] on [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] on [ProductType].idProductType = [Product].idProductType
			WHERE visible=1

			ORDER BY [Product].idProduct
		END;
		
		
		-- User is suscribed, they can view all the products
		ELSE
		BEGIN
			-- Get products from Ireland
			SELECT 
				[Product].idProduct,
				[ProductType].[name] as category, 
				[Product].productImage,  
				[Product].name,
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip,
				[Coin].country, 
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM 
				[ProductsDB].[dbo].[Product]
				INNER JOIN [IrelandDB].[dbo].[Inventory] on [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] on [ProductType].idProductType = [Product].idProductType

			-- Get products from Scotland
			UNION ALL 
			SELECT 
				[Product].idProduct,
				[ProductType].[name] as category, 
				[Product].productImage,  
				[Product].name,
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip,
				[Coin].country, 
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM 
				[ProductsDB].[dbo].[Product]
				INNER JOIN [ScotlandDB].[dbo].[Inventory] on [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] on [ProductType].idProductType = [Product].idProductType

			-- Get products from United States
			UNION ALL 
			SELECT 
				[Product].idProduct,
				[ProductType].[name] as category, 
				[Product].productImage,  
				[Product].name,
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip,
				[Coin].country, 
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM 
				[ProductsDB].[dbo].[Product]
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] on [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] on [ProductType].idProductType = [Product].idProductType

			ORDER BY [Product].idProduct
		END;

	END TRY
	BEGIN CATCH
		PRINT('Show Products Error')
	END CATCH
END

-- Example
EXEC ReadProducts @visibleId = 1;

--- Get 1 products from the database ---------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE ReadProduct
	@inProductId INT,
	@visibleId INT
AS BEGIN
	BEGIN TRY
		-- User can see only the visible products
		IF(@visibleId = 0)
		BEGIN
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] as category, 
				[Product].productImage,  
				[Product].name,[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip
			FROM [Product]
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE visible=1 AND idProduct = @inProductId
		END;
		-- User is suscribed, they can view all the products
		ELSE
		BEGIN
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] as category, 
				[Product].productImage,  
				[Product].name,[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip
			FROM [Product]
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE idProduct = @inProductId
		END;
	END TRY
	BEGIN CATCH
		PRINT('Show Products Error')
	END CATCH
END

-- Example
EXEC ReadProduct @visibleId = 1, @inProductId = 2;
EXEC ReadProduct @visibleId = 1, @inProductId = 10;

--- Get all the reviews of the database ---------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE ReadReviews
	@visible int
AS BEGIN
BEGIN TRY
	SELECT COUNT([Review].idProduct) AS reviews FROM [Product] 
	LEFT JOIN [GeneralDB].[dbo].[Review] ON [Review].idProduct = [Product].idProduct
	WHERE visible=@visible
	GROUP BY [Product].idProduct
	END TRY
	BEGIN CATCH
		PRINT('Show Products Error')
	END CATCH
END

EXEC ReadReviews @coinId = 1, @visible = 1;
