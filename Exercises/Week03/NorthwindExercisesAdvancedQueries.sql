--select c.CompanyName, od.OrderID, 
--round(sum(UnitPrice * Quantity),2) [Initial Value],
--round(sum(UnitPrice * Quantity * Discount),2) [Discount Value],
--round(sum(UnitPrice * Quantity * (1 - Discount)),2) [Final Value]
--from [Order Details] od
--join Orders o on o.OrderID = od.OrderID
--join Customers c on c.CustomerID = o.CustomerID
--group by c.CompanyName, od.OrderID;

--SELECT  ISNULL(TE.City, TC.City) Cities, 
--		ISNULL(TE.CntEmployees,0) + ISNULL(TC.CntCustomers,0) CntEntities
--FROM 
--(
--	SELECT City, COUNT(EmployeeID) CntEmployees 
--	FROM Employees
--	GROUP BY City
--) TE
--FULL OUTER JOIN 
--(
--	SELECT City, COUNT(CustomerID) CntCustomers 
--	FROM Customers
--	GROUP BY City
--) TC 
--ON TE.City = TC.City;


----What were our total revenues in 1997 (Result must be 617.085,27)
--select sum(ExtendedPrice) from Invoices
--where Year(OrderDate) = 1997

--select sum(ExtendedPrice) from
--(select * from Orders Where Year(OrderDate) = 1997) o
--join
--(select * from [Order Details Extended]) x on x.OrderID = o.OrderID

--select sum(ProductSales) from [Product Sales for 1997]

----What is the total amount each customer has payed us so far (Hint: QUICK-Stop has payed us 110.277,32)
--SELECT CustomerName, SUM(ExtendedPrice)
--FROM Invoices
--GROUP BY CustomerName

----Find the 10 top selling products (Hint: Top selling product is "Côte de Blaye")
--SELECT TOP 10 ProductName, SUM(ExtendedPrice) 
--FROM [Order Details Extended]
--GROUP BY ProductName 
--ORDER BY SUM(ExtendedPrice) DESC

----Create a view with total revenues per customer
-- DROP VIEW [Total Revenues per Customer]

--CREATE VIEW [Total Revenues per Customer] AS
--SELECT CustomerName, SUM(ExtendedPrice) [Total Revenue]
--FROM Invoices
--GROUP BY CustomerName;

--SELECT * FROM [Total Revenues per Customer] ORDER BY [Total Revenue] DESC


---- Which UK Customers have payed us more than 1000 dollars (6 rows)
--SELECT CustomerName, SUM(ExtendedPrice)
--FROM Invoices
--Where Country = 'UK'
--GROUP BY CustomerName
--HAVING SUM(ExtendedPrice) > 1000;

--How much has each customer payed in total and how much in 1997. We want one result set with the following columns:
--CustomerID, CompanyName, Country, Customer's total from all orders, Customer's total from 1997 orders, 
--You can try this with views, subqueries or temporary tables. Try using [Order Subtotals] view that already exists in database. 

--SELECT C.CustomerID, C.CompanyName, C.Country, ISNULL(T97.[Total 1997],0) [Total 97], ISNULL(TOT.[Total Alltime],0) [Total Alltime]
--FROM
--(
--	SELECT * FROM Customers
--) C
--LEFT JOIN
--(
--	SELECT CustomerID, CustomerName, Country, SUM(ExtendedPrice) [Total Alltime] 
--	FROM Invoices
--	GROUP BY CustomerID, CustomerName, Country
--) TOT
--ON C.CustomerID = TOT.CustomerID
--LEFT JOIN
--(
--	SELECT CustomerName, SUM(ExtendedPrice) [Total 1997] 
--	FROM Invoices
--	WHERE Year(OrderDate) = 1997
--	GROUP BY CustomerName
--) T97
--ON T97.CustomerName = TOT.CustomerName
--ORDER BY C.CompanyName;



----Find the 10 top selling products By Quantity
--SELECT TOP 10 ProductName, SUM(Quantity) 
--FROM [Order Details Extended]
--GROUP BY ProductName 
--ORDER BY SUM(Quantity) DESC

----CREATE VIEW [Product sales / Month]
----AS
--SELECT  od.ProductName, YEAR(o.OrderDate) [Year], MONTH(o.OrderDate) [Month], SUM(Quantity) [Quantity]
--FROM [Order Details Extended] od
--JOIN Orders o ON o.OrderID = od.OrderID
--GROUP BY ProductName, YEAR(o.OrderDate),  MONTH(o.OrderDate);

--select * from Categories

--EXEC [SalesByCategory] 'Beverages', 1998;
 