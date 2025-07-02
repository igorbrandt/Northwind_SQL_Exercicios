-- 1. Para cada cliente, liste todos os pedidos com o total acumulado de valores ordenado pela data do pedido.
-- Objetivo: usar SUM(...) OVER (PARTITION BY … ORDER BY …)
--Resultado: uma linha por pedido incluindo coluna acumulado_cliente

-- CTE para calcular total de cada pedido
WITH total_por_cliente AS(
	SELECT 
		o.customer_id,
		od.order_id,
		o.order_date,
		SUM((od.unit_price * od.quantity) - od.discount) AS valor_ordem
	FROM order_details od
	JOIN orders o ON od.order_id = o.order_id
	GROUP BY od.order_id, o.customer_id, o.order_date
)

-- Consulta em si
SELECT 
	tpc.customer_id, 
	tpc.order_id, 
	tpc.order_date,
	tpc.valor_ordem,
	SUM(tpc.valor_ordem) OVER(PARTITION BY tpc.customer_id ORDER BY tpc.order_date)
FROM total_por_cliente tpc


-- 2. Para cada produto, atribua um número sequencial ao seu histórico de vendas (ordem de entrada em OrderDetails).
-- Objetivo: usar ROW_NUMBER() OVER (PARTITION BY productID ORDER BY orderID)
-- Resultado: coluna seq_venda_por_produto