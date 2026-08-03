use datawarehouse5;

select * from bronze.erp_cust_az12;
select * from bronze.crm_cust_info;

-- so lets remove that part NAS

select*,
case
when cid like 'NSA%' then substring (cid,4,len(cid))
else cid
end as cid,
case
 when bdate > getdate () or bdate < '1926-01-01' then null
else bdate
end as bdate,
case 
    when upper(trim(gen)) in ('F', 'FAMALE') then 'Female'
    when upper(trim(gen)) in ('M', 'MALE') then 'Male'
    else 'n/a'
end as gen
from bronze.erp_cust_az12;

 -- lests get the diff types of values in gender
 
 select distinct gen
 from bronze.erp_cust_az12


 -- getting invaild bdates

 select distinct
 bdate
 from bronze.erp_cust_az12
 where bdate <'1926-01-01' or bdate > getdate()



