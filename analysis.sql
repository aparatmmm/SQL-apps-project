--The applications analysis.

--How many apps are user-friendly ? 

SELECT
    COALESCE(product_name,'Total_user_friendly_apps') AS user_friendly_apps,
    COUNT(*) AS amount
FROM
    product_information
WHERE
    product_description LIKE 'User-friendly%'
GROUP BY ROLLUP
    (product_name);
    
    
--Give a number of multimedia apps.   
    
SELECT
    COUNT(*) AS multimedia_apps
FROM
    product_information
WHERE
    product_description LIKE '%multimedia%';
    
    
--What is the most recent version of each of the apps?

SELECT 
    DISTINCT product_name,
    MAX(product_version) AS new_version
FROM
    product_information
GROUP BY 
    product_name
ORDER BY
    1;


--Which of the 'generation' apps includes the new version?

SELECT 
     product_name,
     product_description AS generation_app,
     product_version AS new_version
FROM 
    product_information
WHERE
    product_description LIKE '%generation%'
    AND product_version IN (
        SELECT 
            MAX(product_version)
        FROM 
            product_information
        GROUP BY
            product_name )
ORDER BY 
    product_name;
    
----------------------------------------------------

--Clients analysis.

--Which one of the inbox names appears the most?
--For example: mail jwalthalla8@bizjournals.com - as a name inbox bizjournals.

SELECT
    RTRIM(LTRIM(email,SUBSTR(email,1,(LENGTH(first_name)+ LENGTH(last_name) + 2))),'.com') AS supplier,
    COUNT ( RTRIM(LTRIM(email,SUBSTR(email,1,(LENGTH(first_name)+ LENGTH(last_name) + 2))),'.com')) AS count
FROM
    customers
GROUP BY
    RTRIM(LTRIM(email,SUBSTR(email,1,(LENGTH(first_name)+ LENGTH(last_name) + 2))),'.com')
ORDER BY
    2 DESC
FETCH FIRST 1 ROWS ONLY;
    
      
--Assign to each of customers an income category accordingly to the list below:
--A: Below 30,000
--B: 30,000 - 49,999
--C: 50,000 - 69,999
--D: 70,000 - 89,999
--E: 90,000 - 109,999
--F: 110,000 - 129,999
--G: 130,000 - 149,999
--H: 150,000 - 169,999
--I: 170,000 - 189,999
--J: 190,000 - 249,999
--K: 250,000 - 299,999
--L: 300,000 and above


SELECT
    first_name,
    last_name,
    income_level,
    CASE        
        WHEN income_level < 30000 THEN 'A: Below 30,000'
        WHEN income_level BETWEEN 30000 AND 49999 THEN 'B: 30,000 - 49,999'
        WHEN income_level BETWEEN 50000 AND 69999 THEN 'C: 50,000 - 69,999'
        WHEN income_level BETWEEN 30000 AND 49999 THEN 'B: 30,000 - 49,999'
        WHEN income_level BETWEEN 50000 AND 89999 THEN 'D: 70,000 - 89,999'
        WHEN income_level BETWEEN 90000 AND 109999 THEN 'E: 90,000 - 109,999'
        WHEN income_level BETWEEN 110000 AND 129999 THEN 'F: 110,000 - 129,999'
        WHEN income_level BETWEEN 130000 AND 149999 THEN 'G: 130,000 - 149,999'
        WHEN income_level BETWEEN 150000 AND 169999 THEN 'H: 150,000 - 169,999'
        WHEN income_level BETWEEN 170000 AND 189999 THEN 'I: 170,000 - 189,999'
        WHEN income_level BETWEEN 190000 AND 249999 THEN 'J: 190,000 - 249,999'
        WHEN income_level BETWEEN 250000 AND 299999 THEN 'K: 250,000 - 299,999'
        ELSE 'L: 300,000 and above'
    END income_category
FROM
    customers
ORDER BY
    income_level DESC;


--How many clients are assigned to each of the income category?

