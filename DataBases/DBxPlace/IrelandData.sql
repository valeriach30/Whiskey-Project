USE IrelandDB;
GO
-- Insert users type
INSERT INTO UserType (name) VALUES
	('admin'),
	('user'),
	('employee');

------------------------------------------JSONS------------------------------------------
DECLARE @json1 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 53.52039016645552, "Y": -7.334747314453126}
    ],
    "work" : [
        {"X" : 53.52155361799698 , "Y": -7.358715534210206}
    ]
}';
DECLARE @json2 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 53.96203943547343 , "Y": -8.790650367736818}
    ],
    "other" : [
        {"X" : 53.97228381639416 , "Y": -8.794813156127931}
    ]
}';
DECLARE @json3 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 53.83082156853109, "Y": -6.396660804748535}
    ]
}';
DECLARE @json4 NVARCHAR(MAX) = N'{
    "work" : [
        {"X" : 53.71406448046467 , "Y": -6.33960485458374}
    ]
}';
DECLARE @json5 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 53.714707043985854, "Y": -6.347265243530274}
    ]
}';
DECLARE @json6 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 53.57007393041162 , "Y": -6.1045628786087045}
    ],
    "work" : [
        {"X" : 53.573430147298254 , "Y": -6.114363670349121}
    ]
}';
DECLARE @json7 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 53.48603594526762, "Y": -6.147215366363525}
    ]
}';
DECLARE @json8 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 53.26674401052799 , "Y": -6.246339082717896}
    ]
}';
DECLARE @json9 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 52.89664281677395 , "Y": -6.822509765625001}
    ]
}';
DECLARE @json10 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 52.9661762784136, "Y": -6.053466796875001}
    ]
}';

------------------------------------------PERSONAL INFO------------------------------------------

INSERT INTO PersonalInfo(name, surname, address, email, phone) VALUES
	('Javith', 'Aguero Hernandez', @json1, 'aguerojavith@gmail.com', 85343403),
	('Juana', 'Perez Mendez', @json2, 'perezjuana@gmail.com', 70112205),
	('Jose', 'Flores Arguedas', @json3, 'floresjose@gmail.com', 67707206),
	('Oscar', 'Villalobos Romero', @json4, 'villalobososcar@gmail.com', 72639471),
	('Guadalupe', 'Zu�iga Chacono', @json5, 'gaguadalupe@gmail.com', 75624554),
	('Ana', 'Hernandez Gomez', @json6, 'hernandezana@gmail.com', 84257486),
	('Osvaldo', 'Orozco Guevara', @json7, 'osadage@gmail.com', 87541766),
	('Ruben', 'Cubero Duarte', @json8, 'cuberoruben@gmail.com', 78241767),
	('Jose', 'Ulloa Ulate', @json9, 'morenovictor@gmail.com', 78758222),
	('Agustin', 'Guevara Oviedo', @json10, 'guevaraagustin@gmail.com', 64151372),
	-- Employees
	('Micheil', 'Mighrad', @json9, 'michmiag@gmail.com', 56498751),
	('Connor', 'Murphy', @json2, 'connormurp@gmail.com', 54912321),
	('James', 'Kelly ',@json1, 'jamkell@gmail.com',54984318),
	('Sean', 'Byrne ', @json6, 'seanbyr@gmail.com',78758224),
	('Jack', 'Ryan ',@json7,'jackryan@gmail.com', 67907206),
	('Aoife', 'OSullivan ',@json9, 'aoifosul@gmail.com',95343403);

----------------------------------PAY METHODS-------------------------------------
INSERT INTO PayMethod(methodName) VALUES
	('Credit Card'),
	('Debit Card');

