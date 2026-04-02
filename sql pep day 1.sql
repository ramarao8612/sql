-- 1. Create and Use Database
CREATE DATABASE IF NOT EXISTS empdetails;
USE empdetails;

-- 2.creating a table(Employees)                            #ddl
CREATE TABLE Employees (
    emp_id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50),
    joining_date DATE
);


-- 4. Inserting Data
INSERT INTO Employees VALUES
(1, 'Ravi', 'IT', 60000, 'Hyderabad', '2022-01-10'),
(2, 'Anu', 'HR', 45000, 'Mumbai', '2021-03-15'),
(3, 'John', 'IT', 70000, 'Delhi', '2020-07-20'),
(4, 'Sara', 'Finance', 50000, 'Mumbai', '2023-02-01'),
(5, 'Mike', 'IT', 65000, 'Hyderabad', '2022-11-11');

-- 5. Updating Data
UPDATE Employees SET salary = 75000 WHERE emp_id = 3;                            #dml

-- 6. Deleting Data
DELETE FROM Employees WHERE emp_id = 6;                                          #dml

-- 7. Select Queries
SELECT * FROM Employees;
SELECT name, salary FROM Employees;

-- 8. WHERE Clause Examples
SELECT * FROM Employees
WHERE department='it';  -- IT

SELECT * FROM Employees
WHERE salary > 60000;

SELECT * FROM Employees
WHERE deptartment = 'it' AND salary > 60000;

SELECT * FROM Employees
WHERE city IN ('Mumbai', 'Delhi');

SELECT * FROM Employees
WHERE city not in ('chennai')

-- 9. ORDER BY Clause
SELECT * FROM Employees
ORDER BY salary ASC;

SELECT * FROM Employees
ORDER BY salary DESC;

-- 10. Aggregate Functions
SELECT COUNT(*) AS total_employees FROM Employees;
SELECT MAX(salary) AS max_salary FROM Employees;
SELECT MIN(salary) AS min_salary FROM Employees;
SELECT SUM(salary) AS total_salary FROM Employees;
SELECT AVG(salary) AS avg_salary FROM Employees;

-- 11. GROUP BY and HAVING
SELECT department, COUNT(*) AS total_employees
FROM Employees
GROUP BY department;

SELECT department, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department;

SELECT deparment, COUNT(*) AS total
FROM Employees
GROUP BY department
HAVING COUNT(*) > 1;

-- 12. LIKE Pattern Matching
SELECT * FROM Employees WHERE name LIKE 'R%';   -- starts with R
SELECT * FROM Employees WHERE name LIKE '%a';   -- ends with a
SELECT * FROM Employees WHERE name LIKE '_a%';  -- second letter is a

-- 13. BETWEEN, IN, NOT IN, NULL
SELECT * FROM Employees WHERE salary BETWEEN 50000 AND 70000;
SELECT * FROM Employees WHERE city IN ('Mumbai', 'Delhi');
SELECT * FROM Employees WHERE city NOT IN ('Chennai');
SELECT * FROM Employees WHERE city IS NULL;
SELECT * FROM Employees WHERE city IS NOT NULL;

-- 14. Aliases
SELECT name AS Employee_Name, salary AS Income
FROM Employees; 

truncate table employees;  #truncate table it removes all data with out eliminating its structure ddl

select * from employees; 

drop table employees;       #drops the entire table ddl
