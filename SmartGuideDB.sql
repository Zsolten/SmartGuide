drop database IF EXISTS SmartGuideDB;
create database IF NOT EXISTS SmartGuideDB;
USE SmartGuideDB;

create table IF NOT EXISTS Regions(
	name VARCHAR(256) NOT NULL,
    description MEDIUMTEXT NOT NULL,

	id INT NOT NULL auto_increment PRIMARY KEY
);


create table IF NOT EXISTS Locations(
	name VARCHAR(256) NOT NULL,
	city VARCHAR(256) NOT NULL,
	category VARCHAR(256) NOT NULL,
    description TEXT NOT NULL,
	
	googleMapsLink VARCHAR(256) NOT NULL,
    
	id INT NOT NULL auto_increment PRIMARY KEY
);

create table IF NOT EXISTS OpenHours(
	day INT NOT NULL,
    openTime time,
    closeTime time,
    
	id INT NOT NULL auto_increment PRIMARY KEY,
	LocationKey INT,
    FOREIGN KEY (LocationKey) REFERENCES Locations(id)
);

create table IF NOT EXISTS Pictures(
	path VARCHAR(256) NOT NULL,
    name VARCHAR(256) NOT NULL,
	id INT NOT NULL auto_increment PRIMARY KEY,
	LocationKey INT,
	FOREIGN KEY (LocationKey) REFERENCES Locations(id)
);

create table IF NOT EXISTS Prices(
	category VARCHAR(50) NOT NULL,
    price INT,
    
	id INT NOT NULL auto_increment PRIMARY KEY,
	LocationKey INT,
	FOREIGN KEY (LocationKey) REFERENCES Locations(id)
);

-- Dropping the Tables
drop table Prices;
drop table Pictures;
drop table OpenHours;
drop table Locations;

-- Inserting Location
INSERT INTO Locations (name, city, category, description, googleMapsLink)
VALUES ("Hunyadi Kastely", "Vajdahunyad", "tortenelmi epiteszet",  
    "A Hunyadiak kastélya Hunyad megye leglátogatottabb turisztikai látványossága. Európa legcsodásabb kastélyai közt a nyolcadik helyre rangsorolta a világhírű Lonely Planet útikönyv-kiadó és utazási filmek készítője. Az utóbbi időben több történelmi témájú film forgatásának a helyszíne. A birtokot 1409-ben adományként kapja meg Hunyadi János édesapja és ide építi fel a mai vár elődjét birtokközpontnak. Míg Hunyadi János kormányzó volt, addig felesége Szilágyi Erzsébet lakott a várban. Ekkor bővítették ki az építményt és alakították át Hunyadi János kormányzói rangjához méltó lovagvárrá. Későbbi jelentős építési átalakításai a 17-ik század elején Bethlen Gábor és a század közepén Zólyomi Dávidné idejében történt. 1725-től a kincstári uradalom hivatalai kapnak székhelyet a várban. Újabb felújítás 1807 után I. Ferenc utasítására kezdődik el, aminek sajnálatos módon 1818-ban egy villámcsapás okozta tűz véget vet. 1854-ben ismét tűz áldozata lesz. Közadakozásból 1868-ban újrakezdik az évtizedekig elhúzódó helyreállítását a várnak egységesen gótikus stílusban. Akkor alakították ki a tetők mai formáját. A Zalasd mély és széles árkán egy négy hatalmas pillérre támaszkodó fahíd vezet át. Baloldalt, a város felőli parton van a huszárvár. A Kaputorony az 1440-es években épült, innen nyílik a lejárás a kazamatákba. Nyugati oldalon van a vár palotaszárnya, amelynek alsó szintjén a lovagterem van, a felső szinten az Országház nevű tárgyalóterem.",  
    "https://www.google.com/maps/place/Castelul+Corvinilor+(Corvins'+Castle)/@45.7493634,22.8857117,17z/data=!3m1!4b1!4m6!3m5!1s0x474e8a8efc2a74cb:0x2cec7ae8ba35e916!8m2!3d45.7493634!4d22.8882866!16zL20vMDZ6MXpt?authuser=0&entry=ttu"
    ),

    ("Devai Var", "Deva", "tortenelmi epiteszet",  
    "Déva Erdély történetének fontos tanúja és tükörképe. Ókori erődítmények helyén épült Erdély egyik első királyi vára, a tatárjáráskor megrongálódott várat IV. Béla építtette újjá. A kezdetektől kettős funkciót látott el, védelmi szerepe mellett főúri rezidencia, 1302-től az erdélyi alvajdák székhelye. A Maros völgye fölé 180 méterre emelkedő sziklára épült, legkorábbi része a hegytetőn állt, az idők folyamán óriási területet olvaszt magába spirálisan kiépített védrendszerével a hegy lábáig leereszkedve. A későbbi királyi birtokot Hunyadi János V. Lászlótól kapta adományként, a környező 56 faluval együtt. A következő évszázadban Szapolyai János és Bocskai István is birtokolja. Fontos megemlíteni még Dávid Ferencet, az egyetlen kifejezetten magyar vallás, az unitárius egyház alapítóját; itt raboskodva fejezte be életét 1579-ben. Emléktábla jelzi a cellát az udvar közepén, amelybe bezárva volt. A vár hadászati szerepe megmaradt az Erdélyi Fejedelemség idején is. Az 1848-as szabadságharc idején a magyar honvédek kezébe került vár, egy 1849-es ostrom alatt a lőporraktár felrobbanása következtében elpusztul, maga alá temetve a 150 fős magyar honvéd helyőrséget is. A felújítási munkálatok már évek óta szinte folyamatosak, a falak erősítése lassan a végéhez közeledik. A belső várat a tervek szerint 2018-ban nyitják meg a látogatók előtt.",  
    "https://www.google.com/maps/place/The+Fortress+of+Deva/@45.8888805,"
    );


