-- customer name, order number, and order date
select c.customerName, c.customerNumber, o.orderNumber, o.orderDate
from classicmodels.customers c 
left join classicmodels.orders o 
on c.customerNumber = o.customerNumber; 

-- customer name and their total payment amount
select c.customerNumber, c.customerName,
sum(p.amount) as totalPayment
from classicmodels.customers c 
left join classicmodels.payments p 
on c.customerNumber = p.customerNumber
group by c.customerNumber, c.customerName;

-- orders along with product names and quantities ordered
select p.productName, o.quantityOrdered
from classicmodels.products p 
left join classicmodels.orderdetails o 
on p.productCode = o.productCode
order by quantityOrdered desc;

--  employees and the offices they work in
select e.employeeNumber, o.officeCode, e.jobTitle
from classicmodels.employees e
left join classicmodels.offices o 
on e.officeCode = o.officeCode;

--  customers who have no orders
select c.customerNumber, c.customerName
from classicmodels.customers c 
left join classicmodels.orders o 
on c.customerNumber = o.customerNumber
where o.customerNumber is NULL;

-- total sales amount per customer
select c.customerNumber,
sum(p.amount) as TotalSales
from classicmodels.customers c
left join  classicmodels.payments p
on c.customerNumber = p.customerNumber
group by customerNumber;

--  all products that have never been ordered
select o.orderNumber
from classicmodels.orders o 
left join classicmodels.orderdetails od
on o.orderNumber = od.orderNumber
where od.orderNumber;

-- order details including product name and price
select p.productName, o.priceEach
from classicmodels.products p 
left join classicmodels.orderdetails o 
on p.productCode = o.productCode;

-- sales representative name and their customers
select e.firstName as salesRepFirstName, e.lastName as salesRepLastName, c.customerName
from classicmodels.employees e
join classicmodels.customers c 
on e.employeeNumber = c.salesRepEmployeeNumber
order by e.lastName, c.customerName;

-- which office has the highest number of employees
select officeCode,
count(employeeNumber) as NumOfEmpl
from classicmodels.employees
group by officeCode
order by NumOfEmpl desc
limit 1;






