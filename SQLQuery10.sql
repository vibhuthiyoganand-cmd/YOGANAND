use master;

create database datawarehouse5;

use datawarehouse5;

create schema bronze;

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);

select * from bronze.crm_cust_info;

BULK INSERT bronze.crm_cust_info
from 'C:\Users\vibhu\AppData\Local\Packages\5319275A.WhatsAppDesktop_cv1g1gvanyjgm\LocalState\sessions\04E73E20C3DD40366CAA1A4E9642947B075C73A4\transfers\2026-30\datasets\datasets\source_crm\cust_info.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)

drop table bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);

select * from bronze.crm_prd_info;

BULK INSERT bronze.crm_prd_info
from 'C:\Users\vibhu\AppData\Local\Packages\5319275A.WhatsAppDesktop_cv1g1gvanyjgm\LocalState\sessions\04E73E20C3DD40366CAA1A4E9642947B075C73A4\transfers\2026-30\datasets\datasets\source_crm\prd_info.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);

select * from  bronze.crm_sales_details;


BULK INSERT bronze.crm_sales_details
from 'C:\Users\vibhu\AppData\Local\Packages\5319275A.WhatsAppDesktop_cv1g1gvanyjgm\LocalState\sessions\04E73E20C3DD40366CAA1A4E9642947B075C73A4\transfers\2026-30\datasets\datasets\source_crm\sales_details.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);

select * from bronze.erp_loc_a101;

BULK INSERT bronze.erp_loc_a101
from 'C:\Users\vibhu\AppData\Local\Packages\5319275A.WhatsAppDesktop_cv1g1gvanyjgm\LocalState\sessions\04E73E20C3DD40366CAA1A4E9642947B075C73A4\transfers\2026-30\datasets\datasets\source_erp\loc_a101.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);


select * from bronze.erp_cust_az12

BULK INSERT bronze.erp_cust_az12
from 'C:\Users\vibhu\AppData\Local\Packages\5319275A.WhatsAppDesktop_cv1g1gvanyjgm\LocalState\sessions\04E73E20C3DD40366CAA1A4E9642947B075C73A4\transfers\2026-30\datasets\datasets\source_erp\cust_az12.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)

select * from bronze.erp_cust_az12

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);

select * from bronze.erp_px_cat_g1v2

BULK INSERT bronze.erp_px_cat_g1v2
from 'C:\Users\vibhu\AppData\Local\Packages\5319275A.WhatsAppDesktop_cv1g1gvanyjgm\LocalState\sessions\04E73E20C3DD40366CAA1A4E9642947B075C73A4\transfers\2026-30\datasets\datasets\source_erp\px_cat_g1v2.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)

select * from bronze.erp_px_cat_g1v2


use datawarehouse5;

select * from bronze.crm_prd_info;

select * from bronze.crm_prd_info;

select * from bronze.erp_cust_az12;


https://github.com/Anudeep423/sql_datawarehouse_proj



-- primary key must be unique and not null

-- Writing a query to check if any duplicates are there in pl(cst_id) or not

select
cst_id,
count(*)
from bronze.crm_cust_info
group by cst_id
having count(*)>1 or cst_id is null;

select * from bronze.crm_cust_info where cst_id = 29466;

-- we want to pick the latest one based on the create data

select
cst_id,
cst_key,
trim(cst_firstname) as cst_firstname,
trim(cst_lastname) as cst_lastname,
case
when trim(upper(cst_marital_status)) = 'S' then 'Singal'
when trim(upper(cst_marital_status)) = 'M' then 'Married'
else 'n/a'
end as cst_marital_status,
case
when trim(upper(cst_gndr)) = 'M' then 'Male'
when trim(upper(cst_gndr)) = 'F' then 'female'
else 'n/a'
end as cst_gndr,
cst_create_date
from(
select
*,
row_number() over(
partition by cst_id
order by cst_create_date desc)as flag_last
from bronze.crm_cust_info
) as t
where flag_last = 1 and cst_id is not null;


-- check for unwanted space in firstname

