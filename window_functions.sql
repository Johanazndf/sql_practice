					-- window function queries--

-- Show each payment with the customer’s total payment
select customerNumber, paymentDate, amount, 
sum(amount) over(partition by customerNumber)
as TotalPayment from classicmodels.payments;

-- Rank payments of each customer from highest to lowest amount
select customerNumber, amount, rank() over(partition by customerNumber order by amount desc )
as RankfromHightoLow
from classicmodels.payments;

-- For each payment, show the previous payment amount of the same customer
select customerNumber, paymentDate,
lag(amount) over (partition by customerNumber order by paymentDate)
as PreviouPayment from classicmodels.payments;

-- For each payment, show the next payment amount of the same customer
select customerNumber, paymentDate,
lead(amount) over (partition by customerNumber order by paymentDate)
as NextPayment from classicmodels.payments;

-- For each payment, show: amount, customer’s highest payment, difference between this payment and highest payment
select customerNumber, amount, paymentDate, 
max(amount) over (partition by customerNumber) as highestPayment,
max(amount) over (partition by customerNumber) - amount as difference
from classicmodels.payments;

-- Number each payment of a customer by payment date
select customerNumber, amount,paymentDate, count(*) over (partition by paymentDate ) 
as NoPayment
from classicmodels.payments; 

-- Rank customers by payment amount without skipping ranks
select customerNumber, amount, dense_rank() over (partition by customerNumber order by  amount desc)
as RankByPayment
from classicmodels.payments;

-- Show each payment and the customer’s first payment amount
select amount, first_value(amount) over (partition by customerNumber)
as FirstPayment 
from classicmodels.payments;

-- Show each payment and the customer’s last payment amount
select amount, last_value(amount) over (partition by customerNumber)
as LastPayment 
from classicmodels.payments;

-- Show each payment and the customer’s lowest payment
select customerNumber, amount, min(amount) over (partition by customerNumber) 
as LowestPayment
from classicmodels.payments;

-- Show each payment along with the customer’s total payment
select customerNumber,amount, sum(amount) 
over (partition by amount) as TotalPayment
from classicmodels.payments;

-- For each employee, rank them by number of customers handled give query
select e.employeeNumber,e.firstName,e.lastName,
count(c.customerNumber) as total_customers,
dense_rank() over (order by count(c.customerNumber) desc) as employee_rank
from classicmodels.employees e
left join classicmodels.customers c
on e.employeeNumber = c.salesRepEmployeeNumber
group by e.employeeNumber, e.firstName, e.lastName;


