--1. IQSchool has decided to suspend new student registrations for the time being.
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
	(199923250, 'Dennis', 'Kent', 'M', '11044 -83 ST.', 'Edmonton', 'AB', 'T3O1J1', 'Apr 29, 1993', 0.00)

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