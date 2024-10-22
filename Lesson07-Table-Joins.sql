select * from Staff
select * from Position

--list the staff names and their positions
select FirstName, LastName, PositionDescription
from Staff join Position on Staff.PositionID = Position.PositionID

--get all columns from the student and payment tables
select *
from Student join Payment on Student.StudentID = Payment.StudentID

--select the student names, with the payment amounts that the students have made
select FirstName, LastName, Amount
from Student join Payment on Student.StudentID = Payment.StudentID
order by LastName, Amount

--add to the above query
--include the payment year and payment month with every payment (Dave Brown 2013 December 90.00)
select FirstName, LastName, datename(yy, PaymentDate) + ', ' + datename(mm, PaymentDate) as 'Payment Month', Amount
from Student join Payment on Student.StudentID = Payment.StudentID
order by LastName, 'Payment Month', Amount

--add to the above query
--include the payment type (payment method) that the student paid with
select FirstName, LastName, datename(yy, PaymentDate) + ', ' + datename(mm, PaymentDate) as 'Payment Month', Amount, PaymentTypeDescription
from Student join Payment on Student.StudentID = Payment.StudentID join PaymentType on Payment.PaymentTypeID = PaymentType.PaymentTypeID
order by LastName, 'Payment Month', Amount

--select student names and the clubs that they belong to
select ClubName, FirstName, LastName
from Student join Activity on Student.StudentID = Activity.StudentId join Club on Activity.ClubID = Club. ClubID
order by ClubName, LastName

--select staff names and the names of the courses that they teach
select FirstName, LastName, CourseName
from Staff join Offering on Staff.StaffID = Offering.StaffID join Course on Offering.CourseID = Course.CourseId
order by LastName, CourseName

--select Offering Codes, Course Names, and the students who were registered in the Offerings
select Offering.OfferingCode, CourseName, FirstName, LastName
from Offering join Course on Offering.CourseID = Course.CourseID join Registration on Offering.OfferingCode = Registration.OfferingCode join Student on Registration.StudentID = Student.StudentID
where CourseName = 'Game Programming Essentials'