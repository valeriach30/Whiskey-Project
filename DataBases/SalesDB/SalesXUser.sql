-- Create Function that determines if the id of the product exists
CREATE FUNCTION [dbo].[Check_IdUser](@inIdUser INT = 0)
RETURNS INT
AS
BEGIN
    DECLARE @v_RetVal   INT;
    SET @v_RetVal = 0;

    IF EXISTS(SELECT * FROM [GeneralDB].[dbo].[UserxPlace] WHERE idUserxPlace = @inIdUser)
       BEGIN
          SET @v_RetVal = 1;
       END

    RETURN @v_RetVal;
END

-- Add the constraints

-- SaleXProduct
ALTER TABLE [dbo].[Sale]
ADD CONSTRAINT Check_IdUserExists_Sale
CHECK([dbo].[Check_IdUser](idUser)=1);

-- Check the constraint
INSERT INTO Sale(idUser) VALUES (999);