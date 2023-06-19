/* (84) From the following table write a SQL query to determine the discount price for the salesorderid 46672. 
Calculate only those orders with discounts of more than.02 percent. Return productid, UnitPrice, UnitPriceDiscount, 
and DiscountPrice (UnitPrice*UnitPriceDiscount ). */

select ProductID, UnitPrice, UnitPriceDiscount, (UnitPrice*UnitPriceDiscount ) discountPrice
from AdventureWorks2019.sales.SalesOrderDetail
where SalesOrderID = 46672 and UnitPriceDiscount > 0.02;

/* (83) From the following table write a query in SQL to convert the Name column to a char(16) column. 
Convert those rows if the name starts with 'Long-Sleeve Logo Jersey'. 
Return name of the product and listprice. */

Select CAST(name AS char(16)) name, ListPrice
from AdventureWorks2019.Production.Product
where name like 'Long-Sleeve Logo Jersey%';

/* (82) From the following table write a query in SQL to find those persons that have a 2 in the first digit of their SalesYTD. 
Convert the SalesYTD column to an int type, and then to a char(20) type. Return FirstName, LastName, SalesYTD, and BusinessEntityID. */

select FirstName, LastName, cast(cast( SalesYTD as int) as char (20)) salesYTD, s.BusinessEntityID 
from [AdventureWorks2019].person.person p
inner join [AdventureWorks2019].sales.salesperson s
on p.BusinessEntityID = s.BusinessEntityID
where SalesYTD like '2%';

/* (81) From the following table write a query in SQL to calculate by dividing the total year-to-date sales (SalesYTD) 
by the commission percentage (CommissionPCT). Return SalesYTD, CommissionPCT, and the value rounded to the nearest whole number. */

Select SalesYTD, CommissionPct, (SalesYTD / nullif(CommissionPct,0)) commission
from AdventureWorks2019.Sales.SalesPerson
where CommissionPct <> 0;

/* (80) From the following table write a query in SQL to retrieve the name of the products. 
Product, that have 33 as the first two digits of listprice. */

select name, ListPrice
from AdventureWorks2019.Production.Product
where ListPrice like '33%';

/* (79) From the following table write a query in SQL to show a resulting expression that is too small to display. 
Return FirstName, LastName, Title, and SickLeaveHours. The SickLeaveHours will be shown as a small expression in text format. */

Select FirstName, LastName, Title, cast(SickLeaveHours as char (1)) sickleave
from [AdventureWorks2019].HumanResources.Employee B
inner join AdventureWorks2019.Person.Person p
on b.BusinessEntityID = p.BusinessEntityID;

/* (78) From the following table write a query in SQL to return the last name of people so that it is in uppercase, 
trimmed, and concatenated with the first name. */

Select Concat(trim(upper(LastName)), ',',' ', FirstName) fullname
from AdventureWorks2019.Person.Person;

/* (77) From the following table write a SQL query to retrieve all the employees whose job titles begin with "Sales". 
Return firstname, middlename, lastname and jobtitle column. */

SELECT FirstName, MiddleName, LastName, JobTitle
FROM AdventureWorks2019.Person.Person p
Inner join [AdventureWorks2019].HumanResources.Employee e
on p.BusinessEntityID = e.BusinessEntityID
where JobTitle like 'Sales%';

/* (76) From the following table write a query in SQL to create a new job title called "Production Assistant" in place of "Production Supervisor". */

Select JobTitle, REPLACE(Jobtitle, 'Supervisor', 'Assistant') NewTitle
from AdventureWorks2019.HumanResources.Employee
where JobTitle like '%Production Supervisor%';

/* (75) From the following table write a query in SQL to find the email addresses of employees and groups them by city. Return top ten rows. */

select top 10 city, string_agg(emailaddress,',')
from AdventureWorks2019.Person.BusinessEntityAddress a
inner join AdventureWorks2019.Person.Address p
on p.AddressID = a.AddressID
inner join AdventureWorks2019.Person.EmailAddress e
on e.businessentityID = a.businessentityID
Group by City;


/* (74) From the following table write a query in SQL to return the names and modified date separated by commas in a single row. */

Select string_agg(concat(firstname,' ',lastname, '(',modifiedDate,')'),',') name
from AdventureWorks2019.Person.Person;

-- Above will result in error, fix as below using cast

