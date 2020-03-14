--Create Check Constraints

ALTER TABLE dbo.Vendors ADD CONSTRAINT CK_Vendor_CreditRating    CHECK (CreditRating >= 1 AND CreditRating <= 5);

--From <https://technet.microsoft.com/en-us/library/ms179491(v=sql.105).aspx> 