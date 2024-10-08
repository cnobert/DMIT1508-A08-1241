--Paper Table
insert into Paper(Description)
values
('Journal'),
('Sun'),
('National Post'),
('Globe and Mail')

select * from Paper;

--Deliverytype Table
insert into Deliverytype (Description, Charge)
values
('Daily',7.00),
('FriSatSun',2.50),
('Saturday',1.50),
('Sunday',1.50)

select * from DeliveryType;

--Region Table
insert into Region (Name, SupervisorFirstName, SupervisorLastName)
values 
('Edmonton','Joni','Jones'),
('Sherwood Park','John','Jacobs'),
('St. Albert','Heather','Hollack')

select * from Region;

--Route Table
insert into Route (Name, RegionID)
values
('Riverbend',1),
('Mills Haven',2),
('North St.Albert',3),
('Millwoods',1)

select * from Route;

--Customer table
insert into Customer (FirstName, LastName, Address, City, Province, PC, RouteID)
values('Jone', 'Simpson', '13312 121 street','Edmonton','AB','T3J 1J2',1),
('Lisa', 'Jones', '16512 122 street','Edmonton','AB','T3J 1J2',2),
('George', 'Forman', '63271 44 Avenue','St. Albert','AB','T1J 4J6',1),
('Rob', 'smilie', '13312 121 street','Sherwood Park','AB','T3J 1J2',4),
('Cyndi', 'Lauper', '13312 121 street','Sherwood Park','AB','T3J 1J2',3),
('Bob', 'Marley', '13312 121 street','Edmonton','AB','T3J 1J2',1),
('Elvis', 'Presely', '13312 121 street','Edmonton','AB','T3J 1J2',1),
('Eric', 'Clapton', '13312 121 street','Sherwood Park','AB','T3J 1J2',2),
('Dennis', 'Johnson', '13312 121 street','St. Albert','AB','T3J 1J2',2),
('James', 'Douglas', '13312 121 street','Edmonton','AB','T3J 1J2',3),
('Jay', 'Leno', '13312 121 street','Edmonton','AB','T3J 1J2',4),
('Ethan', 'Little', '13312 121 street','Edmonton','AB','T3J 1J2',4),
('Nathan', 'Tyler', '13312 121 street','Sherwood Park','AB','T3J 1J2',1),
('Susan', 'McDonald', '13312 121 street','St. Albert','AB','T3J 1J2',2),
('Betty', 'Carlson', '13312 121 street','Edmonton','AB','T3J 1J2',2)

select * from Customer;

--CustomerPaper Table
insert into CustomerPaper (CustomerID,PaperID, DeliverytypeID)
values(1,1,2),
(1,2,4),
(2,1,1),
(3,1,1),
(1,4,1),
(4,1,2),
(5,1,2),
(6,1,2),
(7,3,2),
(8,1,2),
(9,3,2),
(10,1,1),
(11,1,1),
(12,1,1),
(13,1,1),
(14,1,1),
(15,1,1),
(10,2,1),
(13,2,1),
(11,3,1),
(10,4,1)