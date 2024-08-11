--Identify the 10 best-selling products:
CREATE VIEW top_10_products AS
SELECT 
	products.product_name,
	SUM(order_details.quantity) AS total
FROM 
	products
INNER JOIN
	order_details ON order_details.product_id = products.product_id
GROUP BY
	products.product_name
ORDER BY
	total DESC
LIMIT 10