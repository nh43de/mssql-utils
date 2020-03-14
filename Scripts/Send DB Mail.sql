--Send DB Mail
use msdb

exec sp_send_dbmail
	@profile_name = '',
	@recipients = '',
	@from_address= '',
	@subject = '',
	@body = ''
