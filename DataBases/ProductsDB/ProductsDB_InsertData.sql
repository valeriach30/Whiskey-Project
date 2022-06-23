USE ProductsDB;
GO
-- Insert Coins
INSERT INTO Coin(name, symbol, country) VALUES
	('dollar', '$', 'united states'), --1
	('euro', '�', 'ireland'), --2
	('pound', '�', 'scotland');--3

-- Insert type of products
INSERT INTO ProductType(name) VALUES
	('Single Malt'),
	('Blended Scotch'),
	('Irish'),
	('Blended Malt'),
	('Bourbon'),
	('Tennessee Whiskey');

---------------------------------------------------JSONS---------------------------------------------------

DECLARE @json1 NVARCHAR(MAX) = N'{
	"flavour": "fruity",
	"year": 2010,
	"size": 750,
	"description": "Johnnie Walker Red Label is our Pioneer Blend, the one that has introduced our whisky to the world. Highly versatile and with universal appeal, it has a bold, characterful flavour that shines through even when mixed. Johnnie Walker Red Label is now the best-selling Scotch Whisky around the globe. Perfect for parties and get-togethers, at home or going out. Enjoy with friends."
}';
DECLARE @json2 NVARCHAR(MAX) = N'{
	"flavour": "sweet",
	"year": 2015,
	"size": 750,
	"description": "Created to be a sweeter, lighter Blended Scotch Whisky, this was the first whisky created by Stephanie Macleod. Thanks to both our unique double ageing process and golden water source, Dewars 15 Year Old is unusually smooth, with flavour notes of honey, toffee and floral."
}';
DECLARE @json3 NVARCHAR(MAX) = N'{
	"flavour": "sweet",
	"year": 2018,
	"size": 750,
	"description": "Cutty Sark is the worlds only surviving extreme clipper. Most of the hull fabric you see today dates back to its original construction. Clipper ships are marked by three design characteristics - a long, narrow hull, a sharp bow which cuts through the waves rather riding atop - and three raking masts."
}';
DECLARE @json4 NVARCHAR(MAX) = N'{
	"flavour": "grainy",
	"year": 2019,
	"size": 1000,
	"description": "Fresh, grassy and nutty on the nose, J&B offers malt, spice, fruit salad and sweet grains on the well-balanced palate. The blend contains more than 40 individual whiskies, with Speyside malts at its core, and in particular its heart malt Knockando, along with Auchroisk."
}';
DECLARE @json5 NVARCHAR(MAX) = N'{
	"flavour": "citrus",
	"year": 2008,
	"size": 750,
	"description": "The Glenlivet 12 Year scotch is a classic Speyside single malt characterized by a balanced and elegant flavor profile. Its flavors of citrus, honeysuckle, and vanilla promise to please those looking for a non-smoky flavor�no peat flavors here."
	
}';
DECLARE @json6 NVARCHAR(MAX) = N'{
	"flavour": "vanilla",
	"year": 2010,
	"size": 750,
	"description": "A terrific single malt from The Balvenie. This Speysider was initially aged in traditional oak casks before it was finished in casks which previously held Caribbean rum, imparting some extra sweetness and warmth to the whisky. The fabulous result is a well-rounded whisky with notes of toffee, fruit and vanilla."
	
}';
DECLARE @json7 NVARCHAR(MAX) = N'{
	"flavour": "melon",
	"year": 2010,
	"size": 750,
	"description": 
	"12 year old single malt from the Glenrothes distillery, released as part of the Soleo Collection. This range takes its name from the process of sun-drying grapes in Jerez for sherry production,so it shouldnt come as a surprise that sherried deliciousness is a focus here. Also noteworthy is the lack of vintage on the label, with Glenrothes decides to eschew them in favour of age statements for the majority of the series."
	
}';
DECLARE @json8 NVARCHAR(MAX) = N'{
	"flavour": "apple",
	"year": 2010,
	"size": 750,
	"description": "The classic 12 Year Old Aberfeldy single malt Scotch whisky, distilled in the Highlands. While the label sadly no longer features a red squirrel, it now comes with a rather handsome black and rose-gold colour palate to match the rich,malty, honeyed flavour profile."
}';
DECLARE @json9 NVARCHAR(MAX) = N'{
	"flavour": "citrus",
	"year": 2021,
	"size": 750,
	"description": "The wonderful Tullamore D.E.W. has gone and finished its original blend of pot still, malt and grain Irish whiskeys in firstfill Caribbean rum casks which previously held Demerara rum. As well asbeing a taste sensation, the expression pays tribute to the role that Irish immigrants played in the development of rum in the Caribbean back in the 17th century. Some history for you while you sip."
}';
DECLARE @json10 NVARCHAR(MAX) = N'{
	"flavour": "coffee",
	"year": 2018,
	"size": 750,
	"description": "The Dead Rabbit Grocery & Grog in New York City is home to the largest collection of Irish whiskey in North America, so it was only a matter of time before it got its very own Irish whiskey! By teaming up with Darryl McNally, master distiller at The Dublin Liberties,they have created this excellent expression. Its based around a 5 year old whiskey matured in ex-bourbon barrels, which has then been finishedin �half-sized virgin American oak barrels."
}';
DECLARE @json11 NVARCHAR(MAX) = N'{
	"flavour": "velvety",
	"year": 2007,
	"size": 750,
	"description": "A beautiful pure pot still whiskey(or "single pot still" as its now officially known). Redbreast 15 is a rich, thick, sweet, pungent whiskeywith loads of flavour and complexity - really good stuff!"
}';
DECLARE @json12 NVARCHAR(MAX) = N'{
	"flavour": "berries",
	"year": 2017,
	"size": 750,
	"description": " a classic triple-distilled expression combining single malt and grain whiskeys. Wonderfullycreamy and vanilla-forward, with flashes of fruit andspice underneath waves of toffee and malt."
}';
DECLARE @json13 NVARCHAR(MAX) = N'{
	"flavour": "nutmeg",
	"year": 2008,
	"size": 750,
	"description": "Douglas Laings Scallywag is a small batch bottling created using quality Speyside Malts.Non chill-filtered, and the use of 40% first-fill Sherry butts creates a rich colour and a charming malt whisky with a richly spiced character, fused with vanilla, sweet stewed fruit and dark chocolate."
	
}';
DECLARE @json14 NVARCHAR(MAX) = N'{
	"flavour": "smoky",
	"year": 2018,
	"size": 750,
	"description": "Come rain or shine, Big Peat�s Beach Barbecue Limited Edition is ready to celebrate F�is �le 2022! Douglas Laing�s feisty Ileach fisherman is seriously committed to smoke and recommends pairing this Cask Strength bottling with well-charred meat to allow the juicy flavours from the grill to enhance the spirit�s sweeter side, before packing a satisfyingly long and peaty finish."
}';
DECLARE @json15 NVARCHAR(MAX) = N'{
	"flavour": "smoky",
	"year": 2001,
	"size": 750,
	"description": "Rock Island 21 Year Old is a limited edition blended malt from Douglas Laing, marrying together Island single malts from Islay, Arran, Jura and Orkney. This one exclusively features whiskies aged for at least 21 years, and only 4,200 bottles have been produced at 46.8% ABV."
}';
DECLARE @json16 NVARCHAR(MAX) = N'{
	"flavour": "grainy",
	"year": 2016,
	"size": 1000,
	"description": "This here is a rather intriguing blended malt whisky from Adelphis Fusion series. Dubbed The S�ndebud, its a combination of malt whisky from the Ardnamurchan Distillery in Scotland and malt whisky from the High Coast Distillery in Sweden. What a combo! Intrepid whisky explorers should be keen to get their hands on a bottle of this..."
}';
DECLARE @json17 NVARCHAR(MAX) = N'{
	"flavour": "fruit",
	"year": 2015,
	"size": 750,
	"description": "Woodford Reserve introduces itself with a light to moderate sweet honey and vanilla notes with equal amounts of charred wood and dried corn. Its a bready and grainy scent followed by a pinch of mint, fruits, and nuts."
}';
DECLARE @json18 NVARCHAR(MAX) = N'{
	"flavour": "sugar",
	"year": 2016,
	"size": 750,
	"description": "Mellow spice, rich fruit, hints of sweet oak and caramel. Mellow, ripened red berries, dried spice, well-balanced, rich."
}';
DECLARE @json19 NVARCHAR(MAX) = N'{
	"flavour": "almond",
	"year": 2010,
	"size": 750,
	"description": "Widow Jane 10-Year-Old Bourbon is a blend of straight bourbons from distilleries in Kentucky, Tennessee and Indiana. Batches come in 5 barrel batches and are non-chill filtered. The most important feature for the aged whiskies coming from Widow Jane is the proofing water they are using."
}';
DECLARE @json20 NVARCHAR(MAX) = N'{
	"flavour": "banana",
	"year": 2000,
	"size": 750,
	"description": "Sweetens Cove is a richly flavorful and decadent bourbon. Its sweet on the palate but backed by its cask strength proof, boasting notes of vanilla, banana bread, leather, and cedar. The finish is warming with hints of candied orange peel and brown sugar, making it a very enjoyable whiskey to savor."
}';
DECLARE @json21 NVARCHAR(MAX) = N'{
	"flavour": "nutty",
	"year": 2000,
	"size": 750,
	"description": "is somewhat sweet and spicy with drops of honey, charred wood, vanilla, and anise. Small chunks of bread and a gentle nuttiness intermingle with everything else as well."
}';
DECLARE @json22 NVARCHAR(MAX) = N'{
	"flavour": "Caramel",
	"year": 2006,
	"size": 750,
	"description": "Behold, Double Barrel Bourbon from the Heavens Door range. Created by the one and only Bob Dylan and Marc Bushala (founder of Angels Envy Bourbon), this expression blends together three whiskeys which are then finished in hand-toasted, new American oak barrels. "
}';
DECLARE @json23 NVARCHAR(MAX) = N'{
	"flavour": "spearmint",
	"year": 2015,
	"size": 750,
	"description": "In the glass, Nelsons First 108 Green Label has a decidedly reddish amber appearance. The nose has a little heat, but around that is a buttery cinnamon toast core, drizzled with liquid caramel and accented by cedar shavings."
}';
DECLARE @json24 NVARCHAR(MAX) = N'{
	"flavour": "chocolate ",
	"year": 2010,
	"size": 750,
	"description": "Chattanooga Whiskey 111 Cask is the unfiltered, barrel strength expression of Chattanooga Whiskey�s signature high malt bourbon, Chattanooga Whiskey 91. Unlike 91 however, Cask 111 is not Solera aged. It�s made from a single fermentation which is extended 7 days. Each 8-12 barrel batch represents a single distillation run. It�s aged for at least two years in toasted and charred 53 gallon barrels before bottling."
}';
---------------------------------------------------PRODUCTS---------------------------------------------------



