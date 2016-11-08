--SELECT c.CompanyName, count(o.OrderID) AS TotalOrders
--FROM Customers c 
--LEFT JOIN Orders o on o.CustomerID = c.CustomerID
----LEFT JOIN [Order Details] od on od.OrderID = o.OrderID
----Where c.Country = 'UK'
--GROUP BY c.CompanyName
--HAVING count(o.OrderID) = 0
--ORDER BY c.CompanyName;

---- Orders / Client, UK 1997
--SELECT c.CompanyName, count(o.OrderID) AS [Orders in 1997]
--FROM Customers c 
--LEFT JOIN Orders o on o.CustomerID = c.CustomerID
--WHERE c.Country = 'UK' AND YEAR(o.OrderDate) = 1997
--GROUP BY c.CompanyName
--ORDER BY c.CompanyName;

---- Revenue / Client, UK 1997
--SELECT c.CompanyName [Company (UK)], COUNT(DISTINCT o.OrderID) AS [Orders 1997], 
--SUM(od.Quantity * od.UnitPrice) as [Revenue 1997]
--FROM Customers c 
--LEFT JOIN Orders o on o.CustomerID = c.CustomerID
--LEFT JOIN [Order Details] od on od.OrderID = o.OrderID
--WHERE c.Country = 'UK' AND YEAR(o.OrderDate) = 1997
--GROUP BY c.CompanyName
--ORDER BY c.CompanyName;


---- Average Items / Order / Client
--select t.CompanyName, COUNT(t.OrderID) [Total Orders], AVG(CAST(t.Items AS DECIMAL)) [Avg.items/Order] from (
--SELECT c.CompanyName, o. OrderDate, o.OrderID, COUNT(od.ProductID) Items
--FROM Customers c 
--LEFT JOIN Orders o on o.CustomerID = c.CustomerID
--LEFT JOIN [Order Details] od on od.OrderID = o.OrderID
--GROUP BY c.CompanyName, o.OrderDate, o.OrderID
----ORDER BY c.CompanyName
--) t
--group by t.CompanyName


-- Average Order value / client 
SELECT t.CompanyName, count(t.OrderID) [No of Orders], avg(t.OrderValue) [Average Value], sum(t.OrderValue) [Total Value] from 
(SELECT c.CompanyName, o. OrderDate, o.OrderID, SUM(od.Quantity * od.UnitPrice) OrderValue
FROM Customers c 
LEFT JOIN Orders o on o.CustomerID = c.CustomerID
LEFT JOIN [Order Details] od on od.OrderID = o.OrderID
GROUP BY c.CompanyName, o.OrderDate, o.OrderID
) t
GROUP BY t.CompanyName