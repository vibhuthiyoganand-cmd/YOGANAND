use tech_school;

CREATE TABLE city_table(
cid int primary key identity (1,1),
city varchar (100)
)

SELECT * FROM city_table;

insert into city_table(City)
values('Agra'),
('Bhopal'),
('Delhi'),
('Noida')


CREATE TABLE student_table(
id int primary key identity (1,1),
name varchar(100),
Age int,
city int
Foreign key (city) references city_table(cid)
)

select * from student_table;

insert into student_table(name,age,city)
values
('Nandu',20,1),
('Surya',19,2),
('Shubham',20,1),
('sreehan',18,3)


SELECT * FROM student_table;

SELECT * FROM student_table inner join 
city_table on
student_table.city = city_table.cid;

-- alter table------

alter table student_table NOCHECK CONSTRAINT ALL;

alter table student_table CHECK CONSTRAINT ALL;


select * from student_table;

insert into student_table(name,age,city)
values('abc',20,5)

select * from student_table;

SELECT * FROM student_table 
left join
city_table on
student_table.city = city_table.cid;


SELECT * FROM student_table 
inner join 
city_table on
student_table.city = city_table.cid;

SELECT * FROM student_table 
right join 
city_table on
student_table.city = city_table.cid;


SELECT * FROM student_table
full join 
city_table on
student_table.city = city_table.cid;


SELECT * FROM student_table left join city_table on student_table.city = city_table.cid
UNION
SELECT * FROM student_table right join city_table on student_table.city = city_table.cid;


CREATE TABLE Customers(
id INT PRIMARY KEY,
first_name VARCHAR(100),
Country varchar(100),
Score int
);

INSERT INTO Customers(id, first_name, country, score)
values(1, 'Maria', 'Germany', 350),
(2, 'John', 'USA', 900),
(3, 'George', 'UK', 750),
(4,'Martin' ,'Germany', 600),
(5,'Peter', 'USA',0)


SELECT * from customers;

CREATE TABLE ORDERS(
order_id INT PRIMARY KEY,
Customer_id INT,
Order_date DATE,
SALES int,
FOREIGN KEY (customer_id) references customers(id)
)

alter table ORDERS NOCHECK CONSTRAINT ALL;
INSERT INTO ORDERS(order_id, customer_id,order_date,sales)
values(1001,1,'2021-01-11',35),
(1002,2,'2021-04-03',13),
(1003,3,'2021-06-18',20),
(1004,4,'2021-08-31',10);
SELECT * FROM ORDERS;
-- WE WANT TO GET ALL THE CUSTOMERS WHO DIDN'T ORDER ANYTHING

SELECT * FROM Customers as c
left join Orders as o
on c.id = o.customer_id
where o.customer_id IS NULL;
-- get all orders without matching customers

SELECT * FROM CUSTOMERS AS C
RIGHT JOIN ORDERS AS O
ON C.ID = O.CUSTOMER_ID
WHERE C.ID is null;
-- find customers without orders and orders without customers
SELECT * FROM CUSTOMERS AS C
FULL OUTER JOIN 
ORDERS AS O
ON C.ID = O.CUSTOMER_ID
WHERE O.CUSTOMER_ID IS NULL OR C.ID IS NULL;