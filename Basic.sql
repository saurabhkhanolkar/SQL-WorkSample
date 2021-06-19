
--Note: CAPS or not: doesnt matter in sql


-------------------------------------PART 1: CREATING TABLES-----------------------------------

use SQLTutorial;  

create table EmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int, 
Gender varchar(50));

create table EmployeeSalary
(
EmployeeID int,
JobTitle varchar(50),
Salary int
);

select * from EmployeeDemographics;

Insert into EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

select * from EmployeeDemographics;

select * from EmployeeSalary;

Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

select * from EmployeeSalary;





-------------------------------------PART 2: SELECT + FROM STATEMENTS-----------------------------------


--selecting all
select * from EmployeeSalary;
--selecting 1 col
select JobTitle from EmployeeSalary;
--selecting multiple columns
select jobtitle,EmployeeID from employeesalary;
--selecting top 5 rows
select top 6 * from employeesalary;
--select distinct from a particular col
select distinct(gender) from Employeedemographics;
--count statement
select count(LastName) from employeedemographics;
select count(LastName) as lastnamecount from employeedemographics;   --when there is a derived column, you can use as to rename the column.
--max, min and average
select max(salary) from EmployeeSalary;
select max(salary) as maxsalary from EmployeeSalary;
--for minimum: use min and average: use avg
-- from part of the select clause: used to specify the database and the table name from which the information is to be queried
--eg:
select count(LastName) as lastnamecount from sqltutorial.dbo.employeedemographics;





-------------------------------------PART 3: WHERE STATEMENTS-----------------------------------


-- Where statement limits the amount of data and puts a specific condition on the data you want returned.
select * from employeedemographics where firstname='jim';
select * from employeedemographics where firstname<>'jim'; -- does not equal
select * from employeedemographics where age>30;
select * from employeedemographics where age>=30 and gender='male'; -- AND: both criterias need to be correct
select * from employeedemographics where age>=30 or gender='male'; --Or: anyone criteria needs to be correct

--Like : 
select * from employeedemographics where firstname like 'j%'; -- returns all rows where first name starts with j
select * from employeedemographics where firstname like '%m'; -- returns all rows where first name ends with m
select * from employeedemographics where firstname like '%s%'; -- returns all rows where first name contains an s
select * from employeedemographics where Lastname like 'H%s%n'; -- returns all rows where last name contains an starts with h , contains an s and ends with n.

-- Null, not null
select * from employeedemographics where Lastname is null;
select * from employeedemographics where Lastname is not null;

-- IN: concise way to say equal for multiple things
--eg:
select * from employeedemographics where Firstname='jim' or firstname='michael';
-- this can be replaced by 1 IN
select * from employeedemographics where Firstname in ('jim' , 'michael');







-------------------------------------PART 4 : GROUP BY AND ORDER BY STATEMENTS-----------------------------------


--distinct: gives only the unique categories
select distinct(gender) from employeedemographics;

--group by: gives all the values in the category rolled into one  
select gender from employeedemographics group by gender; -- although the output is similar to distinct, it is basically all the rows rolled up into 2 categories

select gender,count(gender) from employeedemographics group by gender; 

-- doing group by with 2 columns: columns that have same combination will be grouped together 

select gender,age,count(gender) from employeedemographics group by gender,age;

select gender,age,count(gender) as countofgender from employeedemographics group by gender,age;

-- In this group by statement, you can still do things such as:
select gender,count(gender) from employeedemographics where age>31 group by gender;

--orderby
select gender,count(gender) as countgender from employeedemographics where age>31 group by gender order by gender asc; -- order by is by default: ascending
select gender,count(gender) as countgender from employeedemographics where age>31 group by gender order by countgender asc; --default: ascending
select gender,count(gender) as countgender from employeedemographics where age>31 group by gender order by gender desc; --default: ascending
select gender,count(gender) as countgender from employeedemographics where age>31 group by gender order by countgender desc; --default: ascending


select * from employeedemographics order by age;
select * from employeedemographics order by age asc;
select * from employeedemographics order by age desc;

-- order by wrt 2 columns
select * from employeedemographics order by age,gender;
select * from employeedemographics order by gender,age;

-- asc and desc can be given to different variables differently
select * from employeedemographics order by age asc,gender desc;
select * from employeedemographics order by age desc,gender asc;

-- ordering by column number
select * from employeedemographics order by 4 desc,5 asc;



