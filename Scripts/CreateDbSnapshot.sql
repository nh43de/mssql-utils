CREATE DATABASE [MySnapshot1]
    ON  (
        NAME = [OriginalDb_dataFile1],
        FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Data\MySnapShotFileName.ss'
    ) AS SNAPSHOT OF [OriginalDb];
GO

--restore database from snapshot
USE [master];
-- Reverting AdventureWorks to AdventureWorks_dbss1800  
RESTORE DATABASE [OriginalDb] FROM DATABASE_SNAPSHOT = 'MySnapshot1';
GO


--drop snapshot
DROP DATABASE [MySnapshot1];