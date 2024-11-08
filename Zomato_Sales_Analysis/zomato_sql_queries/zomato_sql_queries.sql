-- ------------------------------
-- Exploratory Data Analysis
-- ------------------------------

DELETE FROM customers;
DELETE FROM restaurants;
DELETE FROM orders;
DELETE FROM riders;
DELETE FROM deliveries;


select * from customers;
select * from restaurants;
select * from orders;
select * from riders;
select * from deliveries;

-- checking for null values

select count(*) from customers
where
	customer_id is null
	or
	customer_name is null
	or
	reg_date is null
;

select count(*) from restaurants
where
	restaurant_id is null
	or
	restaurant_name is null
	or
	city is null
	or
	opening_hours is null
;

select count(*) from orders
where
	order_id is null
	or
	customer_id is null
	or
	restaurant_id is null
	or
	order_item is null
	or
	order_date is null
	or
	order_time is null
	or
	order_status is null
	or
	total_amount is null
;

select count(*) from riders
where
	rider_id is null
	or
	rider_name is null
	or
	sign_up is null
;

select count(*) from deliveries
where
	delivery_id is null
	or
	order_id is null
	or
	delivery_status is null
	or
	delivery_time is null
	or
	rider_id is null
;


-- ------------------------------
-- Solving Business Questions --
-- ------------------------------


-- Q.1
-- Find the top 5 most ferquently ordered dishes by customer 'Daniel Bryant' in the last 5 year

select * from
	(select 
		c.customer_id,
		c.customer_name,
		o.order_item as dishes,
		count(*) as total_orers,
		dense_rank() over(order by count(*) desc) as rank
	from orders as o
	join customers as c
	on o.customer_id = c.customer_id
	where
		o.order_date >= current_date - interval '5 year'
		and
		c.customer_name  = 'Daniel Bryant'
	group by 1,2,3
	order by 1,4 desc)
as ti
where rank <= 5;

-- -------------------------

-- Q.2 Popular Time Slots
-- identify the time slots with 2 hours interval where most of the orders are placed

select 
	case
		when extract(hour from order_time) between 0 and 1 then  '00:00 - 02:00'
		when extract(hour from order_time) between 2 and 3 then  '02:00 - 04:00' 
		when extract(hour from order_time) between 4 and 5 then  '04:00 - 06:00'
		when extract(hour from order_time) between 6 and 7 then  '06:00 - 08:00' 
		when extract(hour from order_time) between 8 and 9 then  '08:00 - 10:00'
		when extract(hour from order_time) between 10 and 11 then  '10:00 - 12:00'
		when extract(hour from order_time) between 12 and 13 then  '12:00 - 14:00'
		when extract(hour from order_time) between 14 and 15 then  '14:00 - 16:00' 
		when extract(hour from order_time) between 16 and 17 then  '16:00 - 18:00'
		when extract(hour from order_time) between 18 and 19 then  '18:00 - 20:00'
		when extract(hour from order_time) between 20 and 21 then  '20:00 - 22:00'
		when extract(hour from order_time) between 22 and 23 then  '22:00 - 00:00'
	end as time_slot,
	count(order_id) as order_count
from orders
group by time_slot
order by 2 desc
limit 5;


-- another approach
select
	floor(extract(hour from order_time)/2)*2 as start_time,
	floor(extract(hour from order_time)/2)*2+2 as end_time,
	count(*) as order_count
from orders
group by start_time, end_time
order by count(*) desc
limit 5;


-- -------------------------

-- Q.3 Order value analysis
-- Average orders by each customer who has ordered more than 20 times
-- return customer_name and avg_amnt (average of total_amount)

select * from orders;
select
	c.customer_name,
	count(o.order_id) as order_count,
	round(avg(o.total_amount)::numeric,2) as avg_amnt
	from orders as o
join customers as c
on c.customer_id = o.customer_id
group by c.customer_name
having count(o.order_id) >= 20
order by avg_amnt desc;


-- -------------------------

-- Q.4 High Value Customers
-- list the customers who spent more than 10k on food orders
-- return customer_name and customer_id

select
	c.customer_name,
	o.customer_id,
	round(sum(o.total_amount)::numeric,2) as tot_spent
	from orders as o
join customers as c
on c.customer_id = o.customer_id
group by c.customer_name, o.customer_id
having round(sum(o.total_amount)::numeric,2) >= 100000
order by tot_spent desc;


-- -------------------------

-- Q.5 Ordered but not delivered
-- list the orders which are ordered but not delivered
-- return the restaurant_name, city and number of not delivered orders

select * from restaurants;
select * from orders;
select * from deliveries;


select 
	r.restaurant_name,
	r.city,
	count(o.order_id) as not_delivered_count
