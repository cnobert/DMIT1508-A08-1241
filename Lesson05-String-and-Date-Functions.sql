select FirstName, LastName
from Student

select FirstName + ' ' + LastName as 'Student Name'--string concatenation
from Student

select LastName + ', ' + FirstName  as 'Student Name'--string concatenation
from Student

select FirstName, Lastname, Province
from Student
where Province <> 'AB'

select FirstName, Lastname, Province
from Student
where Province = 'AB'

select FirstName + ' ' + LastName, PositionID
from Staff
where PositionID = 3

select * from Registration

select StudentID, OfferingCode, Mark
from Registration
where Mark between 70 and 80

--aggregate functions

--avg()
select avg(Mark) as 'Average Mark of All Courses'
from Registration

select avg(Mark) as 'Average Mark for Offering 1000'
from Registration
where OfferingCode = 1000

select avg(Mark) as 'Average Mark for Student 200978500'
from Registration
where StudentID = 200978500

--sum()
select sum(Amount) as 'Total amunt that Student 200495500 has paid'
from Payment
where StudentID = 200495500

--aggregate functions and "group by" clause are best friends
select StudentID, sum(Amount) as 'Total amunt that each Student has paid'
from Payment
group by StudentID
  
--max() min()
select max(Mark) as 'Highest mark in offering 1000 of DMIT1514'
from Registration
where OfferingCode = 1000 --offering 100 was the course DMIT1514

--count()
select * from Staff

select count(DateReleased) as 'Number of staff who have left'
from Staff

--string functions

--length function
select len(FirstName), FirstName
from Student

select FirstName
from Student
where len(FirstName) = 3

--left, right
--return the first N characters, starting from the left or right
select left(FirstName, 3), FirstName
from Student

select right(FirstName, 3), FirstName
from Student

--substring - return part of a string

--returns 4 characters of the CourseID starting on the 5th character
select CourseID, substring(CourseID, 5, 4)
from Course

select CourseID, left(CourseId, 4)
from Course

--achieves the same thing as "left(CourseID, 4)"
select CourseId, substring(CourseID, 1, 4)
from Course

--reverse
select reverse(FirstName)
from Student

--lower and upper
--good for comparisons
select upper(FirstName)
from Student

select lower(FirstName)
from Student

--date functions
select * from student

select month(Birthdate)
from Student

select datename(mm, Birthdate)
from Student

select getdate()
