-- 9. Liste os 5 clientes que mais compraram em valor total, considerando 
-- todos os pedidos.
WITH valores_clientes AS (
	select
		o.customer_id,
		SUM((od.quantity * od.unit_price) * (1 - od.discount)) AS valor_total
	from order_details od
	join orders o ON o.order_id = od.order_id
	GROUP BY o.customer_id
)

SELECT 
	vc.customer_id,
	vc.valor_total,
	RANK() OVER(ORDER BY vc.valor_total DESC)
FROM valores_clientes vc
LIMIT 5