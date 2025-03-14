-- loome db
create database TARpe24SQL


-- db valimine
use TARpe24SQL

-- db kustutamine
drop database TARpe24SQL


-- tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

-- andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (3, 'Unknown')

-- vaatame tabeli sisu
select * from Gender

-- teeme tabeli Person
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

-- andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'Antman', 'ant@ant.com', 2),
(7, 'Spiderman', 'spider@s.com', 2),
(9, NULL, NULL, 2)

-- soovime vaadata Person tabeli andmeid
select * from Person

-- võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla väärtust
-- siis see automaatselt sisestab sellele reale väärtuse 3 e nagu meil on unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

--
insert into Person (Id, Name, Email, GenderId)
values (10, 'Deadpool', 'd@d.com', NULL)
insert into Person (Id, Name, Email)
values (11, 'Kalveipoeg', 'k@k.com')

-- piirangu kustutamine
alter table person
drop constraint DF_Persons_GenderId

-- lisame uue veeru
alter table Person
add Age nvarchar(10)

-- lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

-- kustutame rea
delete from Person where Id = 11

-- kuidas uuendada andmeid
update Person
set Age = 50
where Id = 4

alter table Person
add City nvarchar(50)

-- kõik kes elavad Gothami linnas
select * from Person where City = 'Gotham'

-- kõik kes ei ela gothamis
select * from Person where City != 'Gotham'

-- variant 2
select * from Person where city <> 'Gotham'

-- näitab teatud vanusega inimesi
select * from Person where Age = 100 or Age = 35 or Age = 27
select * from Person where Age in (100, 35, 27)

-- näitab teatud vanusevahemikus olevaid inimesi
select * from Person where Age < 90 and Age > 20
-- variant 2
select * from Person where Age between 22 and 50

-- wildcard ehk näitab kõik n-tähega linnad
select * from Person where City like 'n%'

-- kõik emailid kus on @-märk emailis
select * from Person where Email like '%@%'

-- näitab kõiki, kellel ei ole @-märki emailis
select * from Person where Email not like '%@%'

-- tund 2 07.03.2025

-- näitab, kellel on emailis ees ja peale @-märki ainult üks täht
select * from Person where Email like '_@_.com'

-- kõik kellel on nimes täht W, A, S
select * from Person where Name like '[^WAS]%'
select * from Person

-- kes elavad Gothamis ja New Yorkis

select * from Person where City = 'Gotham' or City = 'New York'

-- kõik, kes elavad gothamis ja new yorkis ja on vanemad kui 29
select * from Person where (City = 'Gotham' or City = 'New York') and Age >= 30

-- kuvab tähestikulises järjekorras inimesi ja võtab aluseks nime
select * from Person order by Name

-- sama aga vastupidi
select * from Person order by Name desc

-- võtab kolm esimest rida
select top 3 * from Person

-- kolm esimest aga tabeli järjestus on age ja siis name
select top 3 Age, Name from Person

-- näitab esimesed 50% tabelis
select top 50 percent * from Person

-- järjestab vanuse järgi isikud
select * from Person order by Age desc

-- muudab Age muutuja intiks ja näitab vanuselises järjestuses
select * from Person order by cast(Age as int) desc

-- kõikide isikute koondvanus
select sum(cast(Age as int)) from Person

-- kuvab kõige noorem
select min(cast(Age as int)) from Person

-- kõige vanem
select max(cast(Age as int)) from Person

-- konkreetsetes linnades olevate isikute koondvanus
-- enne oli Age nvarchar, aga muudame selle int andmetüübiks
-- var 1 (minu meetod)
select sum(Age) from Person where city = 'Gotham'
-- var 2
select City, sum(Age) as totalage from Person group by City
 
-- kuidas saab koodiga muuta andmetüüpi ja selle pikkust
alter table Person
alter column Name nvarchar(25)

-- kuvab esimeses reas välja toodud järjestuses ja kuvab Age totalAge-iks
-- järjestab City-s olevate nimede järgi ja siis GenderId järgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

-- näitab ridade arvu tabelis
select count(*) from Person
select * from Person

-- näitab tulemust, et mitu inimest on genderId väärtusega 2 konkreetses linnas
-- arvutab vanuse kokku
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

-- loome tabelid Employees ja Department

create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)
create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

-- andmete sisestamine

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (2, 'Pam', 'Female', 3000, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (3, 'John', 'Male', 3500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (4, 'Sam', 'Male', 4500, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (5, 'Todd', 'Male', 2800, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (6, 'Ben', 'Male', 7000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (7, 'Sara', 'Female', 4800, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (8, 'Valarie', 'Female', 5500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (9, 'James', 'Male', 6500, NULL)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (10, 'Russell', 'Male', 8800, NULL)

select * from Employees

insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (2, 'Payroll', 'Delhi', 'Ron')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (3, 'HR', 'New York', 'Christie')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (4, 'Other Department', 'Sydney', 'Cindrella')

select * from Department

-- Teeme left join päringu
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- Arvutab kõikide palgad kokku
select sum(cast(Salary as int)) from Employees

-- Tahame teada minimum palga saajat
select top 1 * from Employees order by cast(Salary as int)

select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location -- Ühe kuu palgafond linnade lõikes

alter table Employees
add City nvarchar(30)
select * from Employees
select * from Department

select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees group by City, Gender

select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees group by City, Gender order by City

-- mitu töötajat on soo ja linna kaupa selles firmas
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City

-- loeb ära tabelis olevate ridade arvu
select count (*) from Employees

-- kuvab ainult mehede linnade kaupa
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

-- samasugune päring, aga kasutame having
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'

-- kõik kes teenived palka üle 4000
select * from Employees where Salary >= 4000

-- kasutame having, et teha samasugune päring
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000

-- loome tabeli, milles hakatakse automaatselt Id-d nummerdama
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)

)
insert into Test1 values('X')
select * from Test1

-- kustutame veeru nimega City tabelist Employees
alter table Employees
drop column City
select * from Employees

-- inner join
-- kuvab neid kellel on Deprartmentname all olemas väärtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department on Employees.DepartmentId = Department.Id

-- left join
-- kuidas saada kõik andmed Employees-t kätte saada
select Name, Gender, Salary, DepartmentName from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- right join
-- kuidas saada DepartmentName alla uus nimetus e antud juhul Other Department
select Name, Gender, Salary, DepartmentName from Employees
right join Department -- võib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- kuidas saada kõikide tabelite väärtused ühte päringusse
-- outer join
select Name, Gender, Salary, DepartmentName from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

-- cross join
select Name, Gender, Salary, DepartmentName from Employees
cross join Department

-- päringu sisu
Select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

-- inner join
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department on Employees.DepartmentId = Department.Id

-- kuidas kuvada ainult need isikud kellel on department name null
select Name, Gender, Salary, DepartmentName
from Employees
left join Department on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- Kuidas saame Department tabelis oleva rea, kus on NULL
-- right joini tuleb kasutada
select Name, Gender, Salary, DepartmentName
from Employees
right join Department on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null or Department.Id is null

-- saame muuta nimetust, alguses vana tabeli nimi ja siis uus soovitud
sp_rename 'Department1', 'Department'

-- kasutame Employees tabeli asemel muutujat E ja M
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table Employees
add ManagerId int


-- inner join
-- kuvab ainult ManagerId all olevate isikute väärtuseid
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

-- kõik saavad kõikide ülemused olla
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

-- 14.03.2025
select isnull('Asd', 'No manager') as Manager

-- NULL asemel kuvab No manager
select coalesce(NULL, 'No manager') as Manager

-- kui expression on õige, siis paneb väärtuse mida soovid või mõne teise väärtuse

case when Expression then '' else '' end

-- neil kellel ei ole ülemust, siis paneb neile no manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager from Employees E
left join Employees M on E.ManagerId = M.Id

-- Teeme päringu kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M on E.ManagerId = M.Id

-- lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

select * from Employees

-- muudame veeru nime
sp_rename 'Employees.Name', 'FirstName'

-- muudame ja lisame andmeid
update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1

update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2

update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3

update Employees
set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5

update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6

update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7

update Employees
set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8

update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9

update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

select * from Employees

-- igast reast võtab esimesena täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name from Employees


-- loome kaks tabelit
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25),
)
create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25),
)

-- sisestame tabelisse andmeid
insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

-- kasutame union all, näitab kõiki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

-- korduvate väärtustega read pannakse ühte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name

-- stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end
-- nüüd saab kasutada selle nimelist sp-d
spGetEmployees

exec spGetEmployees


select * from Employees

create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20), @DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

spGetEmployeesByGenderAndDepartment 'Male', 1

--- niimoodi saab järjekorda muuta päringul, kui ise paned muutuja paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

-- soov vaadata sp sisu
sp_helptext spGetEmployeesByGenderAndDepartment