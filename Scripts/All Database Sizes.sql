--view all database sizes
--source: https://stackoverflow.com/questions/5945360/sql-server-2008-how-to-query-all-databases-sizes

SELECT
    [D].[name],
    [SizeInBytes] = CAST(SUM([F].[size]) AS BIGINT) * 8 * 1024,
    [SizeInGB] = CAST(SUM([F].[size] * 8.0) / 1024 / 1024 AS DECIMAL(18, 3))
FROM [sys].[master_files] AS [F]
    INNER JOIN [sys].[databases] AS [D]
        ON [D].[database_id] = [F].[database_id]
GROUP BY [D].[name]
ORDER BY [SizeInBytes] DESC;