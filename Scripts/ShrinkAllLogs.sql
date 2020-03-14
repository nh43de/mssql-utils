--shrink all database log files
EXEC [sys].[sp_MSforeachdb] N'
	USE [?];
	PRINT ''?'';

	DECLARE @logFile VARCHAR(100)

	SELECT @logFile = [name] FROM [sys].[database_files] AS [df] WHERE [df].[type_desc] = ''LOG''
	
	DBCC SHRINKFILE (@logFile , 0, TRUNCATEONLY)
';