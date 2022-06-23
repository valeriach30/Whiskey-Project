-- Create Function that determines if the id of the product exists
CREATE FUNCTION [dbo].[Check_IdProduct](@inIdProduct INT = 0)
RETURNS INT
AS
BEGIN
    DECLARE @v_RetVal   INT;
    SET @v_RetVal = 0;

    IF EXISTS(SELECT * FROM [ProductsDB].[dbo].[Product]  WHERE idProduct = @inIdProduct)
       BEGIN
          SET @v_RetVal = 1;
       END

    RETURN @v_RetVal;
END

-- Add the constraint
ALTER TABLE [dbo].[Inventory]
ADD CONSTRAINT Check_IdProductExists_Scotland
CHECK([dbo].[Check_IdProduct](idProduct)=1);

-- Check the constraint
INSERT INTO Inventory(idProduct) VALUES (9999);
