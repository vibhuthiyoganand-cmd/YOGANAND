use tech_school;

drop  table family_table;


create table family_table(
fid int primary key identity(1,1),
family varchar(100),
Age int,
city varchar(100),
Dataofyear varchar(100)
);

select * from family_table;


insert into family_table(family, Age, city, Dataofyear) 
values
('mohan' ,43, 'Wanaparthy' ,1982 ),
('Jaya' ,38, 'Busreddypally' ,1986),
('Yoganand' ,20, 'Uppal' , 2006),
('Shashirekha' ,18, 'NGRI' ,2008),
('sreehan surya' ,17, 'JBS Ground' ,2010)

select * from family_table;

alter table family_table
add placeofbirth varchar(100);

update  family_table
set placeofbirth = 'WNP'
where family = 'Mohan'

update  family_table
set placeofbirth = 'KNL'
where family = 'Jaya'

update  family_table
set placeofbirth = 'NGKL'
where family = 'Yoganand'

update  family_table
set placeofbirth = 'KLKU'
where family = 'Shashirekha'

update  family_table
set placeofbirth = 'GDL'
where family = 'sreehan surya'

select * from family_table


use tech_school;

drop table employee;

create table employee(
id int primary key,
employee varchar(100),
phone varchar(15),
salary int,
city varchar(100)
);

select * from employee;


insert into employee(id,employee,phone,salary,city)
values
(101,'Nandu', 9765354893, 89000.20, 'HYD'),
(102, 'Sreehan', 9865734254, 68000.30, 'WNP'),
(103, 'Neha', 9564734562, 76000.20, 'KNL'),
(104, 'Ghoshal', 9564732654, 65000.10, 'NGKL'),
(105, 'Sejaan', 7459624485, 55000.10, 'PANL');


SELECT * FROM employee

BEGIN TRANSACTION

UPDATE employee set salary = 80000 where id = 101
UPDATE employee set salary = 77000 where id = 102

rollback;

commit;









