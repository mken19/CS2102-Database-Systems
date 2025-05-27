-- Tutorial4
-- 1
-- (a)
SELECT COUNT(*)
FROM loan l, student s1, student s2
WHERE l.owner = s1.email 
	AND l.borrower = s2.email
	AND s1.department = s2.department;

-- (b)
SELECT d1.faculty, COUNT(*)
FROM loan l, student s1, student s2, department d1, department d2
WHERE l.owner = s1.email 
	AND l.borrower = s2.email
	AND s1.department = d1.department
	AND s2.department = d2.department
	AND d1.faculty = d2.faculty
GROUP by d1.faculty;


--(c)
SELECT ROUND(AVG((CASE
	WHEN l.returned ISNULL 
	THEN '2022-07-31'
	ELSE l.returned
	END) - l.borrowed + 1),0),
	ROUND(STDDEV_POP ((CASE
	WHEN l.returned ISNULL 
		THEN '2022-07-31'
		ELSE l.returned
		END) - l.borrowed + 1),0)
FROM loan l;


-- or
SELECT ROUND(AVG(temp.duration),0),
ROUND(STDDEV_POP (temp.duration),0)
FROM (SELECT ((CASE
	WHEN l.returned ISNULL 
	THEN '2022-07-31'
	ELSE l.returned
	END) - l.borrowed + 1) AS duration FROM loan l) AS temp;



-- 2
-- (a)
SELECT  b.title 
FROM book b
WHERE b.ISBN13 NOT IN (
	SELECT  l.book 
	FROM loan l);

-- or

SELECT  b.title 
FROM book b
WHERE b.ISBN13 <> ALL (
	SELECT  l.book 
	FROM loan l);


-- (b)
SELECT  s.name 
FROM student s
WHERE s.email IN (
	SELECT c.owner
	FROM copy c
	WHERE NOT EXISTS (
		SELECT * 
		FROM loan l
		WHERE l.owner = c.owner
			AND l.book = c.book
			AND l.copy = c.copy));

-- or

SELECT  s.name 
FROM student s
WHERE s.email = ANY (
	SELECT c.owner
	FROM copy c
	WHERE NOT EXISTS (SELECT * 
		FROM loan l
		WHERE l.owner = c.owner
			AND l.book = c.book
			AND l.copy = c.copy));


-- or (use turple construction)
SELECT  s.name 
FROM student s
WHERE s.email IN (
	SELECT c.owner
	FROM copy c
	WHERE (c.owner, c.book, c.copy) NOT IN 
			(SELECT l.owner, l.book, l.copy 
			FROM loan l));

-- try this one
SELECT  s.name 
FROM student s, copy c
WHERE s.email = c.owner 
	AND NOT EXISTS (SELECT * 
	FROM loan l
		WHERE l.owner = c.owner
			AND l.book = c.book
			AND l.copy = c.copy);


-- eliminate the duplicate
SELECT  s.name 
FROM student s, copy c
WHERE s.email = c.owner 
	AND NOT EXISTS (SELECT * 
	FROM loan l
		WHERE l.owner = c.owner
			AND l.book = c.book
			AND l.copy = c.copy)
GROUP BY s.email, s.name;




-- (c)
SELECT  s.department, s.name, count(*)
FROM student s, loan l
WHERE l.owner = s.email
GROUP BY s.department, s.email, s.name
HAVING count(*) >= ALL
	(SELECT  count(*) 
	FROM student s1, loan l1
	WHERE l1.owner = s1.email
		AND s.department = s1.department
	GROUP BY s1.email);



-- (d)
SELECT s.email, s.name
FROM student s
WHERE NOT EXISTS (
	SELECT * 
	FROM book b
	WHERE authors = 'Adam Smith' 
		AND NOT EXISTS (
			SELECT * 
			FROM loan l
			WHERE l.book = b.isbn13 
				AND l.borrower = s.email));





















