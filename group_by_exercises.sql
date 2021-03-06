-- 1 In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT title FROM titles; -- 7 distinct titles.

--2 Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE 'E%e'
GROUP BY last_name; -- 5 rows

--3 Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'. 
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE 'E%'
GROUP BY full_name; -- 6,840 rows

--4 Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
AND NOT LIKE '%qu%'
ORDER BY last_name; -- Chleq, Lindqvist, Qiwen

--5 Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name, COUNT(last_name) AS count_last_name
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%'
GROUP BY last_name; -- Chelq=189, Lindqvist=190, Qiwen=168

--6 Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT first_name, gender, COUNT(gender)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender; --Vidya: M=151 / F81. Irena: M=144 / F=97. Maya: M=146 / F=90.

--7 Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
SELECT LOWER(CONCAT(SUBSTR(first_name,1,1), SUBSTR(last_name, 1,4), '_', SUBSTR(birth_date, 6,2), SUBSTR(birth_date,3,2))) AS username, COUNT(*) AS count_username
FROM employees
GROUP BY username
HAVING count_username > 1; -- Yes there are duplicates. There are 13,251 duplcate usernames

--8 Find the historic average salary for all employees. 
SELECT AVG(salary)
FROM salaries; --63,810.74

-- Now determine the current average salary.
SELECT AVG(salary)
FROM salaries
WHERE to_date > CURDATE(); -- 72,012.24

--9 Now find the historic average salary for each employee. Reminder that when you hear "for each" in the problem statement, you'll probably be grouping by that exact column.
SELECT emp_no, AVG(salary), MIN(salary), MAX(salary)
FROM salaries
GROUP BY emp_no;

--10 Find the current average salary for each employee.
SELECT emp_no, AVG(salary)
FROM salaries
WHERE to_date > CURDATE()
GROUP BY emp_no;

--11 Find the maximum salary for each current employee.
SELECT emp_no, MAX(salary)
FROM salaries
WHERE to_date > CURDATE()
GROUP BY emp_no;

--12 Now find the max salary for each current employee where that max salary is greater than $150,000.
SELECT emp_no, MAX(salary)
FROM salaries
WHERE to_date > CURDATE()
GROUP BY emp_no
HAVING MAX(salary) > 150000;

--13 Find the current average salary for each employee where that average salary is between $80k and $90k.
SELECT emp_no, MAX(salary)
FROM salaries
WHERE to_date > CURDATE()
GROUP BY emp_no
HAVING AVG(salary) BETWEEN 80000 AND 90000;