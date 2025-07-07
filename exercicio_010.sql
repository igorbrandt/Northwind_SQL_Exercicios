-- 10. Para cada cliente, calcule o tempo médio (em dias) entre seus pedidos.
WITH orders_by_client AS (
	SELECT
		o.customer_id,
		o.order_date,
		LAG(o.order_date, 1, NULL) 
			OVER(PARTITION BY o.customer_id ORDER BY o.order_date)
			AS last_order
	FROM orders o
),
orders_tempo_corrido AS (
	SELECT 
		obc.customer_id,
		(obc.order_date - obc.last_order) AS tempo_corrido
	FROM orders_by_client obc
)

SELECT 
	otc.customer_id,
	AVG(tempo_corrido) AS media_tempo_corrido
FROM orders_tempo_corrido otc
GROUP BY otc.customer_id
ORDER BY media_tempo_corrido ASC


