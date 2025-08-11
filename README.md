# ESG-Performance-Stock-Returns-NIFTY-50
Power BI dashboard analyzing ESG risk scores and stock returns for Indian companies.
ESG Risk Scores & Financial Returns Stock Performance Analysis: Data-Driven Insights for Responsible Investing in India

---

## Project Overview
This project analyzes the relationship between Environmental, Social & Governance (ESG) Risk Scores and Stock Performance of Indian companies.
Using datasets from Kaggle, the project integrates ESG risk data with stock price history, calculates financial metrics (including daily returns), and visualizes insights in Power BI for responsible investing decision-making.

---

## Objectives
Evaluate how ESG risk relates to stock returns.

Identify top-performing companies with low ESG risk.

Enable interactive exploration of data by date, industry, and risk level.

Provide a tool for investors to balance profitability with sustainability.

---

## Dataset Information
Three datasets were sourced from Kaggle:

ESG Risk Scores – ESG risk ratings for Indian companies.

Stock Prices – Historical stock price data (Open, Close, High, Low, Volume).

ESG Scores Metadata – Additional company/industry details.

---

## Tools & Technologies
-PostgreSQL – Data extraction, joins, and creation of combined dataset views Data Analysis.

-MS Excel – Initial data cleaning & formatting.

-Power BI – Data modeling, measures, visualizations, and dashboard creation.

---

## Files Included
data/
│── `ESG_data_ NIFTY50(in).csv`          # Kaggle ESG score data
│── `stockpricedata.csv`           # Kaggle stock price history
│── `final_data (1).csv`           # Kaggle ESG Risk data
│── `combined_esg_data.csv`      # SQL-merged ESG & stock data
dashboard/
│── `ESG Performance Analysis Dashboard.pdf` # Final Power BI dashboard (4 pages)
reports/
│── `ESG Performance Analysis Report.pdf`   # Final report with insights & recommendations
sql_scripts/
│── `ESG_Stock_Analysis.sql`          # Queries for cleaning & merging datasets
README.md                      # Project documentation

---
## Workflow
1. Data Collection
Downloaded datasets from Kaggle.

Verified schema, column names, and missing values.

2. Data Cleaning
SQL:

Removed null/duplicate values.

Merged ESG and stock price datasets via CREATE VIEW for combines_esg_data.

Standardized column names and formats (e.g., dates).

Excel:

Additional formatting (date conversions, column renaming).

Checked for anomalies in numerical values.

Powerbi:
Imported stock_price dataset all csv and merged them togetehr by DAX Studio.

3. Data Import & Modeling in Power BI
Imported combines_esg_data from SQL.

Created DAX measures:

Avg ESG Risk Score

Avg Daily Return %

Top Performing Company KPI

Added slicers: Date, Industry, Company.

Created relationships between tables.

4. Dashboard Visuals
KPIs:

- ESSG & Return Executive Summary
  KPIs: Top Performing Company ,Average ESG Risk Score,Average Stock Return %,Lowest Risk (Safest) Company,Highest Risk (Riskiest) Company
  Slicers for Date, Industry.
  Scatter Chart: Risk vs Return
  Bar chart: Top 5 Companies
  Bar Chart: ESG Risk & Stock Return
  Conditional formatting in table: Green = High Returns, Low Risk Red = Low Returns, High Risk
  Metrics: Avg Total ESG Risk, Avg Daily Return %
-	Company Profile (Drill-through Page)
  KPIs: Selected Company, CompanyAvg DailyReturn, CompanyAvgESGRisk
  Area Chart: ESG Risk Score trend over time
  Bar Chart: Peer Comparison Avg Daily Return % by Company
  Line Chart: Company Daily Return/Performance Trend Over Time
-	ESG Risk Insights
  KPIs: Avg Total ESG Risk, Avg Predicated ESG Score, Avg Env Risk ,Avg Gov Risk, Avg Soc Risk
  Bar Chart: Controversy Level Distribution  by Company
  Bar Chart: Avg ESG Risk Score by Industry
  Donut Chart: ESG Risk Level distribution
  Scatter Plot: ESG Risk vs. Predicted Score
-	Stock Price Insights
  Line Chart: ESG and Close price by Company
  Line Chart: Stock Price Trend 
  Area Chart: Volume Trend

---

## Key Metrics
Avg ESG Risk Score – Measures sustainability risk.

Avg Daily Return % – Measures stock profitability.

Top Performing Company: Hero Motor(highest Avg Daily Return %)

---

## Insights & Recommendations
Companies with low ESG risk tend to have stable returns over time.

High-return companies often show medium ESG risk, suggesting a possible trade-off.

Industries like [replace with actual industry names from your results] lead in balancing ESG compliance and profitability.

Investors should use the Risk–Return Filter to find optimal investment targets.

---

## Conclusion
This dashboard enables data-driven investment decisions by merging financial performance with sustainability considerations.
It helps investors quickly identify companies that align with their profit goals and ethical values.

---

## Future Improvements
Automate dashboard refresh in Power BI Service.

---

## Contact
Created by Sumaiya Mohammed Hanif– Aspiring Data Analyst | Finance & ESG Analytics
Email: [sumaiyashaikh123000@gmail.com]
LinkedIn: [www.linkedin.com/in/sumaiya-mohammed-hanif]
GitHub: [https://github.com/SumaiyaMohammedHanif]

---
