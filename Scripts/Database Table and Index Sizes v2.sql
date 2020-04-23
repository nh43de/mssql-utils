--DB Tables Sizes v2
;WITH [SpaceInfo] ([ObjectId], [IndexId], [TableName], [IndexName], [Rows], [TotalSpaceMB], [UsedSpaceMB])
AS (SELECT [ObjectId] = [t].[object_id],
           [IndexId] = [i].[index_id],
           [TableName] = [s].[name] + '.' + [t].[name],
           [Index Name] = [i].[name],
           [Rows] = SUM([p].[rows]),
           [Total Space MB] = SUM([au].[total_pages]) * 8 / 1024,
           [Used Space MB] = SUM([au].[used_pages]) * 8 / 1024
    FROM [sys].[tables] [t] WITH (NOLOCK)
        JOIN [sys].[schemas] [s] WITH (NOLOCK)
            ON [s].[schema_id] = [t].[schema_id]
        JOIN [sys].[indexes] [i] WITH (NOLOCK)
            ON [t].[object_id] = [i].[object_id]
        JOIN [sys].[partitions] [p] WITH (NOLOCK)
            ON [i].[object_id] = [p].[object_id]
               AND [i].[index_id] = [p].[index_id]
        CROSS APPLY
    (
        SELECT [total_pages] = SUM([a].[total_pages]),
               [used_pages] = SUM([a].[used_pages])
        FROM [sys].[allocation_units] [a] WITH (NOLOCK)
        WHERE [p].[partition_id] = [a].[container_id]
    ) [au]
    WHERE [i].[object_id] > 255
    GROUP BY [t].[object_id],
             [i].[index_id],
             [s].[name],
             [t].[name],
             [i].[name])
SELECT [ObjectId],
       [IndexId],
       [TableName],
       [IndexName],
       [Rows],
       [TotalSpaceMB],
       [UsedSpaceMB],
       [ReservedSpaceMB] = [TotalSpaceMB] - [UsedSpaceMB]
FROM [SpaceInfo]
ORDER BY [TotalSpaceMB] DESC
OPTION (RECOMPILE);

--From <http://aboutsqlserver.com/2014/12/02/size-does-matter-10-ways-to-reduce-the-database-size-and-improve-performance-in-sql-server/> 
