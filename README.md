# Ecommerce SQL Project

This project demonstrates the creation and analysis of an e-commerce database using SQL. It includes the creation of tables, importing data, performing various SQL queries, and generating insights from the data.

## Database Setup

1. **Create the Database**
    ```sql
    CREATE DATABASE Ecommerce;
    USE Ecommerce;
    ```

2. **Import the Data**
    - Use the data import functionality to create the following tables:
      - `orders`
      - `details`

3. **Drop Existing Tables**
    If the tables already exist, drop them before re-importing:
    ```sql
    DROP TABLE details;
    DROP TABLE orders;
    ```

4. **Verify Table Contents**
    ```sql
    SELECT * FROM details;
    SELECT * FROM orders;
    ```

## Queries and Analysis

### 1. Inner Join
Combine the `orders` and `details` tables based on matching `Order ID`:
```sql
SELECT o.OrderID, o.OrderDate, o.CustomerName, o.State, o.City, 
       d.Amount, d.Profit, d.Quantity, d.Category, d.SubCategory, d.PaymentMode
FROM orders o
JOIN details d 
ON o.OrderID = d.OrderID;
```

### 2. Left Join
Get all orders, even if details are missing:
```sql
SELECT o.OrderID, o.OrderDate, o.CustomerName, o.State, o.City, 
       d.Amount, d.Profit, d.Quantity, d.Category, d.SubCategory, d.PaymentMode
FROM orders o
LEFT JOIN details d 
ON o.OrderID = d.OrderID;
```

### 3. Aggregations and Insights

#### a) Total Revenue by State
```sql
SELECT o.State, SUM(d.Amount) AS TotalRevenue
FROM orders o
JOIN details d 
ON o.OrderID = d.OrderID
GROUP BY o.State
ORDER BY TotalRevenue DESC;
```

#### b) Profit Margin by Category
```sql
SELECT d.Category, SUM(d.Profit) AS TotalProfit, SUM(d.Amount) AS TotalRevenue, 
       (SUM(d.Profit) / SUM(d.Amount)) * 100 AS ProfitMarginPercentage
FROM details d
GROUP BY d.Category
ORDER BY ProfitMarginPercentage DESC;
```

#### c) Top 5 Cities by Total Sales
```sql
SELECT o.City, SUM(d.Amount) AS TotalSales
FROM orders o
JOIN details d 
ON o.OrderID = d.OrderID
GROUP BY o.City
ORDER BY TotalSales DESC
LIMIT 5;
```

### 4. Filtering Data

#### a) Orders from a Specific State (Maharashtra)
```sql
SELECT o.OrderID, o.OrderDate, o.CustomerName, d.Amount
FROM orders o
JOIN details d 
ON o.OrderID = d.OrderID
WHERE o.State = 'Maharashtra';
```

#### b) Orders with Profit Above 500 Rupees
```sql
SELECT o.OrderID, o.CustomerName, d.Profit, d.Amount
FROM orders o
JOIN details d 
ON o.OrderID = d.OrderID
WHERE d.Profit > 500;
```

### 5. Advanced Analysis

#### a) Most Popular Sub-Category (Based on Quantity Sold)
```sql
SELECT d.SubCategory, SUM(d.Quantity) AS TotalQuantity
FROM details d
GROUP BY d.SubCategory
ORDER BY TotalQuantity DESC
LIMIT 1;
```

#### b) Payment Mode Analysis
```sql
SELECT d.PaymentMode, COUNT(*) AS OrderCount, SUM(d.Amount) AS TotalSales
FROM details d
GROUP BY d.PaymentMode
ORDER BY TotalSales DESC;
