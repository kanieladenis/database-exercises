

# 1 Write a query that returns all employees (emp_no), their department number, their start date, their end date, 
use employees;
select * from dept_emp;

# and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
select emp_no, dept_no, from_date,to_date,
	case
		when to_date > now() then 1
        else 0
        end as is_current_employee
        
from dept_emp;


# 2 Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
select last_name, first_name,
	case
	when last_name like 'a%' then 'A-H'
    when last_name like 'b%' then 'A-H'
    when last_name like 'c%' then 'A-H'
    when last_name like 'd%' then 'A-H'
    when last_name like 'e%' then 'A-H'
    when last_name like 'f%' then 'A-H'
    when last_name like 'g%' then 'A-H'
    when last_name like 'h%' then 'A-H'
    when last_name like 'i%' then 'I-Q'
    when last_name like 'j%' then 'I-Q'
    when last_name like 'k%' then 'I-Q'
    when last_name like 'l%' then 'I-Q'
    when last_name like 'm%' then 'I-Q'
    when last_name like 'n%' then 'I-Q'
    when last_name like 'o%' then 'I-Q'
    when last_name like 'p%' then 'I-Q'
    when last_name like 'q%' then 'I-Q'
	when last_name like 'r%' then 'R-Z'
    when last_name like 's%' then 'R-Z'
    when last_name like 't%' then 'R-Z'
    when last_name like 'u%' then 'R-Z'
    when last_name like 'v%' then 'R-Z'
    when last_name like 'w%' then 'R-Z'
    when last_name like 'x%' then 'R-Z'
    when last_name like 'y%' then 'R-Z'
    when last_name like 'z%' then 'R-Z'
    else last_name
    end as alpha_group
from employees;

select last_name, first_name,
	case
		when last_name < 'H' then 'A-H'
        when last_name < 'Q' then 'I-Q'
        when last_name < 'Z' then 'R-Z'
        else last_name
        end as alpha_group
from employees;



# 3 How many employees (current or previous) were born in each decade?

select
	count(if(birth_date like '195%', true, null)) as '1950',
	count(if(birth_date like '196%', true, null)) as '1960'
from employees; #182,886 in 1950, 300,024 in 1960.

select count(*),
	case
		when birth_date like '195%' then '1950'
        when birth_date like '196%' then '1960'
        else null
        end as decade_born
from employees
group by decade_born;


# Bonus - What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

select dept_group, avg(salary),
	case 
		when dept_name = 'research' or dept_name = 'development' then 'R&D'
        when dept_name = 'sales' or dept_name = 'marketing' then 'Sales & Marketing'
        when dept_name = 'production' or dept_name = 'Quality Management' then 'Prod & QM'
        when dept_name = 'finance' or dept_name = 'human resources' then 'Finance & HR'
		else dept_name 
    end as 'dept_group'
from departments
join dept_emp on dept_emp.dept_no = departments.dept_no
	and dept_emp.to_date > now()
join salaries on salaries.emp_no = dept_emp.emp_no
	and salaries.to_date > now()
group by dept_group;


