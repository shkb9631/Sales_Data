
CREATE DATABASE Sales_Data
USE SALES_DATA

SELECT * FROM sales_data

--Q1. List all customers with their city and join date.

SELECT
	distinct sales_data.name,
	sales_data.city,
	sales_data.join_date
FROM
	sales_data

--Q2.Show all unique product categories.

SELECT
	DISTINCT sales_data.category
FROM
	sales_data

--Q3.Find the total number of customers in each city.

SELECT
	sales_data.city,
	COUNT(DISTINCT sales_data.name) AS 'Number Of Customer'
FROM
	sales_data
GROUP BY sales_data.city
ORDER BY [Number Of Customer] DESC

--Q4. Show the first 10 orders (by order date).

SELECT TOP 10
	*
FROM
	sales_data
ORDER BY order_date DESC

--Q5. List products with their price greater than 50,000.

SELECT
	sales_data.product_name,
	sales_data.price
FROM
	sales_data
WHERE price >= 50000
ORDER BY  price ASC

--Q6. Find the total sales amount per category.

SELECT
	sales_data.category,
	SUM(sales_data.total_amount) AS 'Total Amount'
FROM	
	sales_data
GROUP BY category
ORDER BY [Total Amount] DESC

--Q7. Show the average order amount for each city.

SELECT 
	sales_data.city,
	AVG(sales_data.total_amount) AS 'AVERAGE ORDER'
FROM
	sales_data
GROUP BY sales_data.city

--Q8. Get the maximum and minimum product price in each category.

SELECT
	sales_data.category,
	MAX(sales_data.price) AS 'MAX',
	MIN(sales_data.price) AS 'MIN'
FROM
	sales_data
GROUP  BY sales_data.category

--Q9. Count how many orders were placed per year.

SELECT
	DATEPART(YEAR,sales_data.order_date) AS 'YEAR',
	COUNT(sales_data.customer_id) AS 'Order'
FROM
	sales_data
GROUP BY DATEPART(YEAR,sales_data.order_date)

--Q10. Find the top 5 cities by total sales.

SELECT TOP 5
	sales_data.city,
	SUM(sales_data.total_amount) AS 'Total Sales'
FROM
	sales_data
GROUP BY city
ORDER BY [Total Sales] DESC

--Q11. List each customer with the products they purchased.

SELECT
	DISTINCT sales_data.name,
	sales_data.product_name
FROM
	sales_data

--Q12. Find customers who purchased more than 5 different products.

SELECT 
sales_data.name,
COUNT(DISTINCT sales_data.product_id) AS 'ABC'
FROM sales_data
GROUP BY sales_data.name
HAVING COUNT(DISTINCT sales_data.product_id)>5 

--Q13. Show customers with their total spending.
SELECT * FROM sales_data
SELECT
	sales_data.name,
	SUM(sales_data.subtotal) AS 'Total Spending'
FROM
	sales_data
GROUP BY sales_data.name
ORDER BY [Total Spending] DESC

--Q14. Get the top 5 customers by total amount spent.

SELECT TOP 5
	sales_data.name,
	SUM(sales_data.subtotal) AS 'Total Spent'
FROM
	sales_data
GROUP BY sales_data.name
ORDER BY [Total Spent] DESC

--Q15. List products along with the number of customers who bought them.

SELECT
	sales_data.product_name,
	COUNT(DISTINCT sales_data.customer_id) AS 'Number_Of_Customer'
FROM
	sales_data
GROUP BY sales_data.product_name

--Q16. Rank products by revenue within each category.
SELECT * FROM sales_data

SELECT
	sales_data.category,
	sales_data.product_id,
	sales_data.product_name,
	SUM(sales_data.subtotal) AS 'Total_Revenue',
	DENSE_RANK() OVER(PARTITION BY CATEGORY ORDER BY SUM(sales_data.subtotal) DESC) AS 'Rank'
FROM
	sales_data
GROUP BY sales_data.category,product_id,product_name

--Q17. Show the top 3 customers in each city by total amount spent.

WITH ABCD AS
(SELECT
	sales_data.city,
	 sales_data.name,
	SUM(sales_data.total_amount)as 'total_spent',
	row_number() OVER(PARTITION BY CITY ORDER BY SUM(sales_data.total_amount) DESC) AS 'Top_Customer'
FROM
	sales_data
GROUP BY sales_data.city,sales_data.name
) 
SELECT * FROM ABCD
WHERE ABCD.Top_Customer <= 3
order by ABCD.city asc

--Q18. Find the most frequently purchased product

select
sales_data.product_name,
count(*) as 'Frequently_Purchased'
from 
sales_data
group by sales_data.product_name
order by Frequently_Purchased desc
offset 0 rows fetch next 1 rows only

--Q19 Show the cumulative sales amount per city (using SUM() OVER).



--Q20. Get customers who spent more than the average customer.


select
sales_data.customer_id,
sum(sales_data.total_amount) as 'total_amount'
from
	sales_data
group by sales_data.customer_id
having sum(sales_data.total_amount) >(select avg(sales_data.total_amount) from sales_data)
order by total_amount asc

--Q20. Get customers who spent more than the average customer.

SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM sales_data
GROUP BY customer_id
HAVING SUM(total_amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(total_amount) AS total_spent
        FROM sales_data
        GROUP BY customer_id
    ) t
)
ORDER BY total_spent ASC;











