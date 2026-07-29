use tech_school;


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    BirthDate DATE,
    Gender CHAR(1),
    Salary DECIMAL(10,2),
    ManagerID INT NULL
);



select * from employees


INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID)
VALUES
(1, 'Frank', 'Lee', 'Marketing', '1988-12-05', 'M', 55000, NULL),
(2, 'Kevin', 'Brown', 'Marketing', '1972-11-25', 'M', 65000, 1),
(3, 'Mary',  NULL,   'Sales',     '1986-01-05', 'F', 75000, 1),
(4, 'Michael','Ray', 'Sales',     '1977-02-10', 'M', 90000, 2),
(5, 'Carol', 'Baker','Sales',     '1982-02-11', 'F', 55000, 3);



CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Score INT
);



INSERT INTO Customers (CustomerID, FirstName, LastName, Country, Score)
VALUES
(1, 'Jossef', 'Goldberg', 'Germany', 350),
(2, 'Kevin', 'Brown', 'USA', 900),
(3, 'Mary',  NULL, 'USA', 750),
(4, 'Mark', 'Schwarz', 'Germany', 500),
(5, 'Anna', 'Adams', 'USA', NULL);

select * from Customers;


select * from employees;



select firstname,lastname from Customers
union
select firstname,lastname from Employees;


-- union -----
select firstname,lastname from Customers
union all
select firstname,lastname from Employees;

-- Except---
select firstname,lastname from Customers
except
select firstname,lastname from Employees;

-- Intersect, this will get the customers who are employees

select firstname,lastname from Customers
intersect
select firstname,lastname from Employees;

select firstname,lastname from Customers
intersect
select firstname,lastname from Employees
order by firstname asc;


select * from Customers;


select * from employees;


select firstname,lastname from Customers
except
select firstname,lastname from Employees;

select firstname,lastname from Customers
except
select firstname,lastname from Employees;

select * from Customers;


select * from employees;






