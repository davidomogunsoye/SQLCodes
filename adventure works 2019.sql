/* (43) return the businessentityid,firstname and lastname columns of all persons in the person table (derived table) 
with persontype is 'IN' and the last name is 'Adams'. Sort the result set in ascending order on firstname. 
A SELECT statement after the FROM clause is a derived table.*/

Select BusinessEntityID, firstname, lastname
from (
	Select *
	from AdventureWorks2019.Person.Person p
	where p.PersonType = 'IN' 
	and p.LastName = 'Adams'
	) as subtable
order by FirstName

/* (42) find the employee's full name (firstname and lastname) and city from the following tables. 
Order the result set on lastname then by firstname. */

select concat(p.FirstName,' ',p.LastName) fullname, City
from AdventureWorks2019.Person.Person p
	inner Join AdventureWorks2019.HumanResources.Employee e
	on p.BusinessEntityID = e.BusinessEntityID 
	inner join AdventureWorks2019.Person.BusinessEntityAddress b
	on p.BusinessEntityID = b.BusinessEntityID
	inner join AdventureWorks2019.Person.Address a
	on a.AddressID = b.AddressID
order by LastName, FirstName

/* (41) write a SQL query to retrieve the territory name and BusinessEntityID. The result set includes all salespeople, 
regardless of whether or not they are assigned a territory. */

select t.name, BusinessEntityID
from AdventureWorks2019.sales.SalesTerritory t
Right outer join AdventureWorks2019.sales.SalesPerson s
on t.TerritoryID = s.TerritoryID;

/* (40) write a SQL query to get all product names and sales order IDs. Order the result set on product name column.*/

select name, SalesOrderID
from AdventureWorks2019.Production.Product p
inner join AdventureWorks2019.Sales.SalesOrderDetail s
on p.ProductID = s.ProductID
order by Name;

/* (39) From the following table write a SQL query to retrieve the product name and salesorderid. 
Both ordered and unordered products are included in the result set. */

select name, SalesOrderID
from AdventureWorks2019.Production.Product p
inner join AdventureWorks2019.Sales.SalesOrderDetail s
on p.ProductID = s.ProductID
order by Name;

/* (38) Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. 
Additionally, it returns any sales orders that don't have any items mentioned in the Product table as well as any products 
that have sales orders other than those that are listed there. Return product name, salesorderid. Sort the result set on product name column. */

Select Name, SalesOrderID
from AdventureWorks2019.Production.Product p
full outer join AdventureWorks2019.Sales.SalesOrderDetail s
on p.ProductID = s.ProductID
order by Name;

/* (37) write a query in to list all the products that are Red or Blue in color. 
Return name, color and listprice.Sorts this result by the column listprice. */

select name, Color, ListPrice
from [AdventureWorks2019].Production.Product
where color = 'Blue' 
or color = 'Red'
order by ListPrice;

/* (36) write a query in SQL to return the departmentiD, Name and groupname from the HR Dept table, order by departmentId,
skip the first 5 rows and return the next 5 rows from the sorted result set */

Select d.departmentID, d.name, d.groupname
from AdventureWorks2019.HumanResources.Department d
order by departmentID 
	offset 5 Rows
	Fetch Next 5 Rows Only;
	
--Read More about OFFSET FETCH Here: https://www.sqlservertutorial.net/sql-server-basics/sql-server-offset-fetch/

/* (35) write a query in SQL to return the departmentiD, Name and groupname from the HR Dept table, order by departmentId, 
skip the first 10 rows from the sorted result set and return all remaining rows */

Select d.departmentID, d.name, d.groupname
from AdventureWorks2019.HumanResources.Department d
order by departmentID offset 10 Rows;

/* (34) write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. 
Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. 
Order the output on postalcode column.*/

select FirstName, LastName, 
		ROW_NUMBER () OVER(order by PostalCode) rowNum, 
		RANK() OVER(order by PostalCode) Rank, 
		DENSE_RANK () OVER(order by PostalCode) DensErANK, 
		NTILE(4) OVER(order by PostalCode) Quartile,
		s.SalesYTD, a.PostalCode
from AdventureWorks2019.Sales.SalesPerson s
inner Join AdventureWorks2019.Person.Person p
	on s.BusinessEntityID = p.BusinessEntityID
Inner Join AdventureWorks2019.Person.Address a
	On a.AddressID = s.BusinessEntityID
where TerritoryID is not null and SalesYTD <> 0;

