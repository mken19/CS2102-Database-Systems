INSERT INTO book VALUES (
'An Introduction to Database Systems',
'paperback' , 
640 , 
'English' , 
'C. J. Date' , 
'Pearson',
'0321197844' , 
'978-0321197849');


INSERT INTO student VALUES (
'TIKKI TAVI' , 
'tikki@gmail.com' , 
'2021-08-01', 
'School of Computing', 
'CS', 
NULL);

INSERT INTO student (email, name, year, faculty, department)
VALUES (
'rikki@gmail.com', 
'RIKKI TAVI', 
'2021-08-01', 
'School of Computing', 
'CS');


UPDATE student
SET department = 'Computer Science'
WHERE department = 'CS';

INSERT INTO copy
VALUES (
'tikki@gmail.com', 
'978-0321197849', 
1);

BEGIN TRANSACTION;
SET CONSTRAINTS ALL IMMEDIATE;
DELETE FROM book 
WHERE ISBN13 = '978-0321197849' ;
DELETE FROM copy 
WHERE book = '978-0321197849' ;
END TRANSACTION;


BEGIN TRANSACTION;
SET CONSTRAINTS ALL DEFERRED;
DELETE FROM book WHERE ISBN13 = '978-0321197849' ;
DELETE FROM copy WHERE book = '978-0321197849' ;
END TRANSACTION;
