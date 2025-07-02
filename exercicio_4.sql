-- 4. Dentro de cada categoria de produto, descubra quais produtos 
-- estão no top 3 de receita total de vendas.

-- calcular receitas por produto
WITH receitas_totais AS(
	SELECT 
		c.category_name,
		p.product_name,
		SUM((od.quantity * od.unit_price)) AS valor_venda
	FROM order_details od
	JOIN orders o ON od.order_id = o.order_id
	JOIN products p ON od.product_id = p.product_id
	JOIN categories c ON c.category_id = p.category_id
	GROUP BY c.category_name, p.product_name
),

-- criar rankeamento
ranking_receitas_categoria_produto AS(
	SELECT
		rt.category_name,
		rt.product_name,
		rt.valor_venda,
		RANK() OVER(PARTITION BY rt.category_name ORDER BY rt.valor_venda DESC) AS ranking
	FROM receitas_totais rt
)


-- filtrar top3 de cada categoria
SELECT *
FROM ranking_receitas_categoria_produto rrcp
WHERE rrcp.ranking <= 3






