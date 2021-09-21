SELECT COUNT(*) FROM employees;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.

SELECT COUNT(*) FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya'); -- 709 records return

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?


SELECT COUNT(*) FROM employees WHERE first_name='Irena' OR first_name='Vdidya' OR first_name='Maya'; -- 477 records, doesn't match

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

-- Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.

SELECT * FROM employees WHERE birth_date LIKE '%12-25'; -- 842 records

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.

SELECT COUNT(*) FROM employees WHERE hire_date BETWEEN '1990-1-1' AND '1999-12-31' AND birth_date LIKE '%12-25'; -- 362 records

-- Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.

SELECT COUNT(*) FROM employees WHERE last_name LIKE '%q%'; -- 1,873 records

-- Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?

SELECT COUNT(*) FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'; -- 547 records