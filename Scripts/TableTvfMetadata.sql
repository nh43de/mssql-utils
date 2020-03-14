--Returns Table / TVF Metadata
SELECT [so].[name],
       [sc].[name],
       [st].[name],
       [sc].[length]
FROM [sysobjects] [so]
    JOIN [syscolumns] [sc]
        ON [sc].[id] = [so].[id]
    JOIN [systypes] [st]
        ON [st].[xtype] = [sc].[xtype]
ORDER BY 1,[colid]