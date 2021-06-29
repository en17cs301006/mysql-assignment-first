SELECT * FROM salespeople;
/*----------------------------------------------------------------------------------------------------
2) List all customers with a rating 100.
  WHERE is use for the condition in the query so that data can be retrieve from 
  table customer on the validetion of rating.*/

   select * from customer where rating=100;
/*----------------------------------------------------------------------------------------------------
3) Find the largest order taken by each salesperson on each date.
   During query i was not getting my point , GROUP BY helps us to eliminate the duplicate values from 
   column and give us unique values.  */  

   select MAX(ATM) AS numbers,SNUM,ODATE from orders GROUP BY SNUM;

/*----------------------------------------------------------------------------------------------------
4) Arrange the Order table by descending customer number.
  SSQL provide us the facility of natural order on the highly prior column but If we want to change the 
  order . DESC provides us decending order. Here order is  orderd by onum.*/

    select * from orders order by ONUM DESC;

/*----------------------------------------------------------------------------------------------------
5) Find which salespeople currently have orders in the order table.
  Here i have to connect two table for my result set. so I used  join for this purpose . Join provides
  that data can be mapped from both the table with a condition which is done by common column. */  

   select salespeople.SNUM from salespeople right join orders on salespeople.SNUM =orders.SNUM;

   select SNUM  from orders GROUP BY SNUM;
/*----------------------------------------------------------------------------------------------------
6) List names of all customers matched with the salespeople serving them
  when i was dealing with this query .there is a problem for the result set because data retrieved from 
  both tables.*/

   select customer.CNUM,customer.CNAME,customer.CITY,customer.RATING,customer.SNUM from customer inner
 join salespeople on salespeople.SNUM = customer.SNUM;

/*-----------------------------------------------------------------------------------------------------
7) Find the names and numbers of all salespeople who have more than one customer.
   here i got some specific like query , this is very tricky query becaause here i have got to get data
   from customer but i was getting from salespeople that provided wrong result set. Most of the time we 
have to think that i can be tricky. */

 select count(*) AS COUNT ,c.SNUM,s.SNAME from customer c,salespeople s WHERE c.SNUM=s.SNUM GROUP BY c.SNUM ;
/*-----------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
8) Count the orders of each of the salespeople and output the results in descending order
   Here i use the aggregation function of SQL for getting the count of any perticular requirment . I did query 
whit three approches fro the same result . Join is more essential all of them. In second i use alias for denormalizatin 
of thables. In 3rd i used JOINS .*/   

 select COUNT(*) AS count ,SNUM from orders GROUP BY SNUM DESC ;

 select count(*) AS count , o.SNUM FROM orders o,customer c,salespeople s where o.SNUM=c.SNUM AND c.SNUM=s.SNUM GROUP BY SNUM DESC;

 select count(*) AS count , orders.SNUM FROM orders JOIN customer ON orders.SNUM=customer.SNUM JOIN salespeople ON customer.SNUM=salespeople.SNUM   GROUP BY SNUM DESC;
/*-----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
10) Match salespeople to customers according to what city they live in.
   Here i got new thing that is 'AS' which is change the column name during query exicution and set the name as required.
   Here i used three tables and i learnt that how to connect more then two table  and how to denormalization is performed.*/

   SELECT customer.CNAME AS customers,salespeople.SNAME AS Salespeople, salespeople.CITY FROM customer JOIN salespeople ON customer.CITY=salespeople.CITY;

/*------------------------------------------------------------------------------------------------------------
11) Find all the customers in SanJose who have a rating above 200.
    Here i explained the AND operator which is perform and operation between  two conditions.*/
    select * from customer where RATING>=200 AND CITY='SanJose';
/*------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
12) List the names and commissions of all salespeople in London.
    Data is retrieved from salespeople where city is London..*/
   select SNAME , COMM from salespeople where CITY='London';
/*------------------------------------------------------------------------------------------------------
13) List all the orders of Salesperson Motika from the orders table
    here I retrieved data from both the tables by using join. Here join works by defoult like inner join .
    data got on the basic of 'Motika' salespeople.*/

SELECT * FROM orders JOIN salespeople ON salespeople.SNAME='Motika';

