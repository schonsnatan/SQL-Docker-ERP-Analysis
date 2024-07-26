--Customers in groups 3, 4 and 5 for a special marketing analysis with them:
CREATE VIEW marketing_clients AS
WITH marketing_clients AS (
SELECT 
	company_name,
	SUM(unit_price * quantity * (1-discount)) AS total_spend,
	NTILE(5) OVER (ORDER BY SUM(unit_price * quantity * (1-discount)) DESC) AS ranking
FROM 
	customers
JOIN 
	orders ON orders.customer_id = customers.customer_id
JOIN 
	order_details ON orders.order_id = order_details.order_id
GROUP BY
	company_name
ORDER BY 
	total_spend DESC
)

SELECT * FROM marketing_clients
WHERE ranking >= 3
