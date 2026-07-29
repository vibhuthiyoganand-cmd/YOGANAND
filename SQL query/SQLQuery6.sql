use set_database;

CREATE TABLE OrdersArchive1(
    OrderID INT,
    ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(50),
    ShipAddress VARCHAR(200),
    BillAddress VARCHAR(200),
    Quantity INT,
    Sales INT,
    CreationTime DATETIME
);


INSERT INTO OrdersArchive1
(OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, 
 ShipAddress, BillAddress, Quantity, Sales, CreationTime)
VALUES
(1, 2001, 301, 401, '2024-05-01', '2024-05-05', 'Shipped', 'Berlin, Germany', 'Berlin, Germany', 10, 5000, '2024-04-01 12:34:56'),
(2, 2002, 302, 402, '2024-05-03', '2024-05-07', 'Delivered', 'New York, USA', 'New York, USA', 5, 2500, '2024-04-05 23:22:04'),
(3, 2003, 303, 403, '2024-05-04', '2024-05-09', 'Processing', 'London, UK', 'London, UK', 8, 4000, '2024-04-10 18:24:08'),
(4, 2004, 304, 404, '2024-05-06', '2024-05-10', 'Shipped', 'Paris, France', 'Paris, France', 12, 6000, '2024-04-20 05:50:33'),
(4, 2005, 305, 405, '2024-05-08', '2024-05-12', 'Delivered', 'Tokyo, Japan', 'Tokyo, Japan', 15, 7500, '2024-04-20 14:50:33'),
(5, 2006, 306, 406, '2024-05-09', '2024-05-14', 'Processing', 'Sydney, Australia', 'Sydney, Australia', 20, 10000, '2024-05-01 14:02:41'),
(6, 2007, 307, 407, '2024-05-11', '2024-05-16', 'Shipped', 'Toronto, Canada', 'Toronto, Canada', 7, 3500, '2024-05-06 15:34:57'),
(6, 2008, 308, 408, '2024-05-12', '2024-05-18', 'Delivered', 'Dubai, UAE', 'Dubai, UAE', 18, 9000, '2024-05-07 13:22:05'),
(6, 2009, 309, 409, '2024-05-14', '2024-05-20', 'Processing', 'Rome, Italy', 'Rome, Italy', 9, 4500, '2024-05-12 20:36:55'),
(7, 2010, 310, 410, '2024-05-15', '2024-05-21', 'Shipped', 'Madrid, Spain', 'Madrid, Spain', 14, 7000, '2024-06-16 23:25:15');


select * from OrdersArchive1;


-- identify duplicate rows in 'order archive' and return a clean
--resuit without any duplicates

select *
FROM (
SELECT
ROW_NUMBER() over (partition by orderid order by creationtime desc) as rn,
*
from OrdersArchive1)AS A
where rn = 1;

-- return a result with only duplicates

select *
FROM (
SELECT
ROW_NUMBER() over (partition by orderid order by creationtime desc) as rn,
*
from OrdersArchive1)AS A
where rn > 1;


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Product VARCHAR(50),
    Category VARCHAR(50),
    Price INT
);

INSERT INTO Products (ProductID, Product, Category, Price) VALUES
(101, 'Bottle', 'Accessories', 10),
(102, 'Tire', 'Accessories', 15),
(103, 'Socks', 'Clothing', 20),
(104, 'Caps', 'Clothing', 25),
(105, 'Gloves', 'Clothing', 30);

-- find the product that full within the highest 40% of the prices

select * from products;

select * 
from(
select product,
price, 
cume_dist() over (order by price desc) as distRank
from products) as t
where distRank<=0.4

select * from products;


 CREATE TABLE Orders1(
    OrderID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus NVARCHAR(50),
    ShipAddress NVARCHAR(200),
    BillAddress NVARCHAR(200),
    Quantity INT,
    Sales DECIMAL(10,2),
    CreationTime DATETIME  
    
   -- full date + time
);


INSERT INTO Orders1(OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime)
VALUES(1, 101, 2, 3, '2025-01-01', '2025-01-05', 'Delivered', '9833 Mt. Dias Blvd.', '1226 Shoe St.', 1, 10, '2025-01-01 12:34:00'),
(2, 102, 3, 3, '2025-01-05', '2025-01-10', 'Shipped', '250 Race Court', NULL, 1, 15, '2025-01-05 23:22:00'),
(3, 101, 1, 5, '2025-01-10', '2025-01-25', 'Delivered', '8157 W. Book', '8157 W. Book', 2, 20, '2025-01-10 18:24:00'),
(4, 105, 1, 3, '2025-01-20', '2025-01-25', 'Shipped', '5724 Victory Lane', NULL, 2, 60, '2025-01-20 05:50:00'),
(5, 104, 2, 5, '2025-02-01', '2025-02-05', 'Delivered', NULL, NULL, 1, 25, '2025-02-01 14:02:00'),
(6, 104, 3, 5, '2025-02-05', '2025-02-10', 'Delivered', '1792 Belmont Rd.', NULL, 2, 50, '2025-02-06 15:34:00'),
(7, 102, 1, 1, '2025-02-15', '2025-02-27', 'Delivered', '136 Balboa Court', NULL, 2, 30, '2025-02-16 06:22:00'),
(8, 101, 4, 3, '2025-02-18', '2025-02-27', 'Shipped', '2947 Vine Lane', '4311 Clay Rd', 3, 90, '2025-02-18 10:45:00'),
(9, 102, 2, 5, '2025-03-10', '2025-03-15', 'Shipped', '3768 Door Way', NULL, 2, 20, '2025-03-10 12:59:00'),
(10, 102, 3, 5, '2025-03-15', '2025-03-20', 'Shipped', NULL, NULL, 0, 60, '2025-03-16 23:25:00')   
select * from orders1;