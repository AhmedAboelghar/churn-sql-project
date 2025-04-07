CREATE DATABASE CustomerChurn;
GO
USE CustomerChurn;
GO
-- 1. Customers Table
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    signup_date DATE NOT NULL,
    plan_type NVARCHAR(20) CHECK (plan_type IN ('Basic', 'Premium', 'Enterprise')) NOT NULL,
    status NVARCHAR(10) CHECK (status IN ('Active', 'Churned')) DEFAULT 'Active'
);

-- 2. Subscriptions Table
CREATE TABLE subscriptions (
    subscription_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    renewal_status NVARCHAR(10) CHECK (renewal_status IN ('Renewed', 'Cancelled')) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 3. Usage Data Table
CREATE TABLE usage_data (
    usage_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    month DATE NOT NULL,
    call_minutes INT DEFAULT 0,
    data_used_GB DECIMAL(5,2) DEFAULT 0.00,
    sms_sent INT DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 4. Billing Table
CREATE TABLE billing (
    bill_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    bill_date DATE NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_status NVARCHAR(10) CHECK (payment_status IN ('Paid', 'Late', 'Unpaid')) DEFAULT 'Paid',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 5. Support Tickets Table
CREATE TABLE support_tickets (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    issue_type NVARCHAR(255) NOT NULL,
    resolution_time INT NULL, -- Time in hours
    status NVARCHAR(10) CHECK (status IN ('Open', 'Resolved', 'Escalated')) DEFAULT 'Open',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
--Inserting Data
INSERT INTO customers (name, signup_date, plan_type, status)
VALUES 
('Ahmed', '2024-01-15', 'Premium', 'Active'),
('John Doe', '2023-07-01', 'Basic', 'Churned'),
('Sara Ali', '2024-03-20', 'Enterprise', 'Active'),
('Mohamed Tarek', '2022-10-10', 'Premium', 'Churned'),
('Ali Mohamed', '2023-12-05', 'Basic', 'Active');

 
 INSERT INTO subscriptions (customer_id, start_date, end_date, renewal_status)
VALUES 
(1, '2024-01-15', '2025-01-15', 'Renewed'),
(2, '2023-07-01', '2024-07-01', 'Cancelled'),
(3, '2024-03-20', '2025-03-20', 'Renewed'),
(4, '2022-10-10', '2023-10-10', 'Cancelled'),
(5, '2023-12-05', '2024-12-05', 'Renewed');

INSERT INTO usage_data (customer_id, month, call_minutes, data_used_GB, sms_sent)
VALUES 
(1, '2024-01-01', 120, 5.3, 50),
(2, '2023-07-01', 80, 2.5, 30),
(3, '2024-03-01', 150, 8.2, 60),
(4, '2022-10-10', 90, 4.1, 40),
(5, '2023-12-01', 110, 6.0, 45);


INSERT INTO billing (customer_id, bill_date, amount_paid, payment_status)
VALUES 
(1, '2024-01-15', 100.50, 'Paid'),
(2, '2023-07-01', 50.00, 'Unpaid'),
(3, '2024-03-20', 200.00, 'Paid'),
(4, '2022-10-10', 120.00, 'Late'),
(5, '2023-12-05', 75.00, 'Paid');

INSERT INTO support_tickets (customer_id, issue_type, resolution_time, status)
VALUES 
(1, 'Billing Issue', 2, 'Resolved'),
(2, 'Service Outage', 5, 'Resolved'),
(3, 'Account Lock', 1, 'Escalated'),
(4, 'Payment Failure', 6, 'Resolved'),
(5, 'Slow Internet', 4, 'Open');
  
  SELECT customer_id, name, signup_date, plan_type, status
FROM customers
WHERE status = 'Churned';