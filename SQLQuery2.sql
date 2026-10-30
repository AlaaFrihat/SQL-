

create table AccessCards (
CardID INT PRIMARY KEY ,
CardNumber VARCHAR(50)NOT NULL UNIQUE ,
EmployeeID INT UNIQUE ,
FOREIGN KEY(EmployeesID) References Employees(ID)
);
create table Projects(
ProjectID INT primary key , 
ProjectName VARCHAR(100) NOT NULL
);


create table EmployeeProjects(

   AssignedDate date,
   PRIMARY KEY (EmployeeID, ProjectID),
   EmployeeID int FOREIGN KEY  REFERENCES Employees(EmployeeID),
   ProjectID int FOREIGN KEY  REFERENCES Projects(ProjectID)
);

insert into AccessCards values (101,'CARD-101',1),(102,'CARD-102',2),(103,'CARD-103',3);
insert into Projects values (1,'AI & Security Training'),(2,'Cloud Migration');
insert into EmployeeProjects values ('2026-10-29',1,1),('2026-10-29',1,2),( '2026-10-29',2,1),( '2026-10-29',3, 2)

select Employees.FullName , Salary ,DepartmentName from Employees inner join Departments on 
Employees.DepartmentID =Departments.DepartmentID

select Departments .DepartmentName from Employees left join Departments on
Departments . DepartmentID = Employees.EmployeeID

select Employees.FullName,AccessCards.CardNumber from Employees inner join AccessCards on 
Employees.EmployeeID = AccessCards.EmployeeID

select Employees.FullName, Projects.ProjectName, EmployeeProjects.AssignedDate from Employees
inner join EmployeeProjects on Employees.EmployeeID = EmployeeProjects.EmployeeID
inner join Projects on EmployeeProjects.ProjectID = Projects.ProjectID

select DepartmentID, sum(Salary) as TotalSalary,count(*) as EmployeeCount from Employees
group by DepartmentID

select DepartmentID,avg(Salary) as AvgSalary from Employees group by DepartmentID
having avg(Salary) > 1000.00

select EmployeeID, FullName, Salary from Employees where Salary > (select avg(Salary) from Employees)


create view vw_EmployeeDetails as 
select
Employees.EmployeeID, Employees.FullName, Employees.Email,Departments.DepartmentName
from Employees inner join Departments on Employees.DepartmentID = Departments.DepartmentID;

select * from vw_EmployeeDetails 

create procedure sp_GetEmployeesByDepartment
@DeptID int as
begin
select * from Employees where DepartmentID = @DeptID
end;
EXEC sp_GetEmployeesByDepartment @DeptID = 1


create table EmployeeAudit (
AuditID INT primary key IDENTITY ,
EmployeeID INT,
Action VARCHAR(50),
ActionDate DATETIME
);

create TRIGGER trg_Employees_AfterDelete on Employees after delete
as
begin
INSERT into EmployeeAudit (EmployeeID, Action, ActionDate) 
select EmployeeID, 'DELETE', GETDATE() from deleted;
end;

select * from Employees where EmployeeID = 4;

insert into Employees values (4,'ahmed','ahmed@gmail.com',3000,3,07777777)

delete from Employees where EmployeeID =4
select * from EmployeeAudit where EmployeeID=4