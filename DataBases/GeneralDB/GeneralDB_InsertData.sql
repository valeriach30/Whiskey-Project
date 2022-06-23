USE GeneralDB;
GO

-- Insert locations
INSERT INTO LocationCode(code, locationMap) VALUES
	('IRL', geography::Point(53.34680724107667, -6.262823939323426, 4326)),
	('SCO', geography::Point(55.856399878809114 , -4.254401922225953, 4326)),
	('USA', geography::Point(32.77911322589106 , -96.83439731597902, 4326));

-- SELECT * FROM LocationCode

-- Insert users

INSERT INTO UserxPlace (idUser, idCode) VALUES
	-- Irish users
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1),
	(13, 1),
	(14, 1),
	(15, 1),
	(16, 1),
	-- Scotish users 
	(1, 2),
	(2, 2),
	(3, 2),
	(4, 2),
	(5, 2),
	(6, 2),
	(7, 2),
	(8, 2),
	(9, 2),
	(10, 2),
	(11, 2),
	(12, 2),
	(13, 2),
	(14, 2),
	(15, 2),
	(16, 2),
	-- American users
	(1, 3),
	(2, 3),
	(3, 3),
	(4, 3),
	(5, 3),
	(6, 3),
	(7, 3),
	(8, 3),
	(9, 3),
	(10, 3),
	(11, 3),
	(12, 3),
	(13, 3),
	(14, 3),
	(15, 3),
	(16, 3);

-- SELECT * FROM UserxPlace

-- Insert users of employees
INSERT INTO UserxEmployee (idUser, idEmployee) VALUES
	(11, 1),
	(12, 2),
	(13, 3),
	(14, 4),
	(15, 5),
	(16, 6),
	(27, 7),
	(28, 8),
	(29, 9),
	(30, 10),
	(31, 11),
	(32, 12),
	(43, 13),
	(44, 14),
	(45, 15),
	(46, 16),
	(47, 17),
	(48, 18);

-- SELECT * FROM UserxEmployee

-- Insert Evaluations
INSERT INTO Evaluation(idProduct, idUser, idDelieveryPerson, idSeller, comment, calification, evDate) VALUES
	-- Ireland evaluations
	(2, 4, 3, 1, 'excellent service', 10, '2022-05-18'), 
	(5, 5, 3, 2, 'delievery was slow, but great', 8, '2022-05-18'), 
	(8, 6, 4, 2, 'great service', 10, '2022-01-18'), 
	(17, 7, 4, 1, 'dissapointed on the service from the delievery man', 5, '2022-04-03'),
	-- Scotland evaluations
	(3, 17, 9, 7, 'overral great', 9, '2022-05-09'), 
	(72, 18, 10, 7, 'product did not show up', 1, '2022-05-12'), 
	(48, 19, 9, 8, 'very great', 10, '2022-06-11'), 
	(27, 20, 10, 8, 'excellent product', 10, '2022-03-03'), 
	-- American evaluations
	(1, 36, 15, 13, 'i loved it', 10, '2022-02-22'), 
	(19, 37, 16, 13, 'recommended', 10, '2022-04-14'), 
	(10, 39, 15, 14, 'great!!!', 10, '2022-05-30'), 
	(22, 40, 16, 14, 'excellent', 10, '2022-05-28');

-- SELECT * FROM Evaluation

INSERT INTO Review(idProduct, idUser, comment, RevDate) VALUES
	(1, 1, 'Always fancied trying red label as I liked black label so much. No complaints I really like it would recommend.', '2022-02-22'),
	(2, 2, 'Look, if youre a scotch connoisseur, this is not going to be something that you seek out. But for blending, or getting something on ice at a bar with a lousy selection, you could do worse. In those situations, I prefer it to Dewars, Cutty and even its big brother JWB.', '2022-02-22'),
	(23, 40, 'excellent product, will buy again', '2021-03-17'),
	(10, 25, 'great taste and service', '2021-01-30'),
	(10, 20, 'great taste and service', '2022-02-28'),
	(72, 22, 'overral great', '2022-02-27'),
	(13, 1, 'excellent product, will buy again', '2022-10-23'),
	(65, 4, 'overral great', '2021-09-22'),
	(55, 25, 'very good', '2021-08-22'),
	(22, 33, 'excellent product, will buy again', '2021-01-04'),
	(27, 39, 'excellent, thanks', '2022-02-03'),
	(38, 17, 'excellent product', '2022-02-08'),
	(49, 13, 'will buy again, recommended for those looking for something different', '2022-03-22'),
	(51, 3, 'great!!!', '2022-04-12'),
	(57, 42, 'excellent product, will buy again', '2022-04-25'),
	(58, 44, 'excellent product, will buy again', '2022-05-13'),
	(12, 25, 'excellent product, will buy again', '2022-06-11');

-- SELECT * FROM Review

-- Insert suscription types
INSERT INTO SuscriptionType(name, dicosuntBuy, discountShipping, canSee, present, emailNotifications, price) VALUES
	('Tier Short Glass', 5, 0, 0, 0, 1, 19.99), 
	('Tier Gleincairn', 10, 20, 1, 0, 1, 39.99), 
	('Tier Master Distiller', 30, 100, 1, 1, 1, 59.99);

-- SELECT * FROM SuscriptionType

-- Insert suscribed users
INSERT INTO Suscription(idUser, idSuscriptionType) VALUES
	(4, 1),
	(5, 1),
	(6, 1),
	(10, 1),
	(20, 2),
	(21, 2),
	(22, 2),
	(26, 2),
	(36, 3),
	(37, 3),
	(38, 3),
	(42, 3);

-- SELECT * FROM Suscription

-- Insert responses to evaluations
INSERT INTO ResponseEV(idEvaluation, idEmployee, idUser, description, dateResp) VALUES
	(1, 5, 4, 'Thank you so much for taking the time to leave us a evaluation its much appreciated!', '2022-05-22'),
	(4, 5, 7, 'Im sorry, please feel free to contact us at +17 8909 3281', '2022-04-13'),
	(6, 12, 18, 'Please send us an email to refund you', '2022-05-15');

-- SELECT * FROM ResponseEV