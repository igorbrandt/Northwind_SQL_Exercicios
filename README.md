# Exercícios com base no banco de dados de exemplo da Microsoft: Northwind

1. Para cada cliente, liste todos os pedidos com o total acumulado de valores ordenado pela data do pedido.
Objetivo     : usar SUM(...) OVER (PARTITION BY … ORDER BY …)
Resultado    : uma linha por pedido incluindo coluna acumulado_cliente
2. Para cada produto, atribua um número sequencial ao seu histórico de vendas (ordem de entrada em OrderDetails).
Objetivo     : usar ROW_NUMBER() OVER (PARTITION BY productID ORDER BY orderID)
Resultado    : coluna seq_venda_por_produto
3. Calcule a média móvel de três pedidos consecutivos (em termos de OrderID) para cada cliente.
Objetivo     : usar AVG(valor_total) OVER (PARTITION BY customerID ORDER BY orderID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
4. Dentro de cada categoria de produto, descubra quais produtos estão no top 3 de receita total de vendas.
Objetivo     : combinar SUM(...), PARTITION BY categoryID, RANK() e filtrar no nível da janela.
5. Para cada funcionário, calcule o desvio em relação à média de pedidos que ele atendeu.
Objetivo     : usar COUNT(orderID) OVER (PARTITION BY employeeID) e AVG(...) OVER ()
6. Gere uma coluna que mostre o valor do pedido anterior para o mesmo cliente e outra que calcule a diferença percentual entre o pedido atual e o anterior.
Objetivo     : usar LAG(valor_total) OVER (...) e expressões aritméticas.
7. Divida todos os clientes em quartis com base no valor total de compras até hoje.
Objetivo     : usar NTILE(4) OVER (ORDER BY total_compras) após agregar por cliente.
8. Para cada mês de 1997, calcule o total de vendas e compare com o mesmo mês do ano anterior, exibindo a variação percentual.
Objetivo     : combinar DATE_TRUNC(), soma por período e LAG(...) OVER (ORDER BY mes)
9. Liste os 5 clientes que mais compraram em valor total, considerando todos os pedidos.
Use uma CTE para calcular o total de compras por cliente e uma função de janela para ranqueá-los.
Objetivo:
- SUM(...) com GROUP BY
- RANK() ou ROW_NUMBER()
- ORDER BY e LIMIT ou filtro por ranking
10. Para cada cliente, calcule o tempo médio (em dias) entre seus pedidos.
Use LAG() para obter a data do pedido anterior e uma CTE para calcular os intervalos.
Objetivo:
- LAG(order_date)
- DATE_PART('day', atual - anterior)
- AVG(...) OVER (PARTITION BY customer_id)
11. Para cada produto, calcule o total de vendas por mês e identifique os meses em que houve crescimento em relação ao mês anterior.
Objetivo:
- DATE_TRUNC('month', order_date)
- SUM(quantity * unit_price)
- LAG() para comparar meses
- CTE para organizar os dados
12. Para cada funcionário, calcule o número de pedidos por mês e a variação percentual em relação ao mês anterior.
Liste os funcionários com as maiores variações positivas.
Objetivo:
- COUNT(order_id) por mês e funcionário
- LAG() + cálculo de variação percentual
- RANK() ou ROW_NUMBER() para destacar os maiores saltos
13. Identifique os clientes que fizeram pelo menos um pedido em todos os 12 meses de 1997.
Use CTEs para contar os meses distintos com pedidos por cliente.
Objetivo:
- DATE_TRUNC('month', order_date)
- COUNT(DISTINCT mes) por cliente
- Filtro: HAVING COUNT(...) = 12
14. Crie uma visualização (por exemplo, no Power BI ou Tableau) que use uma window function para colorir os cinco maiores pedidos de cada cliente em destaque.
Objetivo     : integrar SQL e ferramenta de BI, usando RANK() ou DENSE_RANK().
15. Descubra o pedido mais caro de cada cliente… e também o segundo mais caro
16. Para cada produto, calcule o intervalo médio de tempo entre cada venda
17. Identifique produtos que ficaram pelo menos 90 dias sem vender
18. Calcule o total de vendas acumuladas por categoria, mês a mês
19. Para cada cliente, descubra o mês em que ele gastou mais… e o segundo mais