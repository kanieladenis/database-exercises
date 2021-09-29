# Employees Database
use employees;

# How much do the current managers of each department get paid, 
select salary as dept_manager_salary
from dept_manager dm
join salaries s using(emp_no)
join departments d using (dept_no)
where s.to_date > now()
and dm.to_date > now();


# ...relative to the average salary for the department? 

select dept_name, avg(salary) as dept_salary
from departments d
join dept_emp de using(dept_no)
join salaries s using(emp_no)
where de.to_date > now()
and s.to_date > now()
group by dept_name;


# Is there any department where the department manager gets paid less than the average salary?

select dept_name, avg(salary) as dept_salary 
from departments d
join dept_emp de using(dept_no)
join salaries s using(emp_no)
and de.to_date > now()
and s.to_date > now()
group by dept_name;


#World Database
use world;

# 1 What languages are spoken in Santa Monica?

select *
from countrylanguage
where countrycode = 'usa'
order by percentage;
