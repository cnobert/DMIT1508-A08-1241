--CHECK CONSTRAINTS (DDL5 Check Constrains)
    --example (the answer is in the IQSchool Create Table Script)
    --add a check constraint to Student that ensures that the BirthDate is greater than today's date

--ALTER TABLE (DDL7 Alter Table)
    --Oops! We forgot to add a default of 60 for CourseHours in the Course table. Fix the mistake with an "Alter table" command
alter table Course
add constraint DF_CourseHours default 60 for CourseHours

--QUERIES
--don't worry about outer vs inner join
    --join tables and put filter with where clause
    --group by clause, with aggregate functions (Average, Maximum, Minimum, Count)
    --filter with "having" clause
    --union
    --example: select the firstname and lastname of every person in the database
        select FirstName, LastName from Student
        union
        select FirstName, LastName from Staff
    --order by

--VIEWS
    --Create View is like creating another table
    --Once created, you can query it like any other table

--DML
    --Insert
        --for example, insert a student with these data
            --199966234, 'Conrad', 'Nobert, 'M', '11044 -83 ST.', 'Edmonton', 'AB', 'T3O1J1', 'Apr 29, 1993'
            --same BalanceOwing as student 200978400
            Insert into Student
                (StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
            Values
                (199966234, 'Conrad', 'Nobert', 'M', '11044 -83 ST.', 'Edmonton', 'AB', 'T3O1J1', 'Apr 29, 1993', (select BalanceOwing from Student where StudentID = 200978400))

    --Update
        --reduce the BalanceOwing of all students by 10%
        update Student
        set BalanceOwing = BalanceOwing * 0.9
    --Delete
        --delete all clubs for which no one has ever registered
        delete from Club where ClubId not in (select ClubID from Activity)
