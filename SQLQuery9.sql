use tech_school;

-- find the total sales per customer(CTE)

select * from orders1;
with cte_total_sales as
(
select
customerid,
sum(sales) as totalsales
from orders1
group by customerid
),cte_last_order as
(
select 
customerid,
max(orderdate) as last_order
from orders1
group by customerid
)



-- find the last order for each customer(cte)
select * from orders1;

select 
customerid,
max(orderdate) as last_order
from orders1
group by customerid

use tech_school;

select * from products;

BEGIN TRANSACTION

update products set price = 10 where productID = 101;
Update products set price = 15 where productID = 102 ;

ROLLBACK;

COMMIT;