--Unique Constraints where Columns are not NULL

CREATE UNIQUE INDEX foo ON dbo.bar(key) WHERE key IS NOT NULL;

--From <http://dba.stackexchange.com/questions/80514/why-does-a-unique-constraint-allow-only-one-null> 
