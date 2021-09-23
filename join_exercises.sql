#1 the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT *
FROM users
JOIN roles ON roles.id = users.role_id; # 4 records

#2 Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users
LEFT JOIN roles ON roles.id = users.role_id; #  6records

SELECT *
FROM users
RIGHT JOIN roles ON roles.id = users.role_id; # 5 records

#3 Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query
SELECT roles.name, COUNT(roles.name)
FROM users
RIGHT JOIN roles ON roles.id = users.role_id
GROUP BY roles.name;

# -----------------------------------------------

#1 Use the employees database.
USE employees;

#2 Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM employees
JOIN dept_manager 
ON dept_manager.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date > CURDATE()
ORDER BY dept_name;

#3 Find the name of all departments currently managed by women.
SELECT dept_name AS Department, CONCAT(first_name, ' ', last_name) AS 'Manager Name'
FROM employees
JOIN dept_manager 
ON dept_manager.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date > CURDATE()
AND employees.gender = 'F';

#4 Find the current titles of employees currently working in the Customer Service department.
SELECT departments.dept_name AS department, titles.title AS dept_title, COUNT(titles.title) AS count_emp
FROM employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
JOIN titles
ON titles.emp_no = employees.emp_no
WHERE dept_name = 'Customer Service'
AND dept_emp.to_date > CURDATE()
AND titles.to_date > CURDATE()
GROUP BY titles.title;

#5 Find the current salary of all current managers.
SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS Name, salary AS Salary
FROM employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
JOIN dept_manager
ON dept_manager.emp_no = employees.emp_no
JOIN salaries
ON salaries.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE dept_manager.to_date > CURDATE()
AND salaries.to_date > CURDATE();

#6 Find the number of current employees in each department
SELECT dept_name, dept_emp.dept_no, dept_name, COUNT(*) AS Num_employees
FROM employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_no ASC; 

#7 Which department has the highest average salary? Hint: Use current not historic information.
SELECT departments.dept_name AS dept_name, AVG(salary) AS average_salary
FROM salaries
JOIN dept_emp
ON dept_emp.emp_no = salaries.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE salaries.to_date > CURDATE()
AND dept_emp.to_date > CURDATE()
GROUP BY departments.dept_name
ORDER BY average_salary DESC LIMIT 1;

#8 Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name, salary
FROM employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
JOIN salaries
ON salaries.emp_no = employees.emp_no
WHERE dept_name = "Marketing"
ORDER BY salaries.salary DESC LIMIT 1;

#9 Which current department manager has the highest salary?
SELECT e.first_name, e.last_name, salary, dept_name
FROM employees AS e
JOIN dept_manager
ON dept_manager.emp_no = e.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
JOIN salaries
ON salaries.emp_no = e.emp_no
WHERE dept_manager.to_date > CURDATE()
ORDER BY salary DESC LIMIT 1;

#10 Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', dept_name AS 'Department Name', CONCAT(managers.first_name, ' ', managers.last_name) AS 'Manager Name'
FROM employees AS managers
JOIN dept_manager
ON dept_manager.emp_no = managers.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
JOIN dept_emp
ON dept_emp.dept_no = dept_manager.dept_no
JOIN employees AS e 
ON e.emp_no = dept_emp.emp_no
WHERE dept_manager.to_date > NOW()
AND dept_emp.to_date > NOW();


#11 Bonus Who is the highest paid employee within each department (UNFINISHED)
SELECT *
FROM employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
JOIN dept_manager
ON dept_manager.emp_no = employees.emp_no
JOIN salaries
ON salaries.emp_no = employees.emp_no;
#GROUP BY dept_name;
#ORDER BY salary DESC;

#13 Determine the average salary for each department. Use all salary information and round your results.
SELECT dept_name, ROUND(AVG(salary)) average_salary
FROM salaries s
JOIN dept_emp de USING (emp_no)
JOIN departments d USING (dept_no)
GROUP BY dept_name
ORDER BY average_salary DESC;



