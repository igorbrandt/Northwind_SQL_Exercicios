-- 6. Gere uma coluna que mostre o valor do pedido anterior para o mesmo cliente 
-- e outra que calcule a diferença percentual entre o pedido atual e o anterior.
-- Objetivo: usar LAG(valor_total) OVER (...) e expressões aritméticas.

-- calcular valor dos pedidos por cliente
WITH valores_vendas AS (
	SELECT
		o.order_id,
		o.order_date,
		o.customer_id,
		SUM((od.quantity * od.unit_price) * (1 - od.discount)) AS valor_venda
	FROM order_details od
	JOIN orders o ON o.order_id = od.order_id
	GROUP BY o.order_id
	ORDER BY o.order_date
),

-- calcular valor do pedido anterior para cada cliente
valores_vendas_lag AS (
	SELECT
		vv.customer_id,
		vv.order_date,
		vv.order_id,
		vv.valor_venda,
		LAG(vv.valor_venda, 1, NULL) OVER(PARTITION BY vv.customer_id ORDER BY vv.order_date) AS venda_anterior
	FROM valores_vendas vv
	ORDER BY vv.customer_id
)

-- output final
SELECT 
	vvl.customer_id,
	vvl.order_date,
	vvl.order_id,
	vvl.valor_venda,
	vvl.venda_anterior,
	((vvl.valor_venda - vvl.venda_anterior) / vvl.venda_anterior) * 100 AS dif_percentual
FROM valores_vendas_lag vvl




