--BEGIN TRANSACTION

--if NOT EXISTS (Select * from Employees where FirstName = 'George' AND LastName = 'Arvanitakis')

--insert into Employees (LastName, FirstName, Title, TitleOfCourtesy, BirthDate,
--HireDate, [Address], City, PostalCode, Country, HomePhone, Extension, ReportsTo) VALUES
--('Arvanitakis', 'George', 'Software Architect', 'Sir','1978-05-17', 
--'2016-09-30', 'Lykourgou 22', 'Glyfada', '16675', 'Greece', '2109638851', '313', 2);

--IF @@ROWCOUNT = 1 COMMIT ELSE ROLLBACK;

--declare @myId int = SCOPE_IDENTITY();

--declare @myId int = (Select Distinct Employees.EmployeeID from Employees
--where FirstName = 'George' AND LastName = 'Arvanitakis');
--select @myId;

--UPDATE Employees
--SET Region = 'Attica' from Employees where EmployeeID = @myId;



--update Employees
--SET Region = 'Attica' from Employees where Employees.FirstName = 'George' AND Employees.LastName = 'Arvanitakis';

--select EmployeeID from Employees where Employees.FirstName = 'George' AND Employees.LastName = 'Arvanitakis';

--insert into Orders (CustomerID, EmployeeID, OrderDate, RequiredDate)
--values ('ALFKI', (select EmployeeID 
--				  from Employees 
--				  where Employees.FirstName = 'George' 
--				  AND Employees.LastName = 'Arvanitakis'), 
--				  '2016-10-25', '2016-10-31');

--declare @myOrder int = SCOPE_IDENTITY(); 

--select * from Orders where CustomerID = 'ALFKI';

--insert into [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
--values (@myOrder, 10, 31.0, 5, 0),
--	   (@myOrder, 8, 30, 5, 0.25),
--	   (@myOrder, 5, 11.67, 20, 0.5);

--update Employees
--Set HomePhone = '(+30) 210 9638851'
--Where FirstName = 'George' AND LastName = 'Arvanitakis';

--update [Order Details]
--set Quantity = Quantity/2
--from [Order Details] od JOIN Orders o ON o.OrderID = od.OrderID
--JOIN Employees e ON e.EmployeeID = o.EmployeeID
--Where e.FirstName='George' AND e.LastName = 'Arvanitakis';

--update [Order Details]
--set Quantity = 2 * Quantity
--from Orders o
--JOIN [Order Details] od on o.OrderID = od.OrderID
--JOIN Employees e on e.EmployeeID = o.EmployeeID
--where e.FirstName = 'George' AND e.LastName = 'Arvanitakis';




--select * from Orders where OrderID = 11079;

--select p.ProductName [Product], od.Quantity [Quantity], od.Discount*100 [Discount %], od.UnitPrice [Unit Price],
--od.UnitPrice * od.Quantity [Value]
--from [Order Details] od
--JOIN Products p ON p.ProductID = od.ProductID
--where OrderID = 11079;

--DELETE from [Order Details] where OrderID = 11080;
--DELETE from Orders where OrderID = 11080;
--DELETE from Employees where FirstName = 'George' AND LastName = 'Arvanitakis';

select * from Employees;