--View Database Sizes
SELECT [Type] = [f].[type_desc],
       [FileName] = [f].[name],
       [FileGroup] = [fg].[name],
       [Path] = [f].[physical_name],
       [CurrentSizeMB] = [f].[size] / 128.0,
       [FreeSpaceMb] = [f].[size] / 128.0 - CONVERT(INT, FILEPROPERTY([f].[name], 'SpaceUsed')) / 128.0
FROM [sys].[database_files] [f] WITH (NOLOCK)
    LEFT OUTER JOIN [sys].[filegroups] [fg] WITH (NOLOCK)
        ON [f].[data_space_id] = [fg].[data_space_id]
OPTION (RECOMPILE);

--From <http://aboutsqlserver.com/2014/12/02/size-does-matter-10-ways-to-reduce-the-database-size-and-improve-performance-in-sql-server/> 