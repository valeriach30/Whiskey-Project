--- Get all the products of the database ---------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE ReadProducts
	@coinId INT, -- It is FILTER BY Coins Category
	@visibleId INT
AS BEGIN
	BEGIN TRY
		-- User can see only the visible products
		IF(@visibleId = 0)
		BEGIN
			SELECT [Product].idProduct,[Coin].country, [ProductType].[name] as category, [Product].productImage,  
			[Product].name,[Product].price,JSON_VALUE([Product].charact, '$.flavour') as flavour,
			JSON_VALUE([Product].charact, '$.year') as year ,JSON_VALUE([Product].charact, '$.size') as size,
			JSON_VALUE([Product].charact, '$.description') as descrip
			from [Product]
			inner join [Coin] on [Coin].idCoin = [Product].idCoin
			inner join [ProductType] on [ProductType].idProductType = [Product].idProductType
			where [Coin].idCoin = @coinId and visible=1
		END;
		-- User is suscribed, they can view all the products
		ELSE
		BEGIN
			SELECT [Product].idProduct,[Coin].country, [ProductType].[name] as category, [Product].productImage,  
			[Product].name,[Product].price,JSON_VALUE([Product].charact, '$.flavour') as flavour,
			JSON_VALUE([Product].charact, '$.year') as year ,JSON_VALUE([Product].charact, '$.size') as size,
			JSON_VALUE([Product].charact, '$.description') as descrip
			from [Product]
			inner join [Coin] on [Coin].idCoin = [Product].idCoin
			inner join [ProductType] on [ProductType].idProductType = [Product].idProductType
			where [Coin].idCoin = @coinId
		END;

	END TRY
	BEGIN CATCH
		PRINT('Show Products Error')
	END CATCH
END


-- Example
EXEC ReadProducts @coinId = 1, @visibleId = 1;


--- Get 1 products from the database ---------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE ReadProduct
	@coinId INT, -- It is FILTER BY Coins Category
	@inProductId INT
AS BEGIN
	BEGIN TRY
		SELECT [Product].idProduct,[Coin].country, [ProductType].[name] as category, [Product].productImage,  
        [Product].name,[Product].price,JSON_VALUE([Product].charact, '$.flavour') as flavour,
		JSON_VALUE([Product].charact, '$.year') as year ,JSON_VALUE([Product].charact, '$.size') as size,
		JSON_VALUE([Product].charact, '$.description') as descrip
		from [Product]
		inner join [Coin] on [Coin].idCoin = [Product].idCoin
		inner join [ProductType] on [ProductType].idProductType = [Product].idProductType
		where [Coin].idCoin = @coinId and visible=1 and idProduct = @inProductId


	END TRY
	BEGIN CATCH
		PRINT('Show Products Error')
	END CATCH
END

-- Example
EXEC ReadProduct @coinId = 1, @inProductId = 1;

--- Get all the reviews of the database ---------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE ReadReviews
@coinId int, @visible int
AS BEGIN
BEGIN TRY
	SELECT COUNT([Review].idProduct) AS reviews FROM [Product] 
	LEFT JOIN [GeneralDB].[dbo].[Review] ON [Review].idProduct = [Product].idProduct
	WHERE idCoin = @coinId AND visible=@visible
	GROUP BY [Product].idProduct
	END TRY
	BEGIN CATCH
		PRINT('Show Products Error')
	END CATCH
END

EXEC ReadReviews @coinId = 1, @visible = 1;

--- Get all the products with reviews count------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE dbo.reviewsCount
	@productId int
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY

		SELECT 
			[Product].idProduct,
			[Coin].country, 
			[ProductType].[name] AS category, 
			[Product].productImage,  
			[Product].[name],
			[Product].price,
			COUNT([Review].idReview) AS cantidadReviews 
		FROM [ProductsDB].[dbo].[Product]
			LEFT JOIN [GeneralDB].[dbo].[Review] on [Review].[idProduct] = [Product].[idProduct]
			INNER JOIN [ProductsDB].[dbo].[Coin] on [Coin].idCoin = [Product].idCoin
			INNER JOIN [ProductsDB].[dbo].[ProductType] on [ProductType].idProductType = [Product].idProductType
		GROUP BY 
			[Product].idProduct,
			[Coin].country, 
			[ProductType].[name], 
			[Product].productImage, 
			[Product].[name],
			[Product].price
		
	END TRY
	BEGIN CATCH
		PRINT 'Product error';
	END CATCH
	SET NOCOUNT OFF
END;

exec reviewsCount 10
