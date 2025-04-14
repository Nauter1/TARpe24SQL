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

-- v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla v��rtust
-- siis see automaatselt sisestab sellele reale v��rtuse 3 e nagu meil on unknown
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

-- k�ik kes elavad Gothami linnas
select * from Person where City = 'Gotham'

-- k�ik kes ei ela gothamis
select * from Person where City != 'Gotham'

-- variant 2
select * from Person where city <> 'Gotham'

-- n�itab teatud vanusega inimesi
select * from Person where Age = 100 or Age = 35 or Age = 27
select * from Person where Age in (100, 35, 27)

-- n�itab teatud vanusevahemikus olevaid inimesi
select * from Person where Age < 90 and Age > 20
-- variant 2
select * from Person where Age between 22 and 50

-- wildcard ehk n�itab k�ik n-t�hega linnad
select * from Person where City like 'n%'

-- k�ik emailid kus on @-m�rk emailis
select * from Person where Email like '%@%'

-- n�itab k�iki, kellel ei ole @-m�rki emailis
select * from Person where Email not like '%@%'

-- tund 2 07.03.2025

-- n�itab, kellel on emailis ees ja peale @-m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'

-- k�ik kellel on nimes t�ht W, A, S
select * from Person where Name like '[^WAS]%'
select * from Person

-- kes elavad Gothamis ja New Yorkis

select * from Person where City = 'Gotham' or City = 'New York'

-- k�ik, kes elavad gothamis ja new yorkis ja on vanemad kui 29
select * from Person where (City = 'Gotham' or City = 'New York') and Age >= 30

-- kuvab t�hestikulises j�rjekorras inimesi ja v�tab aluseks nime
select * from Person order by Name

-- sama aga vastupidi
select * from Person order by Name desc

-- v�tab kolm esimest rida
select top 3 * from Person

-- kolm esimest aga tabeli j�rjestus on age ja siis name
select top 3 Age, Name from Person

-- n�itab esimesed 50% tabelis
select top 50 percent * from Person

-- j�rjestab vanuse j�rgi isikud
select * from Person order by Age desc

-- muudab Age muutuja intiks ja n�itab vanuselises j�rjestuses
select * from Person order by cast(Age as int) desc

-- k�ikide isikute koondvanus
select sum(cast(Age as int)) from Person

-- kuvab k�ige noorem
select min(cast(Age as int)) from Person

-- k�ige vanem
select max(cast(Age as int)) from Person

-- konkreetsetes linnades olevate isikute koondvanus
-- enne oli Age nvarchar, aga muudame selle int andmet��biks
-- var 1 (minu meetod)
select sum(Age) from Person where city = 'Gotham'
-- var 2
select City, sum(Age) as totalage from Person group by City
 
-- kuidas saab koodiga muuta andmet��pi ja selle pikkust
alter table Person
alter column Name nvarchar(25)

-- kuvab esimeses reas v�lja toodud j�rjestuses ja kuvab Age totalAge-iks
-- j�rjestab City-s olevate nimede j�rgi ja siis GenderId j�rgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

-- n�itab ridade arvu tabelis
select count(*) from Person
select * from Person

-- n�itab tulemust, et mitu inimest on genderId v��rtusega 2 konkreetses linnas
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

-- Teeme left join p�ringu
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- Arvutab k�ikide palgad kokku
select sum(cast(Salary as int)) from Employees

-- Tahame teada minimum palga saajat
select top 1 * from Employees order by cast(Salary as int)

select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location -- �he kuu palgafond linnade l�ikes

alter table Employees
add City nvarchar(30)
select * from Employees
select * from Department

select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees group by City, Gender

select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees group by City, Gender order by City

-- mitu t��tajat on soo ja linna kaupa selles firmas
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City

-- loeb �ra tabelis olevate ridade arvu
select count (*) from Employees

-- kuvab ainult mehede linnade kaupa
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

-- samasugune p�ring, aga kasutame having
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'

-- k�ik kes teenived palka �le 4000
select * from Employees where Salary >= 4000

-- kasutame having, et teha samasugune p�ring
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
-- kuvab neid kellel on Deprartmentname all olemas v��rtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department on Employees.DepartmentId = Department.Id

