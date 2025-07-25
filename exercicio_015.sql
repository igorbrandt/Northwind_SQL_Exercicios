-- 15. Identifique o pedido mais caro de cada cliente… 

WITH orders_by_client AS (
	SELECT 
		o.customer_id,
		od.order_id,
		((od.unit_price * od.quantity) * (1 - od.discount)) AS order_value
	FROM order_details od
	JOIN orders o ON o.order_id = od.order_id
	ORDER BY o.customer_id
),

orders_ranking AS (
	SELECT
		obc.customer_id, 
		obc.order_id,
		obc.order_value,
		RANK() OVER(PARTITION BY obc.customer_id ORDER BY obc.order_value DESC) AS order_rank
	FROM orders_by_client obc
)

-- pedido mais caro de cada cliente
SELECT *
FROM orders_ranking ok
WHERE ok.order_rank = 1