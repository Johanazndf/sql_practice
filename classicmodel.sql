					-- Focus: SELECT, WHERE, ORDER BY, LIMIT --
-- all records from the customers table.
select * from classicmodels.customers;

--  customer names and countries 
select customerName, country from classicmodels.customers;

-- all customers from USA
select customerNumber, customerName from classicmodels.customers where country = "USA";

-- all products with their product name and buy price
select productName, buyPrice from classicmodels.products;

-- employees working in the Sales Rep job title
select jobTitle from classicmodels.employees;
select employeeNumber,lastName,firstName,email, jobTitle 
from classicmodels.employees where jobTitle = 'Sales Rep';

-- all orders placed in 2004
select * from classicmodels.orders;
select * from classicmodels.orders where year(orderDate) = 2004 ;

-- the top 10 most expensive products
select productName, buyPrice from classicmodels.products;
select productName from classicmodels.products
order by buyPrice desc limit 10;

-- customers whose name starts with “A”
select * from classicmodels.customers;
select customerName from classicmodels.customers where customerName like 'A%';

-- all payments greater than ₹50,000 (or equivalent currency).
select amount from classicmodels.payments where amount >= 50000;

-- total number of customers
select count(*) from classicmodels.customers;

					-- Focus: GROUP BY, HAVING, COUNT, SUM, AVG --
-- how many customers are there in each country
select country , count(*) as CustPerCountry
from classicmodels.customers group by country;

-- total number of orders placed by each customer
Select c.customerNumber,c.customerName,
count(o.orderNumber) as totalorders from classicmodels.customers c
left join classicmodels.orders o on classicmodels.c.customerNumber = classicmodels.o.customerNumber
group by c.customerNumber, c.customerName;

-- total payment amount received from each customer
select c.customerNumber, c.customerName, sum(p.amount) as totalPayment
from classicmodels.customers c 
left join classicmodels.payments p
on c.customerNumber = p.customerNumber
group by c.customerNumber,c.customerName;

-- average buy price of products by product line
select productLine , avg(buyPrice) as AvgBuyPrice
from classicmodels.products group by productLine;

-- countries having more than 5 customers
select country, count(*) as NoOfCustomers
from classicmodels.customers group by country having NoOfCustomers > 5;

-- total sales amount per order
select orderNumber, sum(quantityOrdered * priceEach) as AmtPerOrder
from classicmodels.orderdetails group by orderNumber;

-- number of employees in each office
select officeCode, count(*) as NoOfEmpl from classicmodels.employees
group by officeCode;

-- highest payment made
select max(amount) as HighAmt from classicmodels.payments;

-- customers who have never made a payment
select c.customerNumber,c.customerName
from classicmodels.customers c 
left join classicmodels.payments p
on c.customerNumber = p.customerNumber
where p.customerNumber is null;

-- total quantity ordered per product
select productCode , sum(quantityOrdered) as TotalQuantity
from classicmodels.orderdetails 
group by productCode;