----------------------------------------- BLENDED SCOTCH -----------------------------------------



INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 2, 'Johnnie Walker Red Label', 22.99, @json1, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\JohnieeWalker-BlendedScotch.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 2, 'Johnnie Walker Red Label', 21.86, @json1, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\JohnieeWalker-BlendedScotch.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 2, 'Johnnie Walker Red Label', 18.67, @json1, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\JohnieeWalker-BlendedScotch.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 2, 'Dewars True Scotch', 28.0, @json2, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Dewars-BlendedScotch.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 2, 'Dewars True Scotch', 23, @json2, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Dewars-BlendedScotch.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 2, 'Dewars True Scotch', 22.17, @json2, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Dewars-BlendedScotch.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 2, 'Cutty Sarck', 22.99, @json3, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\CuttySark-BlendedScotch.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 2, 'Cutty Sarck', 21.43, @json3, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\CuttySark-BlendedScotch.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 2, 'Cutty Sarck', 18.20, @json3, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\CuttySark-BlendedScotch.jpg', Single_Blob) AS productImage;

-- Only for suscribers


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 2, 'J&B', 25, @json4, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\J&B-BlendedScotch.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 2, 'J&B', 23.30, @json4, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\J&B-BlendedScotch.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 2, 'J&B', 19.79, @json4, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\J&B-BlendedScotch.jpg', Single_Blob) AS productImage;


