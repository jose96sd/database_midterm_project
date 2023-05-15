SELECT employees.employee_id,
	   first_name, 
	   last_name,
	   SUM(sale) AS sale_amount,
	   DATE_TRUNC('month', t2.order_date) AS month_date
FROM employees
INNER JOIN 
	(SELECT employee_id,
		   t1.order_id,
		   SUM(order_details.quantity)*order_details.unit_price AS sale,
	 	   order_date
	FROM orders t1
	INNER JOIN order_details ON t1.order_id = order_details.order_id
	INNER JOIN products ON order_details.product_id = products.product_id
	GROUP BY
		t1.order_id,order_details.unit_price,t1.order_date) t2 ON t2.employee_id = employees.employee_id
GROUP BY employees.employee_id, first_name, last_name, month_date
ORDER BY month_date asc, sale_amount desc