-- 12. Para cada funcionário, calcule o número de pedidos por mês 
-- e a variação percentual em relação ao mês anterior.
-- Liste os funcionários com as maiores variações positivas.

-- na CTE é melhor trabalhar com as datas sem formatacao
WITH order_employee_mes AS (
	SELECT 
		o.employee_id, 
		CAST(DATE_TRUNC('month', o.order_date) AS date) as mes,
		COUNT(*) AS cont_orders
	FROM orders o
	GROUP BY o.employee_id, mes
	ORDER BY o.employee_id, mes
),

-- depois chama a data formatada na query
-- nº de pedidos / funcionário / mês / lag
order_employee_mes_lag AS (
	SELECT
		oem.employee_id,
		TO_CHAR(oem.mes, 'MM/YYYY') as competencia,
		oem.cont_orders,
		LAG(oem.cont_orders, 1, NULL) OVER(
			PARTITION BY oem.employee_id) AS mes_anterior
	FROM order_employee_mes oem
)

SELECT
	oeml.employee_id,
	oeml.competencia,
	oeml.cont_orders,
	ROUND(
		(oeml.cont_orders - mes_anterior)::NUMERIC 
		/ mes_anterior * 100
		, 2) AS dif_percent
FROM order_employee_mes_lag oeml
WHERE ROUND(
		(oeml.cont_orders - mes_anterior)::NUMERIC 
		/ mes_anterior * 100
		, 2) IS NOT NULL
ORDER BY dif_percent DESC
LIMIT 25




