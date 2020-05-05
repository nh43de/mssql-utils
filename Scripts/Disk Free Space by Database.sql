--view free disk space by database
--from https://blog.sqlauthority.com/2013/08/02/sql-server-disk-space-monitoring-detecting-low-disk-space-on-server/

SELECT DISTINCT
       [DBName] = DB_NAME([dovs].[database_id]),
       [LogicalName] = [dovs].[logical_volume_name],
       [Drive] = [dovs].[volume_mount_point],
       [FreeSpaceInMB] = CONVERT(INT, [dovs].[available_bytes] / 1048576.0)
FROM [sys].[master_files] AS [mf]
    CROSS APPLY [sys].[dm_os_volume_stats]([mf].[database_id], [mf].[FILE_ID]) AS [dovs]
ORDER BY [FreeSpaceInMB] ASC;
GO