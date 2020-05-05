WITH data AS (
	SELECT  [b].[backup_set_id] ,
			[b].[backup_set_uuid] ,
			[b].[name] AS [bname] ,
			[b].[server_name] ,
			[b].[database_name] ,
			[b].[position] ,
			[b].[first_lsn] ,
			[b].[last_lsn] ,
			[b].[checkpoint_lsn] ,
			[b].[database_backup_lsn] ,
			[b].[backup_start_date] ,
			[b].[backup_finish_date] ,
			[b].[backup_size] / 1024 / 1024 backup_size,
            [b].[compressed_backup_size] / 1024 / 1024 compressed_backup_size,
			[b].[user_name] ,
			[b].[machine_name] ,
			[b].[expiration_date] ,
			[b].[media_set_id] ,
			[b].[differential_base_guid] ,
			[b].[description] AS [bdescription] ,
			[b].[type] ,
			[m].[description] AS [mdescription] ,
			[m].[name] AS [mname] ,
			[f].[logical_device_name] ,
			[f].[physical_device_name] ,
			[f].[device_type] ,
			[f].[family_sequence_number] ,
			[f].[mirror] AS [mirror] ,
			[b].[is_copy_only] AS [IsCopyOnly] ,
			DATEDIFF(DAY, [b].[backup_start_date], GETDATE())  AgeDays
	FROM    [dbo].[backupset] [b]
			INNER JOIN [dbo].[backupmediaset] [m]
				ON [b].[media_set_id] = [m].[media_set_id]
			INNER JOIN [dbo].[backupmediafamily] [f]
				ON [m].[media_set_id] = [f].[media_set_id]
)
SELECT  
        [data].[database_name] DbName ,
        [data].[backup_set_id] BackupSetId,
        [data].[physical_device_name] FilePath,
		[data].[type] BackupType,
		[data].[backup_start_date] BackupStartDate,
        [data].[compressed_backup_size] CompressedBackupSizeMb,
        [data].[backup_size] BackupSizeMb,
        [data].[server_name] OriginalLocation
FROM [data]
WHERE [database_name] = 'myDatabase'
ORDER BY [backup_finish_date] DESC;
