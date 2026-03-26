#  SQL Movie Rental Analysis System

##  Overview
This project performs end-to-end data analysis on a Movie Rental Database using SQL. It transforms raw transactional data into actionable business insights related to customer behavior, revenue trends, and rental patterns.

---

##  Project Objective
- Analyze customer behavior
- Identify top-performing movies & categories
- Understand revenue distribution
- Study rental trends & duration
- Generate insights for business decision-making

---

##  Tools & Technologies
- SQL (MySQL)
- Data Analysis
- Window Functions
- Joins & Aggregations

---

## Dataset
- Source: DVD Rental Database (Kaggle)
- Tables Used:
  - Customer
  - Film
  - Rental
  - Payment
  - Category
  - Inventory
  - Store

---

##  Project Structure
SQL_Movie_Rental_Analysis/

│── sakila_project.sql

│── SQL_Project_Deepanshu.pdf

│── Dataset

│── README.md


---

##  Key Analysis Performed

### 🔹 1. Data Exploration
- Checked multiple tables like customer, film, rental
- Verified relationships between entities

### 🔹 2. Movie & Category Analysis
- Counted number of films per category
- Ranked categories using SQL window functions
- Identified most rented movies

### 🔹 3. Revenue Analysis
- Top 5 revenue-generating movies
- Revenue by store (Store 1 > Store 2)
- Monthly revenue trends (July highest)
- Category-wise revenue contribution

### 🔹 4. Customer Analysis
- Customer ranking based on rentals
- Spending behavior analysis
- Segmentation:
  - High Value
  - Medium Value
  - Low Value
- Repeat vs One-time customers

### 🔹 5. Rental Analysis
- Rental duration calculation
- Duration segmentation:
  - Short (<4 days)
  - Medium (4–7 days)
  - Long (>7 days)

---

##  Key Insights
- Revenue is concentrated in a few top-performing movies
- Sports category generates highest revenue
- Store 1 outperforms Store 2
- Revenue peaks in July (seasonal demand)
- Majority users are medium-value customers
- A small group of customers contributes most revenue
- Strong customer retention (repeat users)

---

##  Business Recommendations
- Focus on top-performing movies & categories
- Target medium-value customers for upselling
- Improve low-performing store operations
- Launch campaigns during peak months
- Introduce loyalty programs

---

##  Limitations
- Data limited to single year
- No real-time data
- No demographic information
- No machine learning models

---

##  Future Scope
- Build Power BI / Tableau dashboards
- Apply Machine Learning models
- Add multi-year data analysis
- Create recommendation system
- Integrate real-time pipelines

---

## 📌 Conclusion
This project demonstrates how SQL can be used to convert raw relational data into meaningful business insights, helping organizations make data-driven decisions and improve performance.

---

## 👨‍💻 Author
**Deepanshu**  
Data Analyst | SQL | Python | Data Visualization  

---

## ⭐ If you like this project
Give it a ⭐ on GitHub and feel free to fork it!