select cst_firstname from bronze.crm_cust_info
where cst_firstname !=trim(cst_firstname)


-- check for unwanted space in firstname

select cst_lastname from bronze.crm_cust_info
where cst_lastname !=trim(cst_lastname)


-- check for unwanted space in gander

select cst_gndr from bronze.crm_cust_info
where cst_gndr !=trim(cst_gndr)

-- lets check value in gander columns

select distinct cst_gndr
from bronze.crm_cust_info


-- lets check value in marital status columns

select distinct cst_marital_status
from bronze.crm_cust_info

-- silver tables----------------------------------------------------------------------

create schema silver;


drop table silver.crm_cust_info

CREATE TABLE silver.crm_cust_info (
    cst_id             INT,
    cst_key            NVARCHAR(50),
    cst_firstname      NVARCHAR(50),
    cst_lastname       NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr           NVARCHAR(50),
    cst_create_date    DATE,
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);



   
insert into silver.crm_cust_info(
cst_id             ,
    cst_key            ,
    cst_firstname      ,
    cst_lastname       ,
    cst_marital_status ,
    cst_gndr          ,
    cst_create_date   
    )

	  SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) as cst_firstname,
TRIM(cst_lastname) as cst_lastname,
CASE
  when trim(upper(cst_marital_status)) = 'S' then 'single'
  when trim(upper(cst_marital_status)) = 'M' then 'Married'
else 'n/a'
end as cst_marital_status
,
CASE
  when trim(upper(cst_gndr)) = 'M' then 'Male'
  when trim(upper(cst_gndr)) = 'F' then 'Female'
else 'n/a'
end as cst_gndr,
cst_create_date
FROM(
SELECT
*,
Row_number() over(
partition by cst_id
order by cst_create_date DESC) as flag_last
from bronze.crm_cust_info
) AS T
WHERE flag_last = 1 and cst_id is not null;


select * from bronze.crm_prd_info;




-- checking if prd_id has any null or duplicates SELECT prd_id,

select prd_id,
count(*) as prd_id_count
from bronze.crm_prd_info 
group by prd_id
having count(*) > 1 or prd_id is null;


SELECT * FROM bronze.crm_prd_info

select*,
replace (substring(prd_key,1,5),'_','_') as cat_id,
substring(prd_key,7,len(prd_key)) as cat_id
from bronze.crm_prd_info;

SELECT * FROM bronze.crm_prd_info


select * from bronze.erp_px_cat_g1v2;

-- check if prd_nm has any unwanted space

select prd_nm
from bronze.crm_prd_info
where prd_nm!= trim(prd_nm)

-- Replace PRD COST with 0

SELECT*,prd_id,
prd_nm,
REPLACE( SUBSTRING (prd_key, 1,5),'-','_') as cat_id,
SUBSTRING(prd_key, 7, len(prd_key)) as cat_id,
isnull(prd_cost, 0) as prd_cost_values,
CASE
when upper(trim(prd_line))= 'M' then 'Mountain'
when upper(trim(prd_line))= 'S' then ' other Sales'
when upper(trim(prd_line))= 'R' then 'Road'
when upper(trim(prd_line))= 'T' then 'Touring'
else 'n/a'
end_data_line
cast(prd_start_dt as date) as prd_start_dt,
cast(lead(prd_start_dt) over (partition by prd_key order by prd_start_dt) - 1 as date)
as prd_end_data
from bronze.crm_prd_info;



-- lets check if the stae=rt data is less than end data

SELECT * FROM bronze.crm_prd_info
where prd_end_dt < prd_start_dt;

SELECT * FROM bronze.crm_prd_info
where prd_id = 212  or prd_id =213 or prd_id = 214;


select
prd_id,
prd_key,
cast(prd_start_dt as date) as prd_start_dt,
cast(lead(prd_start_dt) over (partition by prd_key order by prd_start_dt) - 1 as date)
as prd_end_data
from bronze.crm_prd_info;


SELECT * FROM bronze.crm_prd_info


select * from bronze.erp_px_cat_g1v2;