use SalesDB
go

-- Pruchase SP
CREATE OR ALTER PROCEDURE dbo.purchase
	@productId INT,
	@quantity INT,
	@idUser	 INT, -- this id is from the GeneralDB database							
	@idSeller INT,
	@idDelieveryPerson INT,
	@locationName VARCHAR(20),
	@locationX FLOAT, --coordinates of the users selected location  
	@locationY FLOAT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		
		DECLARE @checkProduct INT, @inventory INT, @location GEOGRAPHY;

		-- Set the location
		SET @location = (geography::Point(@locationX, @locationY, 4326));

		-- Determine if the product exists
		SET @checkProduct = (SELECT [Product] .[idProduct] 
							FROM [ProductsDB].[dbo].[Product]
							WHERE [Product] .[idProduct] = @productId);

		-- Product exists
		IF(@checkProduct IS NOT NULL)
		BEGIN

			DECLARE @countryCode VARCHAR(8), @distance FLOAT, @productName VARCHAR(100);

			-- Get the distance between the most near country with the @location
			SET @distance = (SELECT TOP 1 @location.STDistance([LocationCode].locationMap) AS distance 
							FROM [GeneralDB].[dbo].[LocationCode]
							ORDER BY distance ASC); 

			-- Get the code of the most near country 
			SET @countryCode = (SELECT TOP 1 [LocationCode].code 
								FROM [GeneralDB].[dbo].[LocationCode]
								ORDER BY @location.STDistance([LocationCode].locationMap) ASC);

			-- Get the name of the product
			SET @productName = (SELECT name 
								FROM ProductsDB.dbo.Product 
								WHERE Product.[idProduct] = @productId);
			
			-- Get the inventory from the respective country
			
			IF(@countryCode ='IRL')-- Ireland
			BEGIN
				SET @inventory = (SELECT [Inventory].[quantity]
								 FROM [IrelandDB].[dbo].[Inventory]
								 INNER JOIN [ProductsDB].[dbo].[Product] ON [Product].idProduct = [Inventory].[idProduct]
								 WHERE [Product].name = @productName);
				IF(@inventory<=0)
				BEGIN
				-- Not enough inventory
				SET @countryCode = (SELECT TOP 1 [LocationCode].code 
								FROM [GeneralDB].[dbo].[LocationCode]
								WHERE [LocationCode].code != @countryCode
								ORDER BY @location.STDistance([LocationCode].locationMap) ASC);
				END;
			END;
			IF(@countryCode ='SCO')--Scotland
			BEGIN
				SET @inventory = (SELECT [Inventory].[quantity]  
								 FROM [ScotlandDB].[dbo].[Inventory]
								 INNER JOIN [ProductsDB].[dbo].[Product] ON [Product].idProduct = [Inventory].[idProduct]
								 WHERE [Product].name = @productName);
				-- Not enough inventory
				IF(@inventory<=0)
				BEGIN
				SET @countryCode = (SELECT TOP 1 [LocationCode].code 
								FROM [GeneralDB].[dbo].[LocationCode]
								WHERE [LocationCode].code != @countryCode
								ORDER BY @location.STDistance([LocationCode].locationMap) ASC);
				IF(@countryCode='IRL')
				BEGIN
					SET @inventory = (SELECT [Inventory].[quantity]
								 FROM [IrelandDB].[dbo].[Inventory]
								 INNER JOIN [ProductsDB].[dbo].[Product] ON [Product].idProduct = [Inventory].[idProduct]
								 WHERE [Product].name = @productName);
					IF(@inventory <= 0)
					BEGIN
					SET @countryCode = 'SCO';
					END;
				END;
				END;
			END;
			IF(@countryCode ='USA')--UnitedStates
			BEGIN
				SET @inventory = (SELECT [Inventory].[quantity]  
								 FROM [UnitedStatesDB].[dbo].[Inventory]
								 INNER JOIN [ProductsDB].[dbo].[Product] ON [Product].idProduct = [Inventory].[idProduct]
								 WHERE [Product].name = @productName);
				-- Not enough inventory
				IF(@inventory<=0)
				BEGIN
				SET @countryCode = (SELECT TOP 1 [LocationCode].code 
								FROM [GeneralDB].[dbo].[LocationCode]
								WHERE [LocationCode].code != @countryCode
								ORDER BY @location.STDistance([LocationCode].locationMap) ASC);
				IF(@countryCode='IRL')
				BEGIN
					SET @inventory = (SELECT [Inventory].[quantity]
								 FROM [IrelandDB].[dbo].[Inventory]
								 INNER JOIN [ProductsDB].[dbo].[Product] ON [Product].idProduct = [Inventory].[idProduct]
								 WHERE [Product].name = @productName);
					IF(@inventory <= 0)
					BEGIN
						SET @inventory = (SELECT [Inventory].[quantity]
								 FROM [IrelandDB].[dbo].[Inventory]
								 INNER JOIN [ProductsDB].[dbo].[Product] ON [Product].idProduct = [Inventory].[idProduct]
								 WHERE [Product].name = @productName);
					END;
				END;
				END;
			END;
			
			-- Determine if there is enough inventory for the order
			IF(@inventory IS NOT NULL AND @inventory > @quantity)
				BEGIN
					DECLARE @lastDelivery INT, @typeSub INT , @discountShipping FLOAT,
					@discount FLOAT, @total FLOAT, @productCost FLOAT, @shipping FLOAT;

					-- Determine the suscription of the user
					SET @typeSub =(SELECT [Suscription].idSuscriptionType 
								  FROM [GeneralDB].[dbo].[Suscription]
								  WHERE [Suscription].idUser = @idUser);

					if(@typeSub IS NOT NULL) -- if there is a subscription
					BEGIN
						-- Get discount for buying 
						SET @discount =(SELECT dicosuntBuy
									   FROM [GeneralDB].[dbo].[SuscriptionType] 
									   WHERE [SuscriptionType].idSuscriptionType = @typeSub);
						
						-- Get discount on shipping
						SET @discountShipping = (SELECT discountShipping
									   FROM [GeneralDB].[dbo].[SuscriptionType] 
									   WHERE [SuscriptionType].idSuscriptionType = @typeSub);
					END;
					ELSE --there is no subscription
					BEGIN 
						SET @discount=0;
						SET @discountShipping=0;
					END;

					-- Get the price of the product then multiply it by the quantity and subtract the discount
					SET @productCost =(SELECT [Product].[price] 
									   FROM [ProductsDB].[dbo].[Product] 
									   WHERE [Product].[idProduct] = @productId);

					-- Apply discount
					SET @discount = (@discount / 100) * @productCost

					SET @productCost = @productCost - @discount;

					-- Total amount to pay
					SET @total = @productCost * @quantity; 

					-- Set  the shipping cost by adding the distance by 1000 to the total , maybe this could change
					SET @shipping = @distance / 1000;

					-- Apply shipping discount
					SET @shipping = @shipping - ((@discountShipping / 100) * @shipping);

					-- Total amount to pay
					SET @total = @total + ( @shipping);

					-- Update Inventory
					IF(@countryCode ='IRL')-- Ireland
					BEGIN
						UPDATE [IrelandDB].[dbo].[Inventory] 
						SET [Inventory].[quantity] = [Inventory].[quantity] - @quantity;
					END;

					ELSE IF(@countryCode ='SCO')--Scotland
					BEGIN
						UPDATE [ScotlandDB].[dbo].[Inventory] 
						SET [Inventory].[quantity] = [Inventory].[quantity] - @quantity;
					END;
					ELSE IF(@countryCode ='USA')--UnitedStates
					BEGIN
						UPDATE [UnitedStatesDB].[dbo].[Inventory] 
						SET [Inventory].[quantity] = [Inventory].[quantity] - @quantity;
					END;

					-- Make the json for the delievery adress
					DECLARE @json1 NVARCHAR(MAX) = N'{ '+
						 + @locationName + ': [
							{"X" : ' + STR(@locationX, 25, 15) + ', "Y":' + STR(@locationY, 25, 15) + '}
						]
					}';

					-- The date of the sale is the current date, so it is not used as a parameter 
					INSERT INTO Delievery(idDelieveryPerson,address,delieveryDate) 
					VALUES (@idDelieveryPerson,@json1,GETDATE());

					-- Gets the last delievery 
					SET @lastDelivery = (SELECT top 1 [Delievery].[idDelievery] 
										FROM [SalesDB].[dbo].[Delievery] 
										ORDER BY [Delievery].[idDelievery] DESC);

					-- Add sale
					INSERT INTO Sale(idUser, idSeller, idDelievery, idProduct, total, quantity, deliveryCost) 
					VALUES (@idUser,@idSeller,@lastDelivery,@productId,@total, @quantity,@shipping);

					SELECT '1';

				END;
			-- Product does not exist
			ELSE
				SELECT 'Invertory error'
		END;

	END TRY
	BEGIN CATCH
		SELECT 'Purchase error';
	END CATCH
	SET NOCOUNT OFF
END;

--Example
EXEC purchase  
@productId = 3 ,@quantity  = 2 , @idDelieveryPerson = 2,
@idUser = 1, @idSeller = 1, @locationName = 'house',
@locationX = 70.34680724107667, @locationY =-50.262823939323426;

EXEC purchase @productId =1,
@quantity =1, 
@idUser =15, 
@idSeller =7, 
@idDelieveryPerson =4,
@locationName ='house', 
@locationX =53.48603594526762,
@locationY =-6.147215366363525

SELECT *
FROM [ScotlandDB].[dbo].[Inventory]
INNER JOIN [ProductsDB].[dbo].[Product] ON [Product].idProduct = [Inventory].[idProduct]