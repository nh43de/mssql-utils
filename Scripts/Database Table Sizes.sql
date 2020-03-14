--aDB Table Sizes
SELECT  OBJECT_NAME([ddps].[object_id]) ,
        [ddps].[in_row_used_page_count] * 8 / 1024
FROM    [sys].[dm_db_partition_stats] AS [ddps]
        LEFT JOIN [sys].[indexes] AS [i]
            ON [i].[object_id] = [ddps].[object_id]
               AND [i].[index_id] = [ddps].[index_id]
WHERE   ( [i].[type] = 0
          OR ( [i].[type] = 1 )
        )
        AND [i].[object_id] NOT IN ( SELECT   [o].[object_id]
                                   FROM     [sys].[objects] AS [o]
                                   WHERE    [o].[is_ms_shipped] = 1 )
ORDER BY 2;