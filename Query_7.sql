SELECT suppliers.company_name AS supplier_company,
	   product_name,
	   SUM(order_details.quantity) AS num_products,
	   COUNT(orders.order_id) AS num_orders,
	   customers.company_name AS customer_company,
	   shippers.company_name AS shipper_company	   
FROM suppliers
INNER JOIN products ON products.supplier_id = suppliers.supplier_id
INNER JOIN order_details ON order_details.product_id = products.product_id
INNER JOIN orders ON orders.order_id = order_details.order_id
INNER JOIN customers ON customers.customer_id = orders.customer_id
INNER JOIN shippers ON shippers.shipper_id = orders.ship_via
GROUP BY suppliers.company_name, 
		 products.product_name, 
		 customers.company_name, 
		 shippers.company_name
ORDER BY product_name ASC