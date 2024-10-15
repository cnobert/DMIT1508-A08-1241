use cnobert;

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
