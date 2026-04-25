# Data Analyst Portfolio Projects
## Following are my projects in SQL, Python, Power BI & Excel:

## Project Overview

Project demonstrates end-to-end data analysis skills using the **Superstore Sales Dataset (9,800 records)**.
The goal is to analyze sales performance, regional trends, identify top customers, 
and deliver actionable business insights through SQL, Excel, and Power BI.

---
## Business Questions Answered

1. What is the overall revenue performance, and how has it trended over time?
2. Which regions and states are driving the most and least revenue?
3. Which product categories and sub-categories are top performers?
4. Who are the highest-value customers, and what segment do they belong to?
5. How does shipping mode affect order volume and revenue?

---

## Repository Structure

```
superstore-sales-dashboard/
│
├── data/
│   └── Superstore_Sales_Dataset.csv          # Raw dataset (9,800 rows)
│
├── sql/
│   ├── 01_Data_Cleaning_and_Setup.sql         # Table creation & data validation
│   ├── 02_Sales_Analysis.sql                  # Revenue, regional & category analysis
│   ├── 03_Customer_Analysis.sql               # RFM segmentation & top customers
│   └── 04_Business_Insights.sql               # KPI summary & advanced queries
│
├── excel/
│   └── Superstore_Excel_Analysis.xlsx         # Pivot tables, charts & dashboard
│
├── powerbi/
│   └── Superstore_Dashboard.pbix              # Interactive Power BI dashboard
│
├── docs/
│   ├── 05_PowerBI_DAX_Measures.md            # All DAX measures with explanations
│
└── README.md                                  # This file
```

---

## Tools & Technologies

| Tool | Purpose |
|------|---------|
| **SQL** MySQL | Data cleaning, transformation, and business analysis |
| **Microsoft Excel** | Pivot tables, SUMIF formulas, charts, dashboard |
| **Power BI Desktop** | Interactive dashboard with DAX measures |

---

## Dataset Summary

| Attribute | Value |
|-----------|-------|
| Total Records | 9,800 rows |
| Date Range | 2014 – 2018 |
| Regions | East, West, Central, South |
| Categories | Technology, Furniture, Office Supplies |
| Customer Segments | Consumer, Corporate, Home Office |

---

## Key Findings

| Insight | Finding |
|---------|---------|
| 🥇 Top Region | **West** — $710,274 revenue (31% share) |
| 🥇 Top Category | **Technology** — $827,521 |
| 🥇 Top Segment | **Consumer** — $1,148,152 (51% share) |
| 🥇 Top State | **California** — $446,349 |
| 🥇 Top Sub-Category | **Phones** — $327,821 |
| 🥇 Most Used Shipping | **Standard Class** |

---

## Business Recommendations

1. **Double down on California & New York** — Together they contribute ~33% of revenue. Targeted promotions can increase this further.
2. **Grow Technology sales in the South region** — South lags significantly behind West/East. Bundle deals on phones/accessories can help.
3. **Retain Champion customers via RFM** — Top 10 customers contribute disproportionate revenue. A loyalty program will protect this.
4. **Promote First Class & Same Day shipping** — Currently underutilized. Premium shipping options can increase average order value.
5. **Investigate Central region underperformance** — Central revenue is 27% lower than West. A deeper city-level drill-down may reveal specific gaps.

---

## Dashboard Preview
## SQL & Tableau -
superstore sales dataset
See on PowerBI: 
<img width="1361" height="717" alt="Superstore_KPI_Summary" src="https://github.com/user-attachments/assets/5890bf85-06fd-4b74-a7d2-562ab16bb80c" />
<img width="1363" height="716" alt="Superstore_region" src="https://github.com/user-attachments/assets/9478668c-5035-440e-8706-13b3bc424506" />
<img width="1365" height="719" alt="Superstore_category" src="https://github.com/user-attachments/assets/e3b429cb-a04b-498e-8ccb-c2e8864a8d4d" />
<img width="1363" height="717" alt="Superstore_customer_insights" src="https://github.com/user-attachments/assets/1bcf1305-f149-4ac2-8d92-f6ab7c94448f" />


Review the Data Insertion SQL Script: 
https://github.com/Toibul/Data-Analyst-Portfolio-Projects/blob/5eb66c77b7d87afa3de953c6b8f262bbd620ee89/01_Database%20%26%20Inserting%20Data.sql

Review the Data Cleaning and Validation SQL script:
https://github.com/Toibul/Data-Analyst-Portfolio-Projects/blob/5eb66c77b7d87afa3de953c6b8f262bbd620ee89/02_Data%20Cleaning%20and%20Validation.sql

Review the Data Exploration SQL Script:
https://github.com/Toibul/Data-Analyst-Portfolio-Projects/blob/5eb66c77b7d87afa3de953c6b8f262bbd620ee89/03_Superstore_sales_Data%20Exploratory.sql

## Excel -
Kindly download these Excel files from this repository and view them in Microsoft Excel.

Car sales Sample: Sales Performance Dashboard
<img width="1358" height="728" alt="Car_Sales_kaggle 1" src="https://github.com/user-attachments/assets/1942a9d5-3395-4a73-aef0-991eb67b05cd" />
<img width="1360" height="710" alt="Car_Sales_kaggle 2" src="https://github.com/user-attachments/assets/619c469b-d190-4d62-a8bf-78178cb80346" />
<img width="1361" height="718" alt="Car_Sales_kaggle 3" src="https://github.com/user-attachments/assets/673d3b9f-7950-4c54-adf9-76a32fe39ddb" />
## IBM Cognos Analytics:
<img width="801" height="554" alt="Car_model_sales visualization By IBM_Cognos" src="https://github.com/user-attachments/assets/aa1f2d0b-0076-42f9-ac2f-dd1a0059bcf5" />


---

## 👤 Author

**Toibul Sk**  
Data Analyst | SQL • Excel • Power BI  
📧 toibulsk051@gmail.com
🔗 https://www.linkedin.com/in/toibul-sk-110788207/
🐙 https://github.com/Toibul?tab=repositories

---

## Data Source

Superstore Sales Dataset — publicly available on [Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)

