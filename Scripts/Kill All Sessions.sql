--Kill All Sessions

DECLARE @dbName SYSNAME
DECLARE @sqlCmd VARCHAR(MAX)


SET @sqlCmd = ''
SET @dbName =  DB_NAME(); --'StaticPool_Pegasus';

with sessions1 as (
	select
		distinct l.request_session_id session_id
	from sys.dm_tran_locks l
	left join sys.dm_exec_requests r
	on l.request_session_id = r.session_id
	left join sys.dm_exec_sessions s
	on l.request_session_id = s.session_id
	left join sys.dm_exec_connections c
	on s.session_id = c.session_id
	outer apply sys.dm_exec_sql_text(r.sql_handle) st
	outer apply sys.dm_exec_sql_text(c.most_recent_sql_handle) stc
	where l.resource_database_id = db_id(@dbName)
)
SELECT   @sqlCmd = @sqlCmd + 'KILL ' + CAST(session_id AS VARCHAR) +
         CHAR(13)
from sessions1
 
PRINT @sqlCmd
