SELECT COUNT(*) 
FROM customers;

SELECT COUNT(c.customerid) 
FROM customers c;

SELECT COUNT(c.country) 
FROM customers c;

SELECT COUNT(ALL c.country) 
FROM customers c;

SELECT COUNT(DISTINCT c.country) 
FROM customers c;

SELECT MAX(g.price), 
MIN(g.price), 
TRUNC(AVG(g.price), 2) AS ave, 
TRUNC(STDDEV(g.price),2) AS std
FROM games g;

SELECT c.country, COUNT(*)
FROM customers c
GROUP BY c.country;

SELECT COUNT(*)
FROM customers c;

SELECT c.country, COUNT(*)
FROM customers c
WHERE c.dob >= '2000-01-01'
GROUP BY c.country;

SELECT c.customerid, c.first_name, c.last_name, SUM(g.price)
FROM customers c, downloads d, games g
WHERE c.customerid = d.customerid
AND d.name = g.name AND d.version = g.version
GROUP BY c.customerid, c.first_name, c.last_name;

SELECT c.first_name, c.last_name, SUM(g.price)
FROM customers c, downloads d, games g
WHERE c.customerid = d.customerid
AND d.name = g.name AND d.version = g.version
GROUP BY c.customerid;

SELECT c.first_name, c.last_name, SUM(g.price)
FROM customers c, downloads d, games g
WHERE c.customerid = d.customerid
AND d.name = g.name AND d.version = g.version
GROUP BY c.customerid, c.first_name, c.last_name;

SELECT c.customerid, c.first_name, c.last_name, SUM(g.price)
FROM customers c, downloads d, games g
WHERE c.customerid = d.customerid
AND d.name = g.name AND d.version = g.version
GROUP BY c.first_name, c.last_name;

SELECT c.country, EXTRACT(YEAR FROM c.since ) AS regyear, COUNT(*) AS total
FROM customers c, downloads d
WHERE c.customerid = d.customerid
GROUP BY c.country, regyear
ORDER BY regyear, c.country;

SELECT c.country, EXTRACT(YEAR FROM c.since ) AS regyear, COUNT(*) AS total
FROM customers c, downloads d
WHERE c.customerid = d.customerid
GROUP BY regyear, c.country
ORDER BY regyear, c.country;

SELECT c.country
FROM customers c
WHERE COUNT(*) >= 100
GROUP BY c.country;

SELECT c.country
FROM customers c
GROUP BY c.country
HAVING COUNT(*) >= 100;
