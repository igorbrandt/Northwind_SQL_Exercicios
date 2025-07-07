-- 8. Para cada mês de 1997, calcule o total de vendas e compare com o mesmo mês do ano anterior,
-- exibindo a variação percentual.
-- Objetivo: combinar DATE_TRUNC(), soma por período e LAG(...) OVER (ORDER BY mes)

-- vendas totais para cada mês
WITH vendas_totais AS (
	SELECT
		DATE_TRUNC('month', o.order_date) AS Mes,
		SUM((od.quantity * od.unit_price) * (1 - od.discount)) AS Valor_Total
	FROM order_details od
	JOIN orders o ON o.order_id = od.order_id
	WHERE EXTRACT(YEAR FROM o.order_date) IN (1996, 1997)
	GROUP BY Mes
),

vendas_totais_e_anterior AS (
	SELECT 
	    EXTRACT(MONTH FROM vt.Mes) AS mes,
	    EXTRACT(YEAR FROM vt.Mes) AS ano,
		vt.Valor_Total as Valor_Total,
	    LAG(SUM(vt.valor_total)) OVER (
			PARTITION BY EXTRACT(MONTH FROM vt.Mes) 
			ORDER BY EXTRACT(YEAR FROM vt.Mes)) AS total_mes_ano_anterior
	FROM vendas_totais vt
	GROUP BY 
		EXTRACT(MONTH FROM vt.Mes), 
		EXTRACT(YEAR FROM vt.Mes), 
		vt.Valor_Total
	ORDER BY ano, mes
)

SELECT
	vtea.mes,
	vtea.ano,
	vtea.valor_total,
	vtea.total_mes_ano_anterior,
	((vtea.Valor_Total - vtea.total_mes_ano_anterior)/vtea.total_mes_ano_anterior) * 100 AS Dif
FROM vendas_totais_e_anterior vtea