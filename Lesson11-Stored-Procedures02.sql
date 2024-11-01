--passing parameters to stored procedures

--Sometimes we need to give info to a stored procedure. To do that we use paramaters.

--create a procedure that can find a student based on a studentID that we give it
drop procedure if exists FindStudent
go
create procedure FindStudent (@StudentId int = null)
as 
begin
    if @studentId is NULL
    begin
        print 'ERROR: You must provide a StudentId.'
    end
    else
    begin
        select FirstName, LastName, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing
        from Student
        where StudentId = @StudentId
    end
end 
return
GO

exec FindStudent 199912010

drop procedure if exists CourseByAverage
GO

--returns course names that have averages above the given Course Average
create procedure CourseByAverage (@CourseAverage int = null)
as
begin
    if @CourseAverage is null 
    begin
        print 'ERROR: You must provide a CourseAverage'
    end
    else
    begin 
        select CourseName     
        from Course join Offering on Course.CourseID = Offering.CourseId     
        join Registration on Offering.OfferingCode = Registration.OfferingCode     
        group by CourseName     
        having avg(Registration.Mark) > @CourseAverage
    end 
end 
return
go
exec CourseByAverage 85