-----------------------------------------SINGLE MALT-----------------------------------------  



INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 1, 'The Glenlivet Single Malt Scotch', 73, @json5, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Glenlivet-SingleMat.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 1, 'The Glenlivet Single Malt Scotch', 68.03, @json5, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Glenlivet-SingleMat.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 1, 'The Glenlivet Single Malt Scotch', 57.79, @json5, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Glenlivet-SingleMat.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 1, 'The Balvenie 14 Year Old Caribbean Cask', 85, @json6, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\BalveniCaribbean-SingleMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 1, 'The Balvenie 14 Year Old Caribbean Cask', 79.22, @json6, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\BalveniCaribbean-SingleMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 1, 'The Balvenie 14 Year Old Caribbean Cask', 67.29, @json6, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\BalveniCaribbean-SingleMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 1, 'The Glenrothes 12 Year', 55, @json7, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Glenrothes-SingleMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 1, 'The Glenrothes 12 Year', 51.26, @json7, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Glenrothes-SingleMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 1, 'The Glenrothes 12 Year', 43.54, @json7, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Glenrothes-SingleMalt.jpg', Single_Blob) AS productImage;


-- Only for suscribers


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 1, 'Aberfeldy 12-Year-Old', 45, @json8, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Aberfeldy-SingleMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 1, 'Aberfeldy 12-Year-Old', 41.94, @json8, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Aberfeldy-SingleMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 1, 'Aberfeldy 12-Year-Old', 35.62, @json8, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Aberfeldy-SingleMalt.jpg', Single_Blob) AS productImage;



