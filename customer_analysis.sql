#distribution of customers based on gender, age, location
SELECT gender, COUNT(*) AS Countgender
FROM customers
GROUP BY gender;
# country wise customer count
SELECT 
    continent,country,state,city, 
    COUNT(CustomerKey) AS customercount
FROM 
    CUSTOMERS
GROUP BY 
    continent,country,state,city
ORDER BY 
    customercount DESC;
#Purchase Patterns
#Average Order Value (AOV)
SELECT 
    ROUND(SUM(p.UnitPriceUSD * s.Quantity) / COUNT(DISTINCT s.OrderNumber), 2) AS Average_Order_Value
FROM 
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey;
#Frequency of Purchases
SELECT 
    c.CustomerKey,
    COUNT(DISTINCT s.OrderNumber) AS Frequency_of_Purchases
FROM 
    Customers c
JOIN 
    Sales s ON c.CustomerKey = s.CustomerKey
GROUP BY 
    c.CustomerKey
ORDER BY 
    Frequency_of_Purchases DESC;
#Preferred Products
SELECT 
    p.ProductName,
    SUM(s.Quantity) AS Total_Quantity_Sold
FROM 
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    p.ProductName
ORDER BY 
    Total_Quantity_Sold DESC
LIMIT 10;  
#Customer Segmentation by Age and Gender
SELECT 
    CASE
        WHEN YEAR(CURDATE()) - YEAR(c.Birthday) <= 18 THEN '<=18'
        WHEN YEAR(CURDATE()) - YEAR(c.Birthday) BETWEEN 19 AND 25 THEN '19-25'
        WHEN YEAR(CURDATE()) - YEAR(c.Birthday) BETWEEN 26 AND 35 THEN '26-35'
        WHEN YEAR(CURDATE()) - YEAR(c.Birthday) BETWEEN 36 AND 45 THEN '36-45'
        WHEN YEAR(CURDATE()) - YEAR(c.Birthday) BETWEEN 46 AND 55 THEN '46-55'
        WHEN YEAR(CURDATE()) - YEAR(c.Birthday) BETWEEN 56 AND 65 THEN '56-65'
        ELSE '>65'
    END AS Age_Group,
    c.Gender,
    COUNT(DISTINCT c.CustomerKey) AS Customer_Count,
    SUM(s.Quantity) AS Total_Quantity,
    ROUND(SUM(s.Quantity * p.UnitPriceUSD), 2) AS Total_Spend
FROM 
    Customers c
JOIN 
    Sales s ON c.CustomerKey = s.CustomerKey
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    Age_Group, c.Gender
ORDER BY 
    Total_Spend DESC;
-- Customer Segmentation by Purchase Behavior
SELECT 
    c.CustomerKey,
    SUM(s.Quantity * p.UnitPriceUSD) AS Total_Spend,
    COUNT(DISTINCT s.OrderNumber) AS Frequency_of_Purchases,
    CASE 
        WHEN SUM(s.Quantity * p.UnitPriceUSD) < 100 THEN 'Low Spender'
        WHEN SUM(s.Quantity * p.UnitPriceUSD) BETWEEN 100 AND 500 THEN 'Medium Spender'
        ELSE 'High Spender'
    END AS Spending_Category
FROM 
    Customers c
JOIN 
    Sales s ON c.CustomerKey = s.CustomerKey
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    c.CustomerKey
ORDER BY 
    Total_Spend DESC;


