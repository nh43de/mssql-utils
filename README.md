# mssql-utils
A collection of utility scripts for Microsoft SQL Server (MSSQL)


# SQL Server Date formats

From <http://www.sql-server-helper.com/tips/date-formats.aspx> 

# Clustered vs. Nonclustered Indexes
• Clustered
	? Clustered indexes sort and store the data rows in the table or view based on their key values. These are the columns included in the index definition. There can be only one clustered index per table, because the data rows themselves can be sorted in only one order.
	? The only time the data rows in a table are stored in sorted order is when the table contains a clustered index. When a table has a clustered index, the table is called a clustered table. If a table has no clustered index, its data rows are stored in an unordered structure called a heap.
• Nonclustered
	? Nonclustered indexes have a structure separate from the data rows. A nonclustered index contains the nonclustered index key values and each key value entry has a pointer to the data row that contains the key value.
	? The pointer from an index row in a nonclustered index to a data row is called a row locator. The structure of the row locator depends on whether the data pages are stored in a heap or a clustered table. For a heap, a row locator is a pointer to the row. For a clustered table, the row locator is the clustered index key.
	? You can add nonkey columns to the leaf level of the nonclustered index to by-pass existing index key limits, 900 bytes and 16 key columns, and execute fully covered, indexed, queries. For more information, see Create Indexes with Included Columns.

From <https://msdn.microsoft.com/en-gb/library/ms190457.aspx> 

# Db Owners in Production
http://www.insidesql.org/blogs/andreaswolter/2014/06/sql-server-database-ownership-survey-results-recommendations

# Shrink / Empty Files so you can Remove them
DBCC SHRINKFILE (tempdev8, EMPTYFILE);

# Retrieving Random Data from SQL Server with TABLESAMPLE
https://www.mssqltips.com/sqlservertip/1308/retrieving-random-data-from-sql-server-with-tablesample/

# Using GROUP BY with ROLLUP, CUBE, and GROUPING SETS
https://technet.microsoft.com/en-us/library/bb522495(v=sql.105).aspx

# Creating Indexed Views
https://msdn.microsoft.com/en-us/library/ms191432.aspx?f=255&MSPPError=-2147217396

# How to Serialize a large blob into SQL Server
http://stackoverflow.com/questions/2101149/how-to-i-serialize-a-large-graph-of-net-object-into-a-sql-server-blob-without-c/2151491#2151491

# Stream Insert into Table
http://stackoverflow.com/questions/2459762/can-i-use-a-stream-to-insert-or-update-a-row-in-sql-server-c

# Index Fragmentation
SELECT * FROM sys.dm_db_index_physical_stats
https://msdn.microsoft.com/en-us/library/ms189858.aspx?f=255&MSPPError=-2147217396

# Bad Performance due to OrderBy clause
http://stackoverflow.com/questions/2139980/bad-performance-of-sql-query-due-to-order-by-clause

# Tail Log Recovery and Restore
https://msdn.microsoft.com/en-us/library/ms187495.aspx

# List of FK Dependencies
http://sqlblog.com/blogs/jamie_thomson/archive/2009/09/08/deriving-a-list-of-tables-in-dependency-order.aspx

# Dynamic Group By's, Etc. + Performance
http://www.sqlservercentral.com/articles/T-SQL/121906/

# Regex to Remove Whitespace from Qualified column names
(\[.*?)([ \.])([^\[\]\r\n]*?\]) => $1$3

For quoted ID's ^([^'\r\n]+".*?)([ \.])([^"\r\n]*"[^'\r\n]*)$ => $1$3

# RID Lookup Vs. Key Lookup
http://sqlperformance.com/2016/05/sql-indexes/rid-lookup-faster-key-lookup

# Script to Drop All Orphaned Users
https://www.mssqltips.com/sqlservertip/3439/script-to-drop-all-orphaned-sql-server-database-users/

# Where is sys.Functions?
http://stackoverflow.com/questions/468672/sql-server-where-is-sys-functions

# Understanding and Using Parallelism in SQL Server
https://www.simple-talk.com/sql/learn-sql-server/understanding-and-using-parallelism-in-sql-server/

# Getting Identity Inserted Value
• @@IDENTITY returns the last identity value generated for any table in the current session, across all scopes. You need to be careful here, since it's across scopes. You could get a value from a trigger, instead of your current statement.
• SCOPE_IDENTITY() returns the last identity value generated for any table in the current session and the current scope. Generally what you want to use.
• IDENT_CURRENT('tableName') returns the last identity value generated for a specific table in any session and any scope. This lets you specify which table you want the value from, in case the two above aren't quite what you need (very rare). Also, as @Guy Starbuck mentioned, "You could use this if you want to get the current IDENTITY value for a table that you have not inserted a record into."
• The OUTPUT clause of the INSERT statement will let you access every row that was inserted via that statement. Since it's scoped to the specific statement, it's more straightforward than the other functions above. However, it's a little more verbose (you'll need to insert into a table variable/temp table and then query that) and it gives results even in an error scenario where the statement is rolled back. That said, if your query uses a parallel execution plan, this is theonly guaranteed method for getting the identity (short of turning off parallelism). However, it is executed before triggers and cannot be used to return trigger-generated values.

