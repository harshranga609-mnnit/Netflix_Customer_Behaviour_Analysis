# 🎬 Netflix Customer Churn Analysis

## 📌 Overview
This project analyzes customer churn behaviour for a Netflix-style subscription
service. It combines **SQL** for data exploration, **Python** for making important columns and a **Power BI dashboard** for interactive
reporting. The goal is to understand why customers are churn from platform.

## 🎯 Objective
- Explore customer behaviour and subscription patterns
- Identify the key factors that lead to churn
- Present findings through an interactive Power BI dashboard
- Provide data-driven recommendations to reduce churn

## 📊 Dataset
- **Source:** Downloaded from Kaggle
- **Size:** Number of rows = 5000 and Number of columns = 14
- **Key features:** customer ID,gender,subscription_type,watch_hours,churned,monthly_revenue,payment_type,favourite_genre,number_of_profile,device,region,last_login

## 🛠️ Tools & Technologies
- **SQL** – data cleaning, exploration, and aggregation queries
- **Python** (Pandas, NumPy, Matplotlib/Seaborn) – exploratory data analysis
- **Power BI** – interactive dashboard for visualization
- **Jupyter Notebook** – for the Python analysis

## 🔍 Approach
1. **Data Cleaning** – No need of too much data cleaning.
2. **SQL Analysis** – wrote queries to explore churn rate by region,monthly_revenue,subscription_type and many more.
3. **Dashboard (Power BI)** – built an interactive report to summarize insights visually

## 📈 Key Findings
1. Basic Subscription_Type has 1027, Standard has 748 and Premium has 740 Lost users.
2. Africa region had most 2515 lost users.
3. Africa is the most monthly revenue generated region with Rs.68147 .
4. Romance genre accounted for most 15.85 % contribution in watch hours.
5. If a user has not been loging for 43 or greater then number of churned are most 57.
6. If a user did the payment by credit card then avg watch hours is most 12.1k hours.


## ✅ Results / Conclusion
The analysis shows that customer churn is driven primarily by subscription tier and inactivity, not by genre preference, payment method, or region. Basic-plan users churn almost 1.4x more than Standard or Premium users, and churn risk rises sharply once a customer hasn't logged in for 30+ days. This suggests two clear retention strategies:
- improve the perceived value of the Basic plan
- trigger automated re-engagement campaigns for users inactive for 25–30 days, before they reach the high-risk churn window

## 🚀 Future Improvements
- Build a predictive churn model using machine learning
- Automate the dashboard with live data refresh

## 👤 Author
- **Name:** Harsh Ranga
- **LinkedIn:** [www.linkedin.com/in/harshranga13]
- **Portfolio/GitHub:** [https://github.com/harshranga609-mnnit]
