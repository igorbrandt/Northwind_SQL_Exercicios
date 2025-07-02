-- 5. Para cada funcionário, calcule o seu numero de pedidos e o quanto ele desviou da média
-- Objetivo : usar COUNT(orderID) OVER (PARTITION BY employeeID) e AVG(...) OVER ()

WITH vendas_por_funcionario AS (
	SELECT
		distinct o.employee_id,
		COUNT(*) OVER(PARTITION BY o.employee_id) as n_de_vendas
	FROM orders o
	ORDER BY o.employee_id
)

SELECT
	e.first_name,
	vpf.n_de_vendas,
	(vpf.n_de_vendas - AVG(vpf.n_de_vendas) OVER()) AS desvio
FROM vendas_por_funcionario vpf
JOIN employees e ON e.employee_id = vpf.employee_id

