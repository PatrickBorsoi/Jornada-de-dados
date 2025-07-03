-- customers e orders no ano de 1996
SELECT *
FROM orders AS o
INNER JOIN customers AS c ON o.customer_id = c.customer_id
-- Aqui utilizamos o Extract para pegar somento o Ano
WHERE EXTRACT(YEAR FROM o.order_date) = 1996


--Exercício 1: Criar um relatórioque mostr o número de funcioários e clientes de cada cidade que tem funcionários
SELECT e.city AS cidade,
    COUNT(DISTINCT e.employee_id) AS numero_de_funcionarios,
    COUNT(DISTINCT c.customer_id) AS numero_de_clientes
FROM employees e
LEFT JOIN customers c ON e.city = c.city
GROUP BY e.city
ORDER BY cidade;


--Exercício 2: Valor Total por Pedido
--OBS: Liste todos os OrderID da tabela orders e o valor total de cada pedido.
SELECT 
	o.order_id,
	SUM(od.quantity * od.unit_price) AS valor_total_do_pedido
FROM
	orders AS o
INNER JOIN	
	order_details AS od ON o.order_id = od.order_id
GROUP BY 
	o.order_id;

--Exercício 3: Quais os 10 produtos mais vendidos em quantidade total?

SELECT
	p.product_name,
	SUM(od.quantity) AS total_vendido
FROM
	products AS p
INNER JOIN
	order_details AS od ON p.product_id = od.product_id
GROUP BY
	p.product_name
ORDER BY
	total_vendido DESC
LIMIT 10;

--Exercício 4: Queremos saber qual transportadora é a mais utilizada para nossos envios. Conte quantos pedidos cada transportadora 
--já enviou e ordene o resultado da mais para a menos utilizada.


--Exercício 5: Identifique os 5 principais fornecedores com base na variedade de produtos que eles nos oferecem. Ou seja, conte quantos produtos diferentes cada fornecedor tem em nosso catálogo.
SELECT 
	s.company_name,
	count(p.product_name) AS quantidade_de_produtos
	
FROM 
	suppliers AS s
JOIN 
	products AS p 
	ON s.supplier_id = p.supplier_id
GROUP BY 
	s.company_name
ORDER BY Quantidade_de_produtos DESC
LIMIT 5;

--Exercício 6: : Gere um relatório mostrando o valor total de vendas para cada país de nossos clientes. Ordene os países pelo total de vendas, do maior para o menor.
-- Nesse exercicio utilizei um JOIN triplo para conseguir captar todas as informações
SELECT 
	c.country,
	SUM(od.unit_price * od.quantity) AS Valor_total_de_vendas
FROM
	customers AS c
	INNER JOIN orders AS o
		ON o.customer_id = c.customer_id
	INNER JOIN order_details AS od
		ON od.order_id = o.order_id
GROUP BY 
	c.country
ORDER BY 
	Valor_total_de_vendas DESC

--Exercício 7: Queremos saber qual transportadora é a mais utilizada para nossos envios. Conte quantos pedidos cada transportadora já enviou e ordene o resultado da mais para a menos utilizada.
-- Nesse exercício utilizei o \d na tabela ORDERS para verificar onde estava a Foreing-Key de SHIPPERS
SELECT
	s.company_name,
	count(o.ship_via) AS quantidade_de_pedidos
FROM
	shippers AS s
INNER JOIN orders AS o
	ON o.ship_via = s.shipper_id
GROUP BY 
	s.company_name
ORDER BY
	quantidade_de_pedidos DESC