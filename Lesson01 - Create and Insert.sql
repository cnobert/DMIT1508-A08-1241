create table Student (
    StudentID int not null constraint PK_Student primary key,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    DateOfBirth date null,
    Address varchar(50) null,
    City varchar(50) null,
    Province varchar(2) null,
    PostalCode varchar(6) null
    
);
insert into Student (StudentID, FirstName, LastName, DateOfBirth, Address, City, Province, PostalCode)
values
    (1, 'Amina', 'Khan', '1999-03-14', '123 Maple Street', 'Toronto', 'ON', 'M5A1A1'),
    (2, 'Hiroshi', 'Tanaka', '2000-07-08', '456 Oak Avenue', 'Vancouver', 'BC', 'V6B4B4'),
    (3, 'Emily', 'Johnson', '1998-11-30', '789 Pine Road', 'Montreal', 'QC', 'H2Z1Y5');

select StudentID, FirstName, LastName, DateOfBirth, Address, City, Province, PostalCode from Student;
--------------------------------this is a commented line, which means "ignore this, computer, it's for humans to read"
create table Course (
    CourseID char(7) not null
        constraint PK_Course primary key,
    CourseName varchar(40) not null,
    CourseHours smallint null,
    MaxNumStudents smallint null   
);

insert into Course (CourseID, CourseName, CourseHours, MaxNumStudents)
values
    ('DMIT103', 'Applied Problem Solving', 60, 32),
    ('DMIT201', 'Intermediate Programming', 60, 32);

select CourseID, CourseName, CourseHours, MaxNumStudents from Course;
---------------------------------
create table Grade (
    StudentID int not null
        constraint FK_Grade_StudentID_to_Student_StudentID
        references Student(StudentID),
    CourseID char(7) not null
        constraint FK_Grade_CourseId_To_Course_CourseId
        references Course(CourseID),
    Mark smallint null,
    Constraint PK_Grade_StudentID_CourseID primary key (StudentID, CourseID)
);