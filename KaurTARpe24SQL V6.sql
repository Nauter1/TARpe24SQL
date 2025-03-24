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
declare @Start int
set @Start = 30
while (@Start <= 400)
begin
	select char (@Start)
	set @Start = @Start+1
	if (@Start = 360) set @Start = 30
end

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