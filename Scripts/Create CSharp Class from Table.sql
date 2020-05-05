--Create CSharp Class from Table
--source: https://stackoverflow.com/questions/5873170/generate-class-from-database-table

DECLARE @TableName sysname = 'MyTable';
DECLARE @Result VARCHAR(MAX) = 'public class ' + @TableName + '
{';

SELECT @Result = @Result + '
    public '     + [t].[ColumnType] + [t].[NullableSign] + ' ' + [t].[ColumnName] + ' { get; set; }
'
FROM (
    SELECT
        [ColumnName] = REPLACE([col].[name], ' ', '_'),
        [ColumnId] = [col].[column_id],
        [ColumnType] = CASE [typ].[name]
                           WHEN 'bigint' THEN
                               'long'
                           WHEN 'binary' THEN
                               'byte[]'
                           WHEN 'bit' THEN
                               'bool'
                           WHEN 'char' THEN
                               'string'
                           WHEN 'date' THEN
                               'DateTime'
                           WHEN 'datetime' THEN
                               'DateTime'
                           WHEN 'datetime2' THEN
                               'DateTime'
                           WHEN 'datetimeoffset' THEN
                               'DateTimeOffset'
                           WHEN 'decimal' THEN
                               'decimal'
                           WHEN 'float' THEN
                               'double'
                           WHEN 'image' THEN
                               'byte[]'
                           WHEN 'int' THEN
                               'int'
                           WHEN 'money' THEN
                               'decimal'
                           WHEN 'nchar' THEN
                               'string'
                           WHEN 'ntext' THEN
                               'string'
                           WHEN 'numeric' THEN
                               'decimal'
                           WHEN 'nvarchar' THEN
                               'string'
                           WHEN 'real' THEN
                               'float'
                           WHEN 'smalldatetime' THEN
                               'DateTime'
                           WHEN 'smallint' THEN
                               'short'
                           WHEN 'smallmoney' THEN
                               'decimal'
                           WHEN 'text' THEN
                               'string'
                           WHEN 'time' THEN
                               'TimeSpan'
                           WHEN 'timestamp' THEN
                               'long'
                           WHEN 'tinyint' THEN
                               'byte'
                           WHEN 'uniqueidentifier' THEN
                               'Guid'
                           WHEN 'varbinary' THEN
                               'byte[]'
                           WHEN 'varchar' THEN
                               'string'
                           ELSE
                               'UNKNOWN_' + [typ].[name]
                       END,
        [NullableSign] = CASE
                             WHEN [col].[is_nullable] = 1
                                  AND [typ].[name] IN ( 'bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier' ) THEN
                                 '?'
                             ELSE
                                 ''
                         END
    FROM [sys].[columns] AS [col]
        JOIN [sys].[types] AS [typ]
            ON [col].[system_type_id] = [typ].[system_type_id]
               AND [col].[user_type_id] = [typ].[user_type_id]
    WHERE [col].[object_id] = OBJECT_ID(@TableName)
) AS [t]
ORDER BY [t].[ColumnId];

SET @Result = @Result + '
}';

PRINT @Result;