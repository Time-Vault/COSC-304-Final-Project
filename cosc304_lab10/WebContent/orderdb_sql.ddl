DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS shipment;
DROP TABLE IF EXISTS productinventory;
DROP TABLE IF EXISTS warehouse;
DROP TABLE IF EXISTS orderproduct;
DROP TABLE IF EXISTS incart;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS ordersummary;
DROP TABLE IF EXISTS paymentmethod;
DROP TABLE IF EXISTS customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(100),
    productPrice        DECIMAL(12,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(14,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(14,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(40),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(1000),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(12,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Spirits');
INSERT INTO category(categoryName) VALUES ('Undead');
INSERT INTO category(categoryName) VALUES ('Eldritch Horrors');
INSERT INTO category(categoryName) VALUES ('Ancient Evils/Beings');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Fairmont Banff Springs Hotel',1,'757 bed, 800 bath, Haunted By: Sam the Bellman',1600000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Great Pyramid of Giza',2,'1 bed, 0 bath, Haunted By: Mummified Pharaoh',30000000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bran Castle',2,'7 bed, 3 bath, Haunted By: Dracula - Part Time, Draculas Wives',700000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Carfax House',2,'3 bed, 1 bath, Haunted By: Dracula - Part Time',300000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Winchester Tavern',2,'0 bed, 2 bath, Haunted By: Zombies*<br>*Grabbing a pint and waiting for it to all blow over voids guarantee of zombies.',150000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Amnityville House',1,'3 bed, 2 bath, Haunted By: Jodie',100000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Buckingham Palace',3,'240 bed, 78 bath, Haunted By: Queen Elizabeth The Second',1500000000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Leeds House',4,'2 bed, 1 bath, Haunted By: Jersey Devil',80000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Derry Sewers',3,'0 bed, All bath, Haunted By: It',25000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Goatmans Bridge',4,'0 bed, 0 bath, Haunted by: Goatman, Cultists',21000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Group 16',4,'0 bed, 0 bath, Haunted By: COSC 304 Students',10000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Civil War Hospital',1,'20 bed, 3 bath, Haunted By: Vengful Spirit',750000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Akator',4,'13 bed, 1 bath, Haunted By: Crystal Skulls, Steven Spielberg',90000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Blasted Heath',3,'4 bed, 2 bath, Haunted By: Colour Out Of Space',120000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gilman House Hotel - rubble',3,'10 bed - rubble, 10 bath - rubble, Haunted By: Dagon, Deep Ones',20000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Silver Bridge - rubble',4,'0 bed, 1 bath - river, Haunted By: Mothman',5000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Catherine Palace',1,'40 bed, 30 bath, Haunted By: Rasputin*, Romanov Family<br>*Not guaranteed to be deceased.',1200000000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Winchester House',1,'40 bed*, 10 bath*, Haunted By: Sarah Winchester**, Victims of Winchester Rifles**<br>*If you can find them.<br>**If they can find you.',8700000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Frankensteins Lab',2,'1 bed, 1 bath, 1 lab, Haunted By: Frankensteins Monster, Frankensteins Ego',7000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Snowy Mountain Cabin',4,'5 bed, 3 bath, Haunted By: Wendigos',57000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Medieval German Peasant Home',4,'1 bed, 0 bath, Haunted By: Krampus, The Plague',600);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Eastern State Penitentiary',1,'450 bed/bath combo rooms, Haunted By: Al Capone',1300000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Area 51',3,'[REDACTED] bed, [REDACTED] bath, Haunted By: [REDACTED]',1700000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Victorian Era House', 1, '6 bed, 1 bath, Haunted By: Phantom Teacher',500000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Palace of Nyarlathotep',3,'50 bed, 10 bath, Haunted By: Nyarlathotep',7000000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Paris Catacombs',2,'~6-7 mil bed, 0 bath, Haunted By: Several centuries worth of skeletons',90000000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Okanagan Lake',4,'0 bed, 1 bath, Haunted By: Ogopogo',4500000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mexican Cattle Ranch',4,'3 bed, 2 bath, Haunted By: Chupacabra',400000);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ancient Necropolis',2,'3 bed, 1 bath, Haunted By: Ghouls',45000.00);

INSERT INTO warehouse(warehouseName) VALUES ('North American Distribution Center');
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 1600000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 30000000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 700000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 300000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 150000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 100000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 1500000000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (8, 1, 7, 80000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 25000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (10, 1, 6, 21000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (11, 1, 5, 10000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (12, 1, 3, 750000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (13, 1, 9, 90000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (14, 1, 17, 120000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (15, 1, 2, 20000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (16, 1, 7, 5000);

INSERT INTO warehouse(warehouseName) VALUES ('European Distribution Center');
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (15, 2, 5, 1200000000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (17, 2, 1, 1200000000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (18, 2, 6, 8700000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (19, 2, 4, 7000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (20, 2, 8, 57000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (21, 2, 64, 600);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (22, 2, 3, 1300000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (23, 2, 9, 1700000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (24, 2, 2, 500000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (25, 2, 1, 7000000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (26, 2, 8, 90000000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (27, 2, 4, 4500000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (28, 2, 9, 400000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (29, 2, 4, 45000);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 15, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 17, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE categoryId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE categoryId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE categoryId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE categoryId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE productName = 'Buckingham Palace';
UPDATE Product SET productImageURL = 'img/6.jpg' WHERE productName = 'Silver Bridge - rubble';
UPDATE Product SET productImageURL = 'img/7.jpg' WHERE productName = 'Eastern State Penitentiary';
UPDATE Product SET productImageURL = 'img/8.jpg' WHERE productName = 'Frankensteins Lab';
UPDATE Product SET productImageURL = 'img/9.jpg' WHERE productName = 'Area 51';
UPDATE Product SET productImageURL = 'img/10.jpg' WHERE productName = 'Bran Castle';
UPDATE Product SET productImageURL = 'img/11.jpg' WHERE productName = 'Okanagan Lake';
UPDATE Product SET productImageURL = 'img/12.jpg' WHERE productName = 'Leeds House';
UPDATE Product SET productImageURL = 'img/13.jpg' WHERE productName = 'Derry Sewers';
UPDATE Product SET productImageURL = 'img/14.jpg' WHERE productName = 'Winchester Tavern';
UPDATE Product SET productImageURL = 'img/15.jpg' WHERE productName = 'Fairmont Banff Springs Hotel';
UPDATE Product SET productImageURL = 'img/16.jpg' WHERE productName = 'Catherine Palace';
