-- find the total no of customers

use tech_school;

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
    CreationTime DATETIME  -- full date + time
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
(10, 102, 3, 5, '2025-03-15', '2025-03-20', 'Shipped', NULL, NULL, 0, 60, '2025-03-16 23:25:00');


SELECT * from Orders1;


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

select * from products;


select sum (sales) as total_sales from orders1;


select productID,sum(sales) from orders1
group by productID


-- we went from 10 rows to 4 rows we are losing details 
--find the total sales across all the Products, additionally 
-- provide details like orderid and orderdate


SELECT ProductID, sum (sales) FROM Orders1
group by ProductID;



-- SOLVING THIS USING WINDOW FUNCTION


SELECT * FROM ORDERS1;

select *,sum(sales) over() from orders1

SELECT productid,orderid,
sum (sales)over() as totalsales from orders1;


select orderid,productid,sales,
sum(sales) over (partition by productid)
from orders1;


select orderid,productid,sales,
sum(sales) over (partition by productid order by sales desc)
from orders1;

-- find the total sales for all the order, for each product,
-- And for the combination of product are order statues providing
-- Details such as orderid and orderdate

select orderid,productid,orderstatus,sales,
sum(sales) over (partition by productid) as sales_by_productid,
sum(sales) over (partition by productid,orderstatus) as sales_by_product_status,
sum(sales) over() as total_order_sales  from orders1;

-- calc total sales by order stauts for currnt and next 2 orders

select orderid,productid,orderstatus,sales,
sum(sales) over (partition by orderstauts order by orderdate
rows between current row and 2 following ) as total_sales
from orders1;

-- default frame

select orderid,productid,orderstatus,sales,
sum(sales) over (partition by orderstauts order by orderdate) as total_sales
from orders1;



