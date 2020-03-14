--List Recently Run Queries
SELECT TOP 50 *
FROM
(
    SELECT [ProcName] = COALESCE(OBJECT_NAME([s2].[objectid]), 'Ad-Hoc'),
           [execution_count],
           [s2].[objectid],
           [sql_statement] =
           (
               SELECT TOP 1
                      SUBSTRING(
                                   [s2].[text],
                                   [statement_start_offset] / 2 + 1,
                                   ((CASE
                                         WHEN [statement_end_offset] = -1 THEN
                                   (LEN(CONVERT(NVARCHAR(MAX), [s2].[text])) * 2)
                                         ELSE
                                             [statement_end_offset]
                                     END
                                    ) - [statement_start_offset]
                                   ) / 2 + 1
                               )
           ),
           [last_execution_time]
    FROM [sys].[dm_exec_query_stats] AS [s1]
        CROSS APPLY [sys].[dm_exec_sql_text]([sql_handle]) AS [s2]
) [x]
WHERE [sql_statement] NOT LIKE 'SELECT TOP 50 * FROM(SELECT %'
--and OBJECTPROPERTYEX(x.objectid,'IsProcedure') = 1
ORDER BY [last_execution_time] DESC;

--From <http://stackoverflow.com/questions/3579092/tsql-get-last-queries-ran> 