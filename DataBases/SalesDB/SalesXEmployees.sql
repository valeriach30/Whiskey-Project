-- Create Function that determines if the id of the product exists
CREATE FUNCTION [dbo].[Check_IdEmployee](@inIdEmp INT = 0)
RETURNS INT
AS
BEGIN
    DECLARE @v_RetVal   INT;
    SET @v_RetVal = 0;

    IF EXISTS(SELECT * FROM [GeneralDB].[dbo].[UserxEmployee] WHERE idUserxEmployee = @inIdEmp)
       BEGIN
          SET @v_RetVal = 1;
       END

    RETURN @v_RetVal;
END

-- Add the constraints

-- SaleXProduct
ALTER TABLE [dbo].[Sale]
ADD CONSTRAINT Check_IdEmployeeExists_Sale
CHECK([dbo].[Check_IdEmployee](idUserxEmployee)=1);

-- Check the constraint
INSERT INTO Sale(idUser) VALUES (999);