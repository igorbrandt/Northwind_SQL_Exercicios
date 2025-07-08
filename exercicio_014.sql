-- 14. Crie uma visualização (por exemplo, no Power BI ou Tableau) 
-- que use uma window function para colorir os 5 maiores pedidos de cada cliente em destaque.

CREATE VIEW order_clientes_top_10 AS (
WITH valor_por_ordem_cliente AS (
	SELECT
		o.customer_id,
		o.order_id,
		SUM((od.quantity * od.unit_price) * (1 - od.discount)) as valor
	FROM orders o
	JOIN order_details od ON o.order_id = od.order_id
	GROUP BY o.customer_id, o.order_id
),

	ordens_rankeadas_por_cliente AS (
	SELECT
		vpoc.customer_id,
		vpoc.order_id,
		vpoc.valor,
		RANK() OVER(PARTITION BY vpoc.customer_id ORDER BY vpoc.valor) as rank,
		SUM(vpoc.valor) OVER(PARTITION BY vpoc.customer_id) AS valor_total_cliente
	FROM valor_por_ordem_cliente vpoc
	ORDER BY vpoc.valor DESC
),

top_10_clientes AS (
	SELECT
		DISTINCT orpc.customer_id,
		orpc.valor_total_cliente
	FROM ordens_rankeadas_por_cliente orpc
	ORDER BY orpc.valor_total_cliente DESC
	LIMIT 10
)

SELECT
	orpc.customer_id,
	orpc.order_id,
	orpc.valor,
	orpc.valor_total_cliente,
	orpc.rank
FROM ordens_rankeadas_por_cliente orpc
JOIN top_10_clientes t10 ON t10.customer_id = orpc.customer_id
WHERE orpc.rank <= 5
ORDER BY orpc.customer_id, orpc.valor DESC

)
