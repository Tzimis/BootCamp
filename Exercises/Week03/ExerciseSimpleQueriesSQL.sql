-- Exercise Simple SQL Queries

-- 1.  Get all columns from the tables Customers, Orders and Suppliers
--select * from Customers;
--select * from Orders;
--select * from Suppliers;

--2. Get all Customers alphabetically, by Country and name
--select * from Customers order by Country, CompanyName;

--3. Get all Orders by date
--select * from Orders order by OrderDate;

--4. Get the count of all Orders made during 1997
--select count(*) as TotalOrders1997 from Orders where OrderDate like '%1997%'
--select count(*) as TotalOrders1997 from Orders where OrderDate between '1997-01-01' and '1997-12-31 23:59:59.499';

--5. Get the names of all the contact persons where the person is a manager, alphabetically
--select ContactName,ContactTitle from Customers 
--where ContactTitle LIKE '%Manager%' Order by ContactName;

--6. Get all orders placed on the 19th of May, 1997
--select * from Orders where OrderDate = '1997-05-19';