Select string_agg(concat(cast(firstname as nvarchar(max)),' ',cast(lastname as nvarchar (max)), '(',modifiedDate,')'),',') name
from AdventureWorks2019.Person.Person;

/* (73) From the following table write a query in SQL to replace null values with 'N/A' and return the names separated by commas in a single row. */

Select string_agg(coalesce(firstname, 'N/A'),',') name
from AdventureWorks2019.Person.Person;

/* (72) From the following table write a query in SQL to fetch the rows for the product name ends with the letter 'S' or 'M' or 'L'. 
Return productnumber and name. */

select ProductNumber, name
from AdventureWorks2019.Production.Product
where right(name,1) in ('S','M','L');

/* (71) Write a query in SQL to remove the spaces at the end of a string */

Select Concat('remove the spaces from the beginning of a        ' ,' string') AS text, 
COncat(Rtrim('remove the spaces from the beginning of a        ' ),' string') as trimText;

/* (70)  From the following table write a query in SQL to return the eight rightmost characters of each name of the product. 
Also return name, productnumber column. Sort the result set in ascending order on productnumber. */

select Right(Name, 8) Lst8Lettrs, ProductNumber,name 
from AdventureWorks2019.Production.Product
order by ProductNumber;

/* (69)  From the following table write a SQL query to retrieve all contact first names with the characters inverted for people whose 
businessentityid is less than 6. */

select firstname, reverse(firstname) reverseName
from AdventureWorks2019.Person.person
where BusinessEntityID < 6;

/* (68) From the following table write a query in SQL to repeat a 0 character four times in front of a production line for production line 'T'. */

select name, concat(REPLICATE('0',4), ProductLine) as code
from AdventureWorks2019.Production.Product
WHERE ProductLine = 'T';

/* (67) write a query in SQL to remove the substring 'HN' from the start of the column productnumber. 
Filter the results to only show those productnumbers that start with "HN". Return original productnumber column and 'TrimmedProductnumber'. */

Select ProductNumber, trim('HN' From ProductNumber) AS Trimmed
from AdventureWorks2019.Production.Product
WHERE ProductNumber like 'HN%';

/* (66) Write a query in SQL to remove the spaces from the beginning of a string */

Select '       remove the spaces from the beginning of a string' AS text, 
LTRIM('       remove the spaces from the beginning of a string') as trimText;

/* (65) From the following table write a query in SQL to select product names that have prices between $1000.00 and $1220.00. 
Return product name as Lower, Upper, and also LowerUpper. */

Select lower(Name) lowercase, Upper(Name) uppercase, lower(upper(Name)) lowerUppercase
from AdventureWorks2019.Production.Product p
where p.ListPrice between 1000 and 1220;

/* (64) From the following tables write a query in SQL to return the number of characters in the column FirstName and 
the first and last name of contacts located in Australia. */

Select len(FirstName) length, FirstName, LastName
from AdventureWorks2019.sales.vStoreWithContacts c
inner join AdventureWorks2019.sales.vStoreWithAddresses a
on c.BusinessEntityID = a.BusinessEntityID
where a.CountryRegionName = 'Australia';

/* (63)  From the following table write a query in SQL to select the number of characters and the data in FirstName 
for people located in Australia. */

Select len(FirstName) length, FirstName
from AdventureWorks2019.sales.vIndividualCustomer c
where c.CountryRegionName = 'Australia';


/* (62) From the following table write a query in SQL to return the five leftmost characters of each product name. */

select left(name,5) nameLeft
from AdventureWorks2019.Production.Product;

/* (61) Write a SQL query that concatenate the columns name, productnumber, colour, and a new line character from the following 
table, each separated by a specified character. */

select CONCAT_ws(',',name,' ','Color:',' ',color,' ','ProductName:',ProductNumber,char(13))  info
from AdventureWorks2019.Production.Product;

/* (60)  write a query in SQL to concatenate the name, color, and productnumber columns. */

select CONCAT(name,' ','Color:',' ',color,' ','ProductName:',ProductNumber) Result, Color
from AdventureWorks2019.Production.Product;

/* (59) From the following table write a SQL query to locate the position of the string "yellow" where it appears in the product name. */

select name, CHARINDEX('yellow', Name) strpos
from AdventureWorks2019.Production.Product
where name like '%yellow%';

/* (58)  write a SQL query to output an employee's name and email address, separated by a new line character.  */

