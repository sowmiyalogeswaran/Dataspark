SELECT
    MONTH(OrderDate) AS Month_Number,
    MONTHNAME(OrderDate) AS Month_Name,
    ROUND(SUM(UnitPriceUSD * Quantity), 2) AS Total_Revenue_USD
FROM
    Sales
JOIN 
    Products ON Sales.ProductKey = Products.ProductKey  
GROUP BY
    MONTH(OrderDate), MONTHNAME(OrderDate)
ORDER BY 
    MONTH(OrderDate);
SELECT
    p.ProductName,
    SUM(s.Quantity) AS Total_Quantity
FROM
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY
    p.ProductName
ORDER BY 
    Total_Quantity DESC  
LIMIT 10;
SELECT
    s.StoreKey,
    ROUND(SUM(p.UnitPriceUSD * s.Quantity), 2) AS Total_Revenue_USD
FROM
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY
    s.StoreKey
ORDER BY 
    Total_Revenue_USD DESC;
    SELECT
    p.ProductName,
    ROUND(SUM(p.UnitPriceUSD * s.Quantity), 2) AS Total_Revenue_USD
FROM
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY
    p.ProductName
ORDER BY 
    Total_Revenue_USD DESC 
LIMIT 10;