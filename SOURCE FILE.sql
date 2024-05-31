-- create a database called hotel

CREATE DATABASE HOTEL;

-- use the DB

-- create a table called reservation

CREATE TABLE RESERVATION(
 Booking_ID VARCHAR(200) PRIMARY KEY,
 no_of_adults	int,
 no_of_children	int,
 no_of_weekend_nights int,	
 no_of_week_nights	int,
 type_of_meal_plan	VARCHAR(255),
 room_type_reserved	VARCHAR(255),
 lead_time	INT,
 arrival_date	Date,
 market_segment_type	varchar(255),
 avg_price_per_room float,
 booking_status varchar(255)
);


-- CHANGE THE DATE FORMAT

Set datestyle to sql, DMY


-- read in the data


COPY reservation 
FROM 'C:\Users\HP\Downloads\MENTORNESS\Hotel Reservation Analysis in SQL\Hotel Reservation Dataset.CSV'
DELIMITER ','
CSV HEADER;

-- view the data

SELECT * 
FROM reservation;


-- Question 1
-- What is the total number of reservations in the dataset?

SELECT count(booking_id)
from reservation;

-- 700 reservations are in the dataset


/* Question 2
Which meal plan is the most popular among guests?
*/


SELECT type_of_meal_plan, count(type_of_meal_plan) as "number of orders"
FROM reservation
group by type_of_meal_plan
order by 2 desc
limit 1;

-- meal plan 1 is the most popular



/* Question 3
What is the average price per room for reservations involving children?
*/


SELECT CEIL(AVG(avg_price_per_room))  "average price per room"
FROM reservation
where no_of_children > 0; 


-- The average price per room for reservation involving children is 145 



/* Question 4
How many reservations were made for the year 20XX (replace XX with the desired year)?

our desired year is 2018
*/


SELECT COUNT(booking_id) as "number of booking"
FROM reservation
where arrival_date between '2018-01-01' and '2018-12-31'; 

-- 577 reservation were made in the year 2018 I picked 2018 as my desired year


/* Question 5
What is the most commonly booked room type?
*/

SELECT room_type_reserved, count(room_type_reserved) as Frequency
FROM reservation
group by  room_type_reserved
order by 2 desc;


-- Room 1 is the most commonly booked room with 534 bookings


/* Question 6
How many reservations fall on a weekend (no_of_weekend_nights > 0)?
*/


SELECT count(booking_id) as "numbers of reservations that fall on a weekend"
FROM reservation
WHERE no_of_weekend_nights > 0;


-- 383 reservations falls on weekend



/* Question 7
What is the highest and lowest lead time for reservations?
*/

SELECT max(lead_time) as "highest lead time", min(lead_time) as "Lowest lead time" 
FROM reservation;

-- The highest and the lowest lead time for resevation is 443



/* Question 8
What is the most common market segment type for reservations?
*/


SELECT market_segment_type, count(market_segment_type) as "number of market segments" 
FROM reservation
group by 1
order by 2 desc;


-- The most common market segment type is ONLINE is 518 segment


/* Question 9
How many reservations have a booking status of "Confirmed"?
*/

SELECT count(booking_id)
FROM reservation
where booking_status != 'Canceled';


-- 493 has a booking status of confirmed



/* Question 10
What is the total number of adults and children across all reservations?
*/


SELECT sum(no_of_adults + no_of_children) as "Total number of reservations"
FROM reservation;


-- 1385 was the total number of both adults and children across all reservation



/* 
Question 11
What is the average number of weekend nights for reservations involving children?
*/


SELECT ceil(avg(no_of_weekend_nights)) as "average number of weekend nights"
FROM reservation
where no_of_children > 0;

-- The average number of weekend nights involving children is 1



/* Question 12
How many reservations were made in each month of the year
*/


SELECT extract (month from arrival_date), count(booking_id) 
FROM reservation
group by 1
order by 1;

/* IN FIRST MONTH 11, 
SECOND MONTH 28, 
THIRD MONTH 52, 
FOURTH MONTH 67, 
FIFTH MONTH 55, 
SIXTH MONTH 84, 
SEVENTH MONTH 44,
EIGHTH MONTH 70,
NINTH MONTH 80, 
TENTH MONTH 103, 
ELEVENTH MONTH 54,
TWELVETH MONTH 52
*/



/* Question 13
What is the average number of nights (both weekend and weekday) spent by guests for each room type?
*/ 

with calcu_table as (
select no_of_weekend_nights + no_of_week_nights as "total number",room_type_reserved
from reservation 
)
select room_type_reserved, round(avg("total number"),2) as "average number of nights" 
from calcu_table
group by 1;


/*Average number of nights spent by the guest for each room both weekends and weekdays are descending order
FOR ROOM 7 is 2.67,
ROOM 6 is 3.61, 
ROOM 5 is 2.50, 
ROOM 4 is 3.80, 
ROOM 2 is 3.00,
ROOM 1 is 2.88
*/
 

/* Question 14 For reservations involving children, 
what is the most common room type, 
and what is the average price for that room type?
*/


WITH children_table as (
  SELECT room_type_reserved, avg_price_per_room
	FROM reservation
	where no_of_children >0
)
SELECT room_type_reserved, count(room_type_reserved), ceil(avg(avg_price_per_room)) as "average room price"
FROM children_table
group by 1
order by 2 desc
limit 1;



/* for reservation involving children, the most common room type is ROOM 1 
and the average price for that room is 124
*/


SELECT * 
FROM reservation;


/* Question 15
Find the market segment type that generates the highest average price per room
*/

SELECT market_segment_type, ceil(avg(avg_price_per_room))  as "average price per room"
FROM reservation
group by 1
order by 2 desc
limit 1; 


The market segment type that generates the highest of average price per room is ONLINE with 11 