-- left join
-- kuidas saada k�ik andmed Employees-t k�tte saada
select Name, Gender, Salary, DepartmentName from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- right join
-- kuidas saada DepartmentName alla uus nimetus e antud juhul Other Department
select Name, Gender, Salary, DepartmentName from Employees
right join Department -- v�ib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- kuidas saada k�ikide tabelite v��rtused �hte p�ringusse
-- outer join
select Name, Gender, Salary, DepartmentName from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

-- cross join
select Name, Gender, Salary, DepartmentName from Employees
cross join Department

-- p�ringu sisu
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
-- kuvab ainult ManagerId all olevate isikute v��rtuseid
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

-- k�ik saavad k�ikide �lemused olla
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

-- 14.03.2025
select isnull('Asd', 'No manager') as Manager

-- NULL asemel kuvab No manager
select coalesce(NULL, 'No manager') as Manager

-- kui expression on �ige, siis paneb v��rtuse mida soovid v�i m�ne teise v��rtuse

case when Expression then '' else '' end

-- neil kellel ei ole �lemust, siis paneb neile no manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager from Employees E
left join Employees M on E.ManagerId = M.Id

-- Teeme p�ringu kus kasutame case-i
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

-- igast reast v�tab esimesena t�idetud lahtri ja kuvab ainult seda
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

-- kasutame union all, n�itab k�iki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

-- korduvate v��rtustega read pannakse �hte ja ei korrata
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
-- n��d saab kasutada selle nimelist sp-d
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

--- niimoodi saab j�rjekorda muuta p�ringul, kui ise paned muutuja paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

-- soov vaadata sp sisu
sp_helptext spGetEmployeesByGenderAndDepartment


-- kuidas muuta sp-d ja pane kr�pteeringu peale, et keegi teine peale teid ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

-- sp tegemine

create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

spGetEmployeeCountByGender 'Male' '9'
sp_helptext spGetEmployeeCountByGender

-- annab tulemuse kus loendab �ra n�uetele vastavad read
-- prindib tulemuse konsooli
declare @TotalCount int
execute spGetEmployeeCountByGender 'Male', @TotalCount out
if(@TotalCount = 0) print 'TotalCount is null'
else
print '@Total is not null'
print @TotalCount

-- n�itab �ra, et mitu rida vastab n�uetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

-- sp sisu vaatamine
sp_helptext spGetEmployeeCountByGender
sp_help spGetEmployeeCountByGender
-- tabeli info
sp_help Employees

-- vaatame millest see sp s�ltub
sp_depends spGetEmployeeCountByGender
sp_depends Employees

--
create proc spGetnameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees
end

declare @NameOutput nvarchar(20)
execute spGetnameById 2, @Name = @NameOutput out
print @NameOutput

spGetnameById 1, 'Tom'
sp_help spGetnameById

declare @Firstname nvarchar(50)
execute spGetnameById 1, @Firstname out
print 'Name of the employee = ' + @FirstName

select * from Employees

-- mis id all on keegi nime j�rgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin
	select @FirstName = FirstName from Employees where Id = @Id
end


declare @Firstname nvarchar(50)
execute spGetNameById1 1, @Firstname out
print 'Name of the employee = ' + @FirstName

---
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

-- tuleb veateade kuna kutsusime v�lja int aga tom on string
declare @Firstname nvarchar(50)
execute @FirstName = spGetnameById2 1
print 'Name of the employee = ' + @FirstName
-- Msg 245, Level 16, State 1, Procedure spGetnameById2, Line 4 [Batch Start Line 632]
-- Conversion failed when converting the nvarchar value 'Tom' to data type int.

--sisseehitatud string funktsioonid
-- see konverteerib ASCII t�he v��rtuse numbriks
select ascii('A')
select char (32)

-- infinite loop :O
9

select ltrim('            Hello')

select ltrim(FirstName) as FirstName, MiddleName, LastName from Employees

select rtrim('Hello                  ')

