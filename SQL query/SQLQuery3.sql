use tech_school;

CREATE TABLE Employees_table(
id int identity(1,1) PRIMARY KEY,
name varchar(100) not null,
age int check(age > 0),
salary DECIMAL(10,2),
dept varchar(50)
)

INSERT INTO Employees_table(name, age, salary, dept)
values('aman', 25, 45000.50, 'IT'),
('Ravi', 30, 60000.00,'Finance'),
('Priya',28,52000.70,'HR'),
('Karan',35,75000.20,'IT'),
('Meena',26,48000.20,'Markrting'),
('Vikram',40,90000.20,'Finance'),
('Neha',29,55000.20,'HR'),
('Suresh',32,70000.20,'Sales'),
('Divya',24,42000.20,'IT'),
('Amit',38,88000.20,'Marketing');

SELECT * FROM Employees_table;

SELECT MIN(salary) from Employees_table;

SELECT max(salary) from employees_table;

select * from employees_table where salary = 42000.20

select * from employees_table where salary = 90000.20

select * from employees_table 
where salary = (SELECT MIN(salary) from Employees_table)

select * from employees_table
where salary = (SELECT max(salary) from employees_table)

select sum(salary) from employees_table

select count(id) from employees_table where
salary > 50000;

select dept,count(id) from Employees_table
group by dept;

select dept,count(id),
sum(salary) as total_salary,
avg(salary) as avg_salary
from employees_table
group by dept;

-- we want to show to count and avgm salary by dept 
-- only of those employees whose age is more than
-- 25 and avg salary of the dept must be more than 
--50000
select * from employees_table;
select dept, count(id) as count_by_dept,
avg(salary) as avg_salary
from employees_table
where age > 25
group by dept;

-- we want to show to count and avgm salary by dept 
-- only of those employees whose age is more than
-- 25 and avg salary of the dept must be more than 
--60,000
select * from employees_table;
select dept,
count(id)  as count_by_dept,
avg(salary) as avg_salary
from employees_table
where age > 25
group by dept
having avg(salary) > 60000
order by avg_salary desc;

-- order of execution 
--1) from 
--2)where
--3) group by 
--4) having
--5) select
--6)order by
select * from employees_table;
-- update aman salary to 50k

UPDATE Employees_table 
set salary = 50000
where id = 1;

-- UPDATE HR SALARY TO 60K

UPDATE EMPLOYEES_TABLE
SET  SALARY = 60000
WHERE DEPT = 'HR'

-- INCREASE THE SALARY OF SALES DEPT BY 10%

UPDATE EMPLOYEES_TABLE
SET SALARY = SALARY * 1.10
WHERE DEPT = 'IT'

-- DELETING ROWS

DELETE FROM EMPLOYEES_TABLE
WHERE ID = 1;

-- DELETE ALL THE PEOPLE FROM HR

DELETE FROM EMPLOYEES_TABLE
WHERE DEPT = 'HR'
select * from employees_table;

-- ADD MULTIPLE COLUMNS
ALTER TABLE EMPLOYEES_TABLE
ADD PINCODE INT,
CITY VARCHAR(50) DEFAULT 'HYD'

ALTER TABLE EMPLOYEES_TABLE
ADD STATUS VARCHAR(20) DEFAULT 'ACTIVE'

ALTER TABLE EMPLOYEES_TABLE
ALTER COLUMN AGE VARCHAR(100)

ALTER TABLE EMPLOYEES_TABLE
DROP CONSTRAINT CK_EMPLOYEES_TAGE_6FE99F9F;

INSERT INTO EMPLOYEES_TABLE(NAME,AGE,SALARY,DEPT,CITY)
VALUES('A', '20',60250,'IT','HYD')

-- DELETING A COLUMNS
ALTER TABLE EMPLOYEES_TABLE
DROP COLUMN STATUS;

ALTER TABLE EMPLOYEES_TABLE
DROP CONSTRAINT DF_EMPLOYEESSTATU_71D1E811