--Total amount each client has paid so far (revenue per customer):
CREATE VIEW total_revenue_per_customer AS
SELECT 
	DISTINCT company_name,
	SUM(unit_price * quantity * (1-discount)) OVER(PARTITION BY company_name) AS total_spent 
FROM 
	customers
JOIN 
	orders ON orders.customer_id = customers.customer_id
JOIN 
	order_details ON orders.order_id = order_details.order_id
ORDER BY 
	total_spent DESC
