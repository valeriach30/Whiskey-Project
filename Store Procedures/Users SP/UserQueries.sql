----- User Queries -----
USE GeneralDB
GO;

--- User is employee ---------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE determineEmployee 
	@inUserXPlace INT
AS BEGIN
	BEGIN TRY
		DECLARE @idEmployee INT;
		
		SELECT @idEmployee = idEmployee 
		FROM [GeneralDB].[dbo].[UserxEmployee] 
		WHERE idUser = @inUserXPlace;
		PRINT @idEmployee

		-- User does not exist
		IF(@idEmployee IS NULL) 
		BEGIN
			SELECT '0';
		END;

		-- User exist
		ELSE
		BEGIN
			SELECT @idEmployee;
		END;

	END TRY
	BEGIN CATCH
		PRINT('Error when determining if the employee exists')
	END CATCH
END

EXEC determineEmployee @inUserXPlace = 11;

--- User is Admin ---------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE determineAdmin 
	@inUserXPlace INT
AS BEGIN
	BEGIN TRY
		SET NOCOUNT ON
		DECLARE @idUser INT, @idCode INT, @idUserType INT, @isSupervisor INT;

		-- Determine the country of the user and the id of the user in that db
		SELECT @idUser = idUser, @idCode = idCode
		FROM UserxPlace
		WHERE idUserxPlace = @inUserXPlace;

		-- Determine if the user exists
		IF(@idUser IS NOT NULL) 
		BEGIN
			---------------- USER IS FROM IRELAND ----------------
			IF(@idCode = 1)
			BEGIN 
				SELECT @idUserType = idUserType 
				FROM [IrelandDB].[dbo].[User]
				WHERE idUser = @idUser;

				-- Determine if the user exits
				IF(@idUserType IS NOT NULL)
				BEGIN
					-- Determine if the user is a supervisor 
					CREATE TABLE IsSupervisor (response int)
					INSERT INTO IsSupervisor EXEC determineSupervisor @inUserXPlace
					SET @isSupervisor = (select * from IsSupervisor)
					DROP TABLE IsSupervisor 
					
					-- Determine if the user is an admin or a supervisor
					IF(@idUserType = 1 OR @isSupervisor = 1)
					BEGIN
						-- user is admin or supervisor
						SELECT '1';
					END;
					-- Not an admin or supervisor
					ELSE
					BEGIN
						SELECT '0';
					END;
				END;
				-- User does not exist
				ELSE
				BEGIN
					SELECT '0';
				END;
			END;
			ELSE
			BEGIN
				---------------- USER IS FROM SCOTLAND ----------------
				IF(@idCode = 2)
				BEGIN 
					SELECT @idUserType = idUserType 
					FROM [ScotlandDB].[dbo].[User]
					WHERE idUser = @idUser;

					-- Determine if the user exits
					IF(@idUserType IS NOT NULL)
					BEGIN
						-- Determine if the user is a supervisor 
						CREATE TABLE IsSupervisor (response int)
						INSERT INTO IsSupervisor EXEC determineSupervisor @inUserXPlace
						SET @isSupervisor = (select * from IsSupervisor)
						DROP TABLE IsSupervisor 
					

						-- Determine if the user is an admin or a supervisor
						IF(@idUserType = 1 OR @isSupervisor = 1)
						BEGIN
							-- user is admin or supervisor
							SELECT '1';
						END;
						-- Not an admin or supervisor
						ELSE
						BEGIN
							SELECT '0';
						END;
					END;
					-- User does not exist
					ELSE
					BEGIN
						SELECT '0';
					END;
				END;
				ELSE 
				BEGIN
					---------------- USER IS FROM THE US ----------------
					IF(@idCode = 3)
					BEGIN 
						SELECT @idUserType = idUserType 
						FROM [UnitedStatesDB].[dbo].[User]
						WHERE idUser = @idUser;

						-- Determine if the user exits
						IF(@idUserType IS NOT NULL)
						BEGIN
							-- Determine if the user is a supervisor 
							CREATE TABLE IsSupervisor (response int)
							INSERT INTO IsSupervisor EXEC determineSupervisor @inUserXPlace
							SET @isSupervisor = (select * from IsSupervisor)
							DROP TABLE IsSupervisor 
					

							-- Determine if the user is an admin or a supervisor
							IF(@idUserType = 1 OR @isSupervisor = 1)
							BEGIN
								-- user is admin or supervisor
								SELECT '1';
							END;
							-- Not an admin or supervisor
							ELSE
							BEGIN
								SELECT '0';
							END;
						END;
						-- User does not exist
						ELSE
						BEGIN
							SELECT '0';
						END;
					END;
				END;
			END;
		END;
		-- User does not exist
		ELSE
		BEGIN
			SELECT '0';
		END;
	END TRY
	BEGIN CATCH
		PRINT('Error when determining if user is an admin')
	END CATCH
