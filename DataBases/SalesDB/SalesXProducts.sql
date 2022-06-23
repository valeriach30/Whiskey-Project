-- Create Function that determines if the id of the product exists
CREATE FUNCTION [dbo].[Check_IdProduct](@inIdProduct INT = 0)
RETURNS INT
AS
BEGIN
    DECLARE @v_RetVal   INT;
    SET @v_RetVal = 0;

    IF EXISTS(SELECT * FROM [ProductsDB].[dbo].[Product] WHERE idProduct = @inIdProduct)
       BEGIN
          SET @v_RetVal = 1;
       END

    RETURN @v_RetVal;
END

-- Add the constraints

-- SaleXProduct
ALTER TABLE [dbo].[Sale]
ADD CONSTRAINT Check_IdProductExists_Sale
CHECK([dbo].[Check_IdProduct](idProduct)=1);

-- Check the constraint
INSERT INTO Sale(idProduct) VALUES (999);
