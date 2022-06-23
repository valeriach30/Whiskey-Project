USE ProductsDB
GO;
-------------------------------------- ADD --------------------------------------

-- Add product type
CREATE OR ALTER PROCEDURE AddProductType
    @inName         VARCHAR(20)
AS BEGIN
    BEGIN TRY
        INSERT INTO 
            [ProductsDB].[dbo].[ProductType](name)
        VALUES
            (@inName);
    END TRY
    BEGIN CATCH
        PRINT('Add Product Type Error')
    END CATCH
END

-- Test
EXEC AddProductType @inname = 'Rye Whiskey';

-------------------------------------- MODIFY --------------------------------------

-- Modify Product type
CREATE OR ALTER PROCEDURE modifyProductType
    @inIdProduct    INT,
    @inNewName      VARCHAR(20)
AS BEGIN
    BEGIN TRY
        UPDATE
            [ProductsDB].dbo.[ProductType]
        SET
            name = @inNewName
        WHERE
            idProductType = @inIdProduct;
    END TRY
    BEGIN CATCH
        PRINT('Modify Product Error')
    END CATCH
END

-- Test
EXEC modifyProductType @inIdProduct = 7, @inNewName = 'Rye Whiskey 2'

-------------------------------------- DELETE --------------------------------------
CREATE OR ALTER PROCEDURE dbo.deleteProductType
	@typeProductId int	
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY

		-- Set to null all the products that have this type
		UPDATE Product
		SET idProductType = NULL
		WHERE idProductType = @typeProductId
		
		-- Delete the product type
		DELETE FROM [ProductsDB].[dbo].[ProductType]
		WHERE [ProductType].idProductType = @typeProductId;

	END TRY
	BEGIN CATCH
		PRINT 'Delete Error';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC deleteProductType 7;
-------------------------------------- READ --------------------------------------

CREATE OR ALTER PROCEDURE dbo.GetCategoriesProducts
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		SELECT [name] from [ProductsDB].[dbo].ProductType;
	END TRY
	BEGIN CATCH
		PRINT 'Error ocurred while searching the profile';
	END CATCH
	SET NOCOUNT OFF
END;

-- Test
EXEC GetCategoriesProducts;