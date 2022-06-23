USE ScotlandDB;
GO
-- Insert users type
INSERT INTO UserType (name) VALUES
	('admin'),
	('user'),
	('employee');

------------------------------------------JSONS------------------------------------------
DECLARE @json1 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 58.362258263976884, "Y": -4.875183105468751}
    ]
}';
DECLARE @json2 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 58.30169652592248 , "Y": -4.419250488281251}
    ]
}';
DECLARE @json3 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 58.37810252712886 , "Y": -4.86419677734375}
    ]
}';
DECLARE @json4 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" :  58.026118770486775 , "Y": -4.40004587173462}
    ],
    "work" : [
        {"X" : 58.02389164383482  , "Y": -4.397642612457276}
    ]
}';
DECLARE @json5 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" :  57.98356577584001 , "Y": -4.588240385055543}
    ],
    "work" : [
        {"X" :  57.98040764447853 , "Y": -4.589796066284181}
    ]
}';
DECLARE @json6 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 57.39585047552816 , "Y": -5.8030128479003915}
    ]
}';
DECLARE @json7 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" :  57.317331695031044 , "Y": -5.6728291511535645}
    ],
    "work" : [
        {"X" : 57.317667711768806, "Y": -5.67172408103943}
    ]
}';
DECLARE @json8 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 57.44602094347758 , "Y": -4.220294952392579}
    ]
}';
DECLARE @json9 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 57.45534911837115 , "Y": -4.235572814941407}
    ]
}';
DECLARE @json10 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 57.451470364337936 , "Y": -4.178924560546876}
    ]
}';

------------------------------------------PERSONAL INFO------------------------------------------

INSERT INTO PersonalInfo(name, surname, address, email, phone) VALUES
	('Allan', 'Arias', @json1, 'allanarias@gmail.com', 85543413),
	('Valeria', 'Coto', @json2, 'valeriaco@gmail.com', 70112205),
	('Daniel', 'Cascante', @json3, 'danicas@gmail.com', 87707206),
	('Raul', 'Gutierrez', @json4, 'raulgut@gmail.com', 62639471),
	('Valeria', 'Chinchilla', @json5, 'amcsibaja@gmail.com', 95624554),
	('Rose', 'Herrera', @json6, 'roseherr@gmail.com', 64257486),
	('Dayana', 'Contreras', @json7, 'dayacontre@gmail.com', 88541566),
	('Luis', 'Diaz', @json8, 'luisdiaz@gmail.com', 78445767),
	('Jose', 'Perez', @json9, 'joseper@gmail.com', 98755222),
	('Alexandra', 'Sandi', @json10, 'alexa@gmail.com', 63151272),
	-- Employees
	('Ciara', 'Doyle', @json3,'ciardoy@gmail.com', 78151272),
	('Niamh', 'Walsh', @json6, 'niamwal@gmail.com', 68655222),
	('Cara', 'OConnor', @json9, 'carao@gmail.com', 65239845),
	('Clodagh', 'Mc Carthy', @json1, 'clodmc@gmail.com', 83420512), 
	('Aisling', 'Maoilriain', @json8, 'aismao@gmail.com', 64582364),
	('Eabha', 'Murchadha', @json10, 'eabmurch@gmail.com', 61112988);
	
----------------------------------PAY METHODS-------------------------------------
INSERT INTO PayMethod(methodName) VALUES
	('Credit Card'),
	('Debit Card');

INSERT INTO PaymentInfo(idPayMethod, nameOnCard, accountNumber, expirationDate, CVV) VALUES
	(1, 'Allan Arias', 4568956761276446, '2023-12-30', 555),
	(1, 'Valeria Coto', 1162055511047707, '2024-12-30', 670),
	(1, 'Daniel Cascante', 1140517711620444, '2022-11-30', 423),
	(1, 'Raul Gutierrez', 2104770711688942, '2023-08-15', 345),
	(1, 'Valeria Chinchilla', 1121064971010717, '2023-09-28', 980),
	(2, 'Rose Herrera', 2168894291230649, '2023-10-12', 897),
	(2, 'Dayana Contreras', 9166552361385711, '2023-12-23', 678),
	(2, 'Luis Diaz', 6101671711276446, '2023-12-25', 123),
	(2, 'Jose Perez', 6138571166612657, '2023-12-08', 608),
	(1, 'Alexandra Sandi', 5191211711405188, '2027-12-16', 890),
	(2, 'Ciara Doyle', 4111741931208731, '2026-12-17', 343),
	(1, 'Niamh Walsh', 210243865265, '2025-12-16', 222),
	(1, 'Cara OConnor', 319123577788, '2022-12-15', 333),
	(1, 'Clodagh Mc Carthy', 713350733362, '2023-09-02', 444),
	(1, 'Aisling Maoilriain', 717434552541, '2023-09-22', 666),
	(1, 'Eabha Murchadha', 714937251425, '2023-09-11', 777);
------------------------------------------USERS------------------------------------------


INSERT INTO [User] (idUserType, idPersonalInfo, username, password, suscribed, idPaymentInfo) VALUES
	(2, 1, 'allanar', (select [GeneralDB].[dbo].encdec('123qWe',2,0)), 0, 1),
	(2, 2, 'valecoto', (select [GeneralDB].[dbo].encdec('Q1w2e3r4t5',2,0)), 0, 2),
	(1, 3, 'danicas', (select [GeneralDB].[dbo].encdec('Access12',2,0)), 0, 3),
	(1, 4, 'rauguti',(select [GeneralDB].[dbo].encdec( 'Hunter789',2,0)), 1, 4),
	(1, 5, 'valech', (select [GeneralDB].[dbo].encdec('Venus44',2,0)), 1, 5),
	(2, 6, 'roseherr', (select [GeneralDB].[dbo].encdec('roseF47',2,0)), 1, 6),
	(2, 7, 'dayancort', (select [GeneralDB].[dbo].encdec('passwoR44',2,0)), 0, 7),
	(2, 8, 'luisdiaz',(select [GeneralDB].[dbo].encdec( 'Lollol159',2,0)), 0, 8),
	(2, 9, 'joseper',(select [GeneralDB].[dbo].encdec( 'Ranjos1',2,0)), 0, 9),
	(2, 10, 'alexsand',(select [GeneralDB].[dbo].encdec( '123WaTe',2,0)), 1, 10),
	-- Employees
	(3, 11, 'ciardoy',(select [GeneralDB].[dbo].encdec( 'Ciar201',2,0)), 0, 11),
	(3, 12, 'niamwal',(select [GeneralDB].[dbo].encdec( 'PassNiam1',2,0)), 0, 12),
	(3, 13, 'caraoc', (select [GeneralDB].[dbo].encdec('PaSwOrD1',2,0)), 0, 13),
	(3, 14, 'clodmc', (select [GeneralDB].[dbo].encdec('clodE12',2,0)), 0, 14),
	(3, 15, 'aismao', (select [GeneralDB].[dbo].encdec('Access99',2,0)), 0, 15),
	(3, 16, 'eabmur', (select [GeneralDB].[dbo].encdec('RanSs9',2,0)), 0, 16);

------------------------------------------INVENTORY------------------------------------------
INSERT INTO Inventory(idProduct, quantity) VALUES
	(3, 88),
	(6, 11),
	(9, 32),
	(12, 45),
	(15, 34),
	(18, 67),
	(21, 23),
	(24, 23),
	(27, 8),
	(30, 9),
	(33, 4),
	(36, 21),
	(39, 9),
	(42, 6),
	(45, 25),
	(48, 12),
	(51, 44),
	(54, 54),
	(57, 32),
	(60, 21),
	(63, 22),
	(66, 55),
	(69, 43),
	(72, 18);