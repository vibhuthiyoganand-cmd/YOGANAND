select * from orders1;
use tech_school
--find the  LOWEST AND highest  sales for each product

select * from orders1;

select
orderid,
productid,
sales,
first_value (sales) over (partition by productid order by sales) as lowestsales,
last_value(sales) over(partition by productid order by sales
rows between current row and unbounded following 
) as highestsales
from orders1;

-- find the products that have a price higher than the avg price of all products


select * from products;
select  productid,price from
(
select productid,
price,
avg(price) over() as avgprice
from products
) as t
where price> avgprice;

-- Rank the customers based on their total amount of sales

select *,

rank() over(order by totalsalesbycust DESC) as customerrank
from(

select customerid,
sum(sales) as totalsalesbycust
from orders1
group by customerid
) as t


-- show the product id, product name, price and the total number of orders

select * from orders1;
select * from products;


select
productid,
product,
price,
(select count(*) from orders1) as totalorders
from products;

-- find all the product that have a price higher than the avg price

select * from products

where price>(select avg(price) from products);

select avg(price) from products;

-- show the details from order and customer in germany

select * from orders1;
select * from customers;

select * from customers;
select * 
from orders1 
where customerid in (
select 
customerid 
from customers
where country = 'germany'
)

select * from orders1;
select * from customers;
select * 
from orders1 
where customerid  not in (
select 
customerid 
from customers
where country = 'germany'
)