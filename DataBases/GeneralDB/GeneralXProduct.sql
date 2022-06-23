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
-- EvaluationXProduct
ALTER TABLE [dbo].[Evaluation]
ADD CONSTRAINT Check_IdProductExists
CHECK([dbo].[Check_IdProduct](idProduct)=1);

-- Check the constraint
INSERT INTO Evaluation(idProduct) VALUES (9999);

-- ReviewXProduct
ALTER TABLE [dbo].[Review]
ADD CONSTRAINT Check_IdProductExists_Review
CHECK([dbo].[Check_IdProduct](idProduct)=1);

-- Check the constraint
INSERT INTO Review(idProduct) VALUES (9999);