--Index Usage Stats
SELECT [Table] = [s].[name] + N'.' + [t].[name],
       [Index] = [i].[name],
       [IsUnique] = [i].[is_unique],
       [Seeks] = [ius].[user_seeks],
       [Scans] = [ius].[user_scans],
       [Lookups] = [ius].[user_lookups],
       [Reads] = [ius].[user_seeks] + [ius].[user_scans] + [ius].[user_lookups],
       [Updates] = [ius].[user_updates],
       [Last Seek] = [ius].[last_user_seek],
       [Last Scan] = [ius].[last_user_scan],
       [Last Lookup] = [ius].[last_user_lookup],
       [Last Update] = [ius].[last_user_update]
FROM [sys].[tables] [t] WITH (NOLOCK)
    JOIN [sys].[indexes] [i] WITH (NOLOCK)
        ON [t].[object_id] = [i].[object_id]
    JOIN [sys].[schemas] [s] WITH (NOLOCK)
        ON [t].[schema_id] = [s].[schema_id]
    LEFT OUTER JOIN [sys].[dm_db_index_usage_stats] [ius]
        ON [ius].[database_id] = DB_ID()
           AND [ius].[object_id] = [i].[object_id]
           AND [ius].[index_id] = [i].[index_id]
ORDER BY [s].[name],
         [t].[name],
         [i].[index_id]
OPTION (RECOMPILE);