SELECT 
    CASE
        WHEN income_level < 30000 THEN 'A: Below 30,000'
        WHEN income_level BETWEEN 30000 AND 49999 THEN 'B: 30,000 - 49,999'
        WHEN income_level BETWEEN 50000 AND 69999 THEN 'C: 50,000 - 69,999'
        WHEN income_level BETWEEN 70000 AND 89999 THEN 'D: 70,000 - 89,999'
        WHEN income_level BETWEEN 90000 AND 109999 THEN 'E: 90,000 - 109,999'
        WHEN income_level BETWEEN 110000 AND 129999 THEN 'F: 110,000 - 129,999'
        WHEN income_level BETWEEN 130000 AND 149999 THEN 'G: 130,000 - 149,999'
        WHEN income_level BETWEEN 150000 AND 169999 THEN 'H: 150,000 - 169,999'
        WHEN income_level BETWEEN 170000 AND 189999 THEN 'I: 170,000 - 189,999'
        WHEN income_level BETWEEN 190000 AND 249999 THEN 'J: 190,000 - 249,999'
        WHEN income_level BETWEEN 250000 AND 299999 THEN 'K: 250,000 - 299,999'
        ELSE 'L: 300,000 and above'
    END income_category,
    COUNT(*) AS num_customers
FROM
    customers
GROUP BY
    CASE
        WHEN income_level < 30000 THEN 'A: Below 30,000'
        WHEN income_level BETWEEN 30000 AND 49999 THEN 'B: 30,000 - 49,999'
        WHEN income_level BETWEEN 50000 AND 69999 THEN 'C: 50,000 - 69,999'
        WHEN income_level BETWEEN 70000 AND 89999 THEN 'D: 70,000 - 89,999'
        WHEN income_level BETWEEN 90000 AND 109999 THEN 'E: 90,000 - 109,999'
        WHEN income_level BETWEEN 110000 AND 129999 THEN 'F: 110,000 - 129,999'
        WHEN income_level BETWEEN 130000 AND 149999 THEN 'G: 130,000 - 149,999'
        WHEN income_level BETWEEN 150000 AND 169999 THEN 'H: 150,000 - 169,999'
        WHEN income_level BETWEEN 170000 AND 189999 THEN 'I: 170,000 - 189,999'
        WHEN income_level BETWEEN 190000 AND 249999 THEN 'J: 190,000 - 249,999'
        WHEN income_level BETWEEN 250000 AND 299999 THEN 'K: 250,000 - 299,999'
        ELSE 'L: 300,000 and above'
    END
ORDER BY
    income_category;
    
    
--What is the minimum, maximum and average income of each of the income category?
    
