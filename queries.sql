-- Create Queries: SELECT,JOIN,COUNT,AVERAGE,GROUP BY,ORDER BY AND CONDITION --

SELECT * FROM Perfume;

SELECT c.customer_name, o.order_id
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

SELECT COUNT(*) FROM orders;
SELECT AVG(Price) FROM Perfume;

SELECT customer_id, COUNT(order_id)
FROM orders
GROUP BY customer_id;

SELECT * FROM perfume
WHERE category = 'Women'
ORDER BY Price DESC;

SELECT * FROM customers WHERE city = 'Riyadh';
