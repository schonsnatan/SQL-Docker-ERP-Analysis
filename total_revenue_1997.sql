--Total revenue in 1997:
CREATE VIEW total_revenue_1997 AS
SELECT 
	SUM(od.unit_price * od.quantity * (1-discount)) AS total_revenue_1997 
FROM 
	orders AS o 
JOIN 
	order_details AS od 
ON 
	o.order_id = od.order_id
WHERE 
	EXTRACT(YEAR FROM o.order_date) = 1997
    