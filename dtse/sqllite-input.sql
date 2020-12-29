-- tables preparation which should be done before interview
-- go to https://sqliteonline.com/ and past following commands

CREATE TABLE customers (
    customer_id int,
    last_name varchar(50),
    first_name varchar(50),
	referred_by_id varchar(50));
    
INSERT INTO customers (customer_id,last_name,first_name, referred_by_id)
	VALUES (1,'John','White',''),
		(2,'Sarah','Green',''),
        (3,'George','Black',''),
		(4,'Mark','Koon',''),
		(5,'Tom','Gone',''),
        (6,'Ezra','Beck',''),
		(7,'Jan','Wick',2),
		(8,'Petr','Lame',''),
        (9,'Lucy','Can',''),
		(10,'Karl','Opel',1),
		(11,'Ron','Varon',10),
        (12,'Harry','Bond',''),
		(13,'Paul','Kong',''),
		(14,'Shaun','King',3),
        (15,'Elisabeth','Yellow','');
        
CREATE TABLE contacts (
    customer_id int,
    address varchar(255),
    city varchar(255),
  	phone_number varchar(20),
  	email VARCHAR(255));
    
    
INSERT INTO contacts (customer_id,address,city,phone_number,email)
	VALUES (1,'3525  Fort Street','COLUMBUS','2532326578','JW@email.com'),
		(2,'3924  Cooks Mine Road','Albuquerque','5057657670','SarahG@email.com'),
        (3,'925  College Street','Atlanta','4043278560','Georgie@email.com');

CREATE TABLE orders (
    customer_id int,
    order_id INT,
    item varchar(50),
  	order_value DECIMAL(12,2),
  	order_currency varchar(3),
  	order_date TIMESTAMP);
 
INSERT INTO orders (customer_id,order_id,item,order_value,order_currency,order_date)
	VALUES(1,1,'HDMI cable',3.25,'EUR','2020-01-21 14:50:04'),
    	(2,2,'Keyboard','15.99','EUR','2020-01-21 17:50:04'),
        (3,3,'Charger','9.99','EUR','2020-01-22 18:00:07'),
        (3,3,'Charger','9.99','EUR','2020-01-22 18:00:07'),
        (3,4,'Phone','225.89','EUR','2020-01-22 19:10:56'),
        (2,5,'Camera','199.99','EUR','2020-01-23 07:50:44'),
        (1,6,'Speakers','75.50','EUR','2020-01-23 08:40:00'),
        (1,6,'Speakers','75.50','EUR','2020-01-23 08:40:00'),
        (2,7,'Mouse','22.19','EUR','2020-01-23 09:20:59');    
    
--DROP TABLE customers;
--DROP TABLE contacts;
--DROP TABLE orders;

-- Note before start: 
-- The table was defined with first name and last name vice versa, thus I corrected it in the query

--TASK 1--
--Write query which will match contacts and orders to our customers
SELECT *
from customers cu 
inner join contacts co using (customer_id)
inner join orders o using (customer_id);

--TASK 2--
-- There is  suspision that some orders were wrongly inserted more times. Check if there are any duplicated orders. If so, return duplicates with the following details:
-- first name, last name, email, order id and item
select 
	last_name as first_name, 
	first_name as last_name, 
    email, 
    order_id, 
    item
from customers cu 
inner join contacts co using (customer_id)
inner join orders o using (customer_id)
group by 1,2,3,4,5
having count(*)>1;

--TASK 3-	
-- As you found out, there are some duplicated order which are incorrect, adjust query from previous task so shows following:
-- Shows first name, last name, email, order id and item
-- Does not show duplicates.
-- Order result by customer last name
SELECT 
	DISTINCT last_name as first_name,
    first_name as last_name, 
    email, 
    order_id, 
    item
from customers cu 
inner join contacts co using (customer_id)
inner join orders o using (customer_id)
order by last_name;

--TASK 4--
--Our company distinguishes orders to sizes by value like so:
--order with value less or equal to 25 euro is marked as SMALL
--order with value more than 25 euro but less or equal to 100 euro is marked as MEDIUM
--order with value more than 100 euro is marked as BIG
--Write query which shows only three columns: full_name (first and last name divided by space), order_id and order_size
--Make sure the duplicated values are not shown
select 
	distinct last_name || " " || first_name as full_name,
	order_id, 
    case --- order_currency in eur
    	when order_value <= 25 then 'SMALL'
    	when order_value > 25 and order_value <= 100 then 'MEDIUM'
    	when order_value > 100 then 'BIG'
    end as order_size
from customers cu 
inner join contacts co using (customer_id)
inner join orders o using (customer_id); 

--TASK 5--
-- Filter out all items from orders table which containt in their name 'ea' or start with 'Key'
select *
from orders 
where item not like '%ea%' and item not like 'Key%'; --- not very efficient with larger data 

--TASK 6--
-- Please find out if some customer was referred by already existing customer
-- Return results in following format "Customer Last name Customer First name" "Last name First name of customer who recomended the new customer"
select 
	c1.first_name || " " || c1.last_name as customer_full_name,
    c2.first_name || " " || c2.last_name as referred_by_full_name
from customers c1
inner join customers c2 on c1.referred_by_id = c2.customer_id;
