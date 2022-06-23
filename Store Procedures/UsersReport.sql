
------ Users Report -----------------------------------
CREATE OR ALTER PROCEDURE usersReport 
    @subType int = null,
	@countryId int = null, --1:Ireland, 2:Scotland, 3:US
	@saleId int = null,
	@shipping float = null,
	@date date = null
AS
    BEGIN TRY
		--------------- NO COUNTRY ---------------
		IF (@countryId IS NULL )
		BEGIN
		
			SELECT [UserxPlace].idUser AS UserId,
				[User].idUser AS UserIdContry,
				[UserxPlace].idCode AS country,
				[USER].[username] AS Username,
				ISNULL([SuscriptionType].name, 'No Sub' ) AS SubscriptionName,
				[Product].name AS Product,
				[Sale].quantity AS Quantity,
				[Sale].deliveryCost AS Shipping,
				[Delievery].delieveryDate AS DeliveryDate

	
			FROM [GeneralDB].[dbo].UserxPlace

			LEFT OUTER JOIN [GeneralDB].[dbo].Suscription
			ON [UserxPlace].idUser = [Suscription].idUser

			LEFT OUTER JOIN [GeneralDB].[dbo].SuscriptionType
			ON [SuscriptionType].idSuscriptionType = [Suscription].idSuscriptionType

			LEFT OUTER JOIN [IrelandDB].[dbo].[User]
			ON [IrelandDB].[dbo].[User].idUser = [UserxPlace].idUser
			
			LEFT OUTER JOIN [SalesDB].[dbo].[Sale]
			ON [Sale].idUser = [UserxPlace].idUser

			LEFT OUTER JOIN [ProductsDB].[dbo].[Product]
			ON [Sale].idProduct = [Product].idProduct

			FULL outer join [SalesDB].[dbo].[Delievery]
			ON [Sale].idDelievery = [Delievery].idDelievery
			
			WHERE ((@subType IS NULL) OR ([SuscriptionType].idSuscriptionType IS NOT NULL AND @subType = [SuscriptionType].idSuscriptionType))
				AND ((@saleId IS NULL) OR ([Sale].idSale IS NOT NULL AND @saleId = [Sale].idSale))
				AND ((@shipping IS NULL) OR ([Sale].deliveryCost IS NOT NULL AND [Sale].deliveryCost > @shipping))
				AND ((@date IS NULL) OR ([Delievery].delieveryDate IS NOT NULL AND [Delievery].delieveryDate > @date))
				AND [UserxPlace].idUser IS NOT NULL	
				AND [UserxPlace].idCode =1
			GROUP BY 
				[UserxPlace].idUser,
				[User].idUser ,
				[UserxPlace].idCode,
				[USER].[username],
				[SuscriptionType].name, 
				[Product].name,
				[Sale].quantity,
				[Sale].deliveryCost,
				[Delievery].delieveryDate
			
			UNION ALL
			SELECT [UserxPlace].idUser AS UserId,
				[User].idUser AS UserIdContry,
				[UserxPlace].idCode AS country,
				[USER].[username] AS Username,
				ISNULL([SuscriptionType].name, 'No Sub' )	 AS SubscriptionName,
				[Product].name AS Product,
				[Sale].quantity AS Quantity,
				[Sale].deliveryCost AS Shipping,
				[Delievery].delieveryDate AS DeliveryDate

	
			FROM [GeneralDB].[dbo].UserxPlace

			LEFT OUTER JOIN [GeneralDB].[dbo].Suscription
			ON [UserxPlace].idUser = [Suscription].idUser

			LEFT OUTER JOIN [GeneralDB].[dbo].SuscriptionType
			ON [SuscriptionType].idSuscriptionType = [Suscription].idSuscriptionType

			LEFT OUTER JOIN [ScotlandDB].[dbo].[User]
			ON [ScotlandDB].[dbo].[User].idUser = [UserxPlace].idUser
			
			LEFT OUTER JOIN [SalesDB].[dbo].[Sale]
			ON [Sale].idUser = [UserxPlace].idUser

			LEFT OUTER JOIN [ProductsDB].[dbo].[Product]
			ON [Sale].idProduct = [Product].idProduct

			FULL outer join [SalesDB].[dbo].[Delievery]
			ON [Sale].idDelievery = [Delievery].idDelievery

			WHERE ((@subType IS NULL) OR ([SuscriptionType].idSuscriptionType IS NOT NULL AND @subType = [SuscriptionType].idSuscriptionType))
				AND ((@saleId IS NULL) OR ([Sale].idSale IS NOT NULL AND @saleId = [Sale].idSale))
				AND ((@shipping IS NULL) OR ([Sale].deliveryCost IS NOT NULL AND [Sale].deliveryCost > @shipping))
				AND ((@date IS NULL) OR ([Delievery].delieveryDate IS NOT NULL AND [Delievery].delieveryDate > @date))
				AND [UserxPlace].idUser IS NOT NULL	
				AND [UserxPlace].idCode =2
			GROUP BY 
				[UserxPlace].idUser,
				[User].idUser,
				[UserxPlace].idCode,
				[USER].[username],
				[SuscriptionType].name, 
				[Product].name,
				[Sale].quantity,
				[Sale].deliveryCost,
				[Delievery].delieveryDate
			
			UNION ALL
			SELECT [UserxPlace].idUser AS UserId,
				[User].idUser AS UserIdContry,
				[UserxPlace].idCode AS country,
				[USER].[username] AS Username,
				ISNULL([SuscriptionType].name, 'No Sub' )	 AS SubscriptionName,
				[Product].name AS Product,
				[Sale].quantity AS Quantity,
				[Sale].deliveryCost AS Shipping,
				[Delievery].delieveryDate AS DeliveryDate

	
			FROM [GeneralDB].[dbo].UserxPlace

			LEFT OUTER JOIN [GeneralDB].[dbo].Suscription
			ON [UserxPlace].idUser = [Suscription].idUser

			LEFT OUTER JOIN [GeneralDB].[dbo].SuscriptionType
			ON [SuscriptionType].idSuscriptionType = [Suscription].idSuscriptionType

			LEFT OUTER JOIN [UnitedStatesDB].[dbo].[User]
			ON [UnitedStatesDB].[dbo].[User].idUser = [UserxPlace].idUser
			
			LEFT OUTER JOIN [SalesDB].[dbo].[Sale]
			ON [Sale].idUser = [UserxPlace].idUser

			LEFT OUTER JOIN [ProductsDB].[dbo].[Product]
			ON [Sale].idProduct = [Product].idProduct

			FULL outer join [SalesDB].[dbo].[Delievery]
			ON [Sale].idDelievery = [Delievery].idDelievery

			WHERE ((@subType IS NULL) OR ([SuscriptionType].idSuscriptionType IS NOT NULL AND @subType = [SuscriptionType].idSuscriptionType))
				AND ((@saleId IS NULL) OR ([Sale].idSale IS NOT NULL AND @saleId = [Sale].idSale))
				AND ((@shipping IS NULL) OR ([Sale].deliveryCost IS NOT NULL AND [Sale].deliveryCost > @shipping))
				AND ((@date IS NULL) OR ([Delievery].delieveryDate IS NOT NULL AND [Delievery].delieveryDate > @date))
				AND [UserxPlace].idUser IS NOT NULL	
				AND [UserxPlace].idCode =3
			GROUP BY 
				[UserxPlace].idUser,
				[User].idUser,
				[UserxPlace].idCode,
				[USER].[username],
				[SuscriptionType].name, 
				[Product].name,
				[Sale].quantity,
				[Sale].deliveryCost,
				[Delievery].delieveryDate

		END;
		
		
		--------------- ONLY IRELAND ---------------

		ELSE IF(@countryId = 1 )
		BEGIN
			SELECT [UserxPlace].idUser AS UserId,
				[User].idUser AS UserIdContry,
				[UserxPlace].idCode AS country,
				[USER].[username] AS Username,
				ISNULL([SuscriptionType].name, 'No Sub' )	 AS SubscriptionName,
				[Product].name AS Product,
				[Sale].quantity AS Quantity,
				[Sale].deliveryCost AS Shipping,
				[Delievery].delieveryDate AS DeliveryDate

	
			FROM [GeneralDB].[dbo].UserxPlace

			LEFT OUTER JOIN [GeneralDB].[dbo].Suscription
			ON [UserxPlace].idUser = [Suscription].idUser

			LEFT OUTER JOIN [GeneralDB].[dbo].SuscriptionType
			ON [SuscriptionType].idSuscriptionType = [Suscription].idSuscriptionType

			LEFT OUTER JOIN [IrelandDB].[dbo].[User]
			ON [IrelandDB].[dbo].[User].idUser = [UserxPlace].idUser
			
			LEFT OUTER JOIN [SalesDB].[dbo].[Sale]
			ON [Sale].idUser = [UserxPlace].idUser

			LEFT OUTER JOIN [ProductsDB].[dbo].[Product]
			ON [Sale].idProduct = [Product].idProduct

			FULL outer join [SalesDB].[dbo].[Delievery]
			ON [Sale].idDelievery = [Delievery].idDelievery
			
			WHERE ((@subType IS NULL) OR ([SuscriptionType].idSuscriptionType IS NOT NULL AND @subType = [SuscriptionType].idSuscriptionType))
				AND ((@saleId IS NULL) OR ([Sale].idSale IS NOT NULL AND @saleId = [Sale].idSale))
				AND ((@shipping IS NULL) OR ([Sale].deliveryCost IS NOT NULL AND [Sale].deliveryCost > @shipping))
				AND ((@date IS NULL) OR ([Delievery].delieveryDate IS NOT NULL AND [Delievery].delieveryDate > @date))
				AND [UserxPlace].idUser IS NOT NULL	
				AND [UserxPlace].idCode =1
			GROUP BY 
				[UserxPlace].idUser,
				[User].idUser,
				[UserxPlace].idCode,
				[USER].[username],
				[SuscriptionType].name, 
				[Product].name,
				[Sale].quantity,
				[Sale].deliveryCost,
				[Delievery].delieveryDate;
		END;

		--------------- ONLY SCOTLAND ---------------
		ELSE IF (@countryId = 2)
		BEGIN
			SELECT [UserxPlace].idUser AS UserId,
				[User].idUser AS UserIdContry,
				[UserxPlace].idCode AS country,
				[USER].[username] AS Username,
				ISNULL([SuscriptionType].name, 'No Sub' )	 AS SubscriptionName,
				[Product].name AS Product,
				[Sale].quantity AS Quantity,
				[Sale].deliveryCost AS Shipping,
				[Delievery].delieveryDate AS DeliveryDate

	
			FROM [GeneralDB].[dbo].UserxPlace

			LEFT OUTER JOIN [GeneralDB].[dbo].Suscription
			ON [UserxPlace].idUser = [Suscription].idUser

			LEFT OUTER JOIN [GeneralDB].[dbo].SuscriptionType
			ON [SuscriptionType].idSuscriptionType = [Suscription].idSuscriptionType

			LEFT OUTER JOIN [ScotlandDB].[dbo].[User]
			ON [ScotlandDB].[dbo].[User].idUser = [UserxPlace].idUser
			
			LEFT OUTER JOIN [SalesDB].[dbo].[Sale]
			ON [Sale].idUser = [UserxPlace].idUser

			LEFT OUTER JOIN [ProductsDB].[dbo].[Product]
			ON [Sale].idProduct = [Product].idProduct

			FULL outer join [SalesDB].[dbo].[Delievery]
			ON [Sale].idDelievery = [Delievery].idDelievery

			WHERE ((@subType IS NULL) OR ([SuscriptionType].idSuscriptionType IS NOT NULL AND @subType = [SuscriptionType].idSuscriptionType))
				AND ((@saleId IS NULL) OR ([Sale].idSale IS NOT NULL AND @saleId = [Sale].idSale))
				AND ((@shipping IS NULL) OR ([Sale].deliveryCost IS NOT NULL AND [Sale].deliveryCost > @shipping))
				AND ((@date IS NULL) OR ([Delievery].delieveryDate IS NOT NULL AND [Delievery].delieveryDate > @date))
				AND [UserxPlace].idUser IS NOT NULL	
				AND [UserxPlace].idCode =2
			GROUP BY 
				[UserxPlace].idUser,
				[User].idUser,
				[UserxPlace].idCode,
				[USER].[username],
				[SuscriptionType].name, 
				[Product].name,
				[Sale].quantity,
				[Sale].deliveryCost,
				[Delievery].delieveryDate;
		
		END;

		--------------- ONLY UNITED STATES ---------------
		ELSE IF (@countryId = 3)
		BEGIN
			SELECT [UserxPlace].idUser AS UserId,
				[User].idUser AS UserIdContry,
				[UserxPlace].idCode AS country,
				[USER].[username] AS Username,
				ISNULL([SuscriptionType].name, 'No Sub' )	 AS SubscriptionName,
				[Product].name AS Product,
				[Sale].quantity AS Quantity,
				[Sale].deliveryCost AS Shipping,
				[Delievery].delieveryDate AS DeliveryDate

	
			FROM [GeneralDB].[dbo].UserxPlace

			LEFT OUTER JOIN [GeneralDB].[dbo].Suscription
			ON [UserxPlace].idUser = [Suscription].idUser

			LEFT OUTER JOIN [GeneralDB].[dbo].SuscriptionType
			ON [SuscriptionType].idSuscriptionType = [Suscription].idSuscriptionType

			LEFT OUTER JOIN [UnitedStatesDB].[dbo].[User]
			ON [UnitedStatesDB].[dbo].[User].idUser = [UserxPlace].idUser
			
			LEFT OUTER JOIN [SalesDB].[dbo].[Sale]
			ON [Sale].idUser = [UserxPlace].idUser

			LEFT OUTER JOIN [ProductsDB].[dbo].[Product]
			ON [Sale].idProduct = [Product].idProduct

			FULL outer join [SalesDB].[dbo].[Delievery]
			ON [Sale].idDelievery = [Delievery].idDelievery

			WHERE ((@subType IS NULL) OR ([SuscriptionType].idSuscriptionType IS NOT NULL AND @subType = [SuscriptionType].idSuscriptionType))
				AND ((@saleId IS NULL) OR ([Sale].idSale IS NOT NULL AND @saleId = [Sale].idSale))
				AND ((@shipping IS NULL) OR ([Sale].deliveryCost IS NOT NULL AND [Sale].deliveryCost > @shipping))
				AND ((@date IS NULL) OR ([Delievery].delieveryDate IS NOT NULL AND [Delievery].delieveryDate > @date))
				AND [UserxPlace].idUser IS NOT NULL	
				AND [UserxPlace].idCode =3
			GROUP BY 
				[UserxPlace].idUser,
				[User].idUser,
				[UserxPlace].idCode,
				[USER].[username],
				[SuscriptionType].name, 
				[Product].name,
				[Sale].quantity,
				[Sale].deliveryCost,
				[Delievery].delieveryDate;
		END;
    END TRY
    BEGIN CATCH
		PRINT 'User report error';
	END CATCH
GO



--examples

exec usersReport  @subtype =1 , @shipping = 1.0 
exec usersReport  @countryId =3, @subtype =2 