--customers
CREATE TABLE customers
  (
    customer_id NUMBER 
                PRIMARY KEY,
    first_name VARCHAR2( 255 ) NOT NULL,
    last_name VARCHAR2( 255 )NOT NULL,
    email VARCHAR2( 255 ),
    gender VARCHAR2( 255 ),
    income_level NUMBER( 8, 2 )
  );

--import customers.csv
  
DROP TABLE customers;

--category
CREATE TABLE category 
    (
    category_id NUMBER (2,0)
                PRIMARY KEY,
    category_name VARCHAR2( 255 ) NOT NULL,
    category_description VARCHAR2( 300 )
    );

--import category.csv
  
DROP TABLE category;
  
  -- product information
CREATE TABLE product_information
  (
    product_id NUMBER
                PRIMARY KEY,
    product_name VARCHAR2( 255 ) NOT NULL,
    product_description VARCHAR2( 300 ),
    product_version NUMBER (4,0),
    category_id NUMBER (2,0),
    warranty_period INTERVAL YEAR(2) TO MONTH,
    FOREIGN KEY( category_id )
    REFERENCES category( category_id )
  );

--import product_information.csv

DROP TABLE product_information;

-- order items
CREATE TABLE order_items
  (
    order_id   NUMBER( 12, 0 )
                PRIMARY KEY,
    product_id NUMBER( 12, 0 ) NOT NULL,
    unit_price NUMBER( 8, 2 ) NOT NULL,
    quantity   NUMBER( 8, 0 ) NOT NULL,
    FOREIGN KEY( product_id )
    REFERENCES product_information( product_id )
  );
  
--import order_items.csv
  
DROP TABLE order_items;

-- orders table
CREATE TABLE orders
  (
    order_id NUMBER (4,0)
               PRIMARY KEY,
    order_date  DATE NOT NULL,
    customer_id   NUMBER (4,0),
    order_total NUMBER( 12, 2 ),
    promotion_id NUMBER (1,0),
    FOREIGN KEY( order_id )
    REFERENCES order_items( order_id ),
    FOREIGN KEY( customer_id )
    REFERENCES customers( customer_id ),
    FOREIGN KEY( promotion_id )
    REFERENCES promotions( promo_id )
  );

--import orders.csv  
  
DROP TABLE orders;  

--promotions  
CREATE TABLE promotions
    (
    promo_id NUMBER( 1, 0 )
                    PRIMARY KEY,
    promo_name VARCHAR2( 300 )
    );

--import promotions.csv
--or
--optional
INSERT INTO promotions (promo_id, promo_name)
VALUES (1, 'mid season sale');

INSERT INTO promotions (promo_id, promo_name)
VALUES (2, 'black friday');

DROP TABLE promotions;
