--View index Fragmentation Details for a table
SELECT *
FROM [sys].[dm_db_index_physical_stats]
	(DB_ID(), OBJECT_ID('[dbo].[table]'), 1, 1, NULL);