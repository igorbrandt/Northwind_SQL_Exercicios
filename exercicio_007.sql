-- 7. Divida todos os clientes em quartis com base no valor total de compras até hoje.
-- Objetivo: usar NTILE(4) OVER (ORDER BY total_compras) após agregar por cliente.

WITH valores_totais AS (
	SELECT
		o.customer_id,
		SUM((od.quantity * od.unit_price) * (1 - od.discount)) AS valor_total
	FROM order_details od
	JOIN orders o ON o.order_id = od.order_id
	GROUP BY o.customer_id
	ORDER BY valor_total DESC
)

SELECT
	vt.customer_id,
	vt.valor_total,
	NTILE(4) OVER(ORDER BY vt.valor_total DESC)
FROM valores_totais vt
