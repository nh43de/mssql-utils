--Creating Comma Separated List

/* 

The key to creating the comma separated list is the correlated subquery. 
Working from the inside out, we get each value prefixed with a comma, order by the Value. 
The FOR XML PATH('') generates an XML structure, with an empty string as the root node.
Since the field is ',' + Value (an unnamed expression), there is no name for the individual
elements. What is left is a list of values, with each value prefixed with a comma. The TYPE
clause specifies to return the data as an XML type. The .value('.','varchar(max)') takes each 
value, and converts it into a varchar(max) data type. The combination of the TYPE and .value 
means that values are created at XML tags (such as the ampersand (&), and the greater than
(>) and less than (<) signs), will not be tokenized into their XML representations and will
remain as is.

*/

WITH CTE AS(SELECT DISTINCT        AccountNumber  FROM #TestData)SELECT AccountNumber,       CommaList = STUFF((                   SELECT ',' + Value                     FROM #TestData                    WHERE AccountNumber = CTE.AccountNumber                    ORDER BY Value                      FOR XML PATH(''),                               TYPE).value('.','varchar(max)'),1,1,'')  FROM CTE ORDER BY AccountNumber;

--From <http://www.sqlservercentral.com/articles/comma+separated+list/71700/> 