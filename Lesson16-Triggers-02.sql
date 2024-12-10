--1. IQSchool has decided to suspend new students from being added to the student table for the time being.
--Write a trigger called TR_1 that stops any new student from being added.
--Raise an error and block the insert.
drop trigger if exists TR_1
GO
create trigger TR_1
on Student
for insert
AS
if @@ROWCOUNT > 0 --if at least one row in the table was affected by the insert
BEGIN
	RAISERROR('Insert blocked. There are no more student records allowed for the time being.', 16, 1);
	ROLLBACK TRANSACTION
END

Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(199966259, 'Dennis', 'Kent', 'M', '11044 -83 ST.', 'Edmonton', 'AB', 'T3O1J1', 'Apr 29, 1993', 0.00)

--2. IQSchool has a new rule. No student will be allowed to register in a class if they have a balance owing.
-- Write a trigger called TR_2 that will block any records being added to the Registration table
-- if the student being added has a balance owing. Also, raise an error.
drop trigger if exists TR_2
GO
create trigger TR_2
on Registration
for insert
AS
if @@ROWCOUNT > 0 --if at least one row in the table was affected by the insert
BEGIN
    if exists
    (
        select *
        from student join inserted on student.StudentID = inserted.StudentID
        where student.BalanceOwing > 0
    )
    BEGIN
        RAISERROR('Insert blocked. Cannot add student to registration if they have a balance.', 16, 1);
	    ROLLBACK TRANSACTION
    END
END

Insert into Registration
	(OfferingCode, StudentID,  Mark,  WithdrawYN)
Values
	(1014, 200122100, 80, 'N')
select *
from Student
where studentID = 200122100

--3. Ferris Bueller keeps hacking into the system and changing student marks! Create a trigger called TR_3 that records 
--changes to Student Marks. Record any changes of the Mark in the Registration table. Don't do anything if the 
--value of the Mark didn't actually change though. The MarkChanges table has been included.

drop table if exists MarkChanges;
Create Table MarkChanges
(
    ChangeId int identity(1, 1) not null constraint pk_MarkChanges primary key,
    StudentID int not null,
    OfferingCode int not null,
	ChangeDate datetime not null,
	OldMark decimal (5,2) not null,
	NewMark decimal (5,2) not null,
)
select * from MarkChanges
drop trigger if exists TR_3
GO
create trigger TR_3
on Registration
for update
AS
if @@ROWCOUNT > 0 and update(Mark) --at least one row was updated, and the Mark field was changed
BEGIN
    --to get a record that contains both what was just deleted and what is being inserted (an update is a delete followed by an insert)
    --we join inserted and deleted on the primary key of the table
    insert into MarkChanges (StudentID, OfferingCode, ChangeDate, OldMark, NewMark)
    (
        select inserted.StudentID, inserted.OfferingCode, getdate(), deleted.Mark, inserted.Mark 
        from inserted join deleted on inserted.StudentID = deleted.StudentID
        and inserted.OfferingCode = deleted.OfferingCode
    )
END
update Registration
set mark = 99
where StudentID = 200978500 and OfferingCode = 1000
select * from MarkChanges