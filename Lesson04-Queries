select FirstName, LastName --"select" refers to what info we want
from Student --"from" refers to whiche table(s) we want the info from

select * from Student --"*" means "every column" - DO NOT USE EXCEPT FOR TESTING

select FirstName + ' ' + LastName as 'Student Name', City
from Student

select StudentId, FirstName, LastName, City
from Student
where StudentId = '198933540'

--Exercise: write the following query: Select all the course information for courseID 'DMIT1001'

select CourseId, CourseName, CourseHours, MaxStudents, CourseCost
from Course
where CourseId = 'DMIT1001'

--Select all the course information for all courses except for 'DMIT1001'
select CourseId, CourseName, CourseHours, MaxStudents, CourseCost
from Course
where CourseId <> 'DMIT1001'

--Select all the course information for the courses DMIT1001, DMIT1514, and DMIT2023
select CourseId, CourseName, CourseHours, MaxStudents, CourseCost
from Course
where CourseId in ('DMIT1001', 'DMIT1514', 'DMIT2023')

--Select all course information for courses that cost less than $500 (use "<")
select CourseId, CourseName, CourseHours, MaxStudents, CourseCost
from Course
where CourseCost < 500

--Select all course information for courses for courses that have 64 hours and less than 5 MaxStudents
select CourseId, CourseName, CourseHours, MaxStudents, CourseCost
from Course
where CourseHours = 64 and MaxStudents < 5

--Select first and last names from students who are from Calgary or Edmonton
select FirstName + ' ' + LastName as 'Student Name', City --'Student Name' is a column alias
from Student
where City = 'Edmonton' or City = 'Calgary'

--Select all student info for students whose Last Names begin with 'B'
select FirstName, LastName, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing
from Student
--where LastName like 'B%' --the % sign means "any number of characters, and they can be anything"
--where FirstName like 'Ja_' --the _ sign means "exactly one character, and it can be anything"
where FirstName like '[A-D]%' --first letter is any one between A-D, and then any number of any characters

--we can find values that are "between" two other values
select StudentID, FirstName, LastName, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing
from Student
where StudentID between 198933540 and 199966250