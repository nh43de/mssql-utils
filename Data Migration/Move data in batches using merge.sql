--almost identical performance

--about 6 hours

SET NOCOUNT ON;

SET TRAN ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @ii BIGINT = 1;
DECLARE @tt BIGINT = 0;

DECLARE @startTime DATETIME = GETDATE();

WHILE @ii > 0
BEGIN
	MERGE TOP (255) INTO [dbo].[_MarketData]
	USING [dbo].[MarketData] AS [md2]
		ON ([md2].[RecordDateTimeUtc] = [_MarketData].[RecordDateTimeUtc]
              AND [md2].[Exchange] = [_MarketData].[Exchange]
              AND [md2].[Ticker] = [_MarketData].[Ticker])
	WHEN MATCHED
		THEN DELETE
	;

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