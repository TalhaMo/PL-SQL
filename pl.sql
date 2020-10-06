--/1-
DECLARE
v_customers CUSTOMER %rowtype;

BEGIN
SELECT * INTO v_customers FROM CUSTOMER
dbms_output.put_line(v_customers.Customer_id |''| v_customers.Customer_Name |''| v_customers.Customer_Tel);
END;
/

--2-

CREATE OR REPLACE PS_Customer_Prodcut (v_customer_id CUSTOMER.Customer_id %TYPE) IS
CURSOR cur IS
SELECT Product_Name FROM ORDERS
INNER JOIN CUSTOMER ON ORDERS.Customer_id = CUSTOMER.Customer_id
INNER JOIN PRODUCT ON ORDERS.Product_id = PRODUCT.Product_id
WHERE v_customer_id = Customer_id;
BEGIN
FOR rec IN cur LOOP
dbms_output.put_line('Products: '||rec.Product_Name);
END LOOP;
EXCEPTION
WHEN NO_DATA_FOUND THEN
dbms_output.put_line('No products returned or customer not found');
END;
/

--3/
CREATE OR REPLACE FUNCTION FN_Customer_Orders (v_costumer_id CUSTOMER.Customer_id %type) RETURN NUMBER IS nb_orders 
BEGIN
SELECT count(*) into nb_orders FROM CUSTOMER WHERE
Customer_id=v_Customer_id ;
	RETURN nb_orders ;
END ;
/

--4/

BEFORE INSERT ON ORDERS FOR EACH ROW
BEGIN
 IF (old.OrderDate >= SYSDATE) THEN
    dbms_output.put_line("Order Date must be greater than or equal to today's date");    
 END_IF;
    
END;
/
