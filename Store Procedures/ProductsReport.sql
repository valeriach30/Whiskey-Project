USE ProductsDB
GO;
------ Products Report -----------------------------------
CREATE OR ALTER PROCEDURE productsReport 
    @in_type    VARCHAR(50) = NULL,
	@countryId int = null, --1:Ireland, 2:Scotland, 3:US
	@quantity int = null,
	@sales int = null,
	@year int = null
AS
    BEGIN TRY
		if(@countryId is null)
		BEGIN
        -- Get products from Ireland
			SELECT 
				[Product].idProduct                             AS ProductID,   
				[ProductType].[name]                            AS Category,
				[Product].name                                  AS Product_Name,
				[Product].price                                 AS Price,
				JSON_VALUE([Product].charact, '$.flavour')      AS Flavour,
				JSON_VALUE([Product].charact, '$.year')         AS Year,
				JSON_VALUE([Product].charact, '$.size')         AS Size,
				JSON_VALUE([Product].charact, '$.description')  AS Description,
				[Coin].country                                  AS Country, 
				[IrelandDB].[dbo].[Inventory].quantity          AS Invertory,
				sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 ))					AS Items_Sell
			FROM 
				[ProductsDB].[dbo].[Product]
			INNER JOIN 
                [IrelandDB].[dbo].[Inventory] 
            ON  
                [IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
			INNER JOIN 
                [Coin] 
            ON 
                [Coin].idCoin = [Product].idCoin
			INNER JOIN 
                [ProductType] 
            ON 
                [ProductType].idProductType = [Product].idProductType
			left outer JOIN 
					[SalesDB].[dbo].[Sale]
				ON 
					[Sale].idProduct = [Product].idProduct

			WHERE ((@in_type is null) or(@in_type = [ProductType].idProductType) ) 
					and ((@quantity is null) or ([IrelandDB].[dbo].[Inventory].quantity > @quantity))
					and ((@year is null) or (JSON_VALUE([Product].charact, '$.year')  = @year))
			group by [Product].idProduct,   
						[ProductType].[name],
						[Product].name,
						[Product].price,
						JSON_VALUE([Product].charact, '$.flavour'),
						JSON_VALUE([Product].charact, '$.year'),
						JSON_VALUE([Product].charact, '$.size'),
						JSON_VALUE([Product].charact, '$.description'),
						[Coin].country, 
						[IrelandDB].[dbo].[Inventory].quantity
			having  (@sales is null) or (sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 )) > @sales)
			-- Get products from Scotland
			UNION ALL 
			SELECT 
				[Product].idProduct                             AS ProductID,   
				[ProductType].[name]                            AS Category,
				[Product].name                                  AS Product_Name,
				[Product].price                                 AS Price,
				JSON_VALUE([Product].charact, '$.flavour')      AS Flavour,
				JSON_VALUE([Product].charact, '$.year')         AS Year,
				JSON_VALUE([Product].charact, '$.size')         AS Size,
				JSON_VALUE([Product].charact, '$.description')  AS Description,
				[Coin].country                                  AS Country, 
				[ScotlandDB].[dbo].[Inventory].quantity         AS Invertory,
				sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 ))					AS Items_Sell
			FROM 
				[ProductsDB].[dbo].[Product]
			INNER JOIN 
                [ScotlandDB].[dbo].[Inventory] 
            ON  
                [ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
			INNER JOIN 
                [Coin] 
            ON 
                [Coin].idCoin = [Product].idCoin
			INNER JOIN 
                [ProductType] 
            ON 
                [ProductType].idProductType = [Product].idProductType
			left outer JOIN 
					[SalesDB].[dbo].[Sale]
				ON 
					[Sale].idProduct = [Product].idProduct
			WHERE ((@in_type is null) or(@in_type = [ProductType].idProductType) ) 
					and ((@quantity is null) or ([ScotlandDB].[dbo].[Inventory].quantity > @quantity))
					and ((@year is null) or (JSON_VALUE([Product].charact, '$.year')  = @year))
			group by [Product].idProduct,   
						[ProductType].[name],
						[Product].name,
						[Product].price,
						JSON_VALUE([Product].charact, '$.flavour'),
						JSON_VALUE([Product].charact, '$.year'),
						JSON_VALUE([Product].charact, '$.size'),
						JSON_VALUE([Product].charact, '$.description'),
						[Coin].country, 
						[ScotlandDB].[dbo].[Inventory].quantity
			having  (@sales is null) or (sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 )) > @sales)
			-- Get products from United States

			UNION ALL 
			SELECT 
				[Product].idProduct                             AS ProductID,   
				[ProductType].[name]                            AS Category,
				[Product].name                                  AS Product_Name,
				[Product].price                                 AS Price,
				JSON_VALUE([Product].charact, '$.flavour')      AS Flavour,
				JSON_VALUE([Product].charact, '$.year')         AS Year,
				JSON_VALUE([Product].charact, '$.size')         AS Size,
				JSON_VALUE([Product].charact, '$.description')  AS Description,
				[Coin].country                                  AS Country, 
				[UnitedStatesDB].[dbo].[Inventory].quantity         AS Invertory,
				sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 ))					AS Items_Sell
			FROM 
				[ProductsDB].[dbo].[Product]
			INNER JOIN 
                [UnitedStatesDB].[dbo].[Inventory] 
            ON  
                [UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
			INNER JOIN 
                [Coin] 
            ON 
                [Coin].idCoin = [Product].idCoin
			INNER JOIN 
                [ProductType] 
            ON 
                [ProductType].idProductType = [Product].idProductType
			left outer JOIN 
					[SalesDB].[dbo].[Sale]
				ON 
					[Sale].idProduct = [Product].idProduct
			WHERE ((@in_type is null) or(@in_type = [ProductType].idProductType) ) 
					and ((@quantity is null) or ([UnitedStatesDB].[dbo].[Inventory].quantity > @quantity))
					and ((@year is null) or (JSON_VALUE([Product].charact, '$.year')  = @year))

			group by [Product].idProduct,   
						[ProductType].[name],
						[Product].name,
						[Product].price,
						JSON_VALUE([Product].charact, '$.flavour'),
						JSON_VALUE([Product].charact, '$.year'),
						JSON_VALUE([Product].charact, '$.size'),
						JSON_VALUE([Product].charact, '$.description'),
						[Coin].country,
						[UnitedStatesDB].[dbo].[Inventory].quantity 
			having  (@sales is null) or (sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 )) > @sales)
			END;
		else if(@countryId = 1)
			BEGIN
				SELECT 
					[Product].idProduct                             AS ProductID,   
					[ProductType].[name]                            AS Category,
					[Product].name                                  AS Product_Name,
					[Product].price                                 AS Price,
					JSON_VALUE([Product].charact, '$.flavour')      AS Flavour,
					JSON_VALUE([Product].charact, '$.year')         AS Year,
					JSON_VALUE([Product].charact, '$.size')         AS Size,
					JSON_VALUE([Product].charact, '$.description')  AS Description,
					[Coin].country                                  AS Country, 
					[IrelandDB].[dbo].[Inventory].quantity          AS Invertory,
					sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 ))					AS Items_Sell
				FROM 
					[ProductsDB].[dbo].[Product]
				INNER JOIN 
					[IrelandDB].[dbo].[Inventory] 
				ON  
					[IrelandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN 
					[Coin] 
				ON 
					[Coin].idCoin = [Product].idCoin
				INNER JOIN 
					[ProductType] 
				ON 
					[ProductType].idProductType = [Product].idProductType
				left outer JOIN 
					[SalesDB].[dbo].[Sale]
				ON 
					[Sale].idProduct = [Product].idProduct
				WHERE ((@in_type is null) or(@in_type = [ProductType].idProductType) ) 
					and ((@quantity is null) or ([IrelandDB].[dbo].[Inventory].quantity > @quantity))
					and ((@year is null) or (JSON_VALUE([Product].charact, '$.year')  = @year))
					group by [Product].idProduct,   
						[ProductType].[name],
						[Product].name,
						[Product].price,
						JSON_VALUE([Product].charact, '$.flavour'),
						JSON_VALUE([Product].charact, '$.year'),
						JSON_VALUE([Product].charact, '$.size'),
						JSON_VALUE([Product].charact, '$.description'),
						[Coin].country, 
						[IrelandDB].[dbo].[Inventory].quantity
					having  (@sales is null) or (sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 )) > @sales);

			END;
			else if(@countryId = 2)
			BEGIN
				SELECT 
					[Product].idProduct                             AS ProductID,   
					[ProductType].[name]                            AS Category,
					[Product].name                                  AS Product_Name,
					[Product].price                                 AS Price,
					JSON_VALUE([Product].charact, '$.flavour')      AS Flavour,
					JSON_VALUE([Product].charact, '$.year')         AS Year,
					JSON_VALUE([Product].charact, '$.size')         AS Size,
					JSON_VALUE([Product].charact, '$.description')  AS Description,
					[Coin].country                                  AS Country, 
					[ScotlandDB].[dbo].[Inventory].quantity         AS Invertory,
					sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 ))					AS Items_Sell
				FROM 
					[ProductsDB].[dbo].[Product]
				
				INNER JOIN 
					[ScotlandDB].[dbo].[Inventory] 
				ON  
					[ScotlandDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN 
					[Coin] 
				ON 
					[Coin].idCoin = [Product].idCoin
				INNER JOIN 
					[ProductType] 
				ON 
					[ProductType].idProductType = [Product].idProductType
				left outer JOIN 
					[SalesDB].[dbo].[Sale]
				ON 
					[Sale].idProduct = [Inventory].idProduct
				WHERE ((@in_type is null) or(@in_type = [ProductType].idProductType) ) 
					and ((@quantity is null) or ([ScotlandDB].[dbo].[Inventory].quantity > @quantity))
					and ((@year is null) or (JSON_VALUE([Product].charact, '$.year')  = @year))
				group by [Product].idProduct,   
						[ProductType].[name],
						[Product].name,
						[Product].price,
						JSON_VALUE([Product].charact, '$.flavour'),
						JSON_VALUE([Product].charact, '$.year'),
						JSON_VALUE([Product].charact, '$.size'),
						JSON_VALUE([Product].charact, '$.description'),
						[Coin].country, 
						[ScotlandDB].[dbo].[Inventory].quantity
				having  (@sales is null) or (sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 )) > @sales)
			END;
			else if(@countryId = 3)
			BEGIN
				SELECT 
					[Product].idProduct                             AS ProductID,   
					[ProductType].[name]                            AS Category,
					[Product].name                                  AS Product_Name,
					[Product].price                                 AS Price,
					JSON_VALUE([Product].charact, '$.flavour')      AS Flavour,
					JSON_VALUE([Product].charact, '$.year')         AS Year,
					JSON_VALUE([Product].charact, '$.size')         AS Size,
					JSON_VALUE([Product].charact, '$.description')  AS Description,
					[Coin].country                                  AS Country, 
					[UnitedStatesDB].[dbo].[Inventory].quantity     AS Invertory,
					sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 ))					AS Items_Sell
				FROM 
					[ProductsDB].[dbo].[Product]
				INNER JOIN 
					[UnitedStatesDB].[dbo].[Inventory] 
				ON  
					[UnitedStatesDB].[dbo].[Inventory].idProduct = [Product].idProduct
				INNER JOIN 
					[Coin] 
				ON 
					[Coin].idCoin = [Product].idCoin
				INNER JOIN 
					[ProductType] 
				ON 
					[ProductType].idProductType = [Product].idProductType
				left outer JOIN 
					[SalesDB].[dbo].[Sale]
				ON 
					[Sale].idProduct = [Inventory].idProduct
				WHERE ((@in_type is null) or(@in_type = [ProductType].idProductType) ) 
					and ((@quantity is null) or ([UnitedStatesDB].[dbo].[Inventory].quantity > @quantity))
					and ((@year is null) or (JSON_VALUE([Product].charact, '$.year')  = @year))
				group by [Product].idProduct,   
						[ProductType].[name],
						[Product].name,
						[Product].price,
						JSON_VALUE([Product].charact, '$.flavour'),
						JSON_VALUE([Product].charact, '$.year'),
						JSON_VALUE([Product].charact, '$.size'),
						JSON_VALUE([Product].charact, '$.description'),
						[Coin].country, 
						[UnitedStatesDB].[dbo].[Inventory].quantity
				having  (@sales is null) or (sum(ISNULL([SalesDB].[dbo].[Sale].quantity, 0 )) > @sales);
			END;

    END TRY
    BEGIN CATCH
		PRINT 'Products report error';
	END CATCH
GO

--Test

exec productsReport  @in_type = 1

exec productsReport @sales =0

exec productsReport @countryId =2 ,@sales =1

exec productsReport  @year = 2010

exec productsReport @sales =2

exec productsReport @countryId =3 ,  @quantity =65

--select * from Product
