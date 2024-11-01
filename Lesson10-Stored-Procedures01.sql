drop procedure if exists AllStudentNames
go
create procedure AllStudentNames 
as 
begin     
    --code of the stored procedure goes here     
    select FirstName, LastName     
    from Student 
end 
return 
go 

drop procedure if exists HonourCourses
go
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