-- keerab kooloni sees olevad andmed vastupidiseks
-- vastavalt upper ja lower-ga saan muuta m�rkidse suurust
-- reverse funktsioon p��rab k�ik �mber
select REVERSE(UPPER(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName), rtrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName from Employees

-- n�eb mitu t�hte on s�nal ja loeb t�hikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees

-- n�eb mitu t�hte on s�nal ja ei loe t�hikuid
select FirstName, len(ltrim(rtrim(FirstName))) as [Total Characters] from Employees

-- left, right ja substring
-- vasakult poolt neli esimest t�hte
select left('ABCDEF', 4)
-- paremalt kolm
select right('ABCDEF', 3)
-- kuvab @-t�hem�rgi asetusest ehk mitmes on see t�ht
select charindex('@' , 'Sara@aaah.com')

-- esimene number peale komakohta n�itab et mitmendast alustab ja siis mitu nr peale
-- seda kuvada
select substring('pam@bbb.com', 5,2)

-- @-m�rgist kuvab kolm t�hem�rki, viimase nr saab m�rrata pikkust
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 1,9)

-- peale @-m�rki reguleerin t�hem�rkide pikkuse n�itamist
select substring('pam@bb.com', charindex('@', 'pam@bb.com') + 1, len('pam@bb.com') - CHARINDEX('@', 'pam@bb.com'))
select substring('pam@bb.com', charindex('@', 'pam@bb.com') + 1, len('pam@bb.com') - CHARINDEX('@', 'pam@bb.com'))

select * from Employees

-- vaja teha uus veerg nimega Email, nvarchar(20)

alter table Employees
add Email nvarchar(20)

update Employees
set Email = 'Sam@aaa.com'
where Id = 1
update Employees
set Email = 'Ram@aaa.com'
where Id = 2
update Employees
set Email = 'Sara@ccc.com'
where Id = 3
update Employees
set Email = 'Todd@bbb.com'
where Id = 4
update Employees
set Email = 'John@aaa.com'
where Id = 5
update Employees
set Email = 'Sana@ccc.com'
where Id = 6
update Employees
set Email = 'James@bbb.com'
where Id = 7
update Employees
set Email = 'Rob@ccc.com'
where Id = 8
update Employees
set Email = 'Steve@aaa.com'
where Id = 9
update Employees
set Email = 'Pam@bbb.com'
where Id = 10

-- lisame *-m�rgi alates teatud kohast
select FirstName, LastName,
	substring(Email, 1, 2) + REPLICATE('*', 5) + SUBSTRING(Email, charindex('@', Email), Len(Email) - charindex('@', Email)) as Email
	from Employees

-- Kolm korda n�itab stringis olevat v��rtust
select REPLICATE('ASD', 3)

-- kuidas sisestada t�hikut kahe nime vahele
select space(5)

select FirstName + space(25) + LastName as FullName from Employees

--

-- PATINDEX
-- sama, mis charIndex. aga d�naamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0 --leian k�ik selle domeeni esindajad ja alates mitmendast m�rgist algab @

-- k�ik .com-d asendatakse .net-ga

select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail from Employees

-- soovin asendada peale esimest m�rki kolm t�hte viie t�rniga
select FirstName, LastName, Email, 
	stuff(Email, 2, 3, '*****') as StuffedEmail
	from Employees

-- ajat��bid
create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

select GETDATE(), 'GETDATE()'

insert into DateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

update DateTime set c_datetimeoffset = '2025-04-08 10:59:29.1933333 + 10:00'
where c_datetimeoffset = '2025-03-24 09:01:41.3000000 +00:00'

select CURRENT_TIMESTAMP 'CURRENT_TIMESTAMP' -- aja p�ring
select SYSDATETIME() -- veel t�psem ajap�ring
select SYSDATETIMEOFFSET() -- t�pne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE() -- UTC aeg

select isdate('asd') -- tagastab 0 kuna string ei ole date e aeg
select isdate('01-01-2000')
select isdate(getdate())
select isdate('2025-03-24 09:19:45.232')
select day(getdate()) -- annab t�nase p�eva number
select day('01/31/2017') -- annab stringis oleva p�eva nr
select month('01/31/2017') -- annab stringis oleva p�eva nr
select year('01/31/2017') -- annab stringis oleva p�eva nr

select datename(day, '2025-03-24 09:19:01.149')
select datename(weekday, '2025-03-22 09:19:01.149')
select datename(month, '2025-03-22 09:19:01.149')
select datename(dayofyear, '2025-03-22 09:19:01.149')

create table EmployeesWithDates
(
Id nvarchar(2),
Name nvarchar(20),
DateOfBirth datetime
)
select * from EmployeesWithDates

