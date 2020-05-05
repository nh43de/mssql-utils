USE [CryptoData];
GO

SET TRAN ISOLATION LEVEL READ UNCOMMITTED;

SET NOCOUNT ON;

DECLARE @ii BIGINT = 1;

WHILE @ii > 0
BEGIN

	SET @ii = 0;

    DECLARE @RecordDateTimeUtc DATETIME2(7);
    DECLARE @Exchange NVARCHAR(450);
    DECLARE @Ticker NVARCHAR(450);
    DECLARE @BaseVolume FLOAT;
    DECLARE @QuoteVolume FLOAT;
    DECLARE @Ask FLOAT;
    DECLARE @Bid FLOAT;

    DECLARE [myCursor] CURSOR GLOBAL FAST_FORWARD READ_ONLY FOR(
        SELECT TOP 10
               [md].[RecordDateTimeUtc],
               [md].[Exchange],
               [md].[Ticker],
               [md].[BaseVolume],
               [md].[QuoteVolume],
               [md].[Ask],
               [md].[Bid]
        FROM [dbo].[_MarketData] AS [md]
        WHERE NOT EXISTS (
            SELECT 1
            FROM [dbo].[MarketData] AS [md2]
            WHERE [md2].[RecordDateTimeUtc] = [md].[RecordDateTimeUtc]
                  AND [md2].[Exchange] = [md].[Exchange]
                  AND [md2].[Ticker] = [md].[Ticker]
        ));

    OPEN [myCursor];

    FETCH NEXT FROM [myCursor]
    INTO
        @RecordDateTimeUtc,
        @Exchange,
        @Ticker,
        @BaseVolume,
        @QuoteVolume,
        @Ask,
        @Bid;


    WHILE @@FETCH_STATUS = 0
    BEGIN
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
        VALUES
        (@RecordDateTimeUtc, @Exchange, @Ticker, NULL, @BaseVolume, @QuoteVolume, @Ask, @Bid);

        DELETE FROM [dbo].[_MarketData]
        WHERE [RecordDateTimeUtc] = @RecordDateTimeUtc
              AND [Exchange] = @Exchange
              AND [Ticker] = @Ticker;

        FETCH NEXT FROM [myCursor]
        INTO
            @RecordDateTimeUtc,
            @Exchange,
            @Ticker,
            @BaseVolume,
            @QuoteVolume,
            @Ask,
            @Bid;

        SET @ii = @ii + 1;

        IF (@ii % 2048 = 0)
            PRINT ('Migrated ' + CAST(@ii AS NVARCHAR(100)) + ' rows');

    END;

    PRINT ('Done. Migrated ' + CAST(@ii AS NVARCHAR(100)) + ' rows');

    CLOSE [myCursor];
    DEALLOCATE [myCursor];

END;
