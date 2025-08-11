CREATE TABLE esg_scores (
    Symbol VARCHAR,
    Company VARCHAR,
    Sector VARCHAR,
    Industry VARCHAR,
    Total_ESG_Risk_score FLOAT,
    Environment_Risk_Score FLOAT,
    Governance_Risk_Score FLOAT,
    Social_Risk_Score FLOAT,
    ESG_Risk_Percentile VARCHAR,
    ESG_Risk_Level TEXT
);
CREATE TABLE esg_risk (								
    Symbol VARCHAR,
    company VARCHAR,
    Sector VARCHAR,
    Industry VARCHAR,
    esg_risk_score_2024 FLOAT,
    predicted_future_esg_score FLOAT,
    esg_risk_exposure VARCHAR,
    esg_risk_management VARCHAR,
    esg_risk_level VARCHAR,
	Controversy_Level VARCHAR
);
CREATE TABLE stock_prices (
    Company TEXT,
    Date DATE,
    Close NUMERIC,
    High NUMERIC,
    Low NUMERIC,
    Open NUMERIC,
    Volume BIGINT
);
SELECT DISTINCT esg.company
FROM esg_scores esg
LEFT JOIN stock_prices sp ON esg.company = sp.company
WHERE sp.company IS NULL;

SELECT * FROM esg_scores LIMIT 10;
SELECT * FROM esg_risk LIMIT 10;
SELECT * FROM stock_prices LIMIT 10;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'esg_scores';
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'esg_risk';
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'stock_prices';
SELECT COUNT(*) FROM esg_scores;
SELECT COUNT(*) FROM esg_risk;
SELECT COUNT(*) FROM stock_prices;
-- Check for duplicate companies in ESG Scores
SELECT company, COUNT(*) 
FROM esg_scores
GROUP BY company
HAVING COUNT(*) > 1;
SELECT company, COUNT(*) 
FROM esg_risk
GROUP BY company
HAVING COUNT(*) > 1;
SELECT company, COUNT(*) 
FROM stock_prices
GROUP BY company
HAVING COUNT(*) > 1;
-- Check for missing values
SELECT * 
FROM esg_scores
WHERE company IS NULL OR total_esg_risk_score IS NULL;
SELECT *
FROM esg_scores
WHERE 
  total_esg_risk_score IS NULL
  OR environment_risk_score IS NULL
  OR governance_risk_score IS NULL
  OR social_risk_score IS NULL;
DELETE FROM esg_scores
WHERE 
  total_esg_risk_score IS NULL
  OR environment_risk_score IS NULL
  OR governance_risk_score IS NULL
  OR social_risk_score IS NULL;
INSERT INTO esg_scores (
    symbol, company, sector, industry,
    total_esg_risk_score, environment_risk_score,
    governance_risk_score, social_risk_score,
    esg_risk_percentile, esg_risk_level
)
VALUES (
    'HDFCLIFE', 'HDFC Life Insurance Company Ltd.', 'Financial Services', 'Financial Services',
    30.6, 2.2, 15.1, 13.4,
    NULL, 'High Risk'
);
INSERT INTO esg_scores (
    symbol, company, sector, industry,
    total_esg_risk_score, environment_risk_score,
    governance_risk_score, social_risk_score,
    esg_risk_percentile, esg_risk_level
)
VALUES (
    'SBILIFE', 'SBI Life Insurance Company Ltd.', 'Financial Services', 'Financial Services',
    27.0, 2.3, 12.6, 12.2,
    NULL, 'High Risk'
);
SELECT COUNT(*) FROM esg_scores;
SELECT company, date, COUNT(*) 
FROM stock_prices
GROUP BY company, date
HAVING COUNT(*) > 1;
SELECT company, date, COUNT(*) as rows_per_day
FROM stock_prices
GROUP BY company, date
HAVING COUNT(*) > 1
ORDER BY rows_per_day DESC;
-- Data Analysis
CREATE VIEW combined_esg_data AS
SELECT 
    s.company,
    s.date,
    s.open,
    s.close,
	s.high,
	s.low,
    s.volume,
	e.industry,
	e.total_esg_risk_score,
    e.environment_risk_score,
    e.governance_risk_score,
    e.social_risk_score,
	e.esg_risk_level,
	r.esg_risk_score_2024,
	r.predicted_future_esg_score,
	r.controversy_level
