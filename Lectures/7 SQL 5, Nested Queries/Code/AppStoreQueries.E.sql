SELECT cs.last_name, d.name
FROM
(SELECT * 
FROM customers c
WHERE c.country = 'Singapore') 
AS cs, 
downloads d
WHERE cs.customerid = d.customerid;

SELECT c.last_name, d.name
FROM  customers c, downloads d
WHERE c.country = 'Singapore'
AND c.customerid = d.customerid;

SELECT d.name
FROM  downloads d
WHERE d.customerid IN (
    SELECT c.customerid
    FROM customers c
    WHERE c.country = 'Singapore');
    
SELECT d.name
FROM  customers c, downloads d
WHERE c.country = 'Singapore'
AND c.customerid = d.customerid; 

SELECT d.name
FROM  downloads d
WHERE d.customerid IN (
SELECT c.customerid
FROM customers c
WHERE c.country = 'Singapore');
    
SELECT d.name
FROM  downloads d
WHERE d.customerid = ANY (
SELECT c.customerid
FROM customers c
WHERE c.country = 'Singapore');
    
SELECT g1.name, g1.version, g1.price
FROM  games g1
WHERE g1.price >= ALL (
SELECT g2.price
FROM  games g2);
    
SELECT g1.name, g1.version, g1.price
FROM  games g1
WHERE g1.price >= ANY (
SELECT g2.price
FROM  games g2);
    
SELECT g.name, g.version, g.price
FROM  games g
HAVING g.price= MAX(g.price);

SELECT g1.name, g1.version, g1.price
FROM  games g1
WHERE g1.price = MAX(
SELECT g2.price 
FROM games g2);

SELECT g1.name, g1.version, g1.price
FROM  games g1
WHERE g1.price = ALL(
SELECT MAX(g2.price) 
FROM games g2);

SELECT d.name
FROM  downloads d
WHERE EXISTS (
SELECT c.customerid
FROM customers c
WHERE d.customerid = c.customerid
AND c.country = 'Singapore');

SELECT g1.name, g1.version, g1.price
FROM  games g1
WHERE g1.price >= ALL (
SELECT g2.price
FROM  games g2
WHERE g1.name = g2.name);
    
SELECT c.customerid, d.name
FROM  downloads d
WHERE d.customerid IN (
SELECT c.customerid
FROM customers c
WHERE c.country = 'Singapore');
    
SELECT c.customerid
FROM  customers c
WHERE c.customerid NOT IN (
SELECT d.customerid
FROM downloads d);

SELECT c.customerid
FROM  customers c
WHERE c.customerid <> ALL (
SELECT d.customerid
FROM downloads d);

SELECT c.customerid
FROM  customers c
WHERE NOT EXISTS (
SELECT d.customerid
FROM downloads d
WHERE c.customerid = d.customerid);

SELECT c1.country
FROM customers c1
GROUP BY c1.country
HAVING COUNT(*) >= ALL (
SELECT COUNT(*)
FROM customers c2
GROUP BY c2.country);

SELECT c.first_name, c.last_name
FROM customers c
WHERE NOT EXISTS( 
SELECT *   
FROM games g  
WHERE g.name ='Aerified'  
AND NOT EXISTS (      
SELECT *      
FROM downloads d     
WHERE d.customerid = c.customerid     
AND d.name = g.name      
AND d.version = g.version));

