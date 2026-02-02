# 📊 Data Warehouse & SQL Analysis Project
## 🏗️ Project Architecture & Roadmap
Project Roadmap<img width="1297" height="917" alt="Project_roadmap" src="https://github.com/user-attachments/assets/091f6f1b-6262-4566-a319-217c3c14880d" />
## 📖 Project Description
This project showcases a complete **End-to-End Data Warehousing Solution** designed to transform raw, unorganized business data into a high-quality "Gold Layer" of actionable insights. Using the **AdventureWorks** dataset, I implemented a structured **Medallion Architecture** to ensure data integrity and sophisticated business reporting.
### 🎯 Key Objectives
* **Data Organization:** Structured the project to move from raw, unorganized CSV files (**Bronze Layer**) into clean, standardized datasets (**Silver Layer**).
* **Data Modeling (Gold Layer):** Developed a robust **Gold Layer** by creating specialized **SQL Views**. This transforms complex relational data into simplified, analysis-ready objects.
* **Business Intelligence & KPIs:** Built advanced SQL models to calculate critical business metrics like total sales, order volume, and revenue growth directly within the database.
* **Customer 360 & Loyalty Analytics:** Engineered a unified view of customer behavior, integrating demographics with automated **Loyalty Segmentation** (VIP, Regular, New) to support targeted marketing.
* **Optimization for Analytics:** Ensured the data model is "Plug-and-Play," ready for immediate connection to tools like Power BI or Tableau.
---
## 📂 Repository Structure
 * **`/datasets/crm`**: Contains the raw CRM CSV data (Bronze Layer)
 * **`/datasets/erp`**: Contains the raw ERP CSV data (Bronze Layer)
 * **`/sql_scripts`**: Comprehensive SQL scripts for data transformation and business reporting.

---
## 🚀 How to Run
1. **Download** the CSV files from the `/datasets` folder.
2. **Import** them into your SQL Server environment.
3. **Execute** the SQL scripts provided in the `sql_scripts` folder, starting from (Create_warehouse), then bronze TO gold .
4. **Access the Views** created in the Gold Layer for final analysis.