SELECT
    DISTINCT CASE        
        WHEN income_level < 30000 THEN 'A: Below 30,000'
        WHEN income_level BETWEEN 30000 AND 49999 THEN 'B: 30,000 - 49,999'
        WHEN income_level BETWEEN 50000 AND 69999 THEN 'C: 50,000 - 69,999'
        WHEN income_level BETWEEN 50000 AND 89999 THEN 'D: 70,000 - 89,999'
        WHEN income_level BETWEEN 90000 AND 109999 THEN 'E: 90,000 - 109,999'
        WHEN income_level BETWEEN 110000 AND 129999 THEN 'F: 110,000 - 129,999'
        WHEN income_level BETWEEN 130000 AND 149999 THEN 'G: 130,000 - 149,999'
        WHEN income_level BETWEEN 150000 AND 169999 THEN 'H: 150,000 - 169,999'
        WHEN income_level BETWEEN 170000 AND 189999 THEN 'I: 170,000 - 189,999'
        WHEN income_level BETWEEN 190000 AND 249999 THEN 'J: 190,000 - 249,999'
        WHEN income_level BETWEEN 250000 AND 299999 THEN 'K: 250,000 - 299,999'
        ELSE 'L: 300,000 and above'
    END  AS income_category,
     COUNT (  income_level) OVER (
    PARTITION BY
    CASE        
        WHEN income_level < 30000 THEN 'A: Below 30,000'
        WHEN income_level BETWEEN 30000 AND 49999 THEN 'B: 30,000 - 49,999'
        WHEN income_level BETWEEN 50000 AND 69999 THEN 'C: 50,000 - 69,999'
        WHEN income_level BETWEEN 50000 AND 89999 THEN 'D: 70,000 - 89,999'
        WHEN income_level BETWEEN 90000 AND 109999 THEN 'E: 90,000 - 109,999'
        WHEN income_level BETWEEN 110000 AND 129999 THEN 'F: 110,000 - 129,999'
        WHEN income_level BETWEEN 130000 AND 149999 THEN 'G: 130,000 - 149,999'
        WHEN income_level BETWEEN 150000 AND 169999 THEN 'H: 150,000 - 169,999'
        WHEN income_level BETWEEN 170000 AND 189999 THEN 'I: 170,000 - 189,999'
        WHEN income_level BETWEEN 190000 AND 249999 THEN 'J: 190,000 - 249,999'
        WHEN income_level BETWEEN 250000 AND 299999 THEN 'K: 250,000 - 299,999'
        ELSE 'L: 300,000 and above'
    END) as num_customers,
    MIN(income_level) OVER (
    PARTITION BY 
        CASE
        WHEN income_level < 30000 THEN 'A: Below 30,000'
        WHEN income_level BETWEEN 30000 AND 49999 THEN 'B: 30,000 - 49,999'
        WHEN income_level BETWEEN 50000 AND 69999 THEN 'C: 50,000 - 69,999'
        WHEN income_level BETWEEN 70000 AND 89999 THEN 'D: 70,000 - 89,999'
        WHEN income_level BETWEEN 90000 AND 109999 THEN 'E: 90,000 - 109,999'
        WHEN income_level BETWEEN 110000 AND 129999 THEN 'F: 110,000 - 129,999'
        WHEN income_level BETWEEN 130000 AND 149999 THEN 'G: 130,000 - 149,999'
        WHEN income_level BETWEEN 150000 AND 169999 THEN 'H: 150,000 - 169,999'
        WHEN income_level BETWEEN 170000 AND 189999 THEN 'I: 170,000 - 189,999'
        WHEN income_level BETWEEN 190000 AND 249999 THEN 'J: 190,000 - 249,999'
        WHEN income_level BETWEEN 250000 AND 299999 THEN 'K: 250,000 - 299,999'
        ELSE 'L: 300,000 and above'
    END
    ) AS min_category_salary,
    MAX(income_level) OVER (
    PARTITION BY 
        CASE
        WHEN income_level < 30000 THEN 'A: Below 30,000'
        WHEN income_level BETWEEN 30000 AND 49999 THEN 'B: 30,000 - 49,999'
        WHEN income_level BETWEEN 50000 AND 69999 THEN 'C: 50,000 - 69,999'
        WHEN income_level BETWEEN 70000 AND 89999 THEN 'D: 70,000 - 89,999'
        WHEN income_level BETWEEN 90000 AND 109999 THEN 'E: 90,000 - 109,999'
        WHEN income_level BETWEEN 110000 AND 129999 THEN 'F: 110,000 - 129,999'
        WHEN income_level BETWEEN 130000 AND 149999 THEN 'G: 130,000 - 149,999'
        WHEN income_level BETWEEN 150000 AND 169999 THEN 'H: 150,000 - 169,999'
        WHEN income_level BETWEEN 170000 AND 189999 THEN 'I: 170,000 - 189,999'
        WHEN income_level BETWEEN 190000 AND 249999 THEN 'J: 190,000 - 249,999'
        WHEN income_level BETWEEN 250000 AND 299999 THEN 'K: 250,000 - 299,999'
        ELSE 'L: 300,000 and above'
    END
    ) AS max_category_salary,
    ROUND (AVG(income_level) OVER (
    PARTITION BY 
        CASE
        WHEN income_level < 30000 THEN 'A: Below 30,000'
        WHEN income_level BETWEEN 30000 AND 49999 THEN 'B: 30,000 - 49,999'
        WHEN income_level BETWEEN 50000 AND 69999 THEN 'C: 50,000 - 69,999'
        WHEN income_level BETWEEN 70000 AND 89999 THEN 'D: 70,000 - 89,999'
        WHEN income_level BETWEEN 90000 AND 109999 THEN 'E: 90,000 - 109,999'
        WHEN income_level BETWEEN 110000 AND 129999 THEN 'F: 110,000 - 129,999'
        WHEN income_level BETWEEN 130000 AND 149999 THEN 'G: 130,000 - 149,999'
        WHEN income_level BETWEEN 150000 AND 169999 THEN 'H: 150,000 - 169,999'
        WHEN income_level BETWEEN 170000 AND 189999 THEN 'I: 170,000 - 189,999'
        WHEN income_level BETWEEN 190000 AND 249999 THEN 'J: 190,000 - 249,999'
        WHEN income_level BETWEEN 250000 AND 299999 THEN 'K: 250,000 - 299,999'
        ELSE 'L: 300,000 and above'
    END
    )) AS avg_category_salary
FROM
    customers;


--Show a client and all of the client's orders, whose purchase frequency was the highest?
--Assign to each record a piece of information about a time period (days) between one order and the other subsequent to it.

SELECT
    c.first_name ||' ' ||  c.last_name,
    o.customer_id AS best_customer_id,
    o.order_id,
    o.order_total AS total_order_best_client,
    o.order_date AS order_date_best_client,
    COALESCE(TO_CHAR(LAG(order_date) OVER (ORDER BY order_date), 'DD'),'0') AS days_order_diff