FROM stock_prices s
JOIN esg_scores e ON s.company = e.company
JOIN esg_risk r ON s.company = r.company;
SELECT * FROM combined_esg_data;
-- Top 10 companies with lowest ESG risk
SELECT company, total_esg_risk_score
FROM esg_scores
ORDER BY total_esg_risk_score ASC
LIMIT 10;
-- Average stock return grouped by ESG level
SELECT e.esg_risk_level, AVG(s.close - s.open) AS avg_daily_return
FROM stock_prices s
JOIN esg_scores e ON s.company = e.company
GROUP BY e.esg_risk_level;

SELECT DISTINCT s.company
FROM stock_prices s
LEFT JOIN esg_scores e
    ON s.company = e.company
WHERE e.company IS NULL;

-- Get distinct company names after cleaning .csv and spaces
SELECT DISTINCT TRIM(REPLACE(company, '.csv', '')) AS company_cleaned
FROM stock_prices
ORDER BY company_cleaned;

UPDATE stock_prices
SET company = CASE
    WHEN company ILIKE 'ADANIPORTS%' THEN 'Adani Ports and Special Economic Zone Ltd.'
    WHEN company ILIKE 'ASIANPAINT%' THEN 'Asian Paints Ltd.'
    WHEN company ILIKE 'AXISBANK%' THEN 'Axis Bank Ltd.'
    WHEN company ILIKE 'BAJAJ-AUTO%' THEN 'Bajaj Auto Ltd.'
    WHEN company ILIKE 'BAJAJFINSV%' THEN 'Bajaj Finserv Ltd.'
    WHEN company ILIKE 'BPCL%' THEN 'Bharat Petroleum Corporation Ltd.'
    WHEN company ILIKE 'BHARTIARTL%' THEN 'Bharti Airtel Ltd.'
    WHEN company ILIKE 'CIPLA%' THEN 'Cipla Ltd.'
    WHEN company ILIKE 'COALINDIA%' THEN 'Coal India Ltd.'
    WHEN company ILIKE 'DRREDDY%' THEN 'Dr. Reddy''s Laboratories Ltd.'
    WHEN company ILIKE 'EICHERMOT%' THEN 'Eicher Motors Ltd.'
    WHEN company ILIKE 'GRASIM%' THEN 'Grasim Industries Ltd.'
    WHEN company ILIKE 'HCLTECH%' THEN 'HCL Technologies Ltd.'
    WHEN company ILIKE 'HDFCBANK%' THEN 'HDFC Bank Ltd.'
    WHEN company ILIKE 'HEROMOTOCO%' THEN 'Hero MotoCorp Ltd.'
    WHEN company ILIKE 'HINDALCO%' THEN 'Hindalco Industries Ltd.'
    WHEN company ILIKE 'HINDUNILVR%' THEN 'Hindustan Unilever Ltd.'
    WHEN company ILIKE 'ICICIBANK%' THEN 'ICICI Bank Ltd.'
    WHEN company ILIKE 'ITC%' THEN 'ITC Ltd.'
    WHEN company ILIKE 'INFY%' THEN 'Infosys Ltd.'
    WHEN company ILIKE 'JSWSTEEL%' THEN 'JSW Steel Ltd.'
    WHEN company ILIKE 'KOTAKBANK%' THEN 'Kotak Mahindra Bank Ltd.'
    WHEN company ILIKE 'LT%' THEN 'Larsen & Toubro Ltd.'
    WHEN company ILIKE 'M&M%' THEN 'Mahindra & Mahindra Ltd.'
    WHEN company ILIKE 'MARUTI%' THEN 'Maruti Suzuki India Ltd.'
    WHEN company ILIKE 'NTPC%' THEN 'NTPC Ltd.'
    WHEN company ILIKE 'NESTLEIND%' THEN 'Nestle India Ltd.'
    WHEN company ILIKE 'ONGC%' THEN 'Oil & Natural Gas Corporation Ltd.'
    WHEN company ILIKE 'RELIANCE%' THEN 'Reliance Industries Ltd.'
    WHEN company ILIKE 'SBIN%' THEN 'State Bank of India'
    WHEN company ILIKE 'SUNPHARMA%' THEN 'Sun Pharmaceutical Industries Ltd.'
    WHEN company ILIKE 'TCS%' THEN 'Tata Consultancy Services Ltd.'
    WHEN company ILIKE 'TATAMOTORS%' THEN 'Tata Motors Ltd.'
    WHEN company ILIKE 'TATASTEEL%' THEN 'Tata Steel Ltd.'
    WHEN company ILIKE 'TECHM%' THEN 'Tech Mahindra Ltd.'
    WHEN company ILIKE 'TITAN%' THEN 'Titan Company Ltd.'
    WHEN company ILIKE 'ULTRACEMCO%' THEN 'UltraTech Cement Ltd.'
    WHEN company ILIKE 'WIPRO%' THEN 'Wipro Ltd.'
    ELSE company