insert into EmployeesWithDates
values (1, 'Sam', '1980-12-30 00:00:00.000')
insert into EmployeesWithDates
values (2, 'Pam', '1982-09-01 12:02:36.260')
insert into EmployeesWithDates
values (3, 'John', '1985-08-22 12:03:30.370')
insert into EmployeesWithDates
values (4, 'Sara', '1979-11-29 12:59:30.670')

-- kuidas v�tta �hest veerust andmeid ja selle abil luua ueed veerud
-- vaatab DoB ja kuvab p�eva nimetuse s�nana
select Name, DateOfBirth, DATENAME(weekday, DateOfBirth) as [Day],
-- vaatab DoB veerust kp-d ja kuvad kuu nr
 MONTH(DateOfBirth) as MonthNumber,
 -- vaatab DoB veerust kuud ja kuvab s�nana
 DateName(Month, DateOfBirth) as [MonthName],
 -- v�tab DoB veerust aasta
 Year(DateOfBirth) as [Year]
 from EmployeesWithDates

select DATEPART(weekday, '2025-01-30 12:22:56:401') -- kuvab 1 kuna USA n�dal algab p�hap�eval
select DATEPART(MONTH, '2025-03-24 12:22:56.401') -- kuvab kuu nr
select DATEADD(day, 20, '2025-03-24 12:22:56.401') -- liidab stringis olevale kp 20 p�eva
select DATEADD(day, -20, '2025-03-24 12:22:56.401')
select datediff(MONTH, '11/30/2024', '03/24/2025')
select datediff(year, '11/30/2022', '03/24/2025')
select datediff(year, '11/30/2022', '03/24/0200')

-- funktsiooni tegemine
create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(getdate())) or (MONTH(@DOB)
		= month (getdate()) and day(@DOB) > DAY(getdate())) then 1 else 0 end
		select @tempdate = dateadd(year, @years, @tempdate)

		select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end

		select @tempdate = dateadd(MONTH, @months, @tempdate)

		select @days = datediff(day, @tempdate, getdate())

	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2)) + ' Months ' + cast(@days as nvarchar(2)) + ' Days old'

	return @Age
end

-- saame vaadata kasutajate vanust
select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age from EmployeesWithDates

-- kui kasutame seda funktsiooni, siis saame teada t�nase p�eva vahet v�lja tooduga

select dbo.fnComputeAge('11/11/2011')
select dbo.fnComputeAge('09/23/2007')

select Id, Name, DateOfBirth, convert(nvarchar, DateOfBirth, 110) as ConvertedDOB
from EmployeesWithDates

Select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] from EmployeesWithDates

select cast(getdate() as date)
select convert(nvarchar, getdate(), 110)
select convert(date, getdate())

select abs(-101.5) -- absoluutne nr
select CEILING(15.2) -- tagastab 16 ja suurendab suurema t�isarvu suunas
select CEILING(-15.2) -- tagastab -15 ja suurendab suurema positiivse t�isarvu suunas
select floor(15.2) -- �mardab v�iksema arvu suunas
select floor(-15.2) -- �mardab negatiivsema arvu suunas
select power(2,4) -- hakkab korrutama 2x2x2x2 e 2 astmes 4, esimene nr on korrutatav
select SQUARE(9) -- antud juhul 9 ruudus
select SQRT(81) -- ruutjuur

select rand()*100
select ceiling(rand()*100)

-- iga kord n�itab 10 suvalist numbrit

declare @counter int
set @counter = 1
while (@counter <= 10)
begin
	print floor(rand()*100)
	set @counter = @counter+1
end

-- 7 tund 28.03.2025

select Round(850.556, 2) -- �mardab kaks kohta peale komat, tulemus 850.560
select Round(850.556, 2, 1) -- �mardab allaallapoole, tulemus 8550.550
Select Round(850.556, 1) -- �mardab �lespoole ja v�tab ainult esimest nr peale koma
select round(850.556, 0) -- �mardab t�isarvuni
select round(850.556, -2) -- �mardab sajalise t�psusega
select round(850.556, -1) -- �mardab t�isnumber allapoole

create function dbo.CalculateAge(@DOB date)
returns int
as begin
declare @Age int

set @Age = DATEDIFF(YEAR, @DOB, Getdate()) - case when (MONTH(@DOB) > MONTH(getdate())) or (MONTH(@DOB) > month(getdate()) and DAY(@DOB) > day(getdate()))
then 1
else 0
end
return @Age
end