SELECT * FROM customer JOIN salespeople ON salespeople.SNUM=customer.SNUM JOIN orders ON customer.CNUM=orders.CNUM AND SNAME='Motika';
/*------------------------------------------------------------------------------------------------------
14) Find all customers who booked orders on October 3.
    
    select * from orders where ODATE='1990-03-10';
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
15) Give the sums of the amounts from the Orders table, grouped by date, eliminating all those dates where the SUM was not at least 2000 above
the maximum Amount.
   Here i got the maximum amount from order table at any perticuler date which has higher amount then others.but i got all result 
   but i had to take more then 2000 and 2000 . I tried lots of operator for this which provided me only boolean value not actual value.
   
   so how can i done this task? */
select SUM(ATM) AS SUM ,ODATE FROM orders GROUP BY ODATE;

/*---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
16) Select all orders that had amounts that were greater than at least one of the orders from October 6.
    here i retrieved data whre date is 6 Oct in the order table.*/

select ONUM, MAX(ATM) AS Amount,ODATE,CNUM,SNUM FROM orders WHERE  ODATE='1990-06-10';

/*----------------------------------------------------------------------------------------------------------
18) Find all customers whose cnum is 1000 above the snum of Serres.
   Here i came to the new concept that is subquery . Subquery is nested query .we can write more then one query 
   in a single a query . I got that this concept works where we have to teke a single value from any specific
   table. Subquery also work like joins .here i retrieved data from customer where salespeople is Serres and i add 1000 
   to sarres id because customer id is in term of 2000. */

 select * from customer inner join salespeople where customer.CNUM=salespeople.SNUM+1000;

 select * from customer WHERE CNUM>(select SNUM from salespeople WHERE SNAME='Serres')+1000;

/*-------------------------------------------------------------------------------------------------------
20) Find the largest order taken by each salesperson on each date, eliminating those Maximum orders, which are less than 3000.
     Here i got the maximum amount from order table at any perticuler date which has higher amount then others. I filtered the value on
the be half of  eliminating those Maximum orders, which are less than 3000.*/

select SNUM, MAX(ATM) AS amount, ODATE  from orders Where ATM>3000 GROUP BY SNUM;
/*-------------------------------------------------------------------------------------------------------*/
 126  21to40Question.sql 
@@ -0,0 +1,126 @@
/*-------------------------------------------------------------------------------------------------------
21) List all the largest orders for October 3, for each salesperson.*/
 select * from salespeople where SNUM IN (select SNUM from customer GROUP BY SNUM HAVING COUNT(*));

/*-------------------------------------------------------------------------------------------------------
22) Find all customers located in cities where Serres has customers.
    here i query with subquery in this task where i had to take city from salespeople where salespeople anme is serres .*/ 
select * from customer where CITY=(select CITY FROM salespeople where salespeople.SNAME='Serres');
/*-------------------------------------------------------------------------------------------------------
23) Select all customers with a rating above 200.
    select * from customer where RATING>200;
/*-------------------------------------------------------------------------------------------------------
24) Count the number of salespeople currently having orders in the orders table.
    here i count salespeople who have order in order table . Join is used for denirmalization.
    */   
    select COUNT(*) from salespeople JOIN orders where orders.SNUM=salespeople.SNUM;

    select salespeople.SNUM from salespeople JOIN orders where orders.SNUM=salespeople.SNUM GROUP BY orders.snum ;

/*-------------------------------------------------------------------------------------------------------------------
26) Find salespeople who have multiple customers.
    here i applied both approches join and subquery . I explored this and got that join is more essential then subquery 
    because join works like single query and subquery according to inner queries.*/

    select salespeople.SNUM from customer,salespeople where customer.SNUM=salespeople.SNUM GROUP BY customer.SNUM  HAVING COUNT(*)>1 ;
    select * from salespeople where SNUM IN (select SNUM from customer GROUP BY SNUM HAVING COUNT(*)>1); 
/*--------------------------------------------------------------------------------------------------------------------
27) Find salespeople with customers located in their own cities. 
    Here I used inner join fro the task . I retrieved data from customer and salespeople where city of a salespeople and his customer is same .
    fror this i provide two velidatin city and thier id. */ 

   SELECT salespeople.SNAME , customer.CNAME , salespeople.CITY from customer 
   INNER JOIN salespeople WHERE salespeople.CITY = customer.CITY AND  salespeople.SNUM = customer.SNUM;
