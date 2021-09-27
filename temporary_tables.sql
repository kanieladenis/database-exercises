# 1 Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

use employees;



CREATE TEMPORARY TABLE hopper_1560.employees_with_departments AS
SELECT first_name, last_name, dept_name
FROM employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
WHERE dept_emp.to_date > now();

use hopper_1560;
select * from employees_with_departments;


# 1a Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

# sum of first_name and last_name columns
select MAX(length(first_name) + length(' ') + length(last_name)) from employees_with_departments; # 29 sum char

# Add comlumn with 29 varchar
ALTER TABLE employees_with_departments ADD full_name VARCHAR(29);

# forgot to include space between names, updating column varchar
alter TABLE employees_with_departments modify column full_name VARCHAR (30);

select * from employees_with_departments; # check table change

# 1b Update the table so that full name column contains the correct data

update employees_with_departments set full_name = concat( first_name, ' ', last_name);

# 1c Remove the first_name and last_name columns from the table.

alter table employees_with_departments drop column first_name;
alter table employees_with_departments drop column last_name;

# 1d What is another way you could have ended up with this same table?



# 2 Create a temporary table based on the payment table from the sakila database.

# Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

# 3 Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?