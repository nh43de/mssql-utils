--Max of Values
SELECT o.OrderId,       (SELECT MAX(Price)        FROM (VALUES (o.NegotiatedPrice),(o.SuggestedPrice)) AS AllPrices(Price))FROM Order o

--From <http://stackoverflow.com/questions/124417/is-there-a-max-function-in-sql-server-that-takes-two-values-like-math-max-in-ne> 
