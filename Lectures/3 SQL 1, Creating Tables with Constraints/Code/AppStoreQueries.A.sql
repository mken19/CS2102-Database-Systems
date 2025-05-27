CREATE TABLE downloads(
    first_name VARCHAR(64), 
    last_name VARCHAR(64), 
    email VARCHAR(64), 	
    dob DATE,
    since DATE,
    customerid VARCHAR(16), 
    country VARCHAR(16),
    name VARCHAR(32),
    version CHAR(3),
    price NUMERIC);
    
DROP TABLE downloads;
    
CREATE TABLE customers (
	first_name VARCHAR(64),
	last_name VARCHAR(64),
	email VARCHAR(64),
	dob DATE,
	since DATE,
	customerid VARCHAR(16),
	country VARCHAR(16));

CREATE TABLE games (
	name VARCHAR(32),
	version CHAR(3),
	price NUMERIC);
	
CREATE TABLE downloads(
	customerid VARCHAR(16),
	name VARCHAR(32),
	version CHAR(3));

DELETE FROM customers;
	
DROP TABLE customers;

CREATE TABLE customers (
first_name VARCHAR(64),
last_name VARCHAR(64),
email VARCHAR(64),
dob DATE,
since DATE,
customerid VARCHAR(16) PRIMARY KEY,
country VARCHAR(16));

INSERT INTO customers VALUES(
	'Carole', 
	'Yoga', 
	'cyoga@glarge.org', 
	'1989-08-01', 
	'2016-09-15', 
	'Carole89', 
	'France');
	
INSERT INTO customers VALUES(
	'Carole', 
	'Yoga', 
	'cyoga@glarge.org', 
	'1989-08-01', 
	'2016-09-15', 
	'Carole89', 
	'France');

DROP TABLE games;

CREATE TABLE games(
name VARCHAR(32),
version CHAR(3),
price NUMERIC,
PRIMARY KEY (name, version));

INSERT INTO games VALUES ('Aerified', '1.0', 5), ('Aerified', '1.0', 6);

INSERT INTO games VALUES ('Aerified', '1.0', 5), ('Aerified', '2.0', 6), ('Verified', '1.0', 7);

DROP TABLE games;

CREATE TABLE games(
name VARCHAR(32),
version CHAR(3),
price NUMERIC NOT NULL);

INSERT INTO games (name, version) VALUES ('Aerified', '1.0');

INSERT INTO games VALUES ('Aerified', '1.0', null);

DROP TABLE customers;

CREATE TABLE customers (
	first_name VARCHAR(64),
	last_name VARCHAR(64),
	email VARCHAR(64) UNIQUE,
	dob DATE,
	since DATE,
	customerid VARCHAR(16),
	country VARCHAR(16),
	UNIQUE (first_name, last_name));
	
DROP TABLE downloads;
DROP TABLE customers;
DROP TABLE games;

CREATE TABLE customers (
 first_name VARCHAR(64),
 last_name VARCHAR(64),
 email VARCHAR(64),
 dob DATE,
 since DATE,
 customerid VARCHAR(16) PRIMARY KEY,
 country VARCHAR(16));
	
CREATE TABLE games(
 name VARCHAR(32),
 version CHAR(3),
 price NUMERIC,
 PRIMARY KEY (name, version));
	
CREATE TABLE downloads(
customerid VARCHAR(16) REFERENCES customers (customerid),
name VARCHAR(32),
version CHAR(3),
FOREIGN KEY (name, version) REFERENCES games(name, version));

INSERT INTO downloads VALUES ('Adam1983', 'Biodex', '1.0');

INSERT INTO customers VALUES ('Deborah', 'Ruiz', 'druiz0@drupal.org', '1984-08-01', '2016-10-17', 'Deborah84', 'Singapore');
INSERT INTO games VALUES ('Aerified', '1.0', 12);
INSERT INTO downloads VALUES ('Deborah84', 'Aerified', '1.0');

DELETE FROM customers WHERE country='Singapore';


