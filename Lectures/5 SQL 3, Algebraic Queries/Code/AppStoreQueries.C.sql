SELECT *
FROM customers c 
CROSS JOIN downloads d 
CROSS JOIN games g;

SELECT *
FROM customers c, downloads d, games g;

SELECT *
FROM customers c, downloads d, games g 
WHERE d.customerid = c.customerid 
AND d.name = g.name
AND d.version = g.version;
    
SELECT *
FROM customers c 
INNER JOIN downloads d 
ON d.customerid = c.customerid  
INNER JOIN games g 
ON d.name = g.name
AND d.version = g.version;
    
SELECT *
FROM customers c 
JOIN downloads d 
ON d.customerid = c.customerid  
JOIN games g 
ON d.name = g.name
AND d.version = g.version;
    
SELECT *
FROM customers c 
NATURAL JOIN downloads d 
NATURAL JOIN games g;

SELECT  g.name, g.version, 
c.customerid, 
c.first_name, c.last_name, c.email, c.dob, 
c.since, c.country, 
g.price
FROM customers c, downloads  d, games g
WHERE d.customerid = c.customerid 
AND d.name = g.name
AND d.version = g.version;

SELECT c.customerid, c.email, d.customerid, 
d.name, d.version
FROM customers c LEFT OUTER JOIN downloads d 
ON c.customerid = d.customerid;

SELECT *
FROM downloads d RIGHT OUTER JOIN games a 
ON a.name = d.name AND a.version = d.version;

SELECT c.customerid
FROM customers c LEFT OUTER JOIN downloads d 
ON c.customerid = d.customerid
WHERE d.customerid ISNULL;

SELECT c.email, c.country
FROM customers c LEFT OUTER JOIN downloads d 
ON c.customerid = d.customerid 
WHERE d.customerid ISNULL
AND c.country = 'Singapore';

SELECT c.email, c.country
FROM customers c LEFT OUTER JOIN downloads d 
ON c.customerid = d.customerid 
AND c.country = 'Singapore'
WHERE d.customerid ISNULL;

SELECT d.customerid
FROM downloads d
WHERE d.name = 'Aerified' AND  d.version = '1.0'
UNION
SELECT d.customerid
FROM downloads d
WHERE d.name = 'Aerified' AND d.version = '2.0';

SELECT name || ' ' || version  AS game, price * 1.07 
FROM games 
WHERE price * 0.07 >= 0.3
UNION
SELECT name || ' ' || version  AS game, price 
FROM games 
WHERE price * 0.07 < 0.3;

SELECT d.customerid
FROM downloads d
WHERE d.name = 'Aerified' AND  d.version = '1.0'
INTERSECT
SELECT d.customerid
FROM downloads d
WHERE d.name = 'Aerified' AND d.version = '2.0';

SELECT d.customerid
FROM downloads d
WHERE d.name = 'Aerified' AND  d.version = '1.0'
EXCEPT
SELECT d.customerid
FROM downloads d
WHERE d.name = 'Aerified' AND d.version = '2.0';

SELECT c.email, SUM(g.price)
FROM customers c, downloads d, games g 
WHERE c.customerid = d.customerid 
AND g.name = d.name 
AND g.version = d.version 
AND c.country = 'Indonesia' 
AND g.name = 'Fixflex'
GROUP BY c.email
UNION
SELECT c.email, 0
FROM customers c LEFT OUTER JOIN 
(downloads d INNER JOIN games g 
ON  g.name = d.name 
AND g.version = d.version 
AND g.name = 'Fixflex') 
ON c.customerid = d.customerid
WHERE c.country = 'Indonesia' 
AND d.name IS NULL;
