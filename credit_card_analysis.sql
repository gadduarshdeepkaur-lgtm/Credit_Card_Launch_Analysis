CREATE DATABASE credit_card_analysis;
USE credit_card_analysis;

CREATE TABLE customers (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
customer_age INT,
age_group VARCHAR(20),
gender VARCHAR(10),
income_inr VARCHAR(50),
income_group VARCHAR(50),
credit_limit DECIMAL(10,2),
total_trans_amt INT,
total_trans_count INT,
avg_trans_value DECIMAL(10,2),
spending_level VARCHAR(20)
);

-- total customers 
SELECT COUNT(*) AS total_customers
FROM customers;

-- Customer distribution by income group 
SELECT income_group, COUNT(*) as customers
FROM customers
GROUP BY income_group
ORDER BY customers DESC;

-- Avg credit limit by income group
SELECT income_group, AVG(credit_limit) as avg_credit_limit
FROM customers
GROUP BY income_group;

-- Total spending by income group
SELECT income_group, SUM(total_trans_amt) as total_spending
FROM customers
GROUP BY income_group
ORDER BY total_spending DESC;

-- Avg transaction value by age group
SELECT age_group, SUM(total_trans_amt)/SUM(total_trans_count) as avg_transaction_value
FROM customers
GROUP BY age_group;

-- High spenders count
SELECT spending_level, COUNT(*) as customers
FROM customers
GROUP BY spending_level;

-- Best target customers
SELECT *
FROM customers
WHERE income_group='High Income'
AND spending_level='High';

-- Revenue contribution by segment
SELECT income_group, spending_level, SUM(total_trans_amt) AS revenue
FROM customers
GROUP BY income_group, spending_level
ORDER BY revenue DESC;

-- Rank customers by spending 
SELECT *,
RANK() OVER(ORDER BY total_trans_amt DESC) as spending_rank
FROM customers;

-- Top 10% customers
SELECT *
FROM(
SELECT *,
NTILE(10) OVER (ORDER BY total_trans_amt DESC) as percentile
FROM customers
) t
WHERE percentile=1;



