use GeneralDB
go

-- Create Function that encrypt or decrypt the password
CREATE or Alter FUNCTION encdec(@message varchar(20) , @key int, @mode bit) --0 encrypt and 1 decrypt
RETURNS varchar(20)
AS
BEGIN
    set @message = (select UPPER(@message));
    declare @translated varchar(20), @symbol char, @LETTERS varchar(29), @lenMessage int ,@lenLetters int, @cont int ,@num int;

	--SELECT SUBSTRING('SQL Tutorial', 1, 1) AS ExtractString;
	--SELECT CHARINDEX('1', 'Customer') AS MatchPosition; --returns 0 if doesnt find the letter

	set @translated = '';
    set @LETTERS  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	set @lenMessage = len(@message) + 1 ;
	set @lenLetters = len(@lenLetters) + 1 ;
	set @cont = 1;
	while (@cont < @lenMessage)
	begin
		set @symbol = (select SUBSTRING(@message, @cont, 1));--gets the character of the @message
		if( (SELECT CHARINDEX(@symbol, @LETTERS)) != 0) --ask if the symbol is on the letters
		begin
			set @num =(SELECT CHARINDEX(@symbol, @LETTERS));
			if (@mode = 0 )--"encrypt"
				set @num =@num + @key;
			else if(@mode = 1)--"decrypt"
				set @num = @num - @key;

			if (@num >= @lenLetters )
				set @num =@num - @lenLetters;
			else if(@num < 0)
				set @num = @num + @lenLetters;

			set @translated = (@translated  + (select SUBSTRING(@LETTERS, @num, 1)) );
		end;
		else
			set @translated = @translated + @symbol;
		set @cont = @cont+1;
	end;
    RETURN @translated;
END;

--Example

select [GeneralDB].[dbo].encdec('Hola quiero unas papas',2,0) as xd;
select [GeneralDB].[dbo].encdec('JQNC SWKGTQ WPCU RCR ',2,1) as xd;