FROM
    orders o
    join customers c on (o.customer_id=c.customer_id)
WHERE
    o.customer_id IN
        (SELECT
            customer_id
         FROM
            orders
         GROUP BY
            customer_id
         ORDER BY
            COUNT(*) DESC
         FETCH FIRST 1 ROW ONLY
        )
ORDER BY
    o.order_date;
--------------------------------------

--Promotions analysis.

--Show a time period for each of promotions.

SELECT
    o.promotion_id,
    p.promo_name,
    TO_CHAR(MIN(o.order_date),'YY/MM/DD')||' - '||TO_CHAR(MAX(o.order_date),'YY/MM/DD') AS OKRES_PROMOCJI
FROM
    orders o
    JOIN promotions p on o.promotion_id=p.promo_id
WHERE
    o.promotion_id IS NOT NULL
GROUP BY 
   o.promotion_id,p.promo_name;


--Show total sales for every day of two of promotions.

SELECT
    p.promo_name,
    TO_CHAR(TRUNC(o.order_date), 'YY/MM/DD') AS DATA,
    SUM(o.order_total) AS TOTAL_DAY_SALE
FROM
    orders o
    JOIN promotions p on o.promotion_id=p.promo_id
WHERE
    o.promotion_id IS NOT NULL
GROUP BY
    p.promo_name, TRUNC(o.order_date)
ORDER BY 
    p.promo_name, TO_DATE(TO_CHAR(TRUNC(o.order_date), 'YY/MM/DD'), 'YY/MM/DD');
    
    
--Sum the total sale profit of each of promotions and the total of two of them together. 

SELECT
    COALESCE(p.promo_name,'all promotions') AS promo_name,
    SUM(o.order_total) AS total_sale_profit
FROM
    orders o
    JOIN promotions p on o.promotion_id=p.promo_id
WHERE
    o.promotion_id IS NOT NULL
GROUP BY ROLLUP
    (p.promo_name)
ORDER BY 
    SUM(o.order_total) DESC
FETCH FIRST 3 ROWS ONLY;


--Show a client, who reacted as the first to new promotions, when it started.

SELECT
    pr.promo_name,
    p.min_order_date,
    o.customer_id,
    c.first_name || ' ' || c.last_name AS customer_full_name
FROM 
    (
        SELECT
            promotion_id,
            MIN(order_date) AS min_order_date
        FROM
            orders
        WHERE
            promotion_id IS NOT NULL
        GROUP BY
            promotion_id
    ) p
    JOIN orders o ON (o.promotion_id = p.promotion_id) AND (o.order_date = p.min_order_date)
    JOIN customers c ON (c.customer_id = o.customer_id)
    JOIN promotions pr ON (o.promotion_id=pr.promo_id)
ORDER BY
    p.min_order_date;    
    
    
--Show an impact, that promotions had on the daily profit? What is the percentage difference
--between the average daily profit without any promotion and between the average daily profit with promotions?

SELECT
    (SELECT
        MAX(order_date) - MIN(order_date)
    FROM
        orders
    WHERE
        promotion_id IS NULL) - (MAX(order_date) - MIN(order_date)) AS days_without_promo,
        
    SUM(order_total) AS SUM_NO_PROMO,
    
    ROUND (SUM(order_total) / ((SELECT
        MAX(order_date) - MIN(order_date)
    FROM
        orders
    WHERE
        promotion_id IS NULL) - (MAX(order_date) - MIN(order_date))),2) AS AVG_ORDER_FOR_1DAY 
FROM
    orders
WHERE
    promotion_id = 2
GROUP BY
    promotion_id;

--The average daily profit is 1338,63.


SELECT
    p.promo_name,
    SUM(o.order_total) AS SUM_TOTAL,
    MAX(o.order_date)-MIN(o.order_date) AS LICZBA_DNI_PROMOCJI,
    ROUND( SUM(o.order_total) / (MAX(o.order_date)-MIN(o.order_date)),2) AS AVG_ORDER_FOR_1DAY
FROM
    orders o
    JOIN promotions p on o.promotion_id=p.promo_id
WHERE
    p.promo_name IS NOT NULL
GROUP BY
    p.promo_name
ORDER BY 
    SUM(o.order_total) DESC;

--The average daily profit of the mid season sale is 4575,36.
--The average daily profit of the black friday is 4917,90.
--The average daily profit is 1338,63.

--A temporary table to calculate a percentage difference between the average daily profit with and without promotions.

