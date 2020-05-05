SET TRAN ISOLATION LEVEL READ UNCOMMITTED;

--this is the fastest way - about 30 minutes

--take unmatched records from source into new table
SELECT *
INTO [__remainingRecords]
FROM [dbo].[_MarketData] AS [md]
WHERE NOT EXISTS (
    SELECT 1
    FROM [dbo].[MarketData] AS [md2]
    WHERE [md2].[RecordDateTimeUtc] = [md].[RecordDateTimeUtc]
          AND [md2].[Exchange] = [md].[Exchange]
          AND [md2].[Ticker] = [md].[Ticker]
);

--insert remaining records into destination table
INSERT INTO [dbo].[MarketData]
(
    [RecordDateTimeUtc],
    [Exchange],
    [Ticker],
    [NormalizedTicker],
    [BaseVolume],
    [QuoteVolume],
    [Ask],
    [Bid]
)
SELECT
    [rr].[RecordDateTimeUtc],
    [rr].[Exchange],
    [rr].[Ticker],
    [rr].[BaseVolume],
    [rr].[QuoteVolume],
    [rr].[Price],
    [rr].[Ask],
    [rr].[Bid]
FROM [dbo].[__remainingRecords] AS [rr];

--then drop source table
DROP TABLE [dbo].[_MarketData];
DROP TABLE [dbo].[__remainingRecords];