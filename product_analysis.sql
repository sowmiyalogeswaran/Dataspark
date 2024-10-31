#Product Popularity
SELECT 
    DISTINCT ProductName, 
    SUM(Quantity) AS Total_Quantity
FROM 
    Sales
JOIN 
    Products ON Sales.ProductKey = Products.ProductKey
GROUP BY 
    ProductName
ORDER BY 
    Total_Quantity DESC
LIMIT 10;
SELECT 
    DISTINCT ProductName, 
    SUM(Quantity) AS Total_Quantity
FROM 
    Sales
JOIN 
    Products ON Sales.ProductKey = Products.ProductKey
GROUP BY 
    ProductName
ORDER BY 
    Total_Quantity 
LIMIT 10;
#Profitability Analysis
SELECT
    ProductName,
    ROUND(SUM((UnitPriceUSD - UnitCostUSD) * Quantity), 2) AS Profit_Margin
FROM 
    Sales
JOIN 
    Products ON Sales.ProductKey = Products.ProductKey
GROUP BY 
    ProductName
ORDER BY 
    Profit_Margin DESC
LIMIT 10;
#Category Analysis
SELECT
    Category, 
    Subcategory, 
    ROUND(SUM(UnitPriceUSD * Quantity), 2) AS Total_Sales
FROM
    Sales
JOIN
    Products ON Sales.ProductKey = Products.ProductKey
GROUP BY 
    Category, 
    Subcategory
ORDER BY 
    Total_Sales DESC;
