USE ProductsDB;
GO

-- Clean DataBase

IF OBJECT_ID('ProductType') IS NOT NULL
	DROP TABLE ProductType;

IF OBJECT_ID('Coin') IS NOT NULL
	DROP TABLE Coin;

IF OBJECT_ID('Product') IS NOT NULL
	DROP TABLE Product;



-- Tables Creation

CREATE TABLE ProductType (
	idProductType	INT PRIMARY KEY IDENTITY(1,1),
	name 			VARCHAR(40)
);
	
CREATE TABLE Coin (
	idCoin	INT PRIMARY KEY IDENTITY(1,1),
	name 	VARCHAR(20),
	symbol	VARCHAR(10),
	country VARCHAR(20)
);

CREATE TABLE Product (
	idProduct		INT PRIMARY KEY IDENTITY(1,1),
	idCoin			INT,
	idProductType	INT,
	[name]	        VARCHAR(100),
	price			FLOAT,
	visible			BIT,
	charact			NVARCHAR(MAX),		-- JSON FORMAT
	productImage	VARBINARY(MAX),
	
	FOREIGN KEY (idCoin) REFERENCES Coin(idCoin),
	FOREIGN KEY (idProductType) REFERENCES ProductType(idProductType)
);