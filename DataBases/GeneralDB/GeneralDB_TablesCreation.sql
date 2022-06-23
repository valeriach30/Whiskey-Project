USE GeneralDB;
GO
-- Clean DataBase

IF OBJECT_ID('Review') IS NOT NULL
	DROP TABLE Review;

IF OBJECT_ID('ResponseEV') IS NOT NULL
	DROP TABLE ResponseEV;

IF OBJECT_ID('Evaluation') IS NOT NULL
	DROP TABLE Evaluation;

IF OBJECT_ID('Suscription') IS NOT NULL
	DROP TABLE Suscription;

IF OBJECT_ID('SuscriptionType') IS NOT NULL
	DROP TABLE SuscriptionType;

IF OBJECT_ID('UserxEmployee') IS NOT NULL
	DROP TABLE UserxEmployee;

IF OBJECT_ID('UserxPlace') IS NOT NULL
	DROP TABLE UserxPlace;

IF OBJECT_ID('LocationCode') IS NOT NULL
	DROP TABLE LocationCode;

-- Tables Creation

CREATE TABLE LocationCode(
	idLocationCode INT PRIMARY KEY IDENTITY(1,1),
	locationMap geography,
	code VARCHAR(8)
);

CREATE TABLE UserxPlace(
	idUserxPlace INT PRIMARY KEY IDENTITY(1,1),
	idUser INT,
	idCode INT
	FOREIGN KEY (idCode) REFERENCES LocationCode(idLocationCode)
);

CREATE TABLE UserxEmployee(
	idUserxEmployee INT PRIMARY KEY IDENTITY(1,1),
	idUser INT,
	idEmployee INT,								-- Connects with EmployeeDB
	FOREIGN KEY (idUser) REFERENCES UserxPlace(idUserxPlace)
);

CREATE TABLE Evaluation (
	idEvaluation		INT PRIMARY KEY IDENTITY(1,1),
	idProduct 			VARCHAR(40),						
	idUser				INT,								
	idDelieveryPerson	INT,								
	idSeller			INT,								
	comment				VARCHAR(50),
	calification		INT,
	evDate				DATE,			
	FOREIGN KEY (idUser) REFERENCES UserxPlace(idUserxPlace),
	FOREIGN KEY (idDelieveryPerson) REFERENCES UserxEmployee(idUserxEmployee),
	FOREIGN KEY (idSeller) REFERENCES UserxEmployee(idUserxEmployee)
);

CREATE TABLE Review (
	idReview		INT PRIMARY KEY IDENTITY(1,1),
	idProduct 		VARCHAR(40),						
	idUser			INT,								
	comment			VARCHAR(500),
	RevDate				DATE,
	FOREIGN KEY (idUser) REFERENCES UserxPlace(idUserxPlace)
);
	
CREATE TABLE SuscriptionType (
	idSuscriptionType		INT PRIMARY KEY IDENTITY(1,1),
	name					VARCHAR(30),
	dicosuntBuy				INT,							-- Percentage
	discountShipping		INT,							-- Percentage
	canSee					BIT,
	present					BIT,
	emailNotifications		BIT,
	price					FLOAT
);

CREATE TABLE Suscription (
	idSuscription		INT PRIMARY KEY IDENTITY(1,1),
	idUser	 			INT,							
	idSuscriptionType	INT,
	FOREIGN KEY (idUser) REFERENCES UserxPlace(idUserxPlace),
	FOREIGN KEY (idSuscriptionType) REFERENCES SuscriptionType(idSuscriptionType)
);

CREATE TABLE ResponseEV (
	idResponse		INT PRIMARY KEY IDENTITY(1,1),
	idEvaluation	INT,							
	idEmployee		INT,								
	idUser			INT,	
	dateResp		DATE,	
	description		VARCHAR(500),
	FOREIGN KEY (idUser) REFERENCES UserxPlace(idUserxPlace),
	FOREIGN KEY (idEvaluation) REFERENCES Evaluation(idEvaluation),
	FOREIGN KEY (idEmployee) REFERENCES UserxEmployee(idUserxEmployee)
);