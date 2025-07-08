-- 13. Identifique os clientes que fizeram pelo menos um pedido
-- em ao meses 8 de 1997.

-- contar quantos meses cada cliente possui pedidios em 1997
WITH ordens_por_cliente_mes AS (
	SELECT
		o.customer_id,
		DATE_TRUNC('month', o.order_date) AS mes,
		o.order_id
	FROM orders o
	WHERE o.order_date BETWEEN '1997-01-01' AND '1997-12-31'
),

meses_por_cliente AS (
	SELECT
		opcm.customer_id,
		COUNT(DISTINCT opcm.mes) as cont_mes
	FROM ordens_por_cliente_mes opcm 
	GROUP BY opcm.customer_id
)

SELECT *
FROM meses_por_cliente mpc
WHERE mpc.cont_mes >= 8