/* (33) write a query in SQL to set the result in order by the column TerritoryName when the column CountryRegionName is equal to 'United States' 
and by CountryRegionName for all other rows. Return Business Entity ID, lastname, territoryname, countryregion name */


select BusinessEntityID, LastName, TerritoryName, CountryRegionName
from [AdventureWorks2019].Sales.vSalesPerson
order by case when CountryRegionName = 'United States' then TerritoryName else CountryRegionName end;

/* (32) write a query in SQL to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and 
BusinessEntityID in ascending order when SalariedFlag set to 'false'. Return BusinessEntityID, SalariedFlag columns. */

select BusinessEntityID, SalariedFlag
from AdventureWorks2019.HumanResources.Employee
where SalariedFlag = 'false'
order by case when SalariedFlag = 'true' then BusinessEntityID end desc,
			case when SalariedFlag = 'false' then BusinessEntityID end;

/* (31) write a query in SQL to retrieve those persons whose last name begins with letter 'R'. 
Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns. */

select LastName, FirstName
from [AdventureWorks2019].Person.Person a
where LastName like 'R%'
Order by FirstName, LastName desc;

/* (30) write a query in SQL to retrieve records of employees. Order the output on year (default ascending order) of hiredate. 
Return BusinessEntityID, JobTitle, and HireDate. */

Select BusinessEntityID, JobTitle, HireDate
from [AdventureWorks2019].HumanResources.Employee
order by HireDate;

/*(29) fetch rows from product table and order the result set on column listprice. 
Return product ID, name, and color of the product. */

select ProductID, name, color
from [AdventureWorks2019].[Production].[Product]
order by ListPrice;

/* (28) write a query in SQL to retrieve products whose names start with 'Lock Washer'. 
Return product ID, and name and order the result set in ascending order on product ID column */

Select ProductID, Name
from [AdventureWorks2019].Production.Product
WHERE Name LIKE 'Lock Washer%'
order by ProductID;

/*(27) write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, total cost. */

Select SalesOrderID, Sum(OrderQty*UnitPrice) Total_Cost
from [AdventureWorks2019].Sales.SalesOrderDetail s
Group by SalesOrderID
Having Sum(OrderQty*UnitPrice) > 100000

/* (26) write a query in SQL to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and 
product id starting with '71'. Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity */

select SalesOrderID,ProductID, OrderQty,
sum(OrderQty) OVER(PARTITION BY salesOrderID) sum, 
AVG(OrderQty) OVER(PARTITION BY salesOrderID) avg, 
COUNT(OrderQty) OVER(PARTITION BY salesOrderID) count
from [AdventureWorks2019].Sales.SalesOrderDetail
where SalesOrderID in (43659,43664) and ProductID like '71%';

/* (25) write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. 
Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity. */

select SalesOrderID, ProductID, OrderQty,
sum(OrderQty) OVER(PARTITION BY salesOrderID) sum, 
AVG(OrderQty) OVER(PARTITION BY salesOrderID) avg, 
COUNT(OrderQty) OVER(PARTITION BY salesOrderID) count, 
min(OrderQty) OVER(PARTITION BY salesOrderID) min, 
max(OrderQty) OVER(PARTITION BY salesOrderID) max
from [AdventureWorks2019].Sales.SalesOrderDetail
where SalesOrderID in (43659,43664);

/* (24) write a query in SQL to calculate and display the latest weekly salary of each employee. 
Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees 
Sort the output in ascending order on NameInFull. */

With latest_weekly_salary as 

	(Select CAST(RateChangeDate AS DATE) rateChangeDate, CONCAT(FirstName, ' ',MiddleName, ' ', LastName) FULLNAME, (Rate * 40) weeklySalary, 
	ROW_NUMBER() over( partition by CONCAT(FirstName, ' ',MiddleName, ' ', LastName) order by CAST(RateChangeDate AS DATE) desc) rownum
	from [AdventureWorks2019].HumanResources.EmployeePayHistory E
	Inner Join [AdventureWorks2019].Person.Person p
		on E.BusinessEntityID = P.BusinessEntityID)
		
select rateChangeDate,FULLNAME,weeklySalary
from latest_weekly_salary
where rownum = 1
order by FULLNAME;

/* (23) write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary 
(40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. 
Sort the output in ascending order on NameInFull. */

Select CAST(RateChangeDate AS DATE) rateChangeDate, CONCAT(FirstName, ' ',MiddleName, ' ', LastName) FULLNAME, (Rate * 40) weeklySalary
from [AdventureWorks2019].HumanResources.EmployeePayHistory E
Inner Join [AdventureWorks2019].Person.Person p
	on E.BusinessEntityID = P.BusinessEntityID
