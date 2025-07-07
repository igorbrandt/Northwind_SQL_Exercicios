-- Calcule a média acumulada do valor dos pedidos para cada cliente.
-- Objetivo: usar AVG(valor_total) OVER (PARTITION BY customerID 

-- CTE para calcular o valor de cada ordem
WITH orders_values AS(
	SELECT
		o.customer_id,
		o.order_id,
		o.order_date,
		SUM((od.quantity * od.unit_price) - od.discount) AS order_value
	FROM orders o
	JOIN order_details od ON o.order_id = od.order_id
	GROUP BY o.customer_id, o.order_id
	ORDER BY o.customer_id
)

-- consunta com window func para calcular a média acumulada
SELECT 
	o.customer_id,
	o.order_id,
	o.order_date,
	ov.order_value,
	AVG(ov.order_value) OVER(PARTITION BY o.customer_id ORDER BY ov.order_date)
FROM orders_values ov
JOIN orders o ON o.order_id = ov.order_id