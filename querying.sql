-- 1. Get All Churned Customers
-- This query selects all customers who have the status 'Churned' from the 'customers' table
SELECT customer_id, name, signup_date, plan_type, status
FROM customers
WHERE status = 'Churned';

-- 2. Get All Customers Who Renewed Their Subscriptions
-- This query joins 'customers' and 'subscriptions' tables to get customers who have renewed their subscription
SELECT c.customer_id, c.name, s.start_date, s.end_date, s.renewal_status
FROM customers c
INNER JOIN subscriptions s ON c.customer_id = s.customer_id
WHERE s.renewal_status = 'Renewed';

-- 3. Count Churned Customers Per Plan Type
-- This query counts how many churned customers belong to each subscription plan type (e.g., Basic, Premium)
SELECT plan_type, COUNT(*) AS churn_count
FROM customers
WHERE status = 'Churned'
GROUP BY plan_type;

-- 4. Churned Customers by Signup Year
-- This query groups churned customers by the year they signed up (using the 'signup_date' field)
SELECT YEAR(signup_date) AS signup_year, COUNT(*) AS churned_count
FROM customers
WHERE status = 'Churned'
GROUP BY YEAR(signup_date)
ORDER BY signup_year;

-- 5. Billing Info for Churned Customers
-- This query joins the 'customers' and 'billing' tables to fetch the billing details of customers who churned
SELECT c.customer_id, c.name, b.bill_date, b.amount_paid, b.payment_status
FROM customers c
INNER JOIN billing b ON c.customer_id = b.customer_id
WHERE c.status = 'Churned'
ORDER BY b.bill_date DESC;

-- 6. Churned Customers with Low Data Usage
-- This query identifies churned customers who have used less than 2GB of data, possibly indicating low engagement
SELECT c.customer_id, c.name, u.data_used_GB, c.status
FROM customers c
INNER JOIN usage_data u ON c.customer_id = u.customer_id
WHERE c.status = 'Churned' AND u.data_used_GB < 2;

-- 7. Support Issues from Churned Customers
-- This query identifies the types of support issues faced by customers who have churned
SELECT c.customer_id, c.name, s.issue_type, s.resolution_time, s.status
FROM customers c
INNER JOIN support_tickets s ON c.customer_id = s.customer_id
WHERE c.status = 'Churned';

-- 8. Total Active vs Churned Customers
-- This query compares the number of active customers versus churned customers
SELECT status, COUNT(*) AS customer_count
FROM customers
GROUP BY status;
