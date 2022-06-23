USE SalesDB
GO

------ Sales Report -----------------------------------
CREATE OR ALTER PROCEDURE salesReport 
    @productId   int = null,
	@quantity int = null,
	@date date = null,
	@sellerId int = null,
	@userId int = null
AS
    BEGIN TRY
		select 	idSale,
				idUser,								
				idSeller,								
				Sale.idDelievery,								
				idProduct,	
				quantity,
				total,
				deliveryCost,
				Delievery.delieveryDate
				from [SalesDB].[dbo].Sale
			inner join 
			[SalesDB].[dbo].Delievery
			on Delievery.idDelievery = Sale.idDelievery
			where ((@productId is null) or (@productId = idProduct)) and
					((@date is null) or (Delievery.delieveryDate = @date)) and
					((@quantity is null) or (@quantity = quantity)) and
					((@sellerId is null) or (@sellerId = idSeller)) and
					((@userId is null) or (@userId = idUser));

    END TRY
    BEGIN CATCH
		PRINT 'Sales report error';
	END CATCH
GO

--examples
exec salesReport @date = '2022-06-18',@productId = 2

exec salesReport @userId = 4,@productId = 2
