DROP TABLE OrderedProduct;
DROP TABLE Stores;
DROP TABLE Orders;
DROP TABLE ProductReview;
DROP TABLE Product;
DROP TABLE HasPaymentMethod;
DROP TABLE PaymentMethod;
DROP TABLE Users;
DROP TABLE ShippingOption;
DROP TABLE ProductCategory;
DROP TABLE Warehouse;
DROP TABLE UserGroup;


CREATE TABLE UserGroup (
	GroupID int,
	name varchar(50),
	PRIMARY KEY (GroupID)
);


CREATE TABLE Warehouse (
	wname varchar(50),
	address varchar(50),
	city varchar(50),
	province varchar(3),
	PRIMARY KEY (wname)
);


CREATE TABLE ProductCategory (
	catID int,
	catName varchar(50),
	catURL varchar(50),
	PRIMARY KEY (catID)
);


CREATE TABLE ShippingOption (
	TypeID int,
	TypeName varchar(50),
	discount decimal(4,2),
	PRIMARY KEY (TypeID)
);


CREATE TABLE Users (
	UserID int,
	GroupID int,
	fname varchar(50),
	lname varchar(50),
	address varchar(50),
	city varchar(50),
	province varchar(3),
	postalcode char(7),
	email varchar(254),
	password varchar(50),
	PRIMARY KEY (UserID),
	FOREIGN KEY (GroupID) REFERENCES UserGroup (GroupID)
		ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE PaymentMethod (
	creditcardcompany varchar(50),
	creditnumber int,
	PRIMARY KEY (creditnumber)
);


CREATE TABLE HasPaymentMethod (
	UserID int,
	creditnumber int,
	PRIMARY KEY (UserID, creditnumber),
	FOREIGN KEY (UserID) REFERENCES Users (UserID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (creditnumber) REFERENCES PaymentMethod (creditnumber)
		ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Product (
	pid int,
	pname varchar(50),
	price decimal(9,2),
	catID int,
	picURL varchar(50),
	currentlySelling bit,
	PRIMARY KEY (pid), 
	FOREIGN KEY (catID) REFERENCES ProductCategory (catID)
		ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Orders (
	oid int IDENTITY,
	odate date,
	address varchar(50),
	city varchar(50),
	province varchar(3),
	postalcode char(7),
	TypeID int,
	creditnumber int,
	UserID int,
	TotalAmount decimal(9,2),
	PRIMARY KEY (oid),
	FOREIGN KEY (TypeID) REFERENCES ShippingOption (TypeID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (creditnumber) REFERENCES  PaymentMethod (creditnumber)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (UserID) REFERENCES Users (UserID)
		ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE ProductReview (
	pid int,
	UserID int,
	rnumber int,
	rating int,
	description text,
	PRIMARY KEY (pid, rnumber),
	FOREIGN KEY (pid) REFERENCES Product (pid)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (UserID) REFERENCES Users (UserID)
		ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Stores (
	wname varchar (50),
	pid int,
	inventory int,
	PRIMARY KEY (wname, pid),
	FOREIGN KEY (wname) REFERENCES Warehouse (wname)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (pid) REFERENCES Product (pid)
		ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE OrderedProduct (
	oid int,
	pid int,
	quantity int,
	price float,
	PRIMARY KEY (oid, pid),
	FOREIGN KEY (oid) REFERENCES Orders (oid)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (pid) REFERENCES Product (pid)
		ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO ProductCategory VALUES (1,'Soccer', NULL)
INSERT INTO ProductCategory VALUES (2,'Rugby', NULL)
INSERT INTO ProductCategory VALUES (3,'Basketball', NULL)
INSERT INTO ProductCategory VALUES (4,'Curling', NULL)
INSERT INTO ProductCategory VALUES (5,'Baseball', NULL)
INSERT INTO ProductCategory VALUES (6,'Hockey', NULL)


INSERT INTO Product VALUES (1, 'Soccer Ball', 10, 1, NULL, 1)
INSERT INTO Product VALUES (2, 'Soccer Cleats', 10, 1, NULL, 1)
INSERT INTO Product VALUES (3, 'Soccer Gloves', 10, 1, NULL, 1)
INSERT INTO Product VALUES (4, 'Rugby Ball', 10, 2, NULL, 1)
INSERT INTO Product VALUES (5, 'Rugby Cleats', 10, 2, NULL, 1)
INSERT INTO Product VALUES (6, 'Rugby Cap', 10, 2, NULL, 1)
INSERT INTO Product VALUES (7, 'Basketball', 10, 3, NULL, 1)
INSERT INTO Product VALUES (8, 'Basketball Shoes', 10, 3, NULL, 1)
INSERT INTO Product VALUES (9, 'Basketball Hoop', 10, 3, NULL, 1)
INSERT INTO Product VALUES (10, 'Curling Rock', 10, 4, NULL, 1)
INSERT INTO Product VALUES (11, 'Curling Shoes', 10, 4, NULL, 1)
INSERT INTO Product VALUES (12, 'Curling Broom', 10, 4, NULL, 1)
INSERT INTO Product VALUES (13, 'Baseball', 10, 5, NULL, 1)
INSERT INTO Product VALUES (14, 'Baseball Cleats', 10, 5, NULL, 1)
INSERT INTO Product VALUES (15, 'Baseball Bat', 10, 5, NULL, 1)
INSERT INTO Product VALUES (16, 'Hockey Puck', 10, 6, NULL, 1)
INSERT INTO Product VALUES (17, 'Hockey Stick', 10, 6, NULL, 1)
INSERT INTO Product VALUES (18, 'Hockey Skates', 10, 6, NULL, 1) 


INSERT INTO UserGroup VALUES (1, 'Manager')
INSERT INTO UserGroup VALUES (2, 'Customer')


INSERT INTO Warehouse VALUES ('Warehouse A', ' 1234 SomePlaceInTown Street', 'Kelowna', 'BC')
INSERT INTO Warehouse VALUES ('Warehouse B', ' 4321 SomePlaceInPEI Street', 'Charlottetown', 'PEI')


INSERT INTO ShippingOption VALUES (1, 'Moose', 0)
INSERT INTO ShippingOption VALUES (2, 'Goose', 25)
INSERT INTO ShippingOption VALUES (3, 'Canoe/Portage', 50)


INSERT INTO Users VALUES (1, 1, 'Drew', 'Swan', '413431531698043 Quebec Street', 'Vancouver', 'BC', 'V2I Q8S', 'drewswan@drew.swan', 'a')
INSERT INTO Users VALUES (2, 1, 'Swan', 'Drew', '413431531698043 Vancouver Street', 'Quebec City', 'QB', 'Q8S V2I', 'swandrew@swan.drew', 'b')


INSERT INTO PaymentMethod VALUES ('Drew''s Super Legit Credit Company', 1234567890)


INSERT INTO HasPaymentMethod VALUES (1, 1234567890)


INSERT INTO Stores VALUES ('Warehouse A', 1, 67)
INSERT INTO Stores VALUES ('Warehouse A', 2, 123)
INSERT INTO Stores VALUES ('Warehouse A', 3, 45)
INSERT INTO Stores VALUES ('Warehouse A', 4, 345)
INSERT INTO Stores VALUES ('Warehouse A', 5, 567)
INSERT INTO Stores VALUES ('Warehouse A', 6, 32)
INSERT INTO Stores VALUES ('Warehouse A', 7, 67)
INSERT INTO Stores VALUES ('Warehouse A', 8, 123)
INSERT INTO Stores VALUES ('Warehouse A', 9, 45)
INSERT INTO Stores VALUES ('Warehouse A', 10, 67)
INSERT INTO Stores VALUES ('Warehouse A', 11, 123)
INSERT INTO Stores VALUES ('Warehouse A', 12, 45)
INSERT INTO Stores VALUES ('Warehouse A', 13, 345)
INSERT INTO Stores VALUES ('Warehouse A', 14, 567)
INSERT INTO Stores VALUES ('Warehouse A', 15, 32)
INSERT INTO Stores VALUES ('Warehouse A', 16, 67)
INSERT INTO Stores VALUES ('Warehouse A', 17, 123)
INSERT INTO Stores VALUES ('Warehouse A', 18, 45)
INSERT INTO Stores VALUES ('Warehouse B', 1, 67)
INSERT INTO Stores VALUES ('Warehouse B', 2, 123)
INSERT INTO Stores VALUES ('Warehouse B', 3, 45)
INSERT INTO Stores VALUES ('Warehouse B', 4, 345)
INSERT INTO Stores VALUES ('Warehouse B', 5, 567)
INSERT INTO Stores VALUES ('Warehouse B', 6, 32)
INSERT INTO Stores VALUES ('Warehouse B', 7, 67)
INSERT INTO Stores VALUES ('Warehouse B', 8, 123)
INSERT INTO Stores VALUES ('Warehouse B', 9, 45)
INSERT INTO Stores VALUES ('Warehouse B', 10, 67)
INSERT INTO Stores VALUES ('Warehouse B', 11, 123)
INSERT INTO Stores VALUES ('Warehouse B', 12, 45)
INSERT INTO Stores VALUES ('Warehouse B', 13, 345)
INSERT INTO Stores VALUES ('Warehouse B', 14, 567)
INSERT INTO Stores VALUES ('Warehouse B', 15, 32)
INSERT INTO Stores VALUES ('Warehouse B', 16, 67)
INSERT INTO Stores VALUES ('Warehouse B', 17, 123)
INSERT INTO Stores VALUES ('Warehouse B', 18, 45)


INSERT INTO Orders VALUES ('2015-10-04', '1234 Fun Street', 'Edmonton', 'AB', 'T6L 4S4', 1, 1234567890, 1, 30)


INSERT INTO OrderedProduct VALUES (1, 1, 2, 55.0)
INSERT INTO OrderedProduct VALUES (1, 2, 1, 33.0)

