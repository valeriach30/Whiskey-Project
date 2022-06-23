USE SalesDB;
GO 

-- Clean DataBase

IF OBJECT_ID('Sale') IS NOT NULL
	DROP TABLE Sale;

IF OBJECT_ID('Delievery') IS NOT NULL
	DROP TABLE Delievery;

-- Tables Creation

CREATE TABLE Delievery ( 
	idDelievery			INT PRIMARY KEY IDENTITY(1,1),	
	idDelieveryPerson	INT,							
	address				NVARCHAR(MAX),					-- JSON
	delieveryDate		DATE
);

CREATE TABLE Sale ( 
	idSale			INT PRIMARY KEY IDENTITY(1,1),
	idUser			INT,								
	idSeller		INT,								
	idDelievery		INT,								
	idProduct		INT,	
	quantity		INT,
	total			MONEY,
	deliveryCost	money,

	FOREIGN KEY (idDelievery) REFERENCES Delievery(idDelievery)
);