execute CalculateAge '10/08/2020'

select Id, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates where dbo.CalculateAge(DateOfBirth) > 36


alter table EmployeesWithDates
add DepartmentId int
alter table EmployeesWithDates
add Gender nvarchar(10)

update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 1
update EmployeesWithDates set Gender = 'Female', DepartmentId = 2
where Id = 2
update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 3
update EmployeesWithDates set Gender =  'Female', DepartmentId = 3
where Id = 4
insert into EmployeesWithDates (Id, Name, DateOfBirth, DepartmentId, Gender)
values (5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')

select * from EmployeesWithDates

-- scalare function annab mingis vahemikus olevaid andmeid,
-- inline table  values ei kasuta begin ja end funktsioone
-- scalar annab v��rtused ja inline annab tabeli
create function fn_EmployeeByGender(@Gender nvarchar(10))
returns table
as
return(select Id, Name, DateOfBirth, DepartmentId, Gender from EmployeesWithDates where Gender = @Gender)

-- k�ik female t��tajad
select * from fn_EmployeeByGender('Female')

select * from fn_EmployeeByGender('Female')
where Name = 'Pam'

select * from Department

-- kahest erinevast tabelist andmete v�tmine ja koos kuvaine
-- esimee on funktsioon ja teine tabel, kasutage fn_EmployeesByGender ja tabelit Department

select Name, Gender, DepartmentName
from fn_EmployeeByGender('Male') E
join Department D
on D.Id = E.DepartmentId

select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- multi table statement

-- inline funktsioon
create function fn_GetEmployees()
returns table as return(Select Id, Name, cast(DateOfBirth as date) as DOB from EmployeesWithDates)

select * from fn_GetEmployees()

-- multi state puhul peabdefineerima ue tabeli veerud koos muutujatega
create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, Cast(DateOfBirth as Date) from EmployeesWithDates

	return
end

select * from fn_MS_GetEmployees() -- Multi puhul on pm tegemist stored proceduriga ja kulutab ressurssi rohkem
select * from fn_GetEmployees() -- Inline tabeli funktsioonid on paremini t��tamas kuna k�sitletakse vaatena

update fn_GetEmployees() set Name = 'Sam1' where Id = 1 -- saab muuta andmeid
update fn_MS_GetEmployees() set Name = 'Sam' where Id = 1 -- ei saa muuta multistate puhul


-- 8 tund 04.07.2025

-- deterministic and non-deterministic

select count(*) from EmployeesWithDates
select square(3) -- k�i tehtem�rgid on deterministlikud funktsioonid, sinna kuuluvad sum, avg ja square

-- non-deterministic

select getdate()
select CURRENT_TIMESTAMP
select rand() - see funktsioon saab ola m�lemas kategoorias, k�ik oleneb sellest kas sulgudes on 1 v�i ei ole

-- loome funktsiooni
create function fn_GetNamebyId(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

select * fn_GetNamebyId

select * from EmployeesWithDates

drop table EmployeesWithDates

create table EmployeesWithDates
(
Id int primary key,
Name nvarchar(50) NULL,
DateOfBirth datetime NULL,
Gender nvarchar(10) NULL,
DepartmentId Int NULL
)

select * from EmployeesWithDates

insert into EmployeesWithDates
values (1, 'Sam', '1980-12-30 00:00:00.000', 'Male', 1)
insert into EmployeesWithDates
values (2, 'Pam', '1982-09-01 12:02:36.260', 'Female', 2)
insert into EmployeesWithDates
values (3, 'John', '1985-08-22 12:03:30.370', 'Male', 1)
insert into EmployeesWithDates
values (4, 'Sara', '1979-11-29 12:59:30.670', 'Female', 3)

update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 1
update EmployeesWithDates set Gender = 'Female', DepartmentId = 2
where Id = 2
update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 3
update EmployeesWithDates set Gender =  'Female', DepartmentId = 3
where Id = 4

create function fn_GetEmployeeNamebyId(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

select dbo.fn_GetEmployeeNamebyId(3)

alter function fn_GetEmployeeNamebyId(@Id int)
returns nvarchar(30)
with encryption
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end
-- uuesti vaatame sisu
sp_helptext fn_GetEmployeeNameById

-- muudame �lvealpool olevat funktsiooni, kindlasti tabeli ette panna dbo.Tabelinimi
alter function fn_GetEmployeeNamebyId(@Id int)
returns nvarchar(30)
with schemabinding
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

drop table dbo.EmployeesWithDates

-- temporary tables

-- #-m�rgi ette panemisel saame aru, et tegemist on temp tabeliga
-- seda tabelit saab ainult selles p�ringus avada 

create table #PersonDetails(Id int, Name nvarchar(20))

insert into  #PersonDetails values(1, 'Mike')
insert into  #PersonDetails values(2, 'John')
insert into  #PersonDetails values(3, 'Todd')

select * from #PersonDetails

select Name from sysobjects
where Name like 'Gender'

-- kustutame temp tabeli

drop table #PersonDetails

create proc spCreateLocalTempTable
as begin
create table #Persondetails(Id int, Name nvarchar(20))
insert into  #PersonDetails values(1, 'Mike')
insert into  #PersonDetails values(2, 'John')
insert into  #PersonDetails values(3, 'Todd')
select * from #PersonDetails
end

exec spCreateLocalTempTable

-- Erinevused lokaalse ja globaalse ajutise tabeli osas:
-- 1. Lokaalsed ajutised tabelid on �he #-m�rgiga, aga globaalsel on kaks t�kki.
-- 2. SQL server lisab suvalisi numbreid lokaalse aajutise tabeli nimesse, aga globaalse puhul seda ei ole.
-- 3. Lokaalsed on n�htavad ainult selles sessioonis mis on selle loonud aga globaalsed on n�htavad k�ikides sessioonides
-- 4. Lokaalsed ajutised tabelid on automaatselt kustutatud kui selle loonud sessioon on kinn pandud, aga globaalsed ajutsed tabelid l�petatakse kui viimane viitav �hendus on kinni pandud



-- globaalse temp tabeli tegemine et paned kaks # tabeli nime ette
create table ##PersonDetails(Id int, Name nvarchar(20))

-- index
create table EmployeeWithSalary
(
Id int primary key,
Name nvarchar(25),
Salary int,
Gender nvarchar(10)
)

insert into EmployeeWithSalary values(1, 'Sam', 2500, 'Male')
insert into EmployeeWithSalary values(2, 'Pam', 6500, 'Female')
insert into EmployeeWithSalary values(3, 'John', 4500, 'Male')
insert into EmployeeWithSalary values(4, 'Sara', 5500, 'Female')
insert into EmployeeWithSalary values(5, 'Todd', 3100, 'Male')

select * from EmployeeWithSalary

select * from EmployeeWithSalary
where Salary > 5000 and Salary < 7000

-- loome indeksi , mis asetab palga kahanevasse j�rjestusse
create index IX_Employee_Salary
on EmployeeWithSalary (Salary asc)

-- saame teada, et mis on selle tabeli priimarv�ti ja Index

exec sys.sp_helpindex @objname = 'EmployeeWithSalary'

select * from EmployeeWithSalary 
with (INDEX(IX_Employee_Salary))


-- saame vaadata tabelit koos selle sisuga  alates v�ga detailsest infost
select
	TableName = t.name,
	IndexName = ind.name,
	IndexId = ind.index_id,
	ColumnId = ic.index_column_id,
	ColumnName = col.name,
	ind.*,
	ic.*,
	col.*
from
	sys.indexes ind
inner join
	sys.index_columns ic on ind.object_id = ic.object_id and ind.index_id = ic.index_id
inner join
	sys.columns col on ic.object_id = col.object_id and ic.column_id = col.column_id
inner join
	sys.tables t on ind.object_id = t.object_id
where
	ind.is_primary_key = 0
	and ind.is_unique = 0
	and ind.is_unique_constraint = 0
	and t.is_ms_shipped = 0
order by t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal;

-- indeksi kustutamine
drop index IX_Employee_Salary on EmployeeWithSalary

-- indeksi t��bid:
-- 1. Klastrites olevad
-- 2. Mitte-Klastris olevad
-- 3. Unikaalsed
-- 4. Filreeritud
-- 5. XML
-- 6. T�istekst
-- 7. Ruumiline
-- 8. Veerus�ilitav
-- 9. Veergude indeksid
-- 10. V�lja arvatud veergudega indeksid

-- Klastris olev indeks m��rab �ra tabelis oleva f��silise j�rjestuse
-- ja selle tulemusel saab tabelis lla ainult �ks klastris olev indeks

create table EmployeeCity
(
Id int primary key,
Name nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50),
)

exec sp_helpindex EmployeeCity

Insert into EmployeeCity values(1, 'Sam', 2500, 'Male', 'London')
Insert into EmployeeCity values(2, 'Pam', 6500, 'Female', 'Sydney')
Insert into EmployeeCity values(3, 'John', 4500, 'Male', 'New York')
Insert into EmployeeCity values(4, 'Sara', 5500, 'Female', 'Tokyo')
Insert into EmployeeCity values(5, 'Todd', 3100, 'Male', 'Toronto')

-- andmete �ige j�rjestuse loovad klastris olevad indeksid ja kasutab selleks p�hjus, miks antud juhul kasutab Id-d, tuleneb primaarv�tmest
-- klastris olevad indeksid dikteerivad s�ilitatud andmete j�rjestuse tabelis ja seda saab klastrite puhul olla ainult �ks

select * from EmployeeCity

create clustered index IX_EmployeeCity_Name on EmployeeCity(Name)

-- annab veateate et tabelis saab olla ainult �ks klatris olev indeks
-- kui soovid, uut indeksit luua, siis kustuta olemasolev

-- saame luua ainult �he klastris oleva indeksi tabeli peale
-- klastris olev indes on analoogne telefoni suunakoodile

-- loome omposite indeksi
-- enne tuleb k�ik teised klastris olevad indeksid �ra kustutada

create clustered index IX_Employee_Gender_Salary on EmployeeCity(Gender desc, Salary asc)

-- erinevused kahe indeksi vahel
-- 1. ainult �ks klastris olev indeks saab olla tabeli peale, mittek lastris olevaid indekseid saab olla mitu
-- 2. Klastris olevad indeksid on kiiremad kunda indeks peab tagasi viitama tabelile, juhul kui selekteeritud veerg ei ole olemas indeksis
-- 3 Klastris olev indeks m��ratleb �ra tabeli ridade salvestusj�rjestuse ja ei n�ua kettal lisa ruumi. samas mitte klastris olevad indeksid on salvestatud tabelist eraldi ja n�uab lisa ruumi

create table EmployeeFirstName
(
Id int primary key,
FirstName nvarchar(50),
LastName nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)


)

exec sp_helpindex EmployeeFirstName

-- ei saa sisestada kahte samasuguse Id v��rtusega rida
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values (1, 'John', 'Menco', 2500, 'Male', 'London')

select * from EmployeeFirstName
--
drop index EmployeeFirstName.PK__Employee__3214EC0715DCEC63

-- kui k�ivitad �levalpool oleva koodi, siis tuleb veateade et SQL server kasutab UNIQUE indeksit j�ustamaks v��rtuse unikaalsust
-- ja primaarv�tit
-- koodiga unikaalseid indekseid ei saa kustutada aga k�sitsi v�ib

-- unikaalset indeksid kasutatakse kindlustamaks
-- v��rtustse unikaalsust (sh primaarv�tme oma)
-- m�lemat t��pi indeksid saavad olla unikaalsed

-- 9 tund

-- lisame piirangu, mis n�uab et veerus ei oleks dublikaate
-- aga selles veerus on ja siis ei saa seda rakendada
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstName_City
unique nonclustered(City)

update EmployeeFirstName
set City = 'Los Angeles'
where Id

Delete EmployeeFirstName
where Id = 1

exec sp_helpconstraint EmployeeFirstName

-- 1. Vaikimisi primaarv�ti loob unikaalse klastris oleva indeksi, samas unikaalne piirang loob unikaalse mitte klastris oleva indeksi
-- 2. Unikaalset indeksit v�i piirangut ei saa luua olemasolevasse tabelisse, kui tabel juba sisaldab v��rtusi v�tmeveerus
-- 3. Vaikimisi korduvaid v��rtuseid ei ole veerus lubatud, kui peaks olema unikaalne indeks v�i piirang.
-- Nt, kui tahad sisestada 10 rida andmeid, millest 5 sisaldavad korduvaid andmeid, siis k�ik 10 l�katakse tagasi. 
-- Kui soovin ainult 5 rea tagasi l�kkamist ja �lej��nud 5 rea sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY

create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with IGNORE_DUP_KEY

insert into EmployeeFirstName values(3, 'John', 'Menco', 3512, 'Male', 'Madrid')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3523, 'Male', 'London1')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3520, 'Male', 'London1')


