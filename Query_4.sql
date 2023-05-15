SELECT employees.employee_id,
	   first_name, 
	   last_name,
	   SUM(products_sold) AS products_sold
FROM employees
INNER JOIN 
	(SELECT employee_id,
		   t1.order_id,
		   SUM(order_details.quantity) AS products_sold,
		   category_name
	FROM orders t1
	INNER JOIN order_details ON t1.order_id = order_details.order_id
	INNER JOIN products ON order_details.product_id = products.product_id
	INNER JOIN categories ON products.category_id = categories.category_id
	GROUP BY
		t1.order_id, category_name) t2 ON t2.employee_id = employees.employee_id
WHERE category_name = 'Beverages'
GROUP BY employees.employee_id, first_name, last_name
ORDER BY products_sold desc
LIMIT 10
