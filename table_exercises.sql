SELECT * FROM mysql.user;
SELECT user, host FROM mysql.user;
SELECT * FROM mysql.help_topic;
SELECT help_topic_id, help_category_id, url FROM mysql.help_topic;
-- List all Table in the Database
SHOW TABLES;
DESCRIBE titles;
-- Find different types of data
SHOW CREATE TABLE employees;
DESCRIBE TABLE employees;
-- See relationship between employees and deapartment tables; no relationshiop found
SHOW CREATE TABLE departments;
-- Show SQL that created dept-manager table
SHOW CREATE TABLE dept_manager;