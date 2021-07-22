--In our database, how many customers do we have?-----------------------------------------------------------------------------------------------------------------------------
SELECT COUNT(DISTINCT(CONCAT(customer_fname, ' ', customer_lname))) 
FROM customer

--Who is our most profitable customer and how much did he spend?--------------------------------------------------------------------------------------------------------------
--Join order_item, orders, customer tables
SELECT customer_fname, customer_lname, SUM(order_total) --STEP 3) To find the total amount spent by a customer
FROM
(SELECT sq1.order_id,order_total, customer_id --STEP 2) Subquery 2 to find which customer made the order
FROM
(SELECT order_id, SUM(order_item_total) AS order_total --STEP 1) Subquery 1 to find the total price of an order
FROM order_item
GROUP BY order_id) AS sq1 
LEFT JOIN orders ON orders.order_id=sq1.order_id) AS sq2 
LEFT JOIN customer ON customer.customer_id=sq2.customer_id
GROUP BY customer_fname, customer_lname
ORDER BY SUM(order_total) DESC
LIMIT 1

--Which customer ordered the most and how many orders did he made?------------------------------------------------------------------------------------------------------------
SELECT customer_lname, customer_fname, COUNT(order_id) 
FROM orders
LEFT JOIN customer ON orders.customer_id = customer.customer_id
GROUP BY customer_lname, customer_fname
ORDER BY COUNT(order_id) DESC
LIMIT 1

--What was the total amount spent by the customer who ordered the most?-------------------------------------------------------------------------------------------------------
--Step 1. Find the order_id of the customer who ordered the most
SELECT customer_fname, customer_lname, orders.order_id 
FROM orders
LEFT JOIN customer ON customer.customer_id=orders.customer_id
WHERE customer_fname='Kaleen' AND customer_lname='Bryan'
--Step 2. Sum up all those orders to find the total amount spent
SELECT SUM(individual_order_total)
FROM
(SELECT order_id, SUM(order_item_total) as individual_order_total
FROM order_item
WHERE order_id IN (10,11,12,23)
GROUP BY order_id) as sql1 

--Which item was ordered the most (biggest quantity sold)?--------------------------------------------------------------------------------------------------------------------
SELECT item_name, SUM(order_item_quantity)
FROM order_item
LEFT JOIN item ON item.item_id=order_item.item_id
GROUP BY item_name
ORDER BY SUM(order_item_quantity) DESC
LIMIT 1
 
--Which item generated us the most revenue?-----------------------------------------------------------------------------------------------------------------------------------
SELECT item_name, SUM(order_item_total) 
FROM order_item
LEFT JOIN item ON item.item_id=order_item.item_id
GROUP BY item_name
Order by SUM(order_item_total) DESC
LIMIT 1 
 
--Which menu had the most orders made?----------------------------------------------------------------------------------------------------------------------------------------
SELECT menu_type, SUM(order_item_quantity) AS Total_quantity_per_menu_type 
FROM order_item
LEFT JOIN item ON item.item_id=order_item.item_id
LEFT JOIN Menu ON item.menu_id=menu.menu_id
GROUP BY menu_type
ORDER BY Total_quantity_per_menu_type DESC
LIMIT 1 
 
--Which menu generated us the most revenue?-----------------------------------------------------------------------------------------------------------------------------------
SELECT menu_type, SUM(order_item_total) AS Total_sum_per_menu_type 
FROM order_item
LEFT JOIN item ON item.item_id=order_item.item_id
LEFT JOIN Menu ON item.menu_id=menu.menu_id
GROUP BY menu_type
ORDER BY Total_sum_per_menu_type DESC
LIMIT 1 