select CONCAT(p.FirstName, ' ', p.LastName) + char(13) + e.EmailAddress
from AdventureWorks2019.Person.Person p
inner join AdventureWorks2019.Person.EmailAddress e
on p.BusinessEntityID = e.BusinessEntityID;

--Read up on adding new line character here: https://stackoverflow.com/questions/31057/how-to-insert-a-line-break-in-a-sql-server-varchar-nvarchar-string

/* (57) write a query in SQL to return all category descriptions containing strings with prefixes of either chain or full.*/

Select name, color
from AdventureWorks2019.Production.Product
WHERE name like 'chain %' or name like 'full%';

/* (56) write a query in SQL to return all the product names with at least one word 
starting with the prefix chain in the Name column. */

Select name, color
from AdventureWorks2019.Production.Product
where name like 'Chain %';

/* (55) write a query in SQL to search for name which contains both the word 'Mountain' and the word 'Black'. 
Return Name and color. */

Select name, color
from AdventureWorks2019.Production.Product
where name like '%Mountain%' and name like '%Black%';

/* (54) write a query in SQL to retrieve all the products that contain either the phrase Mountain or Road. 
Return name, and color columns.  */

Select name, color
from AdventureWorks2019.Production.Product
where name like '%Mountain%' or name like '%Road%';

/* (53) write a query in SQL to find all the products with a price of $80.99 that contain the word Mountain. 
Return name, and listprice columns from the table */

Select name, ListPrice
from AdventureWorks2019.Production.Product
where ListPrice = 80.99
and name like '%Mountain%';

/* (52) write a query in SQL that searches for the word 'red' in the name column. Return name, and color columns from the table. */

select name, Color
from AdventureWorks2019.Production.Product
where name like '%red%';

/* (51)  write a SQL query to retrieve the orders with orderqtys greater than 5 or unitpricediscount less than 1000, 
and totaldues greater than 100. Return all the columns from the tables. */

Select *
from AdventureWorks2019.sales.SalesOrderHeader so
inner join AdventureWorks2019.Sales.SalesOrderDetail sd
on so.SalesOrderID = sd.SalesOrderID
where (sd.OrderQty > 5 or sd.UnitPriceDiscount < 1000)
and so.TotalDue >100;

/* (50) From the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. 
Order the result set on hiredate column in descending order.*/

select top 10 JobTitle, HireDate
from AdventureWorks2019.HumanResources.Employee
order by HireDate desc;

/* (49) Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and in a city whose name 
starts with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode columns. */

select AddressLine1, AddressLine2, City, PostalCode, CountryRegionCode
from AdventureWorks2019.Person.Address a
inner join AdventureWorks2019.Person.StateProvince s
on a.StateProvinceID = s.StateProvinceID
where CountryRegionCode <> 'US' 
AND City like 'Pa%';

/* (48) Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field. 
The following table's columns must all be returned. */

Select *
from AdventureWorks2019.Production.ProductPhoto
where LargePhotoFileName like '%green_%';

/* (47) write a query in SQL to find the average number of sales orders for all the years of the sales representatives. */

with totalsales_cte as

(select SalesPersonID, count(SalesOrderID) totalSales
from [AdventureWorks2019].Sales.SalesOrderHeader
where SalesPersonID is not null
group by SalesPersonID
)

select Avg(totalSales) as avgsales
from totalsales_cte;

/* (46) Create a SQL query to display the total number of sales orders each sales representative receives annually. 
Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order. 
Return the year component of the OrderDate, SalesPersonID, and SalesOrderID. */

select SalesPersonID, count(SalesOrderID) totalSales, DATEPART(year,OrderDate) year
from [AdventureWorks2019].Sales.SalesOrderHeader
where SalesPersonID is not null
group by SalesPersonID, DATEPART(year,OrderDate)
order by SalesPersonID, DATEPART(year,OrderDate);

/* (45) Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' 
using a derived table with multiple values.  */

sELECT ProductID, Name, color
FROM (
select *
from AdventureWorks2019.Production.Product
where Name in ('Blade', 'Crown Race' ,'AWC Logo Cap')) as subtable


/* (44) Create a SQL query to retrieve individuals from the following table with a businessentityid inside 1500, 
a lastname starting with 'Al', and a firstname starting with 'M' */

Select BusinessEntityID, FirstName, LastName
from AdventureWorks2019.Person.Person
where BusinessEntityID < 1500
and LastName like 'Al%' 
and FirstName like 'M%';

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
  
  

