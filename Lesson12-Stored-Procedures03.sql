select * from position

--create a stored procedure called 'AddPosition' that inserts a new position into the position table
drop procedure if exists AddPosition
go

create procedure AddPosition 
    (@PositionId tinyint = null, @Description varchar(50) = null)
as 
begin
    if @PositionId is null or @Description is null --game over, blow it up
        begin 
            --RaisError is for catastrophic errors that must stop
            --execution of the stored procedure
            RAISERROR ('You must provide both a Position Id and a Position Description', 16, 1)
        end
    else  
        Insert into Position (PositionID, PositionDescription)
        Values (@PositionId, @Description)
        --many things could have gone wrong with the above insert
        --we need to check if it worked out

        --declare variables that we can check later
        declare @RowCount int
        declare @Error int

        --@@error contains a value of 0 if the most recently executed batch succeeded
        --@@rowcount contains the number of rows affected by the last statement
        --the next two lines make @@error and @@rowcount available for us to use
        --in this stored procedure
        select @error = @@error 
        select @rowcount = @@rowcount

        if @error != 0 --if this is true, there was an error in our last batch
            begin
                RAISERROR('Insert into Position failed.', 16, 1)
            end
        if @RowCount = 0
            begin 
                RAISERROR('You did not successfully insert any records.', 16, 1)
            end 
end 
return 


go
delete from Position where PositionID = 8
delete from Position where PositionID = 9
exec AddPosition 8, 'Teaching Assistant'
exec AddPosition 9, 'Janitorial'
exec AddPosition  10, null

select * from position 