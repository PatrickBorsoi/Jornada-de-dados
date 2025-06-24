-- customers e orders no ano de 1996
SELECT *
FROM orders AS o
INNER JOIN customers AS c ON o.customer_id = c.customer_id
-- Aqui utilizamos o Extract para pegar somento o Ano
WHERE EXTRACT(YEAR FROM o.order_date) = 1996


-- Criar um relatórioque mostr o número de funcioários e clientes de cada cidade que tem funcionários
SELECT e.city AS cidade,
    COUNT(DISTINCT e.employee_id) AS numero_de_funcionarios,
    COUNT(DISTINCT c.customer_id) AS numero_de_clientes
FROM employees e
LEFT JOIN customers c ON e.city = c.city
GROUP BY e.city
ORDER BY cidade;