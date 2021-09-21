SELECT COUNT(*) FROM employees;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.

SELECT COUNT(*) FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya'); -- 709 records return

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?

SELECT COUNT(*) FROM employees WHERE first_name='Irena' OR first_name='Vdidya' OR first_name='Maya'; -- 477 records, doesn't match
SELECT COUNT(*) FROM employees WHERE first_name=('Irena' OR 'Vdidya' OR 'Maya'); -- doens't work

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.

SELECT COUNT(*) FROM employees WHERE (first_name='Irena' OR first_name='Vidya' OR first_name='Maya') AND gender='M'; -- 441 records

-- Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.

SELECT COUNT(*) FROM employees WHERE last_name LIKE 'E%'; -- 7,330 records

-- Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?


SELECT COUNT(*) FROM employees WHERE last_name LIKE 'E%' OR '%e'; -- 7,330 records
SELECT COUNT(*) FROM employees WHERE last_name LIKE '%e' AND NOT 'E%'; -- 24,292 records

-- Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?

SELECT COUNT(*) FROM employees WHERE last_name LIKE 'E%' AND '%e'; -- no records
SELECT COUNT(*) FROM employees WHERE last_name LIKE '%e'; -- 24,292 records

-- Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.

SELECT COUNT(*) FROM employees WHERE hire_date BETWEEN '1990-1-1' AND '1999-12-30'; -- 135,212 records
SELECT COUNT(*) FROM employees WHERE hire_date LIKE '199%'; -- 135,214 records


-- Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.

SELECT * FROM employees WHERE birth_date LIKE '%12-25'; -- 842 records
SELECT * FROM employees WHERE month(birth_date)=12 AND day(birth_date)=25;

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.

SELECT COUNT(*) FROM employees WHERE hire_date BETWEEN '1990-1-1' AND '1999-12-31' AND birth_date LIKE '%12-25'; -- 362 records

-- Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.

SELECT COUNT(*) FROM employees WHERE last_name LIKE '%q%'; -- 1,873 records

-- Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?

SELECT COUNT(*) FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'; -- 547 records

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT * FROM employees WHERE first_name IN ('Irena','Vidya','Maya') ORDER BY first_name; -- first row is Irena Reutenauer. last row is Vidya Simmen

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name, last_name; -- first row Irena Acton. last row Vidya Zweizig

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena','Vidya','Maya') ORDER BY last_name, first_name; -- first row is Irena Acton, last row is Maya Zyda

-- Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.

SELECT first_name, last_name, emp_no FROM employees WHERE last_name LIKE 'E%' AND last_name LIKE '%e' ORDER BY emp_no; -- 899 records. First row emp# 10021, Ramzi Erde. Last row emp#499648, Takahiro Erde.

-- Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.

SELECT first_name, last_name, hire_date FROM employees WHERE last_name LIKE 'E%e' ORDER BY hire_date DESC; -- 899 records; newest is Teiji Eldridge. oldest is Sergi Erde;

-- Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.

SELECT first_name, last_name, birth_date, hire_date FROM employees WHERE hire_date LIKE '199%' AND birth_date LIKE '%12-25' ORDER BY birth_date ASC, hire_date DESC; -- 362 records. oldest employee hired last is Khun Bernini. Youngest employee hired first is Douadi Pettis.