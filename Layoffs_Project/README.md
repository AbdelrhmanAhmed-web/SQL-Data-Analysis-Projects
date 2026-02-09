# 📊 Global Layoffs Analysis Project (2020-2023)

## 📌 Project Overview
This project provides a deep-dive analysis into the global layoffs that occurred across various industries from the start of the COVID-19 pandemic through early 2023. The goal was to transform raw, messy data into a clean, structured format for meaningful exploration and visualization.

---

## 🛠️ Phase 1: Data Cleaning & Transformation (SQL)
Before diving into analysis, the data went through a rigorous cleaning process using **SQL Server** to ensure 100% accuracy:
1. **Staging:** Created a staging table to preserve original data.
2. **Deduplication:** Removed duplicates using `ROW_NUMBER()` and CTEs.
3. **Standardization:** Fixed naming inconsistencies and trimmed white spaces.
4. **Data Type Conversion:** Converted text-based numbers into proper `INT` and `FLOAT` types.
5. **Null Handling:** Imputed missing values using Self-Joins and removed unusable records.

---

## 🔍 Phase 2: Exploratory Data Analysis - EDA (SQL)
With the data cleaned, I performed an in-depth SQL analysis to uncover key trends and "hidden" insights:
* **Overview Metrics:** Identified the maximum layoffs (Google at 12,000) and companies that shut down (100% layoffs).
* **Funding Impact:** Analyzed the correlation between high funding and layoff intensity.
* **Geographic & Industry Rankings:** Ranked countries and sectors most affected by the economic shifts.
* **Time Series Analysis:** Explored layoff trends by year and month, including rolling totals.

---

## 🚀 Phase 3: Power BI Dashboard & Visualization
The final phase involved creating a professional, multi-page interactive dashboard:

### 🖼️ Data Preparation (The SQL View)
I created a final **SQL View** to act as the "Clean Source" for Power BI, ensuring:
* **Professional Naming:** Renamed columns (e.g., `Total Employees Laid Off`).
* **Performance:** Optimized data for seamless dashboard interactions.

![Final Data View](/<img width="1043" height="795" alt="VIEW" src="https://github.com/user-attachments/assets/28bee009-ed19-4261-813e-a9575c2853bc" />
) 

### Dashboard Highlights:
* **Executive Summary:** High-level KPIs for quick decision-making.
* **Deep-Dive Analysis:** Using **Decomposition Trees** to break down layoffs by industry and company stage.
* **Geographic Trends:** Map-based visuals to track the global impact.

---

## 📂 Repository Structure
* `/SQL_Scripts`: Contains all scripts from staging to EDA and the final view.
* `/PowerBI_Report`: The `.pbix` file for the interactive dashboard.
* `/Dataset`: The raw and cleaned CSV files.

---
**Tools Used:** SQL Server, Power BI.