CREATE PRIVATE TEMPORARY TABLE ora$ptt_avg_promo_diff
    (
        avg_promo1 number(10,2),
        avg_promo2 number(10,2),
        avg_no_promo number(10,2)
    );

INSERT INTO ora$ptt_avg_promo_diff VALUES (
    4530.55, 4897.75, 1331.59
    );    

    
SELECT
    (avg_promo1+avg_promo2)/2 AS avg_promos,
    ROUND((((avg_promo1+avg_promo2)/2) - avg_no_promo) / avg_no_promo * 100) AS percent_diff
FROM
    ora$ptt_avg_promo_diff;


--AVG(PROMO1,PROMO2) = 4714,15
--4530,55 1 PROMO
--4897,75 2 PROMO
--1331,59 NO PROMO
--% Increase = ((New Value - Old Value) / Old Value) x 100%
--% Increase = ((4714.15 - 1331.59) / 1331.59) x 100%
--% Increase = 254%

DROP TABLE ora$ptt_avg_promo_diff;
-----------------------------------------------

--Analysis of the warranty risk.

--Each of the product has its warranty period. Assign accordingly to the model listed below,
--the warranty amount for every category description of applications.
--• Game - 5.5%
--• Book - 8%, Shopping - 6%
--• News - 10%
--• else - 4%
--Calculate the sum of reserves for products' waranty that the company needs to store for the day 2023-01-01.
            
            
SELECT ROUND(SUM(product_warranty_amount),2) AS total_product_warranty_amount
FROM
    (            
    SELECT
            i.product_name,
            o.order_id,
            i.product_id,
            (EXTRACT(YEAR FROM i.warranty_period))*12 + EXTRACT(month FROM i.warranty_period) AS warranty_months,
            TRUNC(MONTHS_BETWEEN(TO_DATE('2023-01-01', 'YYYY-MM-DD'), TRUNC(r.order_date))) AS ownership_months_period,
            CASE 
                WHEN substr(c.category_description,1,2) = 'Game' THEN 0.055 * o.unit_price * o.quantity
                WHEN substr(c.category_description,1,6) = 'News' THEN 0.1 * o.unit_price * o.quantity
                WHEN substr(c.category_description,1,11) = 'Book' THEN 0.08 * o.unit_price * o.quantity
                WHEN substr(c.category_description,1,14) = 'Shopping' THEN 0.06 * o.unit_price * o.quantity
                ELSE 0.04 * o.unit_price * o.quantity
                END AS product_warranty_amount
        FROM
            product_information i
            JOIN order_items o ON (o.product_id = i.product_id)
            JOIN orders r ON (o.order_id=r.order_id)
            JOIN product_information p ON (i.product_id=p.product_id)
            JOIN category c ON (i.category_id=c.category_id)
        WHERE
            (EXTRACT(YEAR FROM i.warranty_period))*12 + EXTRACT(month FROM i.warranty_period) > (TRUNC(MONTHS_BETWEEN(TO_DATE('2023-01-01', 'YYYY-MM-DD'), TRUNC(r.order_date))))
        GROUP BY 
            ROLLUP(o.order_id, i.product_id, i.product_name,
            (EXTRACT(YEAR FROM i.warranty_period))*12 + EXTRACT(month FROM i.warranty_period), TRUNC(MONTHS_BETWEEN(TO_DATE('2023-01-01', 'YYYY-MM-DD'), TRUNC(r.order_date))), 
            CASE 
                WHEN substr(c.category_description,1,2) = 'Game' THEN 0.055 * o.unit_price * o.quantity
                WHEN substr(c.category_description,1,6) = 'News' THEN 0.1 * o.unit_price * o.quantity
                WHEN substr(c.category_description,1,11) = 'Book' THEN 0.08 * o.unit_price * o.quantity
                WHEN substr(c.category_description,1,14) = 'Shopping' THEN 0.06 * o.unit_price * o.quantity
                ELSE 0.04 * o.unit_price * o.quantity
                END
            )
        HAVING 
            (CASE 
            WHEN substr(c.category_description,1,2) = 'Game' THEN 0.055 * o.unit_price * o.quantity
            WHEN substr(c.category_description,1,6) = 'News' THEN 0.1 * o.unit_price * o.quantity
            WHEN substr(c.category_description,1,11) = 'Book' THEN 0.08 * o.unit_price * o.quantity
            WHEN substr(c.category_description,1,14) = 'Shopping' THEN 0.06 * o.unit_price * o.quantity
            ELSE 0.04 * o.unit_price * o.quantity
            END) IS NOT NULL
        ORDER BY 
            product_warranty_amount DESC);
            
            
