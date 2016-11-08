--select c.CompanyName, o.OrderID 
--FROM Orders o JOIN Customers c 
--ON c.CustomerID = o.CustomerID
--WHERE YEAR(o.OrderDate) = 1996;

--select City, COUNT(EmployeeID) from Employees
--GROUP BY City;

--select e.City [Empl.City], c.City [Cust.City], COUNT(distinct e.EmployeeID) [Employee#], COUNT(distinct c.CustomerID) [Employee#] from Employees e
--LEFT JOIN Customers c on c.City  = e.City
--GROUP BY e.City, c.City;

--select e.City [Empl.City], c.City [Cust.City], COUNT(distinct e.EmployeeID) [Employee#], COUNT(distinct c.CustomerID) [Employee#] from Employees e
--RIGHT JOIN Customers c on c.City  = e.City
--GROUP BY e.City, c.City;

--select e.City [Empl.City], c.City [Cust.City], COUNT(distinct e.EmployeeID) [Employee#], COUNT(distinct c.CustomerID) [Employee#] from Employees e
--FULL JOIN Customers c on c.City  = e.City
--GROUP BY e.City, c.City;

--select e.EmployeeID empolyees,
--	   c.CustomerID companies,
--	   e.City as EmpCity,
--	   c.City as comCity
--from Employees e
--INNER JOIN Customers c on c.City  = e.City
--GROUP BY e.EmployeeID, c.CustomerID, e.City, c.City;

--SELECT COALESCE(e.City, c.City) AS [Cities], 
--COUNT(DISTINCT e.EmployeeID) + COUNT(DISTINCT c.CustomerID) AS [Cust + Empl]
--FROM Employees e FULL OUTER JOIN Customers c ON  e.City = c.City
--GROUP BY e.City, c.City ORDER BY [Cities];

--SELECT isnull(e.City, c.City) AS [Cities], 
--COUNT(DISTINCT e.EmployeeID) + COUNT(DISTINCT c.CustomerID) AS [Cust + Empl]
--FROM Employees e FULL OUTER JOIN Customers c ON  e.City = c.City
--GROUP BY isnull(e.City, c.City) ORDER BY [Cities];

---- HAVING Exercise
--select o.OrderID, e.LastName, e.FirstName from Orders o
--JOIN Employees e on e.EmployeeID = o.EmployeeID
--WHERE o.ShippedDate > o.RequiredDate;

--Select ProductID, SUM(Quantity)
--FROM [Order Details]
--GROUP BY ProductID
--HAVING SUM(Quantity) < 200;

--SELECT c.CompanyName, COUNT(o.OrderID) 
--FROM Customers c JOIN Orders o ON o.CustomerID = c.CustomerID
--WHERE o.OrderDate > '1996-12-31'
--GROUP BY c.CompanyName
--HAVING COUNT(o.OrderID) > 15
--Order by COUNT(o.OrderID) desc;

 


--SELECT CompanyName
--FROM Customers
--WHERE CustomerID IN (SELECT CustomerID
--            FROM Orders
--            WHERE OrderDate BETWEEN '1997-01-01' AND '1997-12-31');


select * from [Discontinued Product List];
