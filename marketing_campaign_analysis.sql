-- Marketing Campaign Analysis SQL Queries
-- Dataset reference: marketing_data.csv
-- These queries assume the CSV has been loaded into a SQL table named marketing_data

-- 1. Customer spending and purchase behavior
SELECT
    ID,
    Country,
    Education,
    Marital_Status,
    Income,
    Recency,
    (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS Total_Spend,
    (NumWebPurchases + NumCatalogPurchases + NumStorePurchases) AS Total_Purchases
FROM marketing_data;

-- 2. Revenue by country
SELECT
    Country,
    COUNT(ID) AS total_customers,
    AVG(Income) AS avg_income,
    SUM(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS total_spend
FROM marketing_data
GROUP BY Country
ORDER BY total_spend DESC;

-- 3. Channel performance summary
SELECT
    SUM(NumWebPurchases) AS total_web_purchases,
    SUM(NumCatalogPurchases) AS total_catalog_purchases,
    SUM(NumStorePurchases) AS total_store_purchases
FROM marketing_data;

-- 4. Product category performance
SELECT
    SUM(MntWines) AS wine_revenue,
    SUM(MntFruits) AS fruit_revenue,
    SUM(MntMeatProducts) AS meat_revenue,
    SUM(MntFishProducts) AS fish_revenue,
    SUM(MntSweetProducts) AS sweet_revenue,
    SUM(MntGoldProds) AS gold_revenue
FROM marketing_data;

-- 5. Campaign acceptance performance
SELECT
    SUM(AcceptedCmp1) AS accepted_campaign_1,
    SUM(AcceptedCmp2) AS accepted_campaign_2,
    SUM(AcceptedCmp3) AS accepted_campaign_3,
    SUM(AcceptedCmp4) AS accepted_campaign_4,
    SUM(AcceptedCmp5) AS accepted_campaign_5,
    SUM(Response) AS accepted_last_campaign
FROM marketing_data;

-- 6. Income segment analysis
SELECT
    CASE
        WHEN Income < 30000 THEN 'Low Income'
        WHEN Income BETWEEN 30000 AND 70000 THEN 'Middle Income'
        ELSE 'High Income'
    END AS income_segment,
    COUNT(*) AS customer_count,
    AVG(Income) AS avg_income,
    AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS avg_spend
FROM marketing_data
WHERE Income IS NOT NULL
GROUP BY
    CASE
        WHEN Income < 30000 THEN 'Low Income'
        WHEN Income BETWEEN 30000 AND 70000 THEN 'Middle Income'
        ELSE 'High Income'
    END
ORDER BY avg_spend DESC;

-- 7. High-value customers
SELECT
    ID,
    Country,
    Income,
    (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS Total_Spend
FROM marketing_data
ORDER BY Total_Spend DESC
LIMIT 20;

-- 8. Web activity vs purchases
SELECT
    NumWebVisitsMonth,
    AVG(NumWebPurchases) AS avg_web_purchases,
    AVG(Response) AS avg_response_rate
FROM marketing_data
GROUP BY NumWebVisitsMonth
ORDER BY NumWebVisitsMonth;

-- 9. Customer age analysis
SELECT
    (2024 - Year_Birth) AS Age,
    COUNT(*) AS customer_count,
    AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS avg_spend
FROM marketing_data
GROUP BY (2024 - Year_Birth)
ORDER BY Age;

-- 10. RFM-style base table for segmentation
SELECT
    ID,
    Recency,
    (NumWebPurchases + NumCatalogPurchases + NumStorePurchases) AS Frequency,
    (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS Monetary
FROM marketing_data;
