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
select MAX(length(first_name) + length(' ') + length(last_name)) from employees_with_departments; # 29 sum char becuase I originaly forogt to inlcude the space char

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
use employees;
select dept_name, concat(first_name, ' ', last_name)
from departments
join dept_emp using(dept_no)
join employees using(emp_no)
Where dept_emp.to_date > now();



# 2 Create a temporary table based on the payment table from the sakila database.
use sakila;
select * from payment;

create temporary table hopper_1560.temp_payment_table as select * from payment;

select * from hopper_1560.temp_payment_table;

# Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
select database();
use hopper_1560;
alter table temp_payment_table add column new_amount dec(5,0); # added column for new amount
update temp_payment_table set new_amount = (amount*100);
alter table temp_payment_table modify column new_amount int;
select * from temp_payment_table;

# 3 Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?
use employees;

# current avg pay per department
select dept_name, avg(salary)
from dept_emp de
join salaries s using(emp_no)
join departments d using(dept_no)
where s.to_date > now()
group by dept_name;

# overall average pay per department
select dept_name, avg(salary)
from dept_emp de
join salaries s using(emp_no)
join departments d using(dept_no)
group by dept_name;

# z-score for all salaries
select salary, (salary - (select avg(salary) from salaries)) / (select std(salary) from salaries)
from salaries;

# z-score for current salaries
select salary, (salary - (select avg(salary) from salaries)) / (select std(salary) from salaries)
from salaries where to_date > now();

drop table hopper_1560.zscore_temp_table;
drop table hopper_1560.current_avg_salary;
drop table hopper_1560.hist_avg_salary;

use employees;
use hopper_1560;

# create temp table for historical avg salary
create temporary table hopper_1560.hist_avg_salary as
select dept_name, avg(salary) h_avg_salary, stddev(salary) h_salary_std 
from dept_emp de
join salaries s using(emp_no)
join departments d using(dept_no)
group by dept_name;

# create temp table for current avg current salary per department
create temporary table hopper_1560.current_avg_salary as
select dept_name dept_name, avg(salary) c_avg_salary
from dept_emp de
join salaries s using(emp_no)
join departments d using(dept_no)
where s.to_date > now()
group by dept_name;

use hopper_1560;
select database();

select * from current_avg_salary;
select * from hist_avg_salary;

# add columns for hist avg, hist std, 
alter table current_avg_salary add all_avg_salary float(10,2);
alter table current_avg_salary add all_std_salary float(10,2);
alter table current_avg_salary add z_score float(10,2);

update current_avg_salary set all_avg_salary = (select avg(h_avg_salary) all_hist_avg from hist_avg_salary);
update current_avg_salary set all_std_salary = (select std(h_avg_salary) all_hist_std from hist_avg_salary);
update current_avg_salary set z_score = (c_avg_salary - h_avg_salary) / h_std_salary;

