SELECT territory_description,
	   SUM(sale_amount) as territory_sale
	   FROM employee_territories
	   INNER JOIN
	(SELECT employees.employee_id,
		   first_name, 
		   last_name,
		   SUM(sale) AS sale_amount
	FROM employees
	INNER JOIN 
		(SELECT employee_id,
			   t1.order_id,
			   SUM(order_details.quantity)*order_details.unit_price AS sale
		FROM orders t1
		INNER JOIN order_details ON t1.order_id = order_details.order_id
		INNER JOIN products ON order_details.product_id = products.product_id
		GROUP BY
			t1.order_id,order_details.unit_price) t2 ON t2.employee_id = employees.employee_id
	GROUP BY employees.employee_id, first_name, last_name) t3 ON t3.employee_id = employee_territories.employee_id
	INNER JOIN territories ON employee_territories.territory_id = territories.territory_id
	GROUP BY territory_description
	ORDER BY territory_description asc