--Raise a user friendly error if:
--•	Required parameters were not passed to the procedure (2 marks max deduction)
--•	A DML statement fails (2 marks max deduction)
--•	Records to be updated or deleted do not exist (2 marks max deduction)

--Write a stored procedure called AddCourse that will have parameters of CourseName, CourseHours, MaxStudents, 
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

--Write a stored procedure called ChangeMark that will update the Mark of an existing Registration record. 
--It will have parameters of OfferingCode, StudentID, and Mark.