INSERT INTO PaymentInfo(idPayMethod, nameOnCard, accountNumber, expirationDate, CVV) VALUES
	(1, 'Javith Aguero Hernande', 4568956761276446, '2023-12-30', 555),
	(1, 'Juana Perez Mendez', 9162666611047707, '2024-12-30', 670),
	(1, 'Jose Flores Arguedas', 8144417711620444, '2022-11-30', 423),
	(1, 'Oscar Villalobos Romero', 2104770711188942, '2023-08-15', 345),
	(1, 'Guadalupe Zu�iga Chacon', 7121064971110717, '2023-09-28', 980),
	(2, 'Ana Hernandez Gomez', 3168894291231649, '2023-10-12', 897),
	(2, 'Osvaldo Orozco Guevara', 9166552361385711, '2023-12-23', 678),
	(2, 'Ruben Cubero Duarte', 6111671711276446, '2023-12-25', 123),
	(2, 'Jose Ulloa Ulate', 6138522266612657, '2023-12-08', 608),
	(1, 'Agustin Guevara Oviedo', 5221211711405188, '2027-12-16', 890),
	(2, 'Micheil Mighrad', 4111741221208731, '2026-12-17', 343),
	(1, 'Connor Murphy', 210253865265, '2025-12-16', 222),
	(1, 'James Kelly', 319123555588, '2022-12-15', 333),
	(1, 'Sean Byrne', 913355733362, '2023-09-02', 444),
	(1, 'Jack Ryan', 917439552549, '2023-09-22', 666),
	(1, 'Aoife OSullivan', 914937991429, '2023-09-11', 777);
------------------------------------------USERS------------------------------------------

INSERT INTO [User] (idUserType, idPersonalInfo, username, password, suscribed, idPaymentInfo) VALUES
	(1, 1, 'jaguero', (select [GeneralDB].[dbo].encdec('LaFacil1234',2,0)), 0, 1),
	(1, 2, 'juanaper', (select [GeneralDB].[dbo].encdec('LaCont11',2,0)), 0, 2),
	(1, 3, 'joseflor', (select [GeneralDB].[dbo].encdec('Asd1234',2,0)), 0, 3),
	(2, 4, 'oscarvilla', (select [GeneralDB].[dbo].encdec('ContraABC34',2,0)), 1, 4),
	(2, 5, 'guadazun', (select [GeneralDB].[dbo].encdec('guaD12',2,0)), 1, 5),
	(2, 6, 'anahern', (select [GeneralDB].[dbo].encdec('AnaHer32',2,0)), 1, 6),
	(2, 7, 'osvaloroz', (select [GeneralDB].[dbo].encdec('Random12',2,0)), 0, 7),
	(2, 8, 'rubcube', (select [GeneralDB].[dbo].encdec('Default56',2,0)), 0, 8),
	(2, 9, 'joseull', (select [GeneralDB].[dbo].encdec('rapas1234',2,0)), 0, 9),
	(2, 10, 'agusguev', (select [GeneralDB].[dbo].encdec('hunter789',2,0)), 1, 10),
	(3, 11,'michmaig', (select [GeneralDB].[dbo].encdec('PasWER55',2,0)), 0, 11),
	(3, 12,'connmurp', (select [GeneralDB].[dbo].encdec('Assdw34',2,0)), 0, 12),
	(3, 13,'jamkell', (select [GeneralDB].[dbo].encdec('passjam',2,0)), 0, 13),
	(3, 14,'seanbyr', (select [GeneralDB].[dbo].encdec('seancontrA12',2,0)), 0, 14),
	(3, 15,'jackryn', (select [GeneralDB].[dbo].encdec('hunTer779',2,0)), 0, 15),
	(3, 16,'aoifosul', (select [GeneralDB].[dbo].encdec('Thepas12',2,0)), 0, 16); 
------------------------------------------INVENTORY------------------------------------------
INSERT INTO Inventory(idProduct, quantity) VALUES
	(2, 50),
	(5, 13),
	(8, 100),
	(11, 12),
	(14, 34),
	(17, 67),
	(20, 23),
	(23, 15),
	(26, 8),
	(29, 9),
	(32, 33),
	(35, 21),
	(38, 9),
	(41, 6),
	(44, 5),
	(47, 90),
	(50, 87),
	(53, 54),
	(56, 32),
	(59, 21),
	(62, 22),
	(65, 55),
	(68, 43),
	(71, 8);