/*--------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
28) Find all salespeople whose name starts with ‘P’ and fourth character is ‘I'.
    To do this task i refere first LIKE and  REGEXP operator which are used to search in a perticuler string match with the single key word 
     and a specific idex. */
     SELECT * from salespeople WHERE SNAME LIKE 'P__L';
/*----------------------------------------------------------------------------------------------------------------------------------
29) Write a query that uses a subquery to obtain all orders for the customer named ‘Cisneros’. Assume you do not know his customer number.
   Here i got the customer number from customer where customer name is Cisneros using subquery and use this value to get orders from order table.*/

   SELECT * FROM orders where CNUM = (select CNUM from customer where CNAME='Cisneros' ); 
/*-----------------------------------------------------------------------------------------------------------------------------------
30) Find the largest orders for Serres and Rifkin.
    i used aggregation function for max amount from order table . LIKE is used to match same things from the specific columns.*/

    SELECT salespeople.SNAME, MAX(ATM) from orders INNER JOIN salespeople where salespeople.SNUM=orders.SNUM AND  SNAME LIKE  'Serres' OR 'Rifkin' GROUP BY salespeople.SNUM;
/*------------------------------------------------------------------------------------------------------------------------------------
31) Sort the salespeople table in the following order: snum, sname, commission, city.
*/

 ALTER TABLE salespeople MODIFY COMM int(20)  ALTER CITY ;
 select SNUM ,SNAME , COMM ,CITY FROM salespeople;
/*---------------------------------------------------------------------------------------------------------------------------------------
32) Select all customers whose names fall in between ‘A’ and ‘G’ alphabetical range.
select * from customer where CNAME LIKE 'A%' OR 'G%';
/*-----------------------------------------------------------------------------------------------------------------------------------------
33) Select all the possible combinations of customers you can assign.
here i use the new concept of alias of customer so that  all the possible combinations of customers can be assign.
*/
select a.CNAME,b.CNAME from customer a, customer b where a.SNUM= b.SNUM;
/*------------------------------------------------------------------------------------------------------------------------------------
34) Select all orders that are greater than the average for October 4. 
    here i got my result set with aggregation function and subquery . i got avarage by aggregation function .*/
    select * from orders where ATM>(select avg(ATM) from orders where ODATE='1990-04-10');
/*------------------------------------------------------------------------------------------------------------------------------------
35) Write a select command using correlated subquery that selects the names and numbers of all customers with ratings equal to the maximum
for their city.
 here i got my result set with aggregation function and subquery . i got avarage by aggregation function .
*/
select CNUM, CNAME,RATING from customer where RATING>=(select avg(RATING) from customer);
/*-------------------------------------------------------------------------------------------------------------------------------------
36) Write a query that totals the orders for each day and places the results in descending order.
    here i write a query for getting the total of atm date wise and order them into date wise.*/

    select SUM(ATM) AS TOTAL , ODATE from orders GROUP BY ODATE  DESC;
/*---------------------------------------------------------------------------------------------------------------------------------------
37) Write a select command that produces the rating followed by the name of each customer in SanJose.
  */ 
   select * from customer where CITY='Sanjose';
/*----------------------------------------------------------------------------------------------------------------------------------------
38) Find all orders with amounts smaller than any amount for a customer in SanJose.
---------------------------------------------------------------------------------------------------------------------------------------------
39) Find all orders with above average amounts for their customers.
   HERE i retrieved data from the orders table where amount is above then the customer of sanjose.*/
select * from orders JOIN customer where customer.CNUM=orders.CNUM AND ATM>(select AVG(ATM) from orders);
/*------------------------------------------------------------------------------------------------------------------------------------------
40) Write a query that selects the highest rating in each city.
   select CNAME ,CITY,MAX(RATING) from customer GROUP BY CITY;
-------------------------------------------------------------------------------------------------------------------------------------------
 79  41TO 60Question.sql 
@@ -0,0 +1,79 @@
/*41) Write a query that calculates the amount of the salesperson’s commission on each order by a customer with a rating above 100.00.*/

