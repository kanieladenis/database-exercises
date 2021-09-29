# test git functionality

# 1 Write a query that returns all employees (emp_no), their department number, their start date, their end date, 
use employees;
select * from dept_emp;

# and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
select case
		when to_date > now() then 1
        else 0
        end as is_current_employee
from dept_emp;


# 2 Write a query that returns all employee names (previous and current), 
select * 
from dept_emp
join employees using(emp_no);

# and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
select case
	when last_name like 'a%' then 'A-H'
    when last_name like 'i%' then 'I-Q'
    when last_name like 'r%' then 'R-Z'
    else last_name
    end as alpha_group
from dept_emp
join employees using(emp_no);



# 3 How many employees (current or previous) were born in each decade?
select case
	when birth_date like '195%' then '1950'
    when birth_date like '196%' then '1960'
    else birth_date
    end as birth_decade
from employees;



# Bonus - What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?