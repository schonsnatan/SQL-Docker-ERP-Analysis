--Monthly growth analysis and YTD calculation:
CREATE VIEW cumulative_revenue AS
WITH MonthlyRevenue AS (
	SELECT 
		EXTRACT(YEAR FROM order_date) AS year,
		EXTRACT(MONTH FROM order_date) AS month,
		SUM(od.unit_price * od.quantity * (1-od.discount)) AS Monthly_Revenue
	FROM 
		orders AS o 
	INNER JOIN 
		order_details AS od ON o.order_id = od.order_id 
	GROUP BY 
		year,
		month
),

CumulativeRevenue AS (
	SELECT
		year,
		month,
		Monthly_Revenue,
		SUM(Monthly_Revenue) OVER (PARTITION BY year ORDER BY month) AS Revenue_YTD
	FROM 
		MonthlyRevenue
)

SELECT 
	year,
	month,
	Monthly_Revenue,
	Monthly_Revenue - LAG(Monthly_Revenue) OVER (PARTITION BY year ORDER BY month) 
    AS Monthly_Difference, 
	Revenue_YTD,
 	(Monthly_Revenue - LAG(Monthly_Revenue) OVER (PARTITION BY year ORDER BY month)) /     LAG(Monthly_Revenue) OVER (PARTITION BY year ORDER BY month) * 100 
    AS Monthly_Change_Percentage
FROM 
	CumulativeRevenue
ORDER BY
	year,month
	