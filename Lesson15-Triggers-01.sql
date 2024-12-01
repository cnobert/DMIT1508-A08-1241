drop trigger if exists trigger_01
GO
create trigger trigger_01
on Supply
for insert
AS
if @@ROWCOUNT > 0 --if at least one row in the table was affected by the insert
BEGIN
    if exists(select * from inserted where description = 'Acme Brand Soap')
    BEGIN
        RAISERROR('Acme Brand Soap is not allowed.', 16, 1)
        ROLLBACK TRANSACTION --aborts the current command
    END
END
RETURN

INSERT INTO Supply (Description)
VALUES 
('Acme Brand Soap')

drop trigger if exists trigger_02
GO
create trigger trigger_02
on Supply
for update
as 
if @@ROWCOUNT > 0
BEGIN
    select *
    from supply join inserted on Supply.SupplyCode = inserted.SupplyCode
END
RETURN

update Supply
set description = 'Ajax Cleaning Solution'
where SupplyCode = 2

select *
from Supply
where supply.description like '%Ajax%'
