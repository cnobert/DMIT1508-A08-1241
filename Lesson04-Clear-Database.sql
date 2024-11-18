use cnobert;

-- Drop all views
DECLARE @viewName NVARCHAR(256)
DECLARE viewCursor CURSOR FOR
SELECT name FROM sys.objects WHERE type = 'V'

OPEN viewCursor
FETCH NEXT FROM viewCursor INTO @viewName
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP VIEW [' + @viewName + ']')
    FETCH NEXT FROM viewCursor INTO @viewName
END
CLOSE viewCursor
DEALLOCATE viewCursor

-- Drop all functions
DECLARE @functionName NVARCHAR(256)
DECLARE functionCursor CURSOR FOR
SELECT name FROM sys.objects WHERE type IN ('FN', 'IF', 'TF')

OPEN functionCursor
FETCH NEXT FROM functionCursor INTO @functionName
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP FUNCTION [' + @functionName + ']')
    FETCH NEXT FROM functionCursor INTO @functionName
END
CLOSE functionCursor
DEALLOCATE functionCursor

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

-- Drop all tables
DECLARE @tableName NVARCHAR(256)
DECLARE tableCursor CURSOR FOR
SELECT name FROM sys.objects WHERE type = 'U'

OPEN tableCursor
FETCH NEXT FROM tableCursor INTO @tableName
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP TABLE [' + @tableName + ']')
    FETCH NEXT FROM tableCursor INTO @tableName
END
CLOSE tableCursor
DEALLOCATE tableCursor
