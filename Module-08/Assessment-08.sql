Review Question 1

(1/1 point)
You write a query to summarize sales revenue by country/region and state/province. The results from your query should match the following rowset structure:

CountryRegion	StateProvince	Revenue
NULL	NULL	Total Revenue
Country/Region 1	NULL	Subtotal for Country/Region 1
Country/Region 1	State/Province A	Subtotal for State/Province A in Country/Region 1
Country/Region 1	State/Province B	Subtotal for State/Province B in Country/Region 1
Country/Region 2	NULL	Subtotal for Country/Region 2
Country/Region 2	State/Province C	Subtotal for State/Province C in Country/Region 2
Country/Region 2	State/Province D	Subtotal for State/Province D in Country/Region 2
You write the following Transact-SQL code:

SELECT c.CountryRegion, c.StateProvince, SUM(o.TotalDue) AS Revenue
FROM Sales.Customers AS c
JOIN Sales.SalesOrder AS o ON o.CustomerID = c.CustomerID
-- GROUP BY clause goes here
ORDER BY c.CountryRegion, c.StateProvince;

Which two of the following GROUP BY clauses will produce the required results?

 GROUP BY ROLLUP (c.CountryRegion, c.StateProvince)

 GROUP BY GROUPING SETS (c.CountryRegion, (c.CountryRegion, c.StateProvince),())


 Review Question 2

(1 point possible)
You write a query that uses a GROUP BY clause with a GROUPING SETS expression to summarize sales revenue by state, city, and store. The results contain many NULL values and it is difficult to determine which revenue totals are generated by which groupings.

What should you do to resolve this problem?

Create a new column containing an expression that uses the GROUPING_ID function to determine which groupings are being used for each row. 


Review Question 3

(1 point possible)
The Sales.SalesOrder header contains a CustomerID column, an OrderDate column, and a SalesAmount column. You want to query this table and generate a rowset that shows the total revenue per customer for each month using the following format:

CustomerID	1	2	3	4	5	6	...	12
Customer 1	January Revenue	February Revenue	March Revenue	April Revenue	May Revenue	June Revenue	...	December Revenue
Customer 2	January Revenue	February Revenue	March Revenue	April Revenue	May Revenue	June Revenue	...	December Revenue
...	...	...	...	...	...	...	...	...
You write the following Transact-SQL query:

SELECT * FROM
(SELECT CustomerID, SalesAmount, MONTH(OrderDate) AS OrderMonth FROM Sales.SalesOrder) AS SalesByMonth
___________________________________________________________________________________
ORDER BY CustomerID;

Select the appropriate code to complete the query.

 
PIVOT(SUM(SalesAmount) FOR OrderMonth IN([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS pvt 
