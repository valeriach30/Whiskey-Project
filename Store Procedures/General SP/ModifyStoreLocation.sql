CREATE OR ALTER PROCEDURE modifyStoreLocation
	@idStore   INT,
	@locationX FLOAT, 
	@locationY FLOAT
AS BEGIN
    BEGIN TRY
        DECLARE @location GEOGRAPHY;
		
		-- Set the new location
		SET @location = (geography::Point(@locationX, @locationY, 4326));

		-- Update the table
		UPDATE LocationCode
		SET	locationMap = @location
		WHERE idLocationCode = @idStore;

    END TRY
    BEGIN CATCH
        PRINT('Modify Store Error')
    END CATCH
END

-- Test
EXEC modifyStoreLocation @idStore = 1, @locationX =53.34680724107667 , @locationY =-6.262823939323426
SELECT locationMap.Lat as Lat, locationMap.Long as Lon FROM LocationCode