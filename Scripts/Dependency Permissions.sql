--Grants permissions Needed to View Dependencies to a user
GRANT VIEW DEFINITION TO [user]
GRANT SELECT ON [sys].[sql_expression_dependencies] TO [user]
GRANT SELECT ON [sys].[sql_dependencies] TO [user]

--http://dba.stackexchange.com/questions/29385/what-permissions-are-needed-to-view-dependencies