order by FULLNAME;

/* (22) write a query in SQL to count the number of contacts for combination of each type and name. 
Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. 
Sort the result set in descending order on number of contacts. */

select a.ContactTypeID, Name, COUNT(b.BusinessEntityID) No_Of_Contacts
from [AdventureWorks2019].Person.ContactType a
Inner Join [AdventureWorks2019].Person.BusinessEntityContact B 
	on a.ContactTypeID = b.ContactTypeID
Group by a.ContactTypeID, Name
Having COUNT(b.BusinessEntityID) > 100
order by COUNT(b.BusinessEntityID) desc;

/* (21) write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. 
Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. 
Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order. */

select ROW_NUMBER() over(partition by postalcode order by SalesYTD DEsc) Row_num,LastName, SalesYTD, PostalCode
from [AdventureWorks2019].Sales.SalesPerson s
inner join [AdventureWorks2019].Person.Person p
	on s.BusinessEntityID = p.BusinessEntityID
inner join [AdventureWorks2019].Person.Address a
	on a.AddressID = s.BusinessEntityID
where PostalCode is not null 
	and SalesYTD <> 0
order by PostalCode;

/* (20) write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. 
Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName */

select p.BusinessEntityID, p.LastName, p.FirstName
from  [AdventureWorks2019].Person.BusinessEntityContact e
inner join  [AdventureWorks2019].Person.ContactType c
on  c.ContactTypeID = e.ContactTypeID
inner Join [AdventureWorks2019].Person.Person p
on e.BusinessEntityID = p.BusinessEntityID
where c.name = 'Purchasing Manager'
order by p.LastName, p.FirstName;  

/* (19) write a query in SQL to find the contacts who are designated as a manager in various departments. 
Returns ContactTypeID, name. Sort the result set in descending order. */

select c.ContactTypeID, c.Name
from [AdventureWorks2019].[Person].[ContactType] c
where c.name like '%manager%'
order by c.name desc;

/* (18) write a query in SQL to retrieve the total sales for each year. 
Filter the result set for those orders where order year is on or before 2016. 
Return the year part of orderdate and total due amount. 
Sort the result in ascending order on year part of order date. */

select Year(s.OrderDate) year, sum(s.TotalDue) total_due_amount
from [AdventureWorks2019].[Sales].[SalesOrderHeader] s
where Year(s.OrderDate) <= 2016
group by Year(s.OrderDate) 
order by Year(s.OrderDate) ;

/* (17) write a query in SQL to retrieve the total sales for each year. 
Return the year part of order date and total due amount. 
Sort the result in ascending order on year part of order date. */

select Year(s.OrderDate) year, sum(s.TotalDue) total_due_amount
from [AdventureWorks2019].[Sales].[SalesOrderHeader] s
group by Year(s.OrderDate) 
order by Year(s.OrderDate) ;

/* (16) write a query in SQL to retrieve the number of employees for each City. 
Return city and number of employees. Sort the result in ascending order on city. */

select distinct A.CITY,count(distinct e.BusinessEntityID) num_of_emp
from [AdventureWorks2019].[Person].[BusinessEntityAddress] E
Join [AdventureWorks2019].[Person].[Address] A
on e.AddressID = a.AddressID
group by a.City
order by a.City

/* (15) write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. 
Return locationid and total quantity. Group the results on locationid. */

select LocationID, sum(Quantity) TotalQuantity
from [AdventureWorks2019].[Production].[ProductInventory]
group by rollup(LocationID)

/* (14) write a query in SQL to find the sum of the quantity with subtotal for each locationid. 
Group the results for all combination of distinct locationid and shelf column. 
Rolls up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity. */

select LocationID, Shelf, sum(Quantity) TotalQuantity
from [AdventureWorks2019].[Production].[ProductInventory]
group by Grouping sets (rollup (LocationID, Shelf), cube(LocationID, Shelf));

-- Read up on grouping sets here https://www.sqlservertutorial.net/sql-server-basics/sql-server-grouping-sets/

/* (13) write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column. 
Return locationid, shelf and sum of quantity as TotalQuantity. */

select LocationID, Shelf, sum(Quantity) TotalQuantity
from [AdventureWorks2019].[Production].[ProductInventory]
group by cube(LocationID, Shelf)

--Read up on cube fxn here: https://www.sqlservertutorial.net/sql-server-basics/sql-server-cube/