/*===================================================================================================================================
42)Count the customers with ratings above SanJose’s average.*/

select count(*) from customer where RATING > (select AVG(RATING) from customer WHERE CITY = 'Sanjose');
/*======================================================================================================================================
43) Find all salespeople that are located in either Barcelona or London.*/
select * from salespeople where CITY = 'Barcelona' OR 'London';
/*======================================================================================================================================
44) Find all salespeople with only one customer.*/
select a.SNUM ,a.SNAME from salespeople a, (select SNUM , count(*) as countt from customer GROUP BY SNUM HAVING countt=1) b where a.SNUM=b.SNUM;
/*======================================================================================================================================
45) Write a query that joins the Customer table to itself to find all pairs or customers served by a single salesperson.
=======================================================================================================================================*/
/*46) Write a query that will give you all orders for more than $1000.00*/
 select * from orders where ATM>1000;
/*=======================================================================================================================================
47) Write a query that lists each order number followed by the name of the customer who made that order.*/
 select customer.CNUM, orders.ONUM from orders INNER JOIN customer where customer.CNUM=orders.CNUM;
/*=======================================================================================================================================
48) Write a query that selects all the customers whose ratings are equal to or greater than ANY(in the SQL sense) of ‘Serres’.*/
SELECT * FROM customer WHERE RATING >=( select MAX(RATING) from customer JOIN salespeople where customer.SNUM = 
salespeople.SNUM AND salespeople.SNAME ='Serres'GROUP BY customer.SNUM);
/*=======================================================================================================================================
49) Write two queries that will produce all orders taken on October 3 or October 4.*/
select * from orders where ODATE = '1990-03-10' OR ODATE= '1990-04-10';
/*=======================================================================================================================================
50) Find only those customers whose ratings are higher than every customer in Rome.*/
select * from customer where RATING>(select MAX(RATING) from customer where CITY='Rome');
/*=======================================================================================================================================
51) Write a query on the Customers table whose output will exclude all customers with a rating<= 100.00, unless they are located in Rome.*/
select * from customer Where (RATING<=100 AND CITY='Rome') OR RATING>100;
/*=======================================================================================================================================
52) Find all rows from the customer’s table for which the salesperson number is 1001.*/
 Select * from customer Where SNUM=1001;
/*=======================================================================================================================================
53) Find the total amount in orders for each salesperson where their total of amounts are greater than the amount of the largest order in the table.*/
select * from (select SUM(ATM) AS ATM from orders GROUP BY SNUM) a where a.ATM>(select MAX(ATM) from orders );
/*=======================================================================================================================================
54) Write a query that selects all orders save those with zeroes or NULL in the amount file.*/
select * from orders where ATM LIKE NULL OR ATM=0.00;
select * from orders ;
/*=======================================================================================================================================
55) Produce all combinations of salespeople and customer names such that the former precedes the latter alphabetically, and the latter has a
rating of less than 200.*/
select salespeople.SNAME , customer.CNAME,customer.RATING from customer JOIN salespeople where salespeople.SNUM=customer.SNUM AND RATING < 200 ORDER BY salespeople.SNAME ;
/*=======================================================================================================================================
56) Find all salespeople name and commission.*/
select SNAME , COMM from salespeople;

/*========================================================================================================================================
57) Write a query that produces the names and cities of all customers with the same rating as Hoffman. Write the query using Hoffman’s cnum
rather than his rating, so that it would still be usable if his rating is changed.*/

SELECT CNAME , CITY FROM customer where RATING=(select RATING from customer where CNAME='Haffman');
/*============================================================================================================================================
58) Find all salespeople for whom there are customers that follow them in alphabetical order.*/
select salespeople.SNAME , customer.CNAME from customer INNER JOIN salespeople WHERE salespeople.SNUM=customer.SNUM ORDER BY salespeople.SNAME;

/*============================================================================================================================================
59) Write a query that produces the names and ratings of all customers who have average orders.*/

/*============================================================================================================================================
60) Find the SUM of all Amounts from the orders table.*/
select SUM(ATM) AS Total from orders;
/*============================================================================================================================================*/












