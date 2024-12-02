
DECLARE @sql NVARCHAR(MAX) = N'';

-- Step 2.1: Drop all foreign key constraints
SELECT @sql += 'ALTER TABLE [' + SCHEMA_NAME(fk.schema_id) + '].[' + OBJECT_NAME(fk.parent_object_id) + '] DROP CONSTRAINT [' + fk.name + '];' + CHAR(13)
FROM sys.foreign_keys AS fk;

EXEC sp_executesql @sql;

-- Step 2.2: Drop all tables
SET @sql = N'';
SELECT @sql += 'DROP TABLE [' + SCHEMA_NAME(schema_id) + '].[' + name + '];' + CHAR(13)
FROM sys.tables;

EXEC sp_executesql @sql;
go

-- Drop all procedures
DECLARE @procName NVARCHAR(256)
DECLARE procCursor CURSOR FOR
SELECT name FROM sys.objects WHERE type = 'P'

OPEN procCursor
FETCH NEXT FROM procCursor INTO @procName
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP PROCEDURE [' + @procName + ']')
    FETCH NEXT FROM procCursor INTO @procName
END
CLOSE procCursor
DEALLOCATE procCursor
