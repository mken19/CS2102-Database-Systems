-- Tutorial 3 Solution

-- 1 
-- (a)
SELECT d.department
FROM department d;


-- (b)
SELECT DISTINCT s.department
FROM student s;

-- (c)
SELECT DISTINCT s.email 
FROM loan l, student s 
WHERE (s.email = l.borrower AND l.borrowed < s.year) 
OR (s.email = l.owner AND l.borrowed < s.year);

-- (d)
SELECT l.book, l.returned - l.borrowed + 1 AS duration 
FROM loan l
WHERE NOT (l.returned ISNULL)
ORDER BY l.book ASC, duration DESC;

-- use case when
SELECT l.book, 
	((CASE
	WHEN l.returned ISNULL 
	THEN '2022-07-31'
	ELSE l.returned
	END) - l.borrowed + 1) AS duration 
FROM loan l
ORDER BY l.book ASC, duration ASC;

-- (e)
SELECT b.title, 
	s1.name AS ownername, 
	d1.faculty AS ownerFaculty, 
	s2.name AS borrowername, 
	d2.faculty AS  borrowerfaculty
FROM loan l, book b,  copy c, 
	student s1, student s2, 
	department d1, department d2
WHERE l.book=b.ISBN13
	AND c.book = l.book 
	AND c.copy = l.copy 
	AND c.owner = l.owner
	AND l.owner = s1.email
	AND l.borrower = s2.email
	AND s1.department = d1.department
	AND s2.department = d2.department
	AND b.publisher ='Wiley'
	AND l.returned ISNULL;


SELECT b.title, 
	s1.name AS ownername, 
	d1.faculty AS ownerFaculty, 
	s2.name AS borrowername, 
	d2.faculty AS  borrowerfaculty
FROM loan l, book b,  
	student s1, student s2, 
	department d1, department d2
WHERE l.book=b.ISBN13
	AND l.owner = s1.email
	AND l.borrower = s2.email
	AND s1.department = d1.department
	AND s2.department = d2.department
	AND b.publisher ='Wiley'
	AND l.returned ISNULL;



-- 2
-- (a)
SELECT b.title, 
	s1.name AS ownername, 
	d1.faculty AS ownerFaculty, 
	s2.name AS borrowername, 
	d2.faculty AS  borrowerfaculty
FROM loan l 
	INNER JOIN book b ON l.book=b.ISBN13
	INNER JOIN copy c ON c.book = l.book 
		AND c.copy = l.copy 
		AND c.owner = l.owner
	INNER JOIN student s1 ON l.owner = s1.email
	INNER JOIN student s2 ON l.borrower = s2.email
	INNER JOIN department d1 ON s1.department = d1.department
	INNER JOIN department d2 ON s2.department = d2.department
WHERE  b.publisher ='Wiley'
	AND l.returned ISNULL;



SELECT b.title, 
	s1.name AS ownername, 
	d1.faculty AS ownerFaculty, 
	s2.name AS borrowername, 
	d2.faculty AS  borrowerfaculty
FROM loan l 
	INNER JOIN book b ON l.book=b.ISBN13
	INNER JOIN student s1 ON l.owner = s1.email
	INNER JOIN student s2 ON l.borrower = s2.email
	INNER JOIN department d1 ON s1.department = d1.department
	INNER JOIN department d2 ON s2.department = d2.department
	WHERE  b.publisher ='Wiley'
	AND l.returned ISNULL;


-- (b)
SELECT  s.email 
FROM loan l, student s 
WHERE s.email = l.borrower AND l.borrowed = s.year
UNION
SELECT  s.email 
FROM loan l, student s 
WHERE s.email = l.owner AND l.borrowed = s.year;

-- union all 
SELECT  s.email 
FROM loan l, student s 
WHERE s.email = l.borrower AND l.borrowed = s.year
UNION ALL
SELECT  s.email 
FROM loan l, student s 
WHERE s.email = l.owner AND l.borrowed = s.year;

-- simple query
SELECT DISTINCT s.email 
FROM loan l,  student s 
WHERE (s.email = l.borrower OR s.email = l.owner) 
AND l.borrowed = s.year;

-- (c)
SELECT  s.email 
FROM loan l, student s 
WHERE s.email = l.borrower AND l.borrowed = s.year
INTERSECT
SELECT  s.email 
FROM loan l, student s 
WHERE s.email = l.owner AND l.borrowed = s.year;

-- more complicated one
SELECT DISTINCT s.email 
FROM loan l1, loan l2, student s 
WHERE s.email = l1.borrower AND l1.borrowed = s.year 
AND s.email = l2.owner AND l2.borrowed = s.year;


-- (d)
SELECT  s.email 
FROM loan l, student s 
WHERE s.email = l.borrower AND l.borrowed = s.year
EXCEPT
SELECT  s.email 
FROM loan l, student s 
WHERE s.email = l.owner AND l.borrowed = s.year;




-- (e)
SELECT  b.ISBN13 
FROM book b
EXCEPT
SELECT  l.book 
FROM loan l

-- use outer join
SELECT  b.ISBN13 
FROM book b LEFT OUTER JOIN loan l ON b.isbn13 = l.book
WHERE l.book ISNULL;



