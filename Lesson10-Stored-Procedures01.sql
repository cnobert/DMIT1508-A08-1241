drop procedure if exists AllStudentNames
go
--returns every student name
create procedure AllStudentNames 
as 
begin     
    --code of the stored procedure goes here     
    select FirstName, LastName     
    from Student 
end 
return
go
exec AllStudentNames

go 

drop procedure if exists HonourCourses
go
--output all courses that have an honours average (80%)
create procedure HonourCourses
as 
begin     
    select CourseName     
    from Course join Offering on Course.CourseID = Offering.CourseId     
    join Registration on Offering.OfferingCode = Registration.OfferingCode     
    group by CourseName     
    having avg(Registration.Mark) > 80 
end  
return 

exec HonourCourses 

drop procedure if exists NotInDMIT2515
go
create procedure NotInDMIT2515 
as 
begin      
    select FirstName + ' ' + LastName as 'Staff Name'     
    from Staff     
    where StaffId not in (select StaffId from Offering where CourseID = 'DMIT2515') 
end  
return 