END

EXEC determineAdmin 15;

--- Product Type ---------------------------------------------------------------------------------------
USE ProductsDB
GO;
CREATE PROCEDURE showProductType 
	@inIdProduct INT
AS BEGIN
	BEGIN TRY
		SELECT Product.idProduct, ProductType.idProductType, ProductType.name
		FROM [ProductsDB].[dbo].[Product] JOIN [ProductsDB].[dbo].[ProductType] 
		ON  [ProductsDB].[dbo].[Product].idProductType = [ProductsDB].[dbo].[ProductType].idProductType
		WHERE @inIdProduct = Product.idProduct;
	END TRY
	BEGIN CATCH
		PRINT('Show Products Error')
	END CATCH
END

-- Example
EXEC showProductType @inIdProduct = 1;
---------------------------------------------------------------------------------------------------------

--- Product Name --------------------------------------
CREATE PROCEDURE showProductName 
	@inIdProduct INT
AS BEGIN
	BEGIN TRY
		SELECT Product.idProduct, Product.name
		FROM [ProductsDB].[dbo].[Product]  
		WHERE @inIdProduct = Product.idProduct;
	END TRY
	BEGIN CATCH
		PRINT('Show Product Name Error')
	END CATCH
END

-- Example
EXEC showProductName @inIdProduct = 1;
--------------------------------------------------------

--- Product Prices -------------------------------------
CREATE PROCEDURE showProductPrice
	@inIdProduct INT
AS BEGIN
	BEGIN TRY
		SELECT Product.idProduct, Product.price
		FROM [ProductsDB].[dbo].[Product]  
		WHERE @inIdProduct = Product.idProduct;
	END TRY
	BEGIN CATCH
		PRINT('Show Product Price Error')
	END CATCH
END

-- Example
EXEC showProductPrice @inIdProduct = 1;
--------------------------------------------------------

--- Sort Products (Ascending) --------------------------------------
CREATE PROCEDURE showAscSortedProducts
AS BEGIN
	BEGIN TRY  
		SELECT idProduct, idCoin, idProductType, [name], price,	charact, productImage
		FROM [ProductsDB].[dbo].[Product]
		ORDER BY idProduct ASC;
	END TRY
	BEGIN CATCH
		PRINT ('Show Ascending Products Error')
	END CATCH
END

-- Example
EXEC showAscSortedProducts;
--------------------------------------------------------

--- Sort Products (Descending) --------------------------------------
CREATE PROCEDURE showDescSortedProducts
AS BEGIN
	BEGIN TRY  
		SELECT idProduct, idCoin, idProductType, [name], price,	charact, productImage
		FROM [ProductsDB].[dbo].[Product]
		ORDER BY idProduct DESC;
	END TRY
	BEGIN CATCH
		PRINT ('Show Descending Products Error')
	END CATCH
END

-- Example
EXEC showDescSortedProducts;
--------------------------------------------------------

