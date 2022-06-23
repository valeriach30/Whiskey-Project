-- Clean DataBase

IF OBJECT_ID('PaymentInfo') IS NOT NULL
	DROP TABLE PaymentInfo;

IF OBJECT_ID('PersonalInfo') IS NOT NULL
	DROP TABLE PersonalInfo;

IF OBJECT_ID('PayMethod') IS NOT NULL
	DROP TABLE PayMethod;

IF OBJECT_ID('Inventory') IS NOT NULL
	DROP TABLE Inventory;

IF OBJECT_ID('UserType') IS NOT NULL
	DROP TABLE UserType;

IF OBJECT_ID('User') IS NOT NULL
	DROP TABLE [User];

-- Tables Creation

CREATE TABLE UserType (
	idUserType	INT PRIMARY KEY IDENTITY(1,1),
	name 		VARCHAR(40)
);

CREATE TABLE [PersonalInfo](
	idPersonalInfo	INT PRIMARY KEY IDENTITY(1,1),
	name	        VARCHAR(60),
	surname	        VARCHAR(60),
	address		    NVARCHAR(MAX),					
	email		    VARCHAR(70),
	phone		    INT
);

CREATE TABLE [PayMethod] (
	idPayMethod		INT PRIMARY KEY IDENTITY(1,1),
	methodName		VARCHAR(20),
);

CREATE TABLE [PaymentInfo](
	idPaymentInfo   INT PRIMARY KEY IDENTITY(1,1),
	idPayMethod		INT,
	nameOnCard		VARCHAR(60),
	accountNumber	BIGINT,
	expirationDate  DATE,
	CVV				INT,
	FOREIGN KEY (idPayMethod) REFERENCES PayMethod(idPayMethod)
)

CREATE TABLE [User] (
	idUser		   INT PRIMARY KEY IDENTITY(1,1),
	idUserType	   INT,
	idPersonalInfo INT,
	username	   VARCHAR(20),
	password	   VARCHAR(20),
	idPaymentInfo  INT,
	suscribed	   BIT,							-- (0, 1)
	FOREIGN KEY (idUserType) REFERENCES UserType(idUserType),
	FOREIGN KEY (idPersonalInfo) REFERENCES PersonalInfo(idPersonalInfo),
	FOREIGN KEY (idPaymentInfo) REFERENCES PaymentInfo(idPaymentInfo)
);

CREATE TABLE Inventory (
	idInventory		INT PRIMARY KEY IDENTITY(1,1),
	idProduct 		INT,							
	quantity		INT
);
