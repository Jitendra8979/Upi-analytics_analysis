# 💸 End-to-End UPI Transaction Analysis & Fraud Detection

## 📌 Project Overview
This capstone project provides a comprehensive analysis of UPI transactions to uncover spending patterns, evaluate transaction success rates, and detect potential fraudulent activities. The project covers the entire data pipeline, from database ingestion and cleaning to statistical hypothesis testing and interactive dashboarding.

## 🛠️ Tech Stack & Tools
* **Database & Querying:** MySQL (Relational database design, data ingestion scripts, complex joins, and aggregations)
* **Data Processing & EDA:** Python (Pandas, NumPy) and Microsoft Excel (Data cleaning, XLOOKUP, Pivot Tables)
* **Statistical Testing:** Python (SciPy) for hypothesis testing (t-tests, correlation analysis)
* **Visualization & BI:** Power BI (Interactive executive dashboards, DAX measures) & Python (Matplotlib, Seaborn)

## 📁 Repository Contents
* `upi_analytics_sql.sql`: Contains the DDL schemas and queries used to structure and extract transaction data.
* `upi_analytics_python.ipynb`: Jupyter notebook detailing exploratory data analysis (EDA) and statistical hypothesis testing.
* `upi_analytics_dashboard.pbix`: The raw Power BI file containing the interactive data models and dashboards.
* `UPI_Transaction_Analytics_Report.pdf`: A comprehensive exported report of the dashboard and findings for easy viewing.
* `UPI_Analytics_Ppt.pptx`: Presentation deck summarizing the business logic and key insights.

## 🔍 Methodology 
1. **Data Modeling:** Designed relational database schemas and wrote SQL scripts to structure the raw UPI transaction data.
2. **Exploratory Data Analysis (EDA):** Utilized Python and Excel to process datasets, handle missing values, and calculate summary metrics. 
3. **Statistical Testing:** Conducted rigorous hypothesis testing to validate assumptions regarding transaction behaviors and fraud indicators.
4. **Dashboard Creation:** Built dynamic dashboards in Power BI to monitor KPIs, highlight regional transaction volumes, and flag anomalous activities. 

## 📊 Key Insights & Findings

* **Fraud is device-and-channel concentrated, not random:** Feature Phones show the platform's highest fraud rate (2.15% overall), spiking to **2.3% specifically on the QR Code channel** — the single riskiest device-channel combination on the platform.

* **Fraud arrives in coordinated bursts, not steady growth:** While daily transaction volume grows smoothly over time, fraud alert volume spikes sharply on specific dates rather than scaling proportionally — indicating organized attack windows rather than passive, steady-state fraud.

* **Fraud is amount-agnostic:** Pearson correlation between transaction amount and fraud flag was effectively zero (r = -0.0003, p = 0.9355). A ₹20 transfer is statistically as likely to be flagged as a ₹2,000 transfer, ruling out simple amount-based fraud rules and pointing toward automated, scripted micro-fraud rather than high-value "whaling."

* **Failures are split evenly between user error and infrastructure:** Transaction failures break down almost exactly into quarters — Incorrect PIN (25.7%), Network Error (25.3%), Account Blocked (24.8%), Bank Down (24.2%) — meaning fixing failures requires equal investment in PIN-entry UX and backend banking-gateway reliability.

* **The platform is a high-volume, micro-transaction network:** P2P transfers account for ~70% of all transactions, with a median value of just ~₹33 — spending behavior stays statistically identical across device OS, payment channel, and transaction category (p > 0.05 across all tests).
* ## 🖼️ Dashboard Preview
   <img width="1227" height="706" alt="Screenshot 2026-09-15 154932" src="https://github.com/user-attachments/assets/b9a312fa-650a-4ccf-af2b-4245744eadde" />
<img width="1230" height="706" alt="Screenshot 2026-09-15 154949" src="https://github.com/user-attachments/assets/a59a74ab-8c17-444d-bbb9-f8a74f7b9172" />




---
**Author:** Jitendra Kumar  
*Master of Statistics | Data Analyst*
