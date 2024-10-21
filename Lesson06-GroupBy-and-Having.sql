--review of string, date, and aggregate functions

select * 
from student

select distinct city
from student

select PostalCode
from student
--return the first 3 characters of the students' postal codes, with no repeats
select left(PostalCode, 3)
from student

--return the 2nd and 3rd character of the students' postal codes, with no repeats
select SUBSTRING(PostalCode, 2, 3) --T6E2H1
from student

--select student names from certain regions
select FirstName, LastName
from Student
where left(PostalCode, 3) = 'T3Q' or left(PostalCode, 3) = 'T9A'

--select student names and their birth month and year
select FirstName + ' ' + LastName as 'Student Name', datename(mm, Birthdate) + ', ' + datename(yy, Birthdate)
from student

--aggregate functions, review
select * from registration
select avg(Mark)
from registration

--select the average of the marks for registrations that have an offeringCode of less than 1003
select avg(Mark)
from registration
where offeringCode < 1003

select max(Mark)
from registration
where offeringCode < 1003

select min(Mark)
from registration
where offeringCode < 1003

--group by
--select the average mark, grouped by offering code
select offeringCode, avg(Mark) as 'Average Mark for the offering', max(Mark) as 'Maximum mark for the offering', min(Mark) as 'Minimum mark for the offering'
from registration
group by offeringCode 
having offeringCode < 1003 --having is the "where clause" for "group by" queries
-- if you use "group by", you can only put column names that are in the "group by" in the "select"

select * from payment

select studentID, avg(amount) as 'average payment amount'
from payment
group by studentID
having avg(amount) > 100 --we use "having" to filter a "group by" query
