#store performance based on sales, size (square meters), and operational data (open date)
SELECT 
    st.StoreKey,
    st.Country,
    st.State,
    st.SquareMeters,
    YEAR(CURDATE()) - YEAR(st.OpenDate) AS Store_Age,
    ROUND(SUM(p.UnitPriceUSD * s.Quantity), 2) AS Total_Sales
FROM 
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey
JOIN 
    Stores st ON s.StoreKey = st.StoreKey
GROUP BY 
    st.StoreKey, st.Country, st.State, st.SquareMeters, Store_Age
ORDER BY 
    Total_Sales DESC;

#Geographical Analysis
SELECT
    st.StoreKey,
    st.Country,
    st.State,
    ROUND(SUM(p.UnitPriceUSD * s.Quantity), 2) AS Total_Revenue_USD  
FROM
    Sales s
JOIN
    Products p ON s.ProductKey = p.ProductKey  
JOIN
    Stores st ON s.StoreKey = st.StoreKey     
GROUP BY
    st.StoreKey, st.Country, st.State
ORDER BY
    Total_Revenue_USD DESC
LIMIT 0, 1000;