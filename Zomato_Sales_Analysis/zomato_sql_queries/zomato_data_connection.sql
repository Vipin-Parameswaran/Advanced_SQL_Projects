-- Zomato Data Analysis Using SQL

CREATE TABLE customers (
	customer_id	INT PRIMARY KEY,
	customer_name VARCHAR(30),
	reg_date DATE
)

CREATE TABLE restaurants (
	restaurant_id	INT PRIMARY KEY,
	restaurant_name	VARCHAR(50),
	city VARCHAR(50),
	opening_hours VARCHAR(30)
)

CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	customer_id	INT,
	restaurant_id INT,	
	order_item	VARCHAR(100),
	order_date	DATE,
	order_time	TIME,
	order_status VARCHAR(20),
	total_amount FLOAT

);


-- ADDING A CONSTRAINT for customer id to be a foreign key
ALTER TABLE orders
add constraint fk_customers
foreign key (customer_id)
references customers(customer_id);

-- ADDING A CONSTRAINT for restaurant id to be a foreign key
ALTER TABLE orders
add constraint fk_restaurant
foreign key (restaurant_id)
references restaurants(restaurant_id);


CREATE TABLE riders(
	rider_id INT PRIMARY KEY,
	rider_name	VARCHAR(35),
	sign_up DATE

);

-- drop table if exists deliveries;
CREATE TABLE deliveries(
	delivery_id int primary key,
	order_id int,
	delivery_status	varchar(55),
	delivery_time time,
	rider_id int,
	constraint fk_orders foreign key (order_id) references orders(order_id),
	constraint fk_riders foreign key (rider_id) references riders(rider_id)

);