/* (12) write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. 
Roll up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal. */

 select s.SalesPersonID, CustomerID, SUM(SubTotal) sum
 from [AdventureWorks2019].[Sales].[SalesOrderHeader] s
 group by rollup(s.SalesPersonID, CustomerID)

 --rollup creates a running total for each level of grouping.


/* (11) write a query in SQL to find the persons whose last name starts with letter 'L'. 
Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname. */

select p.BusinessEntityID, PP.FirstName, PP.LastName, P.PhoneNumber
from [AdventureWorks2019].[Person].[PersonPhone] p
join [AdventureWorks2019].Person.Person pp
on pp.BusinessEntityID = P.BusinessEntityID
Where pp.LastName like 'L%'
Order by pp.LastName, pp.FirstName;

/* (10) find the total quantity for a group of locationid multiplied by 10. */

select Sum(p.Quantity) sum
from [AdventureWorks2019].[Production].[ProductInventory] p
Group by (p.LocationID*10)

/*(9) retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. 
Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. 
Sort the results according to the productid in ascending order. */

With Sum_Qty as (
	select p.ProductID ID, p.Shelf, sum(p.quantity) sum
	from [AdventureWorks2019].[Production].[ProductInventory] p
	where p.Shelf in ('A','C','H')
	group by p.ProductID, p.Shelf
	)

select ID, Sum
from Sum_Qty
where sum > 500
order by ID

-- or 

select p.ProductID ID, sum(p.quantity) sum
from [AdventureWorks2019].[Production].[ProductInventory] p
where p.Shelf in ('A','C','H')
group by p.ProductID, p.Shelf
Having sum(p.quantity)>500
order by p.ProductID


/* (8) find the average and the sum of the subtotal for every customer. 
Return customerid, average and sum of the subtotal. 
Grouped the result on customerid and salespersonid. 
Sort the result on customerid column in descending order. */

select s.CustomerID, s.SalesPersonID, avg(s.SubTotal) avg, sum(s.subTotal) sum
from [AdventureWorks2019].Sales.SalesOrderHeader s
group by s.CustomerID, S.SalesPersonID
order by s.CustomerID desc;

/* (7) calculate the total freight paid by each customer. 
Return customerid and total freight. Sort the output in ascending order on customerid. */

select s.CustomerID, SUM(s.Freight) total_freight
from [AdventureWorks2019].Sales.SalesOrderHeader s
group by s.CustomerID
order by s.CustomerID;

/* (6) create a list of unique jobtitles in the employee table in Adventureworks database. 
Return jobtitle column and arranged the resultset in ascending order. */

select distinct e.JobTitle
from [AdventureWorks2019].HumanResources.Employee e
order by e.JobTitle; 

  /* (5) return all rows from the salesorderheader table in Adventureworks database 
and calculate the percentage of tax on the subtotal have decided. 
Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. 
Arranged the result set in descending order on subtotal. */

select s.SalesOrderID, s.CustomerID, s.OrderDate, s.SubTotal, ((s.TaxAmt / s.SubTotal) * 100) percent_tax
from [AdventureWorks2019].Sales.SalesOrderHeader s
order by s.SubTotal desc;

-- (1) Retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle.

SELECT *
  FROM [AdventureWorks2019].[HumanResources].[Employee] a
  order by a.[JobTitle] desc;

/* return all rows and a subset of the columns (FirstName, LastName, businessentityid) 
from the person table in the AdventureWorks database. rename the third column to Employee_id. 
Arranged the output in ascending order by lastname. */

select p.[FirstName], p.[LastName], p.[BusinessEntityID] employee_id
from [AdventureWorks2019].[person].[person] p
order by p.LastName asc;

/* return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. 
Return productid, productnumber, and name. Arranged the output in ascending order on name */

SELECT a.ProductID, a.ProductNumber, a.Name
  FROM [AdventureWorks2019].[Production].[Product] a
  where a.SellStartDate is not null 
  and 
  a.ProductLine = 'T'
  order by name;


/* return the total ListPrice and StandardCost of products for each color. 
Products that name starts with 'Mountain' and ListPrice is more than zero. Return Color, total list price, total standardcode. 
Sort the result set on color in ascending order. */

SELECT distinct a.Color, sum(a.ListPrice) total_list_price, sum(a.standardCost) total_standard_cost
  FROM [AdventureWorks2019].[Production].[Product] a
  where a.name like 'Mountain%' 
  and 
  a.ListPrice > 0
  Group by a.color
  order by a.Color;
  
  

