--Cursors

SET NOCOUNT ON;
 
DECLARE @vendor_id int, @vendor_name nvarchar(50),
    @message varchar(80), @product nvarchar(50);
 
PRINT '-------- Vendor Products Report --------';
 
DECLARE vendor_cursor CURSOR FOR 
SELECT VendorID, Name
FROM Purchasing.Vendor
WHERE PreferredVendorStatus = 1
ORDER BY VendorID;
 
OPEN vendor_cursor
 
FETCH NEXT FROM vendor_cursor 
INTO @vendor_id, @vendor_name
 
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT ' '
    SELECT @message = 'Vendor: ' + @vendor_name
 
    PRINT @message
    -- Get the next vendor.
    FETCH NEXT FROM vendor_cursor 
    INTO @vendor_id, @vendor_name
END 
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;

--From <https://msdn.microsoft.com/en-us/library/ms180169.aspx> 
