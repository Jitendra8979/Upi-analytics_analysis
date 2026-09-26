# create database
create database upi_analytics_db;
use upi_analytics_db;

# Customer Master Table
CREATE TABLE customer_master (
    customer_id VARCHAR(32) PRIMARY KEY,
    full_name VARCHAR(128) NOT NULL,
    mobile_number VARCHAR(15),
    age INT CHECK (age >= 18 AND age <= 100),
    gender VARCHAR(16),
    region VARCHAR(32),
    date_joined DATE NOT NULL,
    is_business_user BOOLEAN DEFAULT FALSE,
    risk_score DECIMAL(4, 3) CHECK (risk_score BETWEEN 0.000 AND 1.000)
    
);

# 2. Merchant Info Table
CREATE TABLE merchant_info (
    merchant_id VARCHAR(32) PRIMARY KEY,
    merchant_name VARCHAR(128) NOT NULL,
    merchant_type VARCHAR(64) NOT NULL,
    region VARCHAR(32),
    onboard_date DATE NOT NULL,
    risk_score DECIMAL(4, 3) CHECK (risk_score BETWEEN 0.000 AND 1.000)
);
# 3. Device Info Table
CREATE TABLE device_info (
    device_id VARCHAR(32) PRIMARY KEY,
    customer_id VARCHAR(32) NOT NULL,
    device_type VARCHAR(32) NOT NULL,
    app_version VARCHAR(16),
    is_rooted BOOLEAN DEFAULT FALSE,
    last_active DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id)
);

# 4. UPI Account Details Table
CREATE TABLE upi_account_details (
    upi_id VARCHAR(64) PRIMARY KEY,
    customer_id VARCHAR(32) NOT NULL,
    bank_name VARCHAR(64) NOT NULL,
    account_type VARCHAR(32),
    date_added DATE NOT NULL,
    status VARCHAR(16) CHECK (status IN ('Active', 'Blocked', 'Suspended')),
    FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id)
);

-- 5. Customer Feedback Surveys
CREATE TABLE customer_feedback_surveys (
    feedback_id VARCHAR(32) PRIMARY KEY,
    customer_id VARCHAR(32) NOT NULL,
    date_submitted DATE NOT NULL,
    feedback_text TEXT,
    satisfaction_score INT CHECK (satisfaction_score BETWEEN 1 AND 5),
    issue_type VARCHAR(64),
    resolved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id)
);
# 6. UPI Transaction History (The Fact Table)
CREATE TABLE upi_transaction_history (
    transaction_id VARCHAR(32) PRIMARY KEY,
    upi_id VARCHAR(64) NOT NULL,
    customer_id VARCHAR(32) NOT NULL,
    `timestamp` varchar(50) NOT NULL,
    amount DECIMAL(12, 2) NOT NULL CHECK (amount > 0),
    transaction_type VARCHAR(32),
    merchant_id VARCHAR(32) NULL, -- Nullable because of P2P transactions
    counterparty_upi VARCHAR(64),
    status VARCHAR(16) NOT NULL CHECK (status IN ('Success', 'Failed', 'Pending')),
    device_id VARCHAR(32) NOT NULL,
    device_type VARCHAR(32),
    channel VARCHAR(32),
    fraud_flag BOOLEAN DEFAULT FALSE,
    reversal_flag BOOLEAN DEFAULT FALSE,
    failure_reason VARCHAR(128),
    FOREIGN KEY (upi_id) REFERENCES upi_account_details(upi_id),
    FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id),
    FOREIGN KEY (merchant_id) REFERENCES merchant_info(merchant_id),
    FOREIGN KEY (device_id) REFERENCES device_info(device_id)
);

