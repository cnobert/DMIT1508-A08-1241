--Raise a user friendly error if:
--•	Required parameters were not passed to the procedure (2 marks max deduction)
--•	A DML statement fails (2 marks max deduction) - DML = Data Manipulation Statement (insert, update, delete)
--•	Records to be updated or deleted do not exist (2 marks max deduction)

--1. Write a stored procedure called AddCourse that will have parameters of CourseName, CourseHours, MaxStudents, 
--and CourseCost. Provide an appropriate error message if the CourseName and CourseHours (on the same record) are 
--already in the table.
-- This means we already entered that Course record and should not add it again. If the Course is not already there, 
--add the new Course record. 
--Select the database generated(identity) CourseID if the insert was successful. 

drop PROCEDURE if EXISTS AddCourse;
go

Create Procedure AddCourse (@CourseName varchar(40) = null, @CourseHours decimal(6,2) = null, @MaxStudents smallint = null, @CourseCost decimal(6,2) = null)
as
if @CourseName is null or @CourseHours is null or @MaxStudents is null or  @CourseCost is null
Begin
    RaisError('missing params',16,1)
End
else
Begin
    if exists(select CourseName from Course where CourseName = @CourseName and CourseHours = @CourseHours)
    BEGIN
        RaisError('CourseName and Hours already exist.',16,1)
    END
    else
    BEGIN
        Insert into Course
            (CourseName, CourseHours, MaxStudents, CourseCost)
        Values
            (@CourseName, @CourseHours, @MaxStudents, @CourseCost)
        if @@error!=0 
        Begin
            RaisError('Error adding Course',16,1)
        End
        else
        Begin
            Select @@identity 'New CourseID'
        End
    END
End
Return
go
select * from course
exec AddCourse 'the name', 60, 20, 500
--Raise a user friendly error if:
--•	Required parameters were not passed to the procedure (2 marks max deduction)
--•	A DML statement fails (2 marks max deduction) - DML = Data Manipulation Statement (insert, update, delete)
--•	Records to be updated or deleted do not exist (2 marks max deduction)

--2. Write a stored procedure called ChangeMark that will update the Mark of an existing Registration record. 
--It will have parameters of OfferingCode, StudentID, and Mark.
use cnobert;
go

drop PROCEDURE if EXISTS ChangeMark;
go
Create Procedure ChangeMark(@OfferingCode int = null, @StudentID int = null, @Mark decimal(5,2) = null)
as
if @OfferingCode is null or @StudentID is null or @Mark is null
Begin
    RaisError('Missing params',16,1)
End
else
Begin
    if not exists(Select * from Registration where OfferingCode = @OfferingCode and StudentID = @StudentID)
    Begin
        RaisError('The Mark that you are trying to change does not exist.',16,1)
    End
    else --the parameters are not null, and the record with the given offeringcode and studentID exists
    BEGIN
        Update Registration
        set Mark = @Mark
        where OfferingCode = @OfferingCode and StudentID = @StudentID
        if @@error<>0
        Begin
            RaisError('Update failed',16,1)
        End
    END
END
RETURN

select * from registration
exec ChangeMark 1000, 200494470, 99

--3. Write a stored procedure called TopPayments that receives a numeric parameter. 
--Return all the StudentIDs and First names whose average payment (remember that students can pay multiple times) is above the parameter value. 
--If the parameter is less than 0 raise an error and do not perform the search.
exec TopPayments 300 --returns StudentIDs and First name whose average payment is greater than 300

drop PROCEDURE if exists TopPayments
go
Create Procedure TopPayments(@MaxAveragePaymentAmount money = null)
as
if @MaxAveragePaymentAmount is null
Begin
    RaisError('Missing params',16,1)
End
else
Begin
    if @MaxAveragePaymentAmount < 0
    BEGIN
        RaisError('Max Average Payment Amount must be 0 or greater.',16,1)
    END
    ELSE
    BEGIN
        --query goes here
        select Student.StudentID, Student.FirstName
        from Student join Payment on Student.StudentID = Payment.StudentID
        group by Student.StudentID, Student.FirstName
        HAVING avg(Payment.Amount) > @MaxAveragePaymentAmount
    END
END
RETURN

exec TopPayments 100