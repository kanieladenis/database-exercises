# 1 Find all the current employees with the same hire date as employee 101010 using a sub-query.
USE employees;
SELECT first_name, last_name, hire_date
FROM employees
JOIN dept_emp USING emp_no
WHERE to_date > now()
AND hire_date = (SELECT hire_date FROM employees WHERE emp_no = '101010')
;


# 2 Find all the titles ever held by all current employees with the first name Aamod.
SELECT *
FROM
	(SELECT emp_no, first_name, last_name
	FROM employees
	WHERE first_name = 'Aamod')
JOIN dept_emp USING emp_no
JOIN titles USINg emp_no
WHERE to_date > now();


# 3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. 
SELECT *
FROM employees
WHERE emp_no NOT IN
(SELECT emp_no
FROM salaries
WHERE to_date > now()); # 30,0024


# 4 Find all the current department managers that are female. List their names in a comment in your code.
SELECT *
FROM employees
WHERE emp_no IN
	(SELECT emp_no
	FROM dept_manager
	WHERE to_date > now())
AND gender = 'F'; # 4 femail dept manager = Isamu, Karsten, Leon, Hilary

# 5 Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT *
FROM employees
WHERE emp_no IN
	(SELECT emp_no
	FROM salaries
	WHERE salary > 
		(SELECT AVG(salary)
		FROM salaries)
	AND to_date > now()); # 154,543 employees have a current salary that is also above historical average
	
    
# 6 How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
	# Hint Number 1 You will likely use a combination of different kinds of subqueries.
	# Hint Number 2 Consider that the following code will produce the z score for current salaries.


SELECT 
	(SELECT COUNT(salary)
	FROM salaries
	WHERE salary >
		(SELECT MAX(salary) - stddev(salary)
		FROM salaries)
	AND to_date > now()) 
/ (SELECT COUNT(salary) FROM salaries)
FROM salaries;

SELECT COUNT(salary) AS std_salary
FROM salaries
WHERE salary >
	(SELECT MAX(salary) - stddev(salary)
	FROM salaries)
AND to_date > now(); # 78 current salaries are within 1 std dev of the highest salary. 


SELECT emp_no, salary, 
		(salary - (SELECT AVG(salary)
		FROM salaries)) /
		(SELECT stddev(salary)
		FROM salaries) AS zscore
        









    