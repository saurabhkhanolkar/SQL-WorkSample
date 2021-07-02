
-------------------------------------------------------PART 1: JOINS----------------------------------------------------------------------------------------




-- used when 2 tables are to be stacked besides each other. i.e. horizontally join with each other.
Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly','Flax', NULL, 'Male'),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

Insert into EmployeeSalary VALUES
(1010, NULL, 47000),
(NULL, 'Salesman', 43000)

--inner joins , full/left/right outer joins

select * from SQLTutorial.dbo.EmployeeDemographics;
select * from SQLTutorial.dbo.EmployeeSalary;

--inner join
select * from SQLTutorial.dbo.EmployeeDemographics
inner join SQLTutorial.dbo.EmployeeSalary 
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

--full outer join
select * from SQLTutorial.dbo.EmployeeDemographics
full outer join SQLTutorial.dbo.EmployeeSalary 
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

--left outer join
select * from SQLTutorial.dbo.EmployeeDemographics
Left outer join SQLTutorial.dbo.EmployeeSalary 
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

--right outer join
select * from SQLTutorial.dbo.EmployeeDemographics
right outer join SQLTutorial.dbo.EmployeeSalary 
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;


--most of the time you'll not be selecting all the columns in the table. you'll only select a few columns from either or both of the tables

select EmployeeID, FirstName, LastName, JobTitle, salary 
from  
SQLTutorial.dbo.EmployeeDemographics inner join SQLTutorial.dbo.EmployeeSalary 
on 
EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
;
-- The above query wont execute, since it is not specified from which table the employeeid(common attribute) should be selected. 

select EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, salary 
from  
SQLTutorial.dbo.EmployeeDemographics inner join SQLTutorial.dbo.EmployeeSalary 
on 
EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
;
--now the query will execute, since the table name of employeeid is now specified 
-- Works similarly for the rest 3 joins

--Use Case for joins:
-- Michael Scott wants to Deduct the salary of highest paid employee apart from himself.

select EmployeeDemographics.EmployeeID, FirstName, LastName, salary 
from EmployeeDemographics inner join EmployeeSalary on
EmployeeDemographics.EmployeeId = EmployeeSalary.EmployeeID
where FirstName<>'Michael' 
order by salary desc;

--Tough news for dwight schrute!



-------------------------------------------------------PART 2: UNIONS----------------------------------------------------------------------------------------





-- used when 2 tables are to be stacked on top of each other. i.e. vertically joined with each other

create table WareHouseEmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int, 
Gender varchar(50));


Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL , 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female');


select * from
EmployeeDemographics
union
select * from
WareHouseEmployeeDemographics;

--notice that darryl comes twice(once in each table) but mentioned only once. i.e. duplicates will be removed.
-- use union all to overcome this.


select * from
EmployeeDemographics
union all
select * from
WareHouseEmployeeDemographics 
order by employeeid;


-------------------------------------------------------PART 3: CASE STATEMENTS----------------------------------------------------------------------------------------




-- used to make case wise operations on the table ... just like if statements
-- note that : if the conditions are overlapping, whichever conditon comes first will be applied to the overlapping part
select firstname, lastname, jobtitle, salary, --note the comma after salary(last variable) in case of case statement. it's not used everywhere
case 
	when jobtitle ='salesman' then salary + (salary * 0.1)
	when jobtitle ='accountant' then salary + (salary * 0.05)
	when jobtitle ='HR' then salary + (salary * 0.0001)
	else salary + (salary * 0.01)
end as aftersalaryraise
from SQLTutorial.dbo.EmployeeDemographics
inner join SQLTutorial.dbo.EmployeeSalary 
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;



-------------------------------------------------------PART 4: HAVING CLAUSE----------------------------------------------------------------------------------------


--We know that WHERE clause is used to place conditions on columns but what if we want to place conditions on groups?
--This is where HAVING clause comes into use. We can use HAVING clause to place conditions to decide which group will be the part of final result-set. Also we can not use the aggregate functions like SUM(), COUNT() etc. with WHERE clause. So we have to use HAVING clause if we want to use any of these functions in the conditions.

-- WRONG QUERY: select JobTitle, count(JobTitle) as count_jobtitle from EmployeeSalary where count(jobtitle)> 1 group by jobtitle; 
-- RIGHT QUERY:
select JobTitle, count(JobTitle) as count_jobtitle from EmployeeSalary group by jobtitle having count(jobtitle)> 1; 
--having always comes after group by and before order by. where always comeas before group by.
select JobTitle, avg(salary) as average_salary from EmployeeSalary group by jobtitle having count(jobtitle)> 1 order by avg(salary) desc; 
select JobTitle, avg(salary) as average_salary from EmployeeSalary group by jobtitle having avg(salary) > 44000 order by avg(salary); 

-------------------------------------------------------PART 5: UPDATING/DELETING----------------------------------------------------------------------------------------


select * from SQLTutorial.dbo.EmployeeDemographics;

--update statement
Update SQLTutorial.dbo.employeedemographics
set employeeid=1012
where firstname='Holly' and lastname='Flax';

Update SQLTutorial.dbo.employeedemographics
set age=31, gender='female'
where firstname='Holly' and lastname='Flax';

--delete statement
--before doing delete, write a corresponding select statement to look at the data you will be deleting

Delete from SQLTutorial.dbo.employeedemographics
where employeeid = 1005;





-------------------------------------------------------PART 6: ALIASING----------------------------------------------------------------------------------------
-- Aliasing column names 
select firstname as fname
from SQLTutorial.dbo.EmployeeDemographics;

select firstname + '' + lastname as fullname
from sqltutorial.dbo.employeedemographics;

select avg(age) as avgage
from sqltutorial.dbo.employeedemographics; 

--Aliasing table names

select Demo.EmployeeID, Sal.Salary
From SQLTutorial.dbo.EmployeeDemographics as demo
join sqltutorial.dbo.employeesalary as sal
on demo.employeeid = sal.employeeid;




-------------------------------------------------------PART 7: Partition by ----------------------------------------------------------------------------------------

select firstname, lastname, gender, salary, count(gender)
over (partition by gender) as totalgender
from sqltutorial.dbo.employeedemographics as dem
join SQLTutorial.dbo.employeesalary as sal
on dem.employeeid=sal.employeeid;

-- partition by is similar to group by , just that it enables to get all the records. Group by rolls up the rows, partition by doesnot roll up the rows.





