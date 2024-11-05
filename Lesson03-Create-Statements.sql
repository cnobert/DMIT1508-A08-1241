drop table if exists CustomerPaper;
drop table if exists Paper;
drop table if exists DeliveryType;
drop table if exists Customer;
drop table if exists Route; --since Route has a foreign key that references Region, Route MUST be dropped before Region
drop table if exists Region;

--to create your indexes, find every foreign key, and create an index after the table that contains the foreign key

--"identity" is a way to create primary key values
--identity(1,1) means "start at the number 1, and increase by 1 each time"
create table Paper
(
	PaperID smallint identity(1,1) not null
		constraint PK_Paper primary key,
	Description varchar(30),
)

create table DeliveryType
(
	DeliveryTypeID smallint identity(1,1) not null
		constraint PK_DeliveryType primary key,
	Description varchar (10) not null,
	Charge smallmoney not null constraint ck_Charge check (Charge > 0),
)

create table Region
(
	RegionID int identity(1,1) not null
		constraint PK_Region primary key,
	Name varchar(50) not null,
	SupervisorFirstName varchar(30) not null,
	SupervisorLastName varchar(30) not null,
)
create table Route
(
	RouteID int identity(1,1) not null
		constraint PK_Route  primary key,
	Name varchar(50) not null,
	RegionID int not null
		constraint FK_RegionID references Region(RegionID),
)
create nonclustered index IX_RegionID on Route(RegionID)

create table Customer
(
	CustomerID int identity(1,1) not null
		constraint PK_Customer primary key,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	Address varchar(50) null,
	City varchar(30) null
		constraint CK_City check(City in ('St. Albert', 'Edmonton', 'Sherwood Park')),
	Province char(2) null
		constraint CK_Province Check(Province like '[a-zA-Z][a-zA-Z]')
		constraint DF_Province default 'AB',
	Phone char(13) null 
		constraint ck_CustomerPhone check(Phone like '([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'), 
	PC char(7) null
		constraint CK_PC Check(PC like '[A-Z][0-9][A-Z] [0-9][A-Z][0-9]'),
	RouteID int not null
		constraint FK_RouteID references Route(RouteID),
)
create nonclustered index IX_RouteID on Customer(RouteID)

create table CustomerPaper
(
	CustomerID int not null
		constraint FK_CustomerID references Customer(CustomerID),
	PaperID smallint not null
		constraint FK_PaperID references Paper(PaperID),
	DeliveryTypeID smallint not null
		constraint FK_DeliveryTypeID references DeliveryType(DeliveryTypeID),
	constraint PK_CustomerPaper primary key (CustomerID, PaperID),
)
create nonclustered index IX_CustomerID on CustomerPaper(CustomerID)
create nonclustered index IX_PaperID on CustomerPaper(PaperID)
create nonclustered index IX_DeliveryTypeID on CustomerPaper(DeliveryTypeID)

alter table Customer
add nickname varchar(50) null