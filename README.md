# Zomato Sales Analysis SQL Project

# ![zomato Logo](https://github.com/Vipin-Parameswaran/Zomato_Sales_Analysis-Advanced_SQL/blob/main/zomato_logo_new.png)

## Project Overview

In this project, we aim to perform an in-depth analysis of Zomato’s sales data, using SQL to answer critical business questions that impact Zomato's growth and profitability. By leveraging advanced SQL techniques, we can uncover trends, identify key performance indicators (KPIs), and generate actionable insights that can guide business decisions.

The project is ideal for data analysts looking to enhance their SQL skills by working with a large-scale dataset and solving real-world business questions.

## Entity Relationship Diagram (ERD)

![ERD](https://github.com/Vipin-Parameswaran/Zomato_Sales_Analysis-Advanced_SQL/blob/main/Zomato_Sales_Analysis/Schema_image.png)


## Database Schema

The project utilizes five primary tables to analyze customer orders, restaurant performance, and delivery operations. Each table contains specific information that, together, provides a comprehensive view of Zomato’s operations.

#### customers: Contains information about Zomato customers.
Attributes: customer_id, customer_name, join_date
Description: Stores essential details about customers, including their contact information and location, which is useful for customer segmentation and churn analysis.

#### restaurants: Holds details about restaurants on the Zomato platform.
Attributes: restaurant_id, restaurant_name, city, opening hours
Description: Includes restaurant-specific data such as location, cuisine, and average cost, which helps analyze restaurant performance, revenue ranking, and popular dishes by city.

#### orders: Stores information about each customer order.
Attributes: order_id, customer_id, restaurant_id, order_item, order_date, order_time, total_amount, status (e.g., "delivered", "not delivered", "canceled")
Description: Contains transaction details for each order, allowing for order value analysis, peak order time analysis, and the identification of high-value customers. This table is central to analyzing order trends and cancellation rates.

#### riders: Contains data about delivery riders.
Attributes: rider_id, rider_name, signup_date
Description: Includes rider-specific information used for delivery time analysis and rider performance evaluations, helping Zomato optimize delivery operations.

#### deliveries: Details each delivery attempt for orders.
Attributes: delivery_id, order_id, rider_id, delivery_time, status (e.g., "delivered", "failed")
Description: Tracks each delivery event, providing information on delivery times, distances, and completion statuses. This data is essential for calculating average delivery times per rider and understanding order fulfillment challenges.

## Business Questions and Approach:

### Most Frequently Ordered Dishes:
Objective: Identify the top dishes that customers frequently order to inform popular menu items and supply chain planning.
Approach: Analyze order data to rank the top dishes by frequency, helping Zomato identify customer preferences across its platform.

### Peak Time Slots for Orders:
Objective: Understand peak times for orders to optimize staffing and delivery logistics.
Approach: Determine the 2-hour intervals with the highest order volumes to inform decisions on peak-time resource allocation.

### Customer Order Value Analysis:
Objective: Gain insights into high-frequency customers by calculating their average spending.
Approach: For customers who order frequently, calculate the average order value, helping to identify customer segments with high lifetime value.

### High-Value Customers:
Objective: Identify customers with significant spending on the platform for targeted marketing and loyalty initiatives.
Approach: Analyze total spending per customer to determine a segment of high-value customers who contribute heavily to Zomato’s revenue.

### Orders Not Delivered:
Objective: Track instances where orders were not delivered to pinpoint operational issues or restaurant-specific challenges.
Approach: List orders that were placed but not delivered, providing insights for Zomato to improve customer satisfaction and reduce failed orders.

### Restaurant Revenue Ranking:
Objective: Rank restaurants by revenue to identify top-performing venues within each city.
Approach: Calculate and rank total revenue for each restaurant, giving Zomato insight into which restaurants generate the highest revenue in each city.

### Most Popular Dish by City:
Objective: Understand local customer preferences by identifying the top dishes in each city.
Approach: Determine the most popular dish per city based on order volume, enabling Zomato to tailor its offerings based on regional tastes.

### Customer Churn Analysis:
Objective: Identify customers who have not returned to the platform after a period, helping Zomato target re-engagement efforts.
Approach: Analyze customer ordering patterns over time to detect churned customers, assisting Zomato in re-engagement strategies.

### Order Cancellation Rate Comparison:
Objective: Compare cancellation rates to gauge restaurant reliability and customer satisfaction.
Approach: Calculate order cancellation rates across different time periods to identify trends and target improvements in service reliability.

### Rider Delivery Efficiency:
Objective: Evaluate rider performance by analyzing average delivery times.
Approach: Calculate each rider’s average delivery time to assess efficiency and guide training or process improvements.

### Monthly Restaurant Growth Rate:
Objective: Track restaurant growth on the platform to measure expansion and performance.
Approach: Calculate growth rates of restaurants monthly, giving Zomato insight into platform adoption and market presence.

### Customer Segmentation:
Objective: Segment customers into distinct groups based on behavior and spending to tailor marketing and offerings.
Approach: Use spending, order frequency, and other behavioral data to cluster customers, helping Zomato develop targeted engagement strategies.

## SQL Techniques Summary:
The project involves the use of advanced SQL techniques, including window functions (e.g., RANK, ROW_NUMBER), aggregate functions (SUM, AVG), conditional expressions, joins, and partitioning. These tools allow efficient analysis of large datasets across multiple tables, enabling Zomato to uncover detailed insights and optimize decision-making.

## Outcome:
Through this SQL-based analysis, Zomato can leverage insights to improve customer satisfaction, streamline operations, and increase revenue. Understanding customer preferences, peak times, high-value segments, and restaurant performance will allow Zomato to implement strategic changes to strengthen its market position and enhance service quality.


## Project Focus

This project primarily focuses on developing and showcasing the following SQL skills:

- **Complex Joins and Aggregations**: Demonstrating the ability to perform complex SQL joins and aggregate data meaningfully.
- **Window Functions**: Using advanced window functions for running totals, growth analysis, and time-based queries.
- **Data Segmentation**: Analyzing data across different time frames to gain insights into product performance.
- **Correlation Analysis**: Applying SQL functions to determine relationships between variables, such as product price and warranty claims.
- **Real-World Problem Solving**: Answering business-related questions that reflect real-world scenarios faced by data analysts.


