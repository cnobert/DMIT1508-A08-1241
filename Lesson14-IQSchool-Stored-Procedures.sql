--1.	Write a stored procedure called AddPosition that accepts a PositionDescription as a parameter. 
--Add the new Position to the Position table and select the new PositionId

drop PROCEDURE if EXISTS AddPosition;
go

Create Procedure AddPosition (@PositionDescription varchar(50) = null)
as
if @PositionDescription is null
	Begin
	    RaisError('missing params',16,1)
	End
else
	Begin
        Insert into Position (PositionDescription)
        values (@PositionDescription)
        if @@error!=0 
            Begin
                RaisError('Error adding task',16,1)
            End
        else
            Begin
                Select @@identity 'New PositionID'
            End
    End
Return

select * from Position
exec AddPosition 'janitor'

--2.	Write a stored procedure called UpdateClub that accepts a ClubID and ClubName as parameters. 
--Raise a message if that ClubID is not in the table. Raise a message if the ClubName already exists in the table. 
--If no error message is raised, update the record for that Club.(5 marks)
go
Create Procedure UpdateClub(@ClubID varchar(10) = null, @ClubName varchar(50) = null)
as
if @ClubID is null or @ClubName is null
	Begin
	RaisError('Missing params',16,1)
	End
else
	Begin
        if exists(Select * from Club where clubname = @ClubName)
            Begin
                RaisError('That club name already exists!',16,1)
            End
	else
		Begin
            Update Club
            set ClubName = @ClubName
            where ClubID=@ClubID
            if @@error<>0
                Begin
                    RaisError('Update failed',16,1)
                End
            End
	    End
Return

select * from club
exec UpdateClub 'ACM', 'conrad club'

--3. Write a stored procedure called DeletePaymentType that accepts an PaymentTypeId as a parameter. 
--If the record does not exist in the table raise an appropriate message. 
--If there are payments that are associated with the Payment Type, raise an appropriate message. 
--Otherwise, delete the record from the PaymentType table.	
go
Create Procedure DeletePaymentType (@PaymentTypeID tinyint= null)
as
if @PaymentTypeID is null
	Begin
	    RaisError('Missing params',16,1)
	End
else
	Begin
	if not exists (Select * from PaymentType where PaymentTypeID = @PaymentTypeID)
		Begin
		    RaisError('Record does not exists',16,1)
		End
	else
		Begin
		if exists (Select * from Payment where PaymentTypeID=@PaymentTypeID)
            Begin
                RaisError('Cannot delete Payment Type since it is associated with an existing payment.',16,1)
            End
		Else
			Begin
                Delete PaymentType where PaymentTypeID =@PaymentTypeID
                if @@error !=0
                    Begin 
                        RaisError('Delete failed',16,1)
                    End
                End
		    End
	End
Return

select * from PaymentType

Insert into PaymentType
	(PaymentTypeID, PaymentTypeDescription)
Values
	(7, 'Bitcoin') 

exec DeletePaymentType 7

go
--4.	Write a stored procedure called LookUpStudentPayments that accepts a StudentID as a parameter. 
--Return the Student's full name (as one column), PaymentID, PaymentDate, and Amount for each payment they have. (3 marks)
drop PROCEDURE if exists LookUpStudentPayments
go
Create Procedure LookUpStudentPayments(@studentID int = null)
as
if @studentID is null
Begin
    RaisError('Missing params',16,1)
End
else
Begin
    Select firstname + ' ' + lastname 'Student Name', PaymentID, PaymentDate, Amount 
    from student inner join payment on student.StudentID = payment.StudentID
    where student.studentID = @studentID
End
Return

select * from student
exec LookUpStudentPayments 199899200