DROP TABLE downloads;
DROP TABLE customers;
DROP TABLE games;

CREATE TABLE games (
	name VARCHAR(32),
	version CHAR(3),
	price NUMERIC NOT NULL CHECK (price > 0));


INSERT INTO games VALUES ('Aerified', '1.0', 12);
INSERT INTO games VALUES ('Aerified', '1.1', 3.99);

UPDATE games SET price = price - 10;

DROP TABLE games;

CREATE TABLE customers (
	first_name VARCHAR(64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
	email VARCHAR(64) UNIQUE NOT NULL,
	dob DATE NOT NULL,
	since DATE NOT NULL,
	customerid VARCHAR(16) PRIMARY KEY,
	country VARCHAR(16) NOT NULL);

CREATE TABLE games (
	name VARCHAR(32),
	version CHAR(3),
	price NUMERIC NOT NULL CHECK (price > 0) ,
	PRIMARY KEY (name, version));

CREATE TABLE downloads(
	customerid VARCHAR(16) REFERENCES customers(customerid),
	name VARCHAR(32),
	version CHAR(3),
	FOREIGN KEY (name, version) REFERENCES games(name, version),
	PRIMARY KEY(customerid, name, version));
	
INSERT INTO games VALUES ('Skype', '1.0', 6.36);
INSERT INTO games VALUES ('Comfort', '1.1', 3.76);
INSERT INTO games VALUES ('Skype', '2.0', 3.04);

INSERT INTO customers VALUES ('Thomas', 'Lee', 'tlee@gmail.com', '1984-08-01', '2016-10-17', 'tom1999', 'Singapore');
INSERT INTO customers VALUES ('John', 'Altmann', 'al@hotmail.com', '1986-03-10', '2016-01-01', 'john88', 'Singapore');
INSERT INTO customers VALUES ('Deborah', 'Walnut', 'dcs@nus.edu.sg', '1984-07-07', '2016-09-14', 'walnuts', 'Singapore');

INSERT INTO downloads VALUES ('tom1999', 'Skype', '1.0');
INSERT INTO downloads VALUES ('john88', 'Comfort', '1.1');
INSERT INTO downloads VALUES ('tom1999', 'Skype', '2.0');

UPDATE downloads SET customerid = 'john1988' WHERE customerid = 'john88';
UPDATE customers SET customerid = 'thom1999' WHERE customerid = 'tom1999';
DELETE FROM customers WHERE customerid = 'tom1999';

DROP TABLE downloads;
DROP TABLE customers;
DROP TABLE games;

/* Load the case database */

SELECT first_name, last_name 
FROM customers 
WHERE country = 'Singapore';

SELECT first_name, last_name, email, dob, since, customerid, country
FROM customers;

SELECT *
FROM customers;

SELECT *
FROM games;

SELECT *
FROM downloads;

SELECT c.email, a.version 
FROM customers c, downloads d, games a 
WHERE c.customerid = d.customerid AND a.name = d.name AND a.version = d.version 
AND c.country = 'Indonesia' AND a.name = 'Fixflex';

CREATE VIEW singapore_customers1 AS
SELECT c.first_name, c.last_name, c.email, c.dob, c.since, c.customerid 
FROM customers c 
WHERE country='Singapore';

SELECT * FROM singapore_customers1;

CREATE TABLE singapore_customers2 (
	first_name VARCHAR(64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
	email VARCHAR(64) UNIQUE NOT NULL,
	dob DATE NOT NULL,
	since DATE NOT NULL,
	customerid VARCHAR(16) PRIMARY KEY REFERENCES customers(customerid));
	
SELECT * FROM singapore_customers2;

INSERT INTO singapore_customers2 
SELECT c.first_name, c.last_name, c.email, c.dob, c.since, c.customerid 
FROM customers c 
WHERE country='Singapore';

SELECT * FROM singapore_customers2;

DROP VIEW singapore_customers1;
DROP TABLE singapore_customers2;

