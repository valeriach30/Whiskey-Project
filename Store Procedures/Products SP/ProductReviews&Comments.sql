--- Read Product Reviews
CREATE OR ALTER PROCEDURE readReviews
    @inIdProduct INT
AS BEGIN
    BEGIN TRY
        IF @idProduct IS NOT NULL BEGIN
            SELECT 
                idReview	                AS ReviewID,
                Product.idProduct           AS ProductID,
                Product.name                AS Product_Name,
                idUser                      AS UserID,								
                comment		                AS Review
            FROM 
                [ProductsDB].[dbo].[Product] 
            JOIN
                [GeneralDB].[dbo].[Review]
            ON 
                [ProductsDB].[dbo].[Product].idProduct = [GeneralDB].[dbo].[Review].idProduct
            WHERE 
                @inIdProduct = [ProductsDB].[dbo].[Product].idProduct;
        END
        ELSE BEGIN
            PRINT('Invalid Entry')
        END
    END TRY
    BEGIN CATCH
        PRINT('Read Review Error')
    END CATCH
END

--- Read Product comments
CREATE OR ALTER PROCEDURE readComments
    @inIdProduct INT
AS BEGIN
    BEGIN TRY
        IF @idProduct IS NOT NULL BEGIN
            SELECT 
                idEvaluation		        AS EvaluationID,
                Product.idProduct           AS ProductID,
                Product.name                AS Product_Name,						
                idUser				        AS UserID,								
                idDelieveryPerson	        AS DelieveryPerson_ID,								
                idSeller			        AS SellerID,								
                comment				        AS Comment,
                calification		        AS Calification
            FROM 
                [ProductsDB].[dbo].[Product] 
            JOIN
                [GeneralDB].[dbo].[Evaluation]
            ON 
                [ProductsDB].[dbo].[Product].idProduct = [GeneralDB].[dbo].[Evaluation].idProduct
            WHERE 
                @inIdProduct = [ProductsDB].[dbo].[Product].idProduct;
        END
        ELSE BEGIN
            PRINT('Invalid Entry')
        END
    END TRY
    BEGIN CATCH
        PRINT('Read Comments Error')
    END CATCH
END