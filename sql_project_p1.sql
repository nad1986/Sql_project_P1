create table sql_projects_p2
		(
			transactions_id	int primary key,
			ale_date	date,
			sale_time	time,
			customer_id	int	,	
			gender	varchar(15),
			age	int,
			category varchar(20),
			quantity int,
			price_per_unit	float,
			cogs	float,
			total_sale float
			);

select * from sql_projects_p2;

select count(*) from sql_projects_p2

select * from sql_projects_p2
where transactions_id is null
or
ale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

delete from sql_projects_p2

where 
transactions_id is null
or
ale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

select count(*) from sql_projects_p2;



-- Data exploratio 

-How many sales we have

select count(*) as total_sales from sql_projects_p2;

--How many customer we have

select count(distinct(customer_id)) from sql_projects_p2;

select count (distinct (category)) from sql_projects_p2;

--Data anlaysis/ Business key problems

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from sql_projects_p2
where ale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select * from sql_projects_p2
where category = 'Clothing'
and 
TO_CHAR(ale_date, 'YYYY-MM') = '2022-11'
and
Quantity >= 4;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category ,sum(total_sale) as category_sale 
from sql_projects_p2
group by 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select category, round(avg(age),2) as avg_age from sql_projects_p2
where category = 'Beauty'
group by category;


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select 
* from sql_projects_p2
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select count(transactions_id) as Number_transactionfrom, gender, category from sql_projects_p2
group by gender ,  category;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select year, month, avg_sale
from 
(
select 
		extract (year from ale_date) as year,
		extract (Month from ale_date) as month,
		avg(total_sale) as avg_sale,
		rank () over(partition by extract ( year from ale_date) order by avg(total_sale) desc) as rank
		from sql_projects_p2
		group by 1,2
 ) as t1
 where rank = 1


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id, sum(total_sale) as Sale_by_customer
from sql_projects_p2
group by customer_id
order by 2 desc
limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
category, count(distinct customer_id) as unique_customer
from sql_projects_p2
group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale
as
(
select *,
	case 
	 when extract(hour from sale_time) < 12 then 'Morning'	 
	 when extract (hour from sale_time) between 12 and 17 then 'afternoon'
	 else 'Evening'
	end as shift
from  sql_projects_p2
)
select 
shift, count(*) as total_orders
from hourly_sale
group by shift








