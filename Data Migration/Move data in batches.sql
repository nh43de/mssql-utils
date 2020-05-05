SET NOCOUNT ON;

SET TRAN ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @ii BIGINT = 1;
DECLARE @tt BIGINT = 0;

DECLARE @startTime DATETIME = GETDATE();

WHILE @ii > 0
BEGIN
    DELETE TOP (155) --tune this number
    FROM [dbo].[_MarketData]
    WHERE EXISTS (
        SELECT 1
        FROM [dbo].[MarketData] AS [md2]
        WHERE [md2].[RecordDateTimeUtc] = [_MarketData].[RecordDateTimeUtc]
              AND [md2].[Exchange] = [_MarketData].[Exchange]
              AND [md2].[Ticker] = [_MarketData].[Ticker]
    );

    SELECT @ii = @@ROWCOUNT;

    SET @tt = @tt + @ii;

	PRINT ('Done. Deleted ' + CAST(@ii AS NVARCHAR(100)) + ' rows, ' + CAST(@tt AS NVARCHAR(100)) + ' cumulative, ' + CAST(CAST(@tt AS FLOAT) / NULLIF(DATEDIFF(SECOND, @startTime, GETDATE()), 0) AS NVARCHAR(100)) + ' rps');

END;


--SELECT COUNT(*)
--FROM [dbo].[_MarketData] AS [md]
--WHERE EXISTS (
--    SELECT 1
--    FROM [dbo].[MarketData] AS [md2]
--    WHERE [md2].[RecordDateTimeUtc] = [md].[RecordDateTimeUtc]
--          AND [md2].[Exchange] = [md].[Exchange]
--          AND [md2].[Ticker] = [md].[Ticker]
--);