From <http://stackoverflow.com/questions/42648/best-way-to-get-identity-of-inserted-row> 

# Generate Schema DDL

http://stackoverflow.com/questions/6215459/t-sql-query-to-show-table-definition

# Raise Database Error

IF EXISTS (select top 1 1 from [cfg].[LoanPricingScheme])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

# Splitting strings in SQL Server 2016

http://www.sqlservercentral.com/articles/STRING_SPLIT/139338/

# Dedicated Administrator Connection to SQL Server using SQL CMD

sqlcmd -S localhost -U sa -P dev -d master -A

From <http://blog.sqlauthority.com/2009/01/09/sql-server-sqlcmd-using-a-dedicated-administrator-connection-to-kill-currently-running-query/> 

# T-SQL Script DOM

• https://technet.microsoft.com/en-us/library/hh247625(v=sql.110).aspx
• https://msdn.microsoft.com/en-us/library/microsoft.sqlserver.transactsql.scriptdom(v=sql.120).aspx
• http://blogs.msdn.com/b/gertd/archive/2008/08/21/getting-to-the-crown-jewels.aspx
• https://social.msdn.microsoft.com/Forums/sqlserver/en-US/fbcb255f-bcb7-45d8-9991-270a329b3d51/is-there-any-example-documentation-for-microsoftdataschemascriptdom-and-sql?forum=sqlnetfx
• ScriptDom Visualizer - https://the.agilesql.club/blog/Ed-Elliott/2015-11-03/ScriptDom-Visualizer

# Connecting From Another Domain With Windows Credentials

1. Add computer name / ip address to hosts file (%SystemRoot%\System32\drivers\etc\hosts)
2. Add remote credentials using Control Panel -> Credentials manager (be sure to specify port, 1433 for SQL server)
3. Run ipconfig /renew
4. In connection strings, be  sure to specify Server: <servername>,<port>

From <http://www.mssqltips.com/sqlservertip/3250/connect-to-sql-servers-in-another-domain-using-windows-authentication/>

# Detect Changes to a Row Table

BINARY_CHECKSUM ( * | expression [ ,...n ] ) 

Returns the binary checksum value computed over a row of a table or over a list of expressions. BINARY_CHECKSUM can be used to detect changes to a row of a table.

From <https://msdn.microsoft.com/en-us/library/ms173784.aspx> 

# Optimizing the Use of Joins

5. Instead of using NOT IN, we have utilized LEFT OUTER JOIN and IS NULL.
6. There are three columns in the output of the query, however the GROUP BY is applied only on a single column.
7. One important concept of join that is being exploited here. The two subquery Q and Q2 give less number of rows in the output as compared to the main query, but their result gets repeated as the value in key column that is CustomerName is redundant.

From <http://www.sqlservercentral.com/articles/T-SQL/88443/> 

# Concatenate Many Rows into a Single Text String

27 answers - http://stackoverflow.com/questions/194852/concatenate-many-rows-into-a-single-text-string
Or: Use a user defined aggregate function assembly

# String Splitting Performance Guide

http://sqlperformance.com/2012/07/t-sql-queries/split-strings
Pt. II http://sqlperformance.com/2012/08/t-sql-queries/splitting-strings-follow-up

# Sort Varchar Containing Numeric Characters

http://stackoverflow.com/questions/16103133/sort-varchar-datatype-with-numeric-characters

# Cross Apply versus Join

Just checked. master is a table of about 20,000,000 records with a PRIMARY KEY on id.
This query:
WITH    q AS
        (   
          SELECT  *, ROW_NUMBER() OVER (ORDER BY id) AS rn
          FROM    master
        ),   
        t AS 
        (   
          SELECT  1 AS id
          UNION ALL
          SELECT  2  
        )   
SELECT  * 
FROM    t 
JOIN    q 
ON      q.rn <= t.id 

runs for almost 30 seconds, while this one:

WITH    t AS 
        (
          SELECT  1 AS id
          UNION ALL
          SELECT  2
        )
SELECT  *
FROM    t
CROSS APPLY
        (
          SELECT  TOP (t.id) m.*
          FROM    master m
          ORDER BY
                id
        ) q
is instant.


