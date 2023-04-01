/* Given a table C containing Columns/Fields named CustomerID, order_id, order_date, and order_value and a tableB containing customerid and customerName.
write SQL Queries to calculate 
1. The total order value for each customer
2. The most recent order date for each customer
3. The most recent order value for each customer
4. Person who spent the most
5. List of customer who have ordered thrice */


create table #tableC (customerid int, 
						order_id int primary key iDENTITY (1,1), 
						order_date datetime,
						order_value int);
            
create table #tableB (customerid int, 
						customerName varchar (255))
            
insert into #tablec ([customerid],[order_date],[order_value])
--sample values
values('1001','4/12/2021',42),
	  ('1005','4/13/2021',30),
	  ('1001','1/3/2021',67),
	  ('1001','2/4/2021',37),
	  ('1004','7/7/2022',30),
	  ('1002','4/13/2021',40) ;     
    
    
insert into #tableB ([customerid],[customerName])
--sample values
values(1001,'John'),
	  (1002,'Jacob'),
	  (1004,'Jasper'),
	  (1005,'Jennifer');


-- Question 1
Select customerid, sum(order_value) sum
from #tableC a
group by customerid;

-- or
Select a.customerid, b.customerName, sum(order_value) sum
from #tableC a
join #tableB b
on a.customerid = b.customerid
group by a.customerid,b.customerName;

--Question 2
select CUstomerid, max(order_date) max_order_date
from #tableC a
group by customerid;

--Question 3
with MRV AS 
	(select CUstomerid, order_value, order_date, 
	rank() over(partition by customerid order by [order_date]) r
	from #tableC a
	group by customerid, order_value, order_date)

	SELECT customerid, order_value
	from MRV 
	WHERE r = 1;


--Question 4

with max_spender as (
	Select a.customerid, 
	b.customerName, 
	sum(order_value) sum, 
	DENSE_RANK() over(order by sum(order_value) desc) r
	from #tableC a
	join #tableB b
	on a.customerid = b.customerid
	group by a.customerid,b.customerName
	)

select customerName
from max_spender
where r = 1


--Question 5

with oc as ( 
		Select customerid, count(order_id) count
		from #tableC a
		group by customerid
		)

select customerid
from oc
where count = 3
