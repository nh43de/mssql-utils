--Redundant Indexes
SELECT [Table] = [s].[name] + N'.' + [t].[name],
       [Index1 ID] = [i1].[index_id],
       [Index1 Name] = [i1].[name],
       [Index2 ID] = [dupIdx].[index_id],
       [Index2 Name] = [dupIdx].[name],
       [Column] = [c].[name]
FROM [sys].[tables] [t]
    JOIN [sys].[indexes] [i1]
        ON [t].[object_id] = [i1].[object_id]
    JOIN [sys].[index_columns] [ic1]
        ON [ic1].[object_id] = [i1].[object_id]
           AND [ic1].[index_id] = [i1].[index_id]
           AND [ic1].[index_column_id] = 1
    JOIN [sys].[columns] [c]
        ON [c].[object_id] = [ic1].[object_id]
           AND [c].[column_id] = [ic1].[column_id]
    JOIN [sys].[schemas] [s]
        ON [t].[schema_id] = [s].[schema_id]
    CROSS APPLY
(
    SELECT [i2].[index_id],
           [i2].[name]
    FROM [sys].[indexes] [i2]
        JOIN [sys].[index_columns] [ic2]
            ON [ic2].[object_id] = [i2].[object_id]
               AND [ic2].[index_id] = [i2].[index_id]
               AND [ic2].[index_column_id] = 1
    WHERE [i2].[object_id] = [i1].[object_id]
          AND [i2].[index_id] > [i1].[index_id]
          AND [ic2].[column_id] = [ic1].[column_id]
) [dupIdx]
ORDER BY [s].[name],
         [t].[name],
         [i1].[index_id];
