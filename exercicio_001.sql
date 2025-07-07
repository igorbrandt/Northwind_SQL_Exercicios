-- Para cada cliente, liste todos os pedidos com o total acumulado 
-- de valores ordenado pela data do pedido.

-- CTE para calcular total de cada pedido
WITH total_por_cliente AS(
	SELECT 
		o.customer_id,
		od.order_id,
		o.order_date,
		SUM((od.unit_price * od.quantity) - od.discount) AS valor_ordem
	FROM order_details od
	JOIN orders o ON od.order_id = o.order_id
	GROUP BY od.order_id, o.customer_id, o.order_date
)

-- Consulta em si
SELECT 
	tpc.customer_id, 
	tpc.order_id, 
	tpc.order_date,
	tpc.valor_ordem,
	SUM(tpc.valor_ordem) OVER(PARTITION BY tpc.customer_id ORDER BY tpc.order_date)
FROM total_por_cliente tpc