END;
SELECT DISTINCT s.company
FROM stock_prices s
LEFT JOIN esg_scores e 
    ON s.company = e.company
WHERE e.company IS NULL;
-- Create a temporary table with daily returns
WITH returns AS (
    SELECT 
        company,
        date,
        ((close - open) / open) * 100 AS daily_return
    FROM stock_prices
)
SELECT * FROM returns
LIMIT 5;
--Correlation Analysis
WITH returns AS (
    SELECT 
        s.company,
        ((s.close - s.open) / s.open) * 100 AS daily_return,
        e.total_esg_risk_score
    FROM stock_prices s
    JOIN esg_scores e 
        ON s.company = e.company
)
SELECT CORR(avg_daily_return, total_esg_risk_score) AS correlation
FROM (
    SELECT 
        company,
        AVG(daily_return) AS avg_daily_return,
        total_esg_risk_score
    FROM returns
    GROUP BY company, total_esg_risk_score
) sub;
--Sharpe Ratio Risk-Adjusted Return by ESG Level 
WITH returns AS (
    SELECT 
        s.company,
        e.esg_risk_level,
        ((s.close - s.open) / s.open) * 100 AS daily_return
    FROM stock_prices s
    JOIN esg_scores e 
        ON s.company = e.company
),
stats AS (
    SELECT 
        esg_risk_level,
        AVG(daily_return) AS avg_return,
        STDDEV(daily_return) AS std_dev
    FROM returns
    GROUP BY esg_risk_level
)
SELECT 
    esg_risk_level,
    ROUND(avg_return, 2) AS avg_return_pct,
    ROUND(std_dev, 2) AS volatility_pct,
    ROUND(avg_return / NULLIF(std_dev, 0), 3) AS sharpe_ratio
FROM stats
ORDER BY sharpe_ratio DESC;
--Sector-wise ESG & Return Comparison
WITH returns AS (
    SELECT 
        s.company,
        ((s.close - s.open) / s.open) * 100 AS daily_return,
        e.total_esg_risk_score,
        e.sector
    FROM stock_prices s
    JOIN esg_scores e 
        ON s.company = e.company
),
sector_avg AS (
    SELECT 
        sector,
        ROUND(AVG(daily_return)::numeric, 2) AS avg_return_pct,
        ROUND(AVG(total_esg_risk_score)::numeric, 2) AS avg_esg_score
    FROM returns
    GROUP BY sector
)
SELECT 
    sector,
    avg_return_pct,
    avg_esg_score
FROM sector_avg
ORDER BY avg_return_pct DESC;
--Top 5 Best-Performing ESG Companies
WITH returns AS (
    SELECT 
        s.company,
        ((s.close - s.open) / s.open) * 100 AS daily_return,
        e.total_esg_risk_score
    FROM stock_prices s
    JOIN esg_scores e 
        ON s.company = e.company
),
avg_returns AS (
    SELECT 
        company,
        ROUND(AVG(daily_return), 2) AS avg_return_pct,
        total_esg_risk_score
    FROM returns
    GROUP BY company, total_esg_risk_score
)
SELECT 
    company,
    avg_return_pct,
    total_esg_risk_score
FROM avg_returns
ORDER BY avg_return_pct DESC, total_esg_risk_score ASC
LIMIT 5;

