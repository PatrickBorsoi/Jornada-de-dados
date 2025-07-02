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
