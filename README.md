# sql_exercicios

## Exercícios com base no banco de dados de exemplo da Microsoft: Northwind

### Exercícios básicos
1. Para cada cliente, liste todos os pedidos com o total acumulado de valores ordenado pela data do pedido.
Objetivo     : usar SUM(...) OVER (PARTITION BY … ORDER BY …)
Resultado    : uma linha por pedido incluindo coluna acumulado_cliente
2. Para cada produto, atribua um número sequencial ao seu histórico de vendas (ordem de entrada em OrderDetails).
Objetivo     : usar ROW_NUMBER() OVER (PARTITION BY productID ORDER BY orderID)
Resultado    : coluna seq_venda_por_produto
3. Calcule a média móvel de três pedidos consecutivos (em termos de OrderID) para cada cliente.
Objetivo     : usar AVG(valor_total) OVER (PARTITION BY customerID ORDER BY orderID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)

### Exercícios intermediários
4. Dentro de cada categoria de produto, descubra quais produtos estão no top 3 de receita total de vendas.
Objetivo     : combinar SUM(...), PARTITION BY categoryID, RANK() e filtrar no nível da janela.
5. Para cada funcionário, calcule o desvio em relação à média de pedidos que ele atendeu.
Objetivo     : usar COUNT(orderID) OVER (PARTITION BY employeeID) e AVG(...) OVER ()
6. Gere uma coluna que mostre o valor do pedido anterior para o mesmo cliente e outra que calcule a diferença percentual entre o pedido atual e o anterior.
Objetivo     : usar LAG(valor_total) OVER (...) e expressões aritméticas.

### Exercícios avançados
7. Divida todos os clientes em quartis com base no valor total de compras até hoje.
Objetivo     : usar NTILE(4) OVER (ORDER BY total_compras) após agregar por cliente.
8. Para cada mês de 1997, calcule o total de vendas e compare com o mesmo mês do ano anterior, exibindo a variação percentual.
Objetivo     : combinar DATE_TRUNC(), soma por período e LAG(...) OVER (ORDER BY mes)
9. Crie uma visualização (por exemplo, no Power BI ou Tableau) que use uma window function para colorir os cinco maiores pedidos de cada cliente em destaque.
Objetivo     : integrar SQL e ferramenta de BI, usando RANK() ou DENSE_RANK().