# 7. Fraud Alert History
CREATE TABLE fraud_alert_history (
    alert_id VARCHAR(32) PRIMARY KEY,
    transaction_id VARCHAR(32) NOT NULL,
    alert_type VARCHAR(64) NOT NULL,
    alert_date DATETIME NOT NULL,
    resolved BOOLEAN DEFAULT FALSE,
    resolution_date DATETIME NULL,
    remarks TEXT,
    FOREIGN KEY (transaction_id) REFERENCES upi_transaction_history(transaction_id)
);

# loading data from excel to sql 
SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION';



SET GLOBAL local_infile =1;

# importing data of customer_master
LOAD DATA LOCAL INFILE 'C:/Users/Puneet Kashyap/OneDrive/Desktop/capstone project/customer_master.csv'
INTO TABLE upi_analytics_db.customer_master
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# importing data of merchant_info
LOAD DATA LOCAL INFILE 'C:/Users/Puneet Kashyap/OneDrive/Desktop/capstone project/merchant_info.csv'
INTO TABLE upi_analytics_db.merchant_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
show warnings;


# importing data of device_info

LOAD DATA LOCAL INFILE 'C:/Users/Puneet Kashyap/OneDrive/Desktop/capstone project/device_info.csv'
INTO TABLE upi_analytics_db.device_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;	


# importing data of upi_account_details

LOAD DATA LOCAL INFILE 'C:/Users/Puneet Kashyap/OneDrive/Desktop/capstone project/upi_account_details.csv'
INTO TABLE upi_analytics_db.upi_account_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


# importing data of upi_account_details

LOAD DATA LOCAL INFILE 'C:/Users/Puneet Kashyap/OneDrive/Desktop/capstone project/upi_account_details.csv'
INTO TABLE upi_analytics_db.upi_account_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


# importing data of customer_feedback_surveys

LOAD DATA LOCAL INFILE 'C:/Users/Puneet Kashyap/OneDrive/Desktop/capstone project/customer_feedback_surveys.csv'
INTO TABLE upi_analytics_db.customer_feedback_surveys
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# importing data of upi_transaction_history

LOAD DATA LOCAL INFILE 'C:/Users/Puneet Kashyap/OneDrive/Desktop/capstone project/upi_transaction_history.csv'
INTO TABLE upi_analytics_db.upi_transaction_history
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
show warnings;


# importing data of fraud_alert_history

LOAD DATA LOCAL INFILE 'C:/Users/Puneet Kashyap/OneDrive/Desktop/capstone project/fraud_alert_history.csv'
INTO TABLE upi_analytics_db.fraud_alert_history
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
show warnings;

SET FOREIGN_KEY_CHECKS = 1;

select count(*) from fraud_alert_history;
SELECT * FROM fraud_alert_history  LIMIT 10;
ALTER TABLE upi_analytics_db.fraud_alert_history 
MODIFY COLUMN alert_date VARCHAR(50), 
MODIFY COLUMN resolution_date VARCHAR(50);

SET FOREIGN_KEY_CHECKS = 1;


-- 1. Validate Row Counts Across All Tables (Including Customer Feedback)
SELECT 'customer_master' AS Table_Name, COUNT(*) AS Total_Rows FROM customer_master
UNION ALL
SELECT 'merchant_info', COUNT(*) FROM merchant_info
UNION ALL
SELECT 'device_info', COUNT(*) FROM device_info
UNION ALL
SELECT 'upi_account_details', COUNT(*) FROM upi_account_details
UNION ALL
SELECT 'upi_transaction_history', COUNT(*) FROM upi_transaction_history
UNION ALL
SELECT 'fraud_alert_history', COUNT(*) FROM fraud_alert_history
UNION ALL
SELECT 'customer_feedback', COUNT(*) FROM customer_feedback_surveys;
-- 2. Validate Foreign Key Consistency (Spot Check for Orphans in SQL)
SELECT COUNT(*) AS orphaned_transactions
FROM upi_transaction_history t
LEFT JOIN customer_master c ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL; 
-- (This should return 0, proving your Excel validation worked perfectly)


































































































