-------------------- Other Store Procedures -------------------
USE [ProductsDB]
GO;

--- Order Products by Price Ascending --------------------------------------
CREATE OR ALTER PROCEDURE orderProductsByPriceASC
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

			ORDER BY Product.price ASC;
		END;

		--- User is suscribed, they can view all the products--------------------------------------------------------------------
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

			ORDER BY Product.price ASC;
		END;
	END TRY
	BEGIN CATCH
		PRINT('Order Products Ascending Error')
	END CATCH
END

-- Example
EXEC orderProductsByPriceASC @visibleId = 1;

--------------------------------------------------------

--- Order Products by Price Descending --------------------------------------
CREATE OR ALTER PROCEDURE orderProductsByPriceDESC
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

			ORDER BY Product.price DESC;
		END;

		--- User is suscribed, they can view all the products---------------------------------------------------------
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

			ORDER BY Product.price DESC;
		END;
	END TRY
	BEGIN CATCH
		PRINT('Order Products Descending Error')
	END CATCH
END

-- Example
EXEC orderProductsByPriceDESC @visibleId = 1;

--------------------------------------------------------

--- Get a Product by name ---------------------------------------------------
CREATE OR ALTER PROCEDURE getProductByName
	@productName VARCHAR(50),
	@visibleId INT
AS BEGIN
	BEGIN TRY
	
	DECLARE @idProduct INT;
	
	-- User can see only the visible products
	IF(@visibleId = 0)
	BEGIN
		-- Validate Product Exists
		SELECT @idProduct = Product.idProduct 
		FROM [ProductsDB].[dbo].[Product] 
		WHERE Product.name = @productName AND Product.visible = 1;

		IF(@idProduct IS NOT NULL) 
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
			WHERE visible=1 AND Product.name = @productName

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
			WHERE visible=1 AND Product.name = @productName

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
			WHERE visible=1 AND Product.name = @productName
			END
		ELSE BEGIN
			SELECT 0; -- Product Doesn't exist
		END
	END;
	-- User is suscribed, they can view all the products
	ELSE
	BEGIN
		-- Validate Product Exists
		SELECT @idProduct = Product.idProduct FROM [ProductsDB].[dbo].[Product] WHERE Product.name = @productName;
		IF(@idProduct IS NOT NULL) 
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
			WHERE Product.name = @productName

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
			WHERE Product.name = @productName

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
			WHERE Product.name = @productName
			END
		ELSE BEGIN
			SELECT 0; -- Product Doesn't exist
		END
	END;
	END TRY
	BEGIN CATCH
		PRINT('Searching Product Error')
	END CATCH
END

-- Example
EXEC getProductByName @productName = 'Chivas Regal', @visibleId = 1;
--------------------------------------------------------

--- Order Products by Popularity Descending --------------------------------------
CREATE OR ALTER PROCEDURE orderProductsByPopularDESC
	@visibleId INT
AS BEGIN
	BEGIN TRY
		-- User can see only the visible products
		IF(@visibleId = 0)
		BEGIN
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
				count([Sale].idSale) as sales,
				[Sale].idSale,
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [IrelandDB].[dbo].[Inventory] on [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			WHERE [ProductsDB].[dbo].[Product].visible = 1
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[IrelandDB].[dbo].[Inventory].quantity
			
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
				count([Sale].idSale) as sales,
				[Sale].idSale,
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [ScotlandDB].[dbo].[Inventory] on [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			WHERE [ProductsDB].[dbo].[Product].visible = 1
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[ScotlandDB].[dbo].[Inventory].quantity
			
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
				[Sale].idSale, 
				count([Sale].idSale) as sales,
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] on [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			WHERE [ProductsDB].[dbo].[Product].visible = 1
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[UnitedStatesDB].[dbo].[Inventory].quantity
			ORDER BY
				[Sale].idSale DESC
		END;
		-- User is suscribed, they can view all the products
		ELSE
		BEGIN
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
				count([Sale].idSale) as sales,
				[Sale].idSale,
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [IrelandDB].[dbo].[Inventory] on [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[IrelandDB].[dbo].[Inventory].quantity
			
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
				count([Sale].idSale) as sales,
				[Sale].idSale,
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [ScotlandDB].[dbo].[Inventory] on [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[ScotlandDB].[dbo].[Inventory].quantity
			
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
				count([Sale].idSale) as sales,
				[Sale].idSale,
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] on [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[UnitedStatesDB].[dbo].[Inventory].quantity
			ORDER BY
				[Sale].idSale DESC

		END;
	END TRY
	BEGIN CATCH
		PRINT('Order Products by popularity Descending Error')
	END CATCH
END

-- Example
EXEC orderProductsByPopularDESC 1;
--------------------------------------------------------

--- Order Products by Popularity Ascending --------------------------------------
CREATE OR ALTER PROCEDURE orderProductsByPopularASC
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
				count([Sale].idSale) as sales,
				[Sale].idSale,
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [IrelandDB].[dbo].[Inventory] on [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			WHERE [ProductsDB].[dbo].[Product].visible = 1
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[IrelandDB].[dbo].[Inventory].quantity
			
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
				count([Sale].idSale) as sales,
				[Sale].idSale,
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [ScotlandDB].[dbo].[Inventory] on [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			WHERE [ProductsDB].[dbo].[Product].visible = 1
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[ScotlandDB].[dbo].[Inventory].quantity
			
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
				count([Sale].idSale) as sales,
				[Sale].idSale,
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] on [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			WHERE [ProductsDB].[dbo].[Product].visible = 1
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[UnitedStatesDB].[dbo].[Inventory].quantity
			ORDER BY
				[Sale].idSale ASC
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
				count([Sale].idSale) as sales,
				[Sale].idSale,
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [IrelandDB].[dbo].[Inventory] on [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[IrelandDB].[dbo].[Inventory].quantity
			
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
				count([Sale].idSale) as sales,
				[Sale].idSale,
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [ScotlandDB].[dbo].[Inventory] on [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[ScotlandDB].[dbo].[Inventory].quantity
			
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
					count([Sale].idSale) as sales,
					[Sale].idSale,
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM [ProductsDB].[dbo].[Product]
				LEFT JOIN [SalesDB].[dbo].[Sale]  on [Product].idProduct = [Sale].idProduct
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] on [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
			GROUP BY 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name], 
				[Product].productImage, 
				[Product].[name],
				[Product].price,
				[Sale].idSale,
				JSON_VALUE([Product].charact, '$.flavour'),
				JSON_VALUE([Product].charact, '$.year'),
				JSON_VALUE([Product].charact, '$.size'),
				JSON_VALUE([Product].charact, '$.description'),
				[Coin].country, 
				[UnitedStatesDB].[dbo].[Inventory].quantity
			ORDER BY
				[Sale].idSale ASC
		END;
	END TRY
	BEGIN CATCH
		PRINT('Order Products by popularity Ascending Error')
	END CATCH
END

-- Example
EXEC orderProductsByPopularASC 1;
--------------------------------------------------------
--- Get the products by the category name -------------------------------------

CREATE OR ALTER PROCEDURE readProdcutsByCat
	@productType varchar(40),
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
			WHERE visible=1 AND [ProductType].name= @productType

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
			WHERE visible=1 AND [ProductType].name= @productType

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
			WHERE visible=1 AND [ProductType].name= @productType
		END;
		-- User is suscribed, they can view all the products
		ELSE
		BEGIN
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') AS flavour,
				JSON_VALUE([Product].charact, '$.year') AS year ,
				JSON_VALUE([Product].charact, '$.size') AS size,
				JSON_VALUE([Product].charact, '$.description') AS descrip
			FROM 
				[ProductsDB].[dbo].[Product]
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				[ProductType].name= @productType 
		END;
	END TRY
	BEGIN CATCH
		PRINT('Products Error')
	END CATCH
END

-- Example
EXEC readProdcutsByCat @productType = 'Irish', @visibleId = 1;




--- order all the products by the most near to the most far -------------------------------------
CREATE OR ALTER PROCEDURE readProdcutsByFar
@locationX float,
@locationY float
AS BEGIN
	BEGIN TRY
		DECLARE @countryCode VARCHAR(8), @distance FLOAT,@location geography;

		SET @location = (geography::Point(@locationX, @locationY, 4326));
		
		SET @distance = (SELECT TOP 1 @location.STDistance([LocationCode].locationMap) AS distance 
						FROM [GeneralDB].[dbo].[LocationCode]
							ORDER BY distance ASC); 

		-- Get the code of the most near country 
		SET @countryCode = (SELECT TOP 1 [LocationCode].code 
						FROM [GeneralDB].[dbo].[LocationCode]
						ORDER BY @location.STDistance([LocationCode].locationMap) ASC);

				
		IF(@countryCode ='IRL')-- Ireland
		BEGIN

			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [IrelandDB].[dbo].[Inventory] ON [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [IrelandDB].[dbo].[Inventory].quantity > 0


			UNION ALL 
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [ScotlandDB].[dbo].[Inventory] ON [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [ScotlandDB].[dbo].[Inventory].quantity > 0

			UNION ALL
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] ON [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [UnitedStatesDB].[dbo].[Inventory].quantity > 0

		END;
		ELSE IF(@countryCode ='SCO')--Scotland
		BEGIN

			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [ScotlandDB].[dbo].[Inventory] ON [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [ScotlandDB].[dbo].[Inventory].quantity > 0

			UNION ALL
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [IrelandDB].[dbo].[Inventory] ON [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [IrelandDB].[dbo].[Inventory].quantity > 0

			UNION ALL
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] ON [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [UnitedStatesDB].[dbo].[Inventory].quantity > 0
		END;
		ELSE IF(@countryCode ='USA')--UnitedStates
		BEGIN
			
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] ON [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [UnitedStatesDB].[dbo].[Inventory].quantity > 0

			UNION ALL
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [ScotlandDB].[dbo].[Inventory] ON [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [ScotlandDB].[dbo].[Inventory].quantity > 0

			UNION ALL
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [IrelandDB].[dbo].[Inventory] ON [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [IrelandDB].[dbo].[Inventory].quantity > 0

		END;

	END TRY
	BEGIN CATCH
		PRINT('Products Error')
	END CATCH
END;


--example

EXEC readProdcutsByFar @locationX = 1,@locationY =1;


--- order all the products by the most far to the most near -------------------------------------
CREATE OR ALTER PROCEDURE readProdcutsByNear
@locationX float,
@locationY float
AS BEGIN
	BEGIN TRY
		DECLARE @countryCode VARCHAR(8), @distance FLOAT,@location geography;

		SET @location = (geography::Point(@locationX, @locationY, 4326));
		
		SET @distance = (SELECT TOP 1 @location.STDistance([LocationCode].locationMap) AS distance 
						FROM [GeneralDB].[dbo].[LocationCode]
							ORDER BY distance ASC); 

		-- Get the code of the most near country 
		SET @countryCode = (SELECT TOP 1 [LocationCode].code 
						FROM [GeneralDB].[dbo].[LocationCode]
						ORDER BY @location.STDistance([LocationCode].locationMap) ASC);

		IF(@countryCode ='IRL')-- Ireland
		BEGIN

			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] ON [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [UnitedStatesDB].[dbo].[Inventory].quantity > 0


			UNION ALL
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [ScotlandDB].[dbo].[Inventory] ON [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [ScotlandDB].[dbo].[Inventory].quantity > 0

			UNION ALL
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [IrelandDB].[dbo].[Inventory] ON [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [IrelandDB].[dbo].[Inventory].quantity > 0

		END;
		ELSE IF(@countryCode ='USA')--Scotland
		BEGIN
			
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] ON [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [UnitedStatesDB].[dbo].[Inventory].quantity > 0

			UNION ALL
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [IrelandDB].[dbo].[Inventory] ON [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [IrelandDB].[dbo].[Inventory].quantity > 0

			UNION ALL
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [ScotlandDB].[dbo].[Inventory] ON [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [ScotlandDB].[dbo].[Inventory].quantity > 0

			
		END;
			ELSE IF(@countryCode ='USA')--Scotland
		BEGIN
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[IrelandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [IrelandDB].[dbo].[Inventory] ON [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [IrelandDB].[dbo].[Inventory].quantity > 0
			

			UNION ALL
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[ScotlandDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [ScotlandDB].[dbo].[Inventory] ON [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [ScotlandDB].[dbo].[Inventory].quantity > 0

			UNION ALL 
			SELECT 
				[Product].idProduct,
				[Coin].country, 
				[ProductType].[name] AS category, 
				[Product].productImage,  
				[Product].[name],
				[Product].price,
				JSON_VALUE([Product].charact, '$.flavour') as flavour,
				JSON_VALUE([Product].charact, '$.year') as year ,
				JSON_VALUE([Product].charact, '$.size') as size,
				JSON_VALUE([Product].charact, '$.description') as descrip, 
				[UnitedStatesDB].[dbo].[Inventory].quantity as invertory
			FROM
				[ProductsDB].[dbo].[Product]
				INNER JOIN [UnitedStatesDB].[dbo].[Inventory] ON [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN [Coin] ON [Coin].idCoin = [Product].idCoin
				INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
			WHERE 
				visible=1 AND [UnitedStatesDB].[dbo].[Inventory].quantity > 0

		END;

	END TRY
	BEGIN CATCH
		PRINT('Products Error')
	END CATCH
END;

-- Example
EXEC readProdcutsByNear @locationX = 1,@locationY =1;


