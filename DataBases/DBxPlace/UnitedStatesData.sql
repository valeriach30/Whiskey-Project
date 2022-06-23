USE UnitedStatesDB;
GO
-- Insert users type
INSERT INTO UserType (name) VALUES
	('admin'),
	('user'),
	('employee');

------------------------------------------JSONS------------------------------------------
DECLARE @json1 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 38.327275385625356 , "Y": -85.70091247558595}
    ]
}';
DECLARE @json2 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 38.3490878531808 , "Y": -85.68752288818361}
    ]
}';
DECLARE @json3 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 39.84356615007696 , "Y": -82.80321747064592}
    ]
}';
DECLARE @json4 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 39.244312207102865 , "Y": -81.55865907669069}
    ],
    "work" : [
        {"X" : 39.24328188284714 , "Y": -81.55280113220216}
    ]
}';
DECLARE @json5 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 36.47922761634984 , "Y": -76.04285717010498}
    ]
}';
DECLARE @json6 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 32.7964235306041, "Y": -79.95617866516115}
    ],
    "work" : [
        {"X" : 32.788905254661735 , "Y": -79.94227409362794}
    ]
}';
DECLARE @json7 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 28.29178260748749 , "Y": -81.41950607299806}
    ]
}';
DECLARE @json8 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 33.84578276091017 , "Y": -118.22387695312501}
    ]
}';
DECLARE @json9 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 35.1079447269092 , "Y": -120.61048507690431}
    ],
    "work" : [
        {"X" : 35.10871709385346 , "Y": -120.59812545776367}
    ]
}';
DECLARE @json10 NVARCHAR(MAX) = N'{
    "house" : [
        {"X" : 35.381954445710726 , "Y": -119.1547966003418}
    ]
}';

------------------------------------------PERSONAL INFO------------------------------------------

INSERT INTO PersonalInfo(name, surname, address, email, phone) VALUES
	('Roberto', 'Carazo', @json1, 'roberCar@gmail.com', 81343403),
	('Paula', 'Madrigal', @json2, 'pauMad@gmail.com', 70112205),
	('Ana', 'Esquivel', @json3, 'anaE@gmail.com', 67702506),
	('Bel�n', 'Alvarado Romero', @json4, 'belenAlv@gmail.com', 72649471),
	('Santiago', 'Acosta Chacono', @json5, 'santiacos@gmail.com', 75684554),
	('Sebastian', 'Montero Gomez', @json6, 'sebasmont@gmail.com', 88257486),
	('Gabriel', 'Orozco Varela', @json7, 'gabrvare@gmail.com', 77541766),
	('Adriana', 'Cespedes Sibaja', @json8, 'adsibaja@gmail.com', 78241767),
	('Juliana', 'Blanco Rojas', @json9, 'juliblancor@gmail.com', 78758222),
	('Esteban', 'Rojas Oviedo', @json10, 'estebanroj@gmail.com', 64581372),
	-- Employees
	('Liam', 'Smith', @json7,'liamsmith@gmail.com', 98758222), 
	('Noah', 'Johnsons', @json3, 'noahjogn@gmail.com', 78722222), 
	('Oliver', 'Williams', @json9, 'olivwill@gmail.com', 24568978), 
	('Elijah', 'Brown', @json4, 'elijbrow@gmail.com', 26547825), 
	('Olivia', 'Miller', @json1, 'oliviamill@gmail.com', 38758222), 
	('Charlotte', 'Garcia', @json10, 'charllgarc@gmail.com', 73568222); 

----------------------------------PAY METHODS-------------------------------------
INSERT INTO PayMethod(methodName) VALUES
	('Credit Card'),
	('Debit Card');

