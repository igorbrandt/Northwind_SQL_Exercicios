-- - Para cada produto, atribua um número sequencial ao seu histórico de vendas 
-- (ordem de entrada em OrderDetails).
-- Objetivo: usar ROW_NUMBER() OVER (PARTITION BY productID ORDER BY orderID)
-- Resultado: coluna seq_venda_por_produto

SELECT
	od.order_id,
	od.product_id,
	o.order_date,
	ROW_NUMBER() OVER(PARTITION BY od.product_id ORDER BY o.order_date) 
FROM order_details od
JOIN orders o ON od.order_id = o.order_id