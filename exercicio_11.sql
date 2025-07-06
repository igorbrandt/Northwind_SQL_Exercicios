-- 11. Para cada produto, calcule o total de vendas por mês e 
-- identifique os meses em que houve crescimento em relação ao mês anterior.

-- cria tabela com valores por produto e data
WITH vendas_por_produto AS (
	SELECT
		od.product_id,
		o.order_date,
		SUM((od.quantity * od.unit_price) * (1 - od.discount)) AS order_value
	FROM order_details od
	JOIN orders o ON o.order_id = od.order_id
	GROUP BY od.product_id, o.order_date
	ORDER BY od.product_id
),

-- cria tabela com data separada em meses e anos
vendas_mes_ano AS (
	SELECT
		vpp.product_id,
		EXTRACT(MONTH FROM vpp.order_date) as month,
		EXTRACT(YEAR FROM vpp.order_date) as year,
		SUM(vpp.order_value) AS valor
	FROM vendas_por_produto vpp
	GROUP BY vpp.product_id, month, year
),

-- cria tabela com competencias concatenadas
vendas_produto_competencia AS (
	SELECT
		vma.product_id,
		CONCAT(vma.month, '/', vma.year) AS competencia,
		vma.valor
	FROM vendas_mes_ano vma
)

-- 
SELECT
	p.product_name,
	vpc.competencia,
	SUM(vpc.valor)
FROM vendas_produto_competencia vpc
JOIN products p ON p.product_id = vpc.product_id
GROUP BY p.product_name, vpc.competencia
ORDER BY p.product_name, vpc.competencia ASC