----------------------------------------- IRISH -----------------------------------------



INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 3, 'Tullamore D.E.W. Original', 37, @json9, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Tullamore-Irish.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 3, 'Tullamore D.E.W. Original', 34.48, @json9, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Tullamore-Irish.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 3, 'Tullamore D.E.W. Original', 29.29, @json9, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Tullamore-Irish.jpg', Single_Blob) AS productImage;

INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 3, 'Dead Rabbit Irish Whiskey', 47, @json10, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\DeadRabbit-Irish.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 3, 'Dead Rabbit Irish Whiskey', 43.80, @json10,1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\DeadRabbit-Irish.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 3, 'Dead Rabbit Irish Whiskey', 37.21, @json10,1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\DeadRabbit-Irish.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 3, 'Redbreast 15 Year', 129, @json11, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\redbreast-irish.jpg', Single_Blob) AS productImage;

INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 3, 'Redbreast 15 Year', 120.22, @json11, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\redbreast-irish.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 3, 'Redbreast 15 Year', 102.12, @json11, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\redbreast-irish.jpg', Single_Blob) AS productImage;

-- Only for suscribers

INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 3, 'Bushmills Original', 24, @json12, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\BushmillsOriginal-Irish.jpg', Single_Blob) AS productImage;

INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 3, 'Bushmills Original', 22.37, @json12, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\BushmillsOriginal-Irish.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 3, 'Bushmills Original', 19.00, @json12, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\BushmillsOriginal-Irish.jpg', Single_Blob) AS productImage;



----------------------------------------- BLENDED MALT -----------------------------------------



INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 4, 'Scallywag Bottling Note', 38.38, @json13, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Scallywag-BlendedMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 4, 'Scallywag Bottling Note', 35.77, @json13, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Scallywag-BlendedMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 4, 'Scallywag Bottling Note', 30.38, @json13, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Scallywag-BlendedMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 4, 'Big Peat Beach BBQ Edition', 57.89, @json14, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\BigPeatBeach-BlendedMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 4, 'Big Peat Beach BBQ Edition', 53.95, @json14, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\BigPeatBeach-BlendedMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 4, 'Big Peat Beach BBQ Edition', 45.83, @json14, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\BigPeatBeach-BlendedMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 4, 'Rock Island 21 Year Old ', 80.94, @json15, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\RockIsland-BlendedMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 4, 'Rock Island 21 Year Old ', 75.43, @json15, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\RockIsland-BlendedMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 4, 'Rock Island 21 Year Old ', 64.08, @json15, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\RockIsland-BlendedMalt.jpg', Single_Blob) AS productImage;


-- Only for suscribers

INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 4, 'The Sandebud 6 Year Old', 99.96, @json16, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\TheSandebud-BlendedMalt.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 4, 'The Sandebud 6 Year Old', 93.16, @json16, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\TheSandebud-BlendedMalt.jpg', Single_Blob) AS productImage;

INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 4, 'The Sandebud 6 Year Old', 79.13, @json16, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\TheSandebud-BlendedMalt.jpg', Single_Blob) AS productImage;




-----------------------------------------BOURBON -----------------------------------------



INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 5, 'Woodford Reserve Kentucky', 60, @json17, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Woodford-Bourbon.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 5, 'Woodford Reserve Kentucky', 55.92, @json17, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Woodford-Bourbon.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 5, 'Woodford Reserve Kentucky', 47.50, @json17, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Woodford-Bourbon.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 5, 'Four Roses Small Batch Select', 65, @json18,1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\FourRoses-Bourbon.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 5, 'Four Roses Small Batch Select', 60.58, @json18, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\FourRoses-Bourbon.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 5, 'Four Roses Small Batch Select', 51.46, @json18, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\FourRoses-Bourbon.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 5, 'Widow Jane 10 Year Old Bourbon', 70, @json19, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Widow-Bourbon.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 5, 'Widow Jane 10 Year Old Bourbon', 65.24, @json19, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Widow-Bourbon.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 5, 'Widow Jane 10 Year Old Bourbon', 55.42, @json19, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Widow-Bourbon.jpg', Single_Blob) AS productImage;


-- Only for suscribers

INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 5, 'Sweetens Cove Tennessee Straight Bourbon', 235, @json20, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Sweetens-Bourbon.jpg', Single_Blob) AS productImage;

INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 5, 'Sweetens Cove Tennessee Straight Bourbon', 219.01, @json20, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Sweetens-Bourbon.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 5, 'Sweetens Cove Tennessee Straight Bourbon', 186.04, @json20, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Sweetens-Bourbon.jpg', Single_Blob) AS productImage;




-----------------------------------------TENNESSE----------------------------------------- 



INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 6, 'Jack Daniels Straight Rye', 19.99, @json21, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\JackDaniels-Tennesse.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 6, 'Jack Daniels Straight Rye', 18.62, @json21, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\JackDaniels-Tennesse.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 6, 'Jack Daniels Straight Rye', 15.83, @json21, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\JackDaniels-Tennesse.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 6, 'Heavens Door Double Barrel Whiskey', 50, @json22, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\HeavensDoor-Tennesse.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 6, 'Heavens Door Double Barrel Whiskey', 46.58, @json22, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\HeavensDoor-Tennesse.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 6, 'Heavens Door Double Barrel Whiskey', 39.59, @json22, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\HeavensDoor-Tennesse.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 6, 'Nelsons First 108 Tennessee Whiskey', 40, @json23, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Nelsons-Tennesse.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 6, 'Nelsons First 108 Tennessee Whiskey', 37.26, @json23, 1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Nelsons-Tennesse.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 6, 'Nelsons First 108 Tennessee Whiskey', 31.67, @json23,1, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Nelsons-Tennesse.jpg', Single_Blob) AS productImage;

-- Only for suscribers

INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 1, 6, 'Chattanooga Whiskey 111', 45, @json24, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Chattanooga-Tennesse.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 2, 6, 'Chattanooga Whiskey 111', 41.92, @json24, 0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Chattanooga-Tennesse.jpg', Single_Blob) AS productImage;


INSERT INTO Product(idCoin, idProductType, [name], price, charact, visible, productImage) 
SELECT 3, 6, 'Chattanooga Whiskey 111', 35.63, @json24,0, 
BulkColumn FROM OPENROWSET(Bulk 'C:\Images\Chattanooga-Tennesse.jpg', Single_Blob) AS productImage;


-- SELECT * FROM Product