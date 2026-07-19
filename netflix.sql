USE netflix;

-- 1. Distribution of Users and Revenue by Age Group
SELECT age_group,
COUNT(customer_id) AS total_customers,
ROUND(SUM(monthly_fee),2) AS total_monthly_revenue,
ROUND(AVG(monthly_fee), 2) AS avg_fee_per_customer
FROM netflix_cust
GROUP BY age_group
ORDER BY total_monthly_revenue DESC;

-- 2. Favorite Genre by Region
SELECT 
region, 
favorite_genre, 
COUNT(customer_id) AS total_fans
FROM netflix_cust
GROUP BY region, favorite_genre
ORDER BY region, total_fans DESC;

-- 3. Device Preference based on Engagement (Watch Hours)

SELECT 
device,
COUNT(customer_id) AS total_users,
ROUND(AVG(watch_hours), 2) AS avg_total_watch_hours,
ROUND(SUM(avg_watch_time_per_day), 2) AS total_watch_time,
ROUND(AVG(avg_watch_time_per_day),2) AS avg_total_watch_time_per_day
FROM netflix_cust
GROUP BY device
ORDER BY avg_total_watch_time_per_day DESC;

-- 4. Multi-Profile Engagement Analysis
SELECT 
number_of_profiles,
COUNT(customer_id) AS total_sub,
ROUND(AVG(watch_hours), 2) AS avg_account_watch_hours,
ROUND(AVG(hours_per_profile), 2) AS avg_hours_per_profile -- assuming the last cut-off column is hours_per_profile
FROM netflix_cust
GROUP BY number_of_profiles
ORDER BY number_of_profiles;

-- 5. Revenue Breakdown by Subscription Type
SELECT 
subscription_type,
COUNT(customer_id) AS total_subscriber,
ROUND(SUM(monthly_fee),2) AS total_revenue,
ROUND(COUNT(customer_id) * 100 / (SELECT COUNT(*) FROM netflix_cust),2) AS subscriber_percentage
FROM netflix_cust
GROUP BY subscription_type
ORDER BY total_revenue DESC;

-- 6. Popular Payment Methods for Premium Users
SELECT
payment_method, 
COUNT(customer_id) AS total_premium_users,
ROUND(SUM(monthly_fee),2) As total_premium_revenue
FROM netflix_cust
WHERE subscription_type = 'Premium'
GROUP BY payment_method
ORDER BY total_premium_revenue DESC;

-- 7. Churn Rate by Subscription Tier and Region
SELECT 
region,
subscription_type,
COUNT(customer_id) AS total_customers,
SUM(churned) AS total_churned_customers,
ROUND((SUM(churned) * 100.0 / COUNT(customer_id)), 2) AS churn_rate_percentage
FROM netflix_cust
GROUP BY region, subscription_type
ORDER BY churn_rate_percentage DESC;

-- 8. Inactivity vs. Churn Risk
SELECT 
churned,
ROUND(AVG(avg_watch_time_per_day), 2) AS avg_daily_watch_time,
ROUND(AVG(last_login_days), 2) AS avg_days_since_last_login
FROM netflix_cust
GROUP BY churned;

-- 9. Highly Engaged But Cheap Users (The "High Value/Low Cost" Cohort)
SELECT 
customer_id,
age_group,
subscription_type,
watch_hours,
monthly_fee,
ROUND((watch_hours / monthly_fee), 2) AS hours_watched_per_dollar
FROM netflix_cust
WHERE watch_hours > (SELECT AVG(watch_hours) FROM netflix_cust)
ORDER BY hours_watched_per_dollar DESC;

-- 10. High Profile vs. Low Engagement Accounts
SELECT 
    customer_id,
    region,
    number_of_profiles,
    watch_hours,
    avg_watch_time_per_day
FROM netflix_cust
WHERE number_of_profiles >= 4 
  AND avg_watch_time_per_day < (SELECT AVG(avg_watch_time_per_day) FROM netflix_cust)
ORDER BY number_of_profiles DESC, avg_watch_time_per_day ASC;

-- 11. Gender Preferences in Content and Devices
SELECT 
gender,
favorite_genre,
device,
COUNT(customer_id) AS total_users,
ROUND(AVG(avg_watch_time_per_day), 2) AS avg_daily_watch_time
FROM netflix_cust
GROUP BY gender, favorite_genre, device
ORDER BY gender, total_users DESC;

-- 12. Age Group Monetization vs. Engagement Matrix
SELECT 
    age_group,
    COUNT(customer_id) AS user_count,
    ROUND(SUM(monthly_fee), 2) AS total_revenue,
    ROUND(AVG(watch_hours), 2) AS avg_total_hours,
    ROUND(AVG(monthly_fee) / NULLIF(AVG(watch_hours), 0), 4) AS revenue_earned_per_watch_hour
FROM netflix_cust
GROUP BY age_group
ORDER BY total_revenue DESC;

-- 13. Subscription Upgrade/Downgrade Mismatch
SELECT 
subscription_type,
COUNT(customer_id) AS total_at_risk_users,
SUM(monthly_fee) AS monthly_revenue_at_risk
FROM netflix_cust
WHERE subscription_type IN ('Standard', 'Premium') 
  AND number_of_profiles = 1 
  AND avg_watch_time_per_day < 2.0  -- Adjust threshold as needed
GROUP BY subscription_type;

-- 14. Regionally Dominant Plan Types
WITH RegionalRankings AS (
SELECT 
region,
subscription_type,
COUNT(customer_id) AS subscriber_count,
RANK() OVER (PARTITION BY region ORDER BY COUNT(customer_id) DESC) as plan_rank
FROM netflix_cust
GROUP BY region, subscription_type
)
SELECT 
region,
subscription_type AS dominant_plan,
subscriber_count
FROM RegionalRankings
WHERE plan_rank = 1;

-- 15. Rank coustmer acc to avg watch hours
SELECT customer_id,subscription_type,
watch_hours,age_group,
dense_rank() OVER(PARTITION BY age_group,subscription_type ORDER BY watch_hours DESC) AS watch_time_rank
FROM netflix_cust