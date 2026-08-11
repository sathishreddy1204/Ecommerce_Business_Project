
use ecommerce;

-- Select Questions--

SELECT COUNT(*)
FROM cleaned_ecommerce_project;

select * from cleaned_ecommerce_project;

-- Unique Questions --

select distinct`Customer Name`from cleaned_ecommerce_project;

select distinct`Segment`from cleaned_ecommerce_project;

select distinct`City`from cleaned_ecommerce_project;

select distinct`State`from cleaned_ecommerce_project;

select distinct`Category`from cleaned_ecommerce_project;

select distinct`Sub-Category`from cleaned_ecommerce_project;

select distinct`Product Name`from cleaned_ecommerce_project;

-- Explore Data--
select * from cleaned_ecommerce_project limit 10;

-- Where Questions--

select * from cleaned_ecommerce_project
where profit>300;

select * from cleaned_ecommerce_project
where `Sub-Category`='Phones';

select * from cleaned_ecommerce_project
where delivery_days between 3 and 5;

-- Order by Questions

select * from cleaned_ecommerce_project
order by Sales desc;

select * from cleaned_ecommerce_project
order by customer_rating asc;

-- Aggregate Functions--

select sum(sales) as Revenue,
avg(Profit) as Aveage_Profit,
Max(Customer_rating) as Highest_rating,
min(Delivery_days) as Fast_delivery,
count(`Order ID`) as Orders 
from cleaned_ecommerce_project;

-- Business Questions --

-- Total Cost_price,Sales,Profit --
select round(sum(Cost_price),2) as Total_cost,
round(sum(sales),2) as Total_Sales,
round(sum(Profit),2) As Total_Profit
from cleaned_ecommerce_project;

-- Average Sales,Customer Rating,Delivery_daya
select round(avg(Sales),2) as Average_sales,
round(avg(Customer_rating),2) as Average_rating,
floor(avg(Delivery_days)) as Avg_Delivery_days
from cleaned_ecommerce_project;


-- Group by Questions--

-- Highest Shipping Cost by Product--
select `Product Name`,max(Shipping_Cost) as Highest_Shipping_cost 
from cleaned_ecommerce_project
group by `Product Name`
order by Highest_Shipping_cost Desc;

-- Categories ,Sub_Categories Sales Than 150000--
select Category,`Sub-Category` ,Round(sum(Sales),2) as  Revenue 
from cleaned_ecommerce_project
group by Category,`Sub-Category`
having Revenue>150000;

-- Most Used Payment Method--
select Payment_method,count(Payment_method) AS Count 
from cleaned_ecommerce_project
group by Payment_method
order by Count desc;

-- Cancelled orders--
select count(Order_status) As Order_Status from cleaned_ecommerce_project
where Order_status="Cancelled"
group by Order_status;

-- Top 10 product --
select `product name`,round(sum(sales),2) as revenue
from cleaned_ecommerce_project
group by `product name`
order by revenue desc
limit 10;

-- Sales By Region --
select region,round(sum(sales),2) as Revenue,count(`Order ID`) as Orders from cleaned_ecommerce_project
group by region
order by Revenue desc;

-- Most Revenue Category --
select category,round(sum(sales),2) as Revenue from cleaned_ecommerce_project
group by category
order by Revenue Desc;

-- Top 10 Customers  --
select `Customer Name` , round(sum(sales),2) as Revenue,round(Sum(Profit),2) As Highest_Profit
from cleaned_ecommerce_project
group by `Customer Name`
order by Revenue desc,Highest_Profit Desc limit 10;

-- Having Questions--

-- Orders Having More than 10 Customers--
select `Customer Name`, count(`Order ID`) as Orders
from cleaned_ecommerce_project
group by `Customer Name`
having Orders>10
order by Orders desc;

-- Total Cost_price by Product having more than 12000
select `Product Name`, Sum(`Cost_price`) as Cost_Price
from cleaned_ecommerce_project
group by `Product Name`
having Cost_Price>12000
order by Cost_Price desc;

-- Case When Questions--

-- DElivery Speed--
select `Product Name`,floor(Avg(Delivery_days)) As Delivery_Days,
case
      when avg(Delivery_days)<=3 then 'Fast Delivery'
      when avg(Delivery_days)<=7 then 'Normal Delivery'
      else 'Slow Delivery'
End as Delivery_Status 
from cleaned_ecommerce_project
group by `Product Name`
order by Delivery_days asc;

-- Subqueries--

-- Product above avg Profit--
select `Product Name`,Profit
from cleaned_ecommerce_project
where profit>
(
        select avg(profit) 
        from cleaned_ecommerce_project
);

-- Window Functions--

-- Customers Ranking--
select `Customer Name`,round(sum(Sales),2) as Revenue,
Rank() over(order by Sum(Sales) desc) as Rank_No
from cleaned_ecommerce_project
group by `Customer Name`;

-- Dense Rank by Product ---
select `Product Name`,round(sum(Profit),2) as Profit,
dense_rank() over(order by Sum(Profit) desc) as Dense
from cleaned_ecommerce_project
group by `Product Name`;

-- Date Functions--

-- Monthly Sales Trend --
select month(str_to_date(`Order Date`,'%d/%m/%Y')) as Month ,
round(sum(sales),2) as Revenue 
from cleaned_ecommerce_project
group by Month
order by Month;

-- Yearly Sales Trend --
select year(str_to_date(`Order Date`,'%d/%m/%Y')) as Year ,
count(`Order ID`) as Orders,
round(sum(sales),2) as Revenue 
from cleaned_ecommerce_project
group by Year
order by Year;

-- String Functions--

-- converting to uppercase--

select Upper(`Sub-Category`) as Upper,lower(City) as lower,
concat(`Customer Name`,'-', State)
 from cleaned_ecommerce_project;



