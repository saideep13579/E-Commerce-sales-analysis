create database Ecommerce;

use Ecommerce;

-- i have make the tables by using the data import 

drop table details;

drop table orders;

-- now lets see how the the tables containts look like

select * from details;

select * from orders;

--  Inner Join (Combine Tables Based on Matching Order ID)

SELECT o.OrderID, o.OrderDate, o.CustomerName, o.State, o.City, 
       d.Amount, d.Profit, d.Quantity, d.Category, d.SubCategory, d.PaymentMode
FROM orders o
JOIN details d 
ON o.OrderID = d.OrderID;

-- Left Join (Get All Orders, Even if Details Are Missing)

SELECT o.OrderID, o.OrderDate, o.CustomerName, o.State, o.City, 
       d.Amount, d.Profit, d.Quantity, d.Category, d.SubCategory, d.PaymentMode
FROM orders o
LEFT JOIN details d 
ON o.OrderID = d.OrderID;


--  Aggregations and Insights

-- a) Total Revenue (Amount) by State

SELECT o.State, SUM(d.Amount) AS TotalRevenue
FROM orders o
JOIN details d 
ON o.OrderID = d.OrderID
GROUP BY o.State
ORDER BY TotalRevenue DESC;

--  Profit Margin by Category

SELECT d.Category, SUM(d.Profit) AS TotalProfit, SUM(d.Amount) AS TotalRevenue, 
       (SUM(d.Profit) / SUM(d.Amount)) * 100 AS ProfitMarginPercentage
FROM details d
GROUP BY d.Category
ORDER BY ProfitMarginPercentage DESC;

-- Top 5 Cities by Total Sales

SELECT o.City, SUM(d.Amount) AS TotalSales
FROM orders o
JOIN details d 
ON o.OrderID = d.OrderID
GROUP BY o.City
ORDER BY TotalSales DESC
LIMIT 5;

--  Filtering Data

-- a) Orders from a Specific State (Maharashtra)

SELECT o.OrderID, o.OrderDate, o.CustomerName, d.Amount
FROM orders o
JOIN details d 
ON o.OrderID = d.OrderID
WHERE o.State = 'Maharashtra';

-- b) Orders with Profit Above 500 rupees

SELECT o.OrderID, o.CustomerName, d.Profit, d.Amount
FROM orders o
JOIN details d 
ON o.OrderID = d.OrderID
WHERE d.Profit > 500;

-- Most Popular Sub-Category (Based on Quantity Sold)

SELECT d.SubCategory, SUM(d.Quantity) AS TotalQuantity
FROM details d
GROUP BY d.SubCategory
ORDER BY TotalQuantity DESC
LIMIT 1;

-- Payment Mode Analysis

SELECT d.PaymentMode, COUNT(*) AS OrderCount, SUM(d.Amount) AS TotalSales
FROM details d
GROUP BY d.PaymentMode
ORDER BY TotalSales DESC;