-- Inserting prices for a location
INSERT INTO Prices (LocationKey, category, price) VALUES
(1, 'child', 5.00),
(1, 'student', 7.00),
(1, 'adult', 10.00),
(1, 'pensioner', 8.00);

-- Inserting open hours for a location
INSERT INTO OpenHours (LocationKey, day, openTime, closeTime) VALUES
(1, 1, '09:00:00', '18:00:00'), -- Monday
(1, 2, '08:00:00', '18:00:00'), -- Tuesday
(1, 3, '07:00:00', '18:00:00'), -- Wednesday
(1, 4, '06:00:00', '18:00:00'), -- Thursday
(1, 5, '05:00:00', '18:00:00'), -- Friday
(1, 6, '04:00:00', '14:00:00'), -- Saturday
(1, 7, '12:00:00', '18:00:00'); -- Sunday


-- create table IF NOT EXISTS Users( --???????? 
-- 	name VARCHAR(256) NOT NULL
-- ); 
 
SELECT 
    *
FROM 
    Locations
LEFT JOIN 
    OpenHours ON Locations.id = OpenHours.LocationKey
LEFT JOIN 
    Prices ON Locations.id = Prices.LocationKey;

Select * from Locations;

create table IF NOT EXISTS Restaurants(
	name VARCHAR(256) NOT NULL,
	id INT NOT NULL auto_increment PRIMARY KEY
);

create table IF NOT EXISTS Menus(
	menuName VARCHAR(256) NOT NULL,
	price DOUBLE NOT NULL,
	possibleAlergies VARCHAR(256) NOT NULL,
	ingredients VARCHAR(256) NOT NULL,
	vegan BOOL NOT NULL,
	id INT NOT NULL auto_increment PRIMARY KEY,
    
	FK INT,
    FOREIGN KEY (FK) REFERENCES Restaurants(id)
);
