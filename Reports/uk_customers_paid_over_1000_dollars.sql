--UK customers paid over 1000 dollars:
CREATE VIEW uk_clients_who_pay_more_then_1000 AS
SELECT 
	customers.company_name,
	SUM(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) AS total_spend
FROM 
	customers
INNER JOIN 
	orders ON customers.customer_id = orders.customer_id
INNER JOIN 
	order_details ON orders.order_id = order_details.order_id
WHERE 
	UPPER(customers.country)='UK'
GROUP BY
	customers.company_name
HAVING 
	SUM(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) > 1000