INSERT INTO PaymentInfo(idPayMethod, nameOnCard, accountNumber, expirationDate, CVV) VALUES
	(1, 'Roberto Carazo', 4568956811276446, '2023-12-30', 555),
	(1, 'Paula Madrigal', 1162044411047707, '2024-12-30', 555),
	(1, 'Ana Esquivel', 1140518811620444, '2022-11-30', 555),
	(1, 'Belen Alvarado Romero', 1104770711688942, '2023-08-15', 555),
	(1, 'Santiago Acosta Chacono', 9126064971010717, '2023-09-28', 555),
	(2, 'Sebastian Montero Gomez', 1168894291260649, '2023-10-12', 555),
	(2, 'Gabriel Orozco Varela', 8166555361385711, '2023-12-23', 555),
	(2, 'Adriana Cespedes Sibaja', 7101071711276446, '2023-12-25', 555),
	(2, 'Juliana Blanco Rojas', 6138571151912657, '2023-12-08', 555),
	(1, 'Esteban Rojas Oviedo', 5191265711405188, '2027-12-16', 555),
	(2, 'Liam Smith', 4111741911108731, '2026-12-17', 555),
	(1, 'Noah Johnsons', 110245865265, '2025-12-16', 555),
	(1, 'Oliver Williams', 119126577788, '2022-12-15', 555),
	(1, 'Elijah Brown', 113350733562, '2023-09-02', 555),
	(1, 'Olivia Miller', 117432852541, '2023-09-22', 555),
	(1, 'Oscar Garcia', 114937151425, '2023-09-11', 555);
				
------------------------------------------USERS------------------------------------------

INSERT INTO [User] (idUserType, idPersonalInfo, username, password, suscribed, idPaymentInfo) VALUES
	(1, 1, 'robercar', (select [GeneralDB].[dbo].encdec('Method67',2,0)), 0, 1),
	(1, 2, 'paumad', (select [GeneralDB].[dbo].encdec('LaContra143',2,0)), 0, 2),
	(1, 3, 'anaE', (select [GeneralDB].[dbo].encdec('Asd9876',2,0)), 0, 3),
	(2, 4, 'belenAlv',(select [GeneralDB].[dbo].encdec( 'ContraZWS55',2,0)), 1, 4),
	(2, 5, 'santiacos',(select [GeneralDB].[dbo].encdec( 'Random1223',2,0)), 1, 5),
	(2, 6, 'sebasmont',(select [GeneralDB].[dbo].encdec( 'monT5566',2,0)), 1, 6),
	(2, 7, 'gabrvare',(select [GeneralDB].[dbo].encdec( 'Gabo0908',2,0)), 0, 7),
	(2, 8, 'adsibaja',(select [GeneralDB].[dbo].encdec( 'Default999',2,0)), 0, 8),
	(2, 9, 'juliblan',(select [GeneralDB].[dbo].encdec( 'Blanco4',2,0)), 0, 9),
	(2, 10, 'estebroj',(select [GeneralDB].[dbo].encdec( 'Huunter789',2,0)), 1, 10),
	-- Employees
	(3, 11, 'liamsmi',(select [GeneralDB].[dbo].encdec( 'Liam98',2,0)), 0, 11),
	(3, 12, 'noahjohn',(select [GeneralDB].[dbo].encdec( 'Jogn065',2,0)), 0, 12),
	(3, 13, 'olivwill', (select [GeneralDB].[dbo].encdec('OliWi32',2,0)), 0, 13),
	(3, 14, 'elijbrown',(select [GeneralDB].[dbo].encdec( 'Elij7878',2,0)), 0, 14),
	(3, 15, 'oliviamill',(select [GeneralDB].[dbo].encdec( 'Oliv12',2,0)), 0, 15),
	(3, 16, 'charllgarc',(select [GeneralDB].[dbo].encdec( 'Asd2020',2,0)), 0, 16);

------------------------------------------INVENTORY------------------------------------------
INSERT INTO Inventory(idProduct, quantity) VALUES
    (1, 5),
    (4, 14),
    (7, 51),
    (10, 63),
    (13, 65),
    (16, 90),
    (19, 7),
    (22, 5),
    (25, 3),
    (28, 65),
    (31, 20),
    (34, 62),
    (37, 81),
    (40, 42),
    (43, 55),
    (46, 57),
    (49, 64),
    (52, 13),
    (55, 62),
    (58, 42),
    (61, 75),
    (64, 97),
    (67, 15),
    (70, 48);