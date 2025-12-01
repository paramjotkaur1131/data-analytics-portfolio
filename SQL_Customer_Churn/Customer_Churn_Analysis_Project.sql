-- 1. Create database & table
CREATE DATABASE churn_analysis;
USE churn_analysis;

CREATE TABLE telco_churn (
    customerID VARCHAR(50),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(40),
    MonthlyCharges FLOAT,
    TotalCharges FLOAT,
    Churn VARCHAR(10)
);

-- 2. View first few rows
SELECT * FROM telco_churn LIMIT 10;

-- 3. Check total number of customers & columns
SELECT COUNT(*) AS total_rows FROM telco_churn;

-- 4. Churn count (Yes vs No)
SELECT Churn, COUNT(*) AS total_customers 
FROM telco_churn 
GROUP BY Churn;

-- 5. Churn by contract type
SELECT Contract,
       SUM(Churn = 'Yes') AS churned,
       SUM(Churn = 'No') AS stayed
FROM telco_churn
GROUP BY Contract;

-- 6. Average monthly charges for churned vs not churned
SELECT Churn,
       ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_churn
GROUP BY Churn;

-- 7. Average tenure for churned vs not churned
SELECT Churn,
       ROUND(AVG(tenure), 2) AS avg_tenure
FROM telco_churn
GROUP BY Churn;

-- 8. Churn by Internet Service type
SELECT InternetService,
       SUM(Churn = 'Yes') AS churned,
       SUM(Churn = 'No') AS stayed
FROM telco_churn
GROUP BY InternetService;

-- 9. Senior citizens churn rate
SELECT SeniorCitizen,
       SUM(Churn = 'Yes') AS churned,
       SUM(Churn = 'No') AS stayed
FROM telco_churn
GROUP BY SeniorCitizen;

-- 10. Dependents vs Churn
SELECT Dependents,
       SUM(Churn = 'Yes') AS churned,
       SUM(Churn = 'No') AS stayed
FROM telco_churn
GROUP BY Dependents;

-- 11. High monthly charge customers churn more?
SELECT 
    CASE 
        WHEN MonthlyCharges < 50 THEN 'Low Charges'
        WHEN MonthlyCharges BETWEEN 50 AND 80 THEN 'Medium Charges'
        ELSE 'High Charges'
    END AS Charge_Category,
    SUM(Churn='Yes') AS churned
FROM telco_churn
GROUP BY Charge_Category;