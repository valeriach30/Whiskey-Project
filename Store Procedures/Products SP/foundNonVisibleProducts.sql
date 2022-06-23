-- Found non visible Products
CREATE PROCEDURE foundNonVisibleProducts 
AS BEGIN
	BEGIN TRY
		SELECT 
			[Coin].name,
			[Coin].country,
			[ProductType].[name] as category, 
			[Product].productImage,
        	[Product].name,
        	[Product].price,
        	JSON_VALUE([Product].charact, '$.flavour') as flavour,
			JSON_VALUE([Product].charact, '$.year') as year,
			JSON_VALUE([Product].charact, '$.size') as size
		FROM [Coin]
			INNER JOIN [Product] ON [Coin].idCoin = [Product].idCoin
			INNER JOIN [ProductType] ON [ProductType].idProductType = [Product].idProductType
		WHERE [Product].visible = 0;
	END TRY
	BEGIN CATCH
		PRINT('Found Products Error')
	END CATCH
END

-- Example
EXEC foundNonVisibleProducts;