from orders as o
left join restaurants as r
on r.restaurant_id = o.restaurant_id
left join deliveries as d
on d.order_id = o.order_id
where d.delivery_id is null
or
d.delivery_status = 'Not Delivered'
group by 1,2
order by not_delivered_count desc;


-- -------------------------

-- Q.6 Restaurant Revenue Ranking
-- Rank Restaurants by their total revenue from the last year, including their name
-- total revenue and rank within thier city


with ranking_table 
as
	(select 
		r.restaurant_name,
		r.city,
		sum(o.total_amount) as ttl_amnt,
		rank() over(partition by r.city order by sum(o.total_amount) desc) as rank
	from orders as o
	left join restaurants as r
	on r.restaurant_id = o.restaurant_id
	-- left join deliveries as d
	-- on d.order_id = o.order_id
	-- where extract(year from order_date) = '2020'
	where
		o.order_date >= current_date - interval '5 year'
	group by 1,2
	)
select * from ranking_table
where
	rank = 1;

-- This table has the list of restaurant names from each city which has highest revenue in the year 2020


-- -------------------------

-- Q.7 Most Popular Dish by City
-- To identify the most popular dish among each cities based on the number of orders

select * from
	(select
		CASE 
	        WHEN POSITION(',' IN r.city) > 0 THEN TRIM(SPLIT_PART(r.city, ',', 2))
	        ELSE r.city
	    END AS main_city,
		o.order_item as dish,
		count(o.order_item) as order_count,
		RANK() OVER (
	        PARTITION BY 
	            CASE 
	                WHEN POSITION(',' IN r.city) > 0 THEN TRIM(SPLIT_PART(r.city, ',', 2))
	                ELSE r.city
	            END 
	        ORDER BY COUNT(o.order_item) DESC
	    ) AS rank
		from orders as o
	join restaurants as r
	on r.restaurant_id = o.restaurant_id
	group by 1,2
	) 
as new_table
where rank = 1;

-- The complication of the above query is because some of the city name was having local place name 
-- with the city name seperated by comma, eg:- "Kamothe,Mumbai" "Greater Kailash 2,Delhi"
-- we wanted to group by the city name 


-- -------------------------

-- Q.8 Customer Churn (Find lost customers)
-- Find the customers who havent placed order in 2020 but did in 2019

select
	distinct c.customer_id,
	c.customer_name
	from customers as c
join orders as o
on c.customer_id = o.customer_id
where
	extract( year from o.order_date) = 2019
	and
	c.customer_id not in
	(
		select distinct customer_id from orders
		where
			extract ( year from o.order_date) = 2020
	)


-- -------------------------

-- Q.9 Cancellation rate comparison
-- Calculate and compare the order cancellation rate for each restaurant between the 
--  year 2019 and 2020
select * from deliveries;

with cancellation_ratio_2019
as
	(
	select 
		o.restaurant_id,
		count(o.order_id) as order_count,
		count(case when 
					d.delivery_id is null
					or
					d.delivery_status = 'Not Delivered'
					then 1
				end) not_delivered
	from orders as o
	left join deliveries as d
	on o.order_id = d.order_id
	where extract(year from o.order_date) = 2019
	group by 1
	),
cancellation_ratio_2020
as
	(
	select 
		o.restaurant_id,
		count(o.order_id) as order_count,
		count(case when 
					d.delivery_id is null
					or
					d.delivery_status = 'Not Delivered'
					then 1
				end) not_delivered
	from orders as o
	left join deliveries as d
	on o.order_id = d.order_id
	where extract(year from o.order_date) = 2020
	group by 1
	),
year_data_2019 as
		(
		select restaurant_id,
			order_count,
			not_delivered,
			round(
				not_delivered::numeric/order_count::numeric*100,2
				) as cancel_ratio
		from cancellation_ratio_2019
		),
year_data_2020 as
(
	select restaurant_id,
		order_count,
		not_delivered,
		round(
			not_delivered::numeric/order_count::numeric*100,2
			) as cancel_ratio
	from cancellation_ratio_2020
	)

select y_20.restaurant_id as rest_id,
	y_20.cancel_ratio as year_2020_ratio,
	y_19.cancel_ratio as year_2019_ratio
from year_data_2019 as y_19
join year_data_2020 as y_20
on y_19.restaurant_id = y_20.restaurant_id


-- -------------------------

-- Q.10 Rider Average Delivery Time
-- The average delivery time for each rider

select 
	o.order_id,
	r.rider_id,
	r.rider_name,
	o.order_time,
	d.delivery_time,
	-- d.delivery_time - o.order_time as time_taken,
	round(
		extract(epoch from (d.delivery_time - o.order_time +
		case
		when d.delivery_time < o.order_time then interval '1 day'
		else interval '0 day'
		end))/60,
	2) as time_taken_min
from orders as o
join deliveries as d
on o.order_id = d.order_id
join riders as r
on r.rider_id = d.rider_id
where d.delivery_status = 'Delivered'
