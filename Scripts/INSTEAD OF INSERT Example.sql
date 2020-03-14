--INSTEAD OF INSERT Example

CREATE TABLE dbo.testprods (
    prod VARCHAR(6) NOT NULL PRIMARY KEY,
    term INT NULL
);


CREATE TABLE dbo.testloans (
    id INT IDENTITY PRIMARY KEY,
    coupon FLOAT NOT NULL,
    prod VARCHAR(6) NOT NULL,
    FOREIGN KEY ( prod ) REFERENCES dbo.testprods ( prod )
);
GO;

CREATE TRIGGER insteadtrigger ON testloans
INSTEAD OF INSERT 
AS 
BEGIN
    INSERT INTO testprods (
	   prod
    )
    SELECT DISTINCT Inserted.prod
    FROM Inserted
    WHERE prod NOT IN ( SELECT prod FROM testprods)
    ;

    INSERT INTO dbo.testloans
            ( coupon, prod )
    SELECT Inserted.coupon ,
           Inserted.prod
    FROM Inserted
END
