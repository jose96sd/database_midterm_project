SELECT product_name, 
	   SUM(quantity) AS quantity,
       COUNT(order_id) AS Total_orders
FROM order_details
INNER JOIN products ON order_details.product_id = products.product_id	
GROUP BY
    product_name
ORDER BY
    quantity desc
	