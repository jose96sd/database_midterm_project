SELECT ship_country AS Country, 
       DATE_TRUNC('month', order_date AT TIME ZONE 'Turkey') AS Month,
       COUNT(order_id) AS Total_orders
FROM
    orders
GROUP BY
    Country, Month
ORDER BY
    Country desc, Month asc