-- view
-- view on salvestatud SQL-i p�ring, saab k�istleda ka virtuaalse tabelina

select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

create view vEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

-- view p�ringu esile kutsumine

select * from vEmployeesByDepartment



-- view ei salvesta andmeid vaikimisi
-- seda tasub v�tta, kui salvestatud virtuaalse tabelina

-- milleks vaja:
-- saab kasutada andmebaasi skeemi keerukuse lihtsutamiseks,
-- mitte IT-inimesele
-- piiratud ligip��s andmetele ei n�e k�iki veerge

-- teeme veeru kus n�eb ainult IT-t��tajaid

create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id
where DepartmentName = 'IT'

select * from vITEmployeesInDepartment

-- veeru taseme turvalisus
-- peale selecti m��ratled veergude n�itamise �ra

create view vEmployeesInDepartmentSalaryNoShow
as
select FirstName, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

select * from vEmployeesInDepartmentSalaryNoShow

-- saab kasutada koondandmete esitlemist ja �ksikasjalike andmeid
-- view, mis tagastab summeeritud andmeid
create view vEmployeesCountByDepartment
as
select DepartmentName, count(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.Id
group by DepartmentName

select * from vEmployeesCountByDepartment

-- kui soovid vaadata view sisu
sp_helptext vEmployeesCountByDepartment
-- muuta saab alter k�suga
-- kustutada saab drop k�suga

-- view, mida kasutame andmete uuendamiseks
create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees


-- kasutame seda view-d, et uuendada andmeid
-- muuta Id 2 all olev eesnimi Tom-iks

select * from vEmployeesDataExceptSalary

update vEmployeesDataExceptSalary
set FirstName = 'Tom' where Id = 2

--
alter view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees

-- kustutame andmeid ja kasutame seda viewd: vEmployeesDataExceptSalary
-- Id 2 all olevad andmed

delete vEmployeesDataExceptSalary where Id = 2

-- n��d lisame andmed 
insert into vEmployeesDataExceptSalary (Id, Gender, DepartmentId, FirstName)
values (2, 'Female', 2, 'Pam')

-- indekseeritud view
-- MS SQL-s on indekseeritud view nime all ja
-- Oracle-s materjaliseeritud view

create table product
(
Id int primary key,
Name nvarchar(20),
UnitPrice int
)

insert into Product values (1, 'Books', 20)
insert into Product values (2, 'Pens', 14)
insert into Product values (3, 'Pencils', 11)
insert into Product values (4, 'Clips', 10)

create table ProductSales
(
Id int,
QuantitySold int
)

insert into ProductSales values (1, 10)
insert into ProductSales values (3, 23)
insert into ProductSales values (4, 21)
insert into ProductSales values (2, 12)
insert into ProductSales values (1, 13)
insert into ProductSales values (3, 12)
insert into ProductSales values (4, 13)
insert into ProductSales values (1, 11)
insert into ProductSales values (2, 12)
insert into ProductSales values (1, 14)

-- loome view, mis annab meile veerud TotalSales ja TotalTransaction
create view vTotalSalesByProduct
with schemabinding
as
select Name,
sum(isnull((QuantitySold * UnitPrice), 0)) as TotalSales,
COUNT_BIG(*) as TotalTransactions
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = ProductSales.Id
group by Name

select * from vTotalSalesByProduct

-- kui soovid luua indeksi view sisse, siis peab j�rgima teatud reegleid
-- 1. view tuleb lua koos schemabinding-ga
-- 2. kui lisafunktsioon select list viitab v�ljendile ja selle tulemuseks
-- v�ib olla NULL, siis asendusv��rtus peaks olema t�psustatud.
-- Antud juhul kasutasime ISNULL funktsiooni asendamaks NULL v��rtust
-- 3. Kui GroupBy on t�psustatud, siis view selet list peab sisaldama COUNT_BIG(*) V�ljendit
-- 4. Baastabelis peaksid view-d olema viidatud kaheosalise nimega
-- e antud juhul dbo.Product ja dbo.ProductSales.

create unique clustered index UIX_TotalSalesByProduct_Name
on vTotalSalesByProduct(Name)































