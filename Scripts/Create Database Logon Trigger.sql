--Create Database Login Trigger 
--WARNING: MAY LOCK YOU OUT OF THE DATABASE WHEN/IF TRIGGER FAILS OR IF USER DOESN'T HAVE PERMISSIONS TO INSERT INTO THIS TABLE

CREATE TRIGGER [LogonTrigger] ON ALL SERVER 
	FOR LOGON
AS 
BEGIN 
    BEGIN TRY
	   INSERT INTO NH_TESTING.dbo.[LoginLog]
			 ( UserName, [Database], [Hostname])
	   VALUES  ( ORIGINAL_LOGIN(), DB_NAME(), HOST_NAME() )
    END TRY
    BEGIN CATCH
	   COMMIT
    END CATCH
END