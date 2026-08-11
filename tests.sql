-- Test UPDATE
UPDATE orders
SET delivery_status = 'Delivered'
WHERE order_id = 5004;

UPDATE customers
SET city = 'Makkah'
WHERE customer_id = 10023;

-- Test DELETE
DELETE FROM order_details
WHERE detail_id = 5;

DELETE FROM order_details
WHERE unit_price = 350;

-- Test Stored Function
SELECT get_order_total(5003) FROM dual;

-- Test Stored Procedure
BEGIN
    update_order_status(5003);
END;
/

SELECT order_id, delivery_status
FROM orders
WHERE order_id = 5003;

-- Test Trigger
INSERT INTO orders
VALUES (6001, NULL, 'Cash', 'Paid', NULL, 'Preparing', 10001, 20001);

SELECT order_id, order_date
FROM orders
WHERE order_id = 6001;