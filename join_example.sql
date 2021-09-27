#1 Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;
SELECT *
FROM users
JOIN roles ON users.role_id = roles.id; # 4 rows


#2 Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users
LEFT JOIN roles ON roles.id = users.role_id; # Left has 6 rows,Right has 5 rows


#3 Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name AS role_name, COUNT(roles.name) AS count_role_name
FROM users
RIGHT JOIN roles ON roles.id = users.role_id
GROUP BY role_name;


