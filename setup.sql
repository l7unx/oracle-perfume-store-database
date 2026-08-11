CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2 (100) NOT NULL,
    customer_number VARCHAR2 (10),
    email VARCHAR2 (80) UNIQUE,
    city VARCHAR2 (50) NOT NULL,
    street VARCHAR2 (50),
    district VARCHAR2 (50)
);

CREATE TABLE perfume (
    perfume_id NUMBER PRIMARY KEY,
    perfume_name VARCHAR2(50) NOT NULL,
    brand VARCHAR2 (30),
    price NUMBER NOT NULL,
    category VARCHAR2 (15),
    ingredients VARCHAR2 (200),
    perfume_size VARCHAR2 (600)
);

CREATE TABLE salesperson (
    seller_id NUMBER PRIMARY KEY,
    seller_name VARCHAR2(100),
    phone_number VARCHAR2(10),
    email VARCHAR2(80) UNIQUE
);

CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    Order_date DATE,
    payment_method VARCHAR2 (30),
    payment_status VARCHAR2 (30),
    discount_code VARCHAR2 (30),
    delivery_status VARCHAR2 (30),
    customer_id NUMBER (15),
    CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    detail_id NUMBER PRIMARY KEY,
    order_id NUMBER NOT NULL,
    perfume_id NUMBER NOT NULL,
    unit_price NUMBER NOT NULL,
    quantity NUMBER NOT NULL,
    subtotal NUMBER ,
    discount_applied NUMBER,
    CONSTRAINT fk_details_order
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),
    CONSTRAINT fk_details_perfume
    FOREIGN KEY (perfume_id)
    REFERENCES perfume(perfume_id)
);
ALTER TABLE orders
ADD seller_id NUMBER(15);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_seller
FOREIGN KEY (seller_id)
REFERENCES Salesperson(seller_id);

INSERT INTO Customers VALUES
(10001 , 'Aryam Attia' , '0503764800' , 'Aryam@email.com' , 'AL-Baha' , 'King Abdulaziz Road' , 'Al Zaher');

INSERT INTO Customers VALUES
(10012 , 'Nora Ahmed' , '0507248599' , 'Nora@email.com' , 'Riyadh' , 'Olaya Street' , 'Al-Olaya');

INSERT INTO Customers VALUES
(10023 , 'Rawan Saeed' , '0543876955' , 'Rawan@email.com' , 'Jeddah' , 'Sari Street' , 'Al Rawdah');

INSERT INTO Customers VALUES
(10034 , 'Rana Mohammed' , '0543385115' , 'Rana@email.com' , 'Dammam' , 'Prince Mohammed Road' , 'Al Faisaliyah');

INSERT INTO Customers VALUES
(10045 , 'Noran Saleh' , '0543812934' , 'Noran@email.com' , 'Abha' , 'Abha Dam Road' , 'Al Mansak');

INSERT INTO Perfume VALUES
(301 , 'Rose Oud' , 'Arabian Oud' , 350 , 'Women' , 'Rose , Oud , Musk' , '100ml');

INSERT INTO Perfume VALUES
(302 , 'Amber Night' , 'Ajmal' , 280 , 'Men' , 'Amber, Wood , Spice' , '75ml');

INSERT INTO Perfume VALUES
(303 , 'White Musk' , 'Rasasi' , 190 , 'Unisex' , 'Musk, Lily' , '50ml');

INSERT INTO Perfume VALUES
(304 , 'Royal Bloom' , 'Lattafa' , 220 , 'Women' , 'Rose, Peony, Musk' , '100ml');

INSERT INTO Perfume VALUES
(305 , 'Black Leather' , 'Armaf' , 260 , 'Men' , 'Leather, Patchouli' , '90ml');

INSERT INTO Salesperson VALUES
(20001 , 'Mohammed Ali' , '0508936544' , 'Mohammed@email');

INSERT INTO Orders VALUES
(5001 , SYSDATE , 'Credit Card' , 'Pending' , 'DISC10' , 'Delivered' , 10001 , 20001);

INSERT INTO Orders VALUES
(5002 , SYSDATE , 'Cash' , 'Paid' , NULL , 'Delivered' , 10012 , 20001);

INSERT INTO Orders VALUES
(5003 , SYSDATE , 'Apple Pay' , 'Paid' , NULL , 'Preparing' , 10023 , 20001);

INSERT INTO Orders VALUES
(5004 , SYSDATE , 'Apple Pay' , 'Pending' , 'DISC5' , 'Shipped' , 10045 , 20001);

INSERT INTO Orders VALUES
(5005 , SYSDATE , 'Credit Card' , 'Paid' , NULL , 'Delivered' , 10034 , 20001);

INSERT INTO order_details VALUES
(1 , 5001 , 301 , 350 , 2 , 700 , 70);

INSERT INTO order_details VALUES
(2 , 5002 , 302 , 280 , 1 , 280 , 0);

INSERT INTO order_details VALUES
(3 , 5003 , 304 , 220 , 2 , 440 , 0);

INSERT INTO order_details VALUES
(4 , 5004 , 305 , 260 , 1 , 260 , 25);

INSERT INTO order_details VALUES
(5 , 5005 , 303 , 190 , 1 , 190 , 0);


-- CREATE PL/SQL: Stored Function --
 
CREATE OR REPLACE FUNCTION get_order_total (p_order_id IN NUMBER)
RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    SELECT SUM(subtotal)
    INTO v_total
    FROM order_details
    WHERE order_id = p_order_id;  

    RETURN NVL(v_total, 0);
END;
/

-- Create Stored Procedure --

CREATE OR REPLACE PROCEDURE update_order_status (p_order_id IN NUMBER)
IS
BEGIN
    UPDATE orders
    SET delivery_status = 'Delivered'
    WHERE order_id = p_order_id;
END;
/

-- Create database Trigger --

CREATE OR REPLACE TRIGGER check_order_date
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF :NEW.order_date IS NULL THEN
        :NEW.order_date := SYSDATE;   -- Automatically sets the order date to SYSDATE if no date is provided.
    END IF;
END;
/