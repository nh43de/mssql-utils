--Create a VIEW using RAND function.
CREATE VIEW [rndView]
AS
	SELECT [rndResult] = RAND();
GO

--Create a UDF using the same VIEW.
CREATE FUNCTION [RandFn] ()
	RETURNS DECIMAL(18, 18)
AS
BEGIN
    DECLARE @rndValue DECIMAL(18, 18);
    SELECT @rndValue = [rndResult]
    FROM [rndView];
    RETURN @rndValue;
END;
GO

--From <http://blog.sqlauthority.com/2012/11/20/sql-server-using-rand-in-user-defined-functions-udf/> 
