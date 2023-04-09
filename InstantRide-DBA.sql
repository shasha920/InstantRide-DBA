#Drivers are essential for InstantRide, and the Driver Relationship team is responsible for their integration and success. 
#The team requires all the driver detail in the system for creating a new dashboard. 
#You need to SELECT all available data for the drivers and return back to the team.
select *
from DRIVERS;


#The Driver Relationship team also requests the joining dates of the drivers to create a timeline. 
#In the table, you only need to return the joining date of the drivers. 
#You need to only return the DRIVER_START_DATE column inside a SELECT statement for the DRIVERS table.
select DRIVER_START_DATE
from DRIVERS;

#The Driver Relationship team would like the DRIVER_ID and DRIVER_RATING of drivers currently having a rating higher than 4 in descending order.
select DRIVER_ID, DRIVER_RATING
from DRIVERS
order by 2 desc;


select DRIVER_ID, DRIVER_RATING
from DRIVERS
where DRIVER_RATING>4;

#The InstantRide User Satisfaction team is a core team for InstantRide, and they focus on increasing the customer satisfaction. 
#They want to learn the travel time for each ride in the system. 
#You need to return the USER_ID, and the TRAVEL_TIME column which is calculated using the TIMEDIFF function on the TRAVEL_END_TIME and 
#the TRAVEL_START_TIME.
select USER_ID,TIMEDIFF(TRAVEL_END_TIME,TRAVEL_START_TIME) AS TRAVEL_TIME
from TRAVELS;


#User Satisfaction team wants to send monthly summaries for each user. They need the following details with the user ID:

#The last day of the month when the users traveled most recently
#One week after the last day of the month when the users traveled most recently
#You need to return a three-column output with USER_ID, LAST_TRAVEL_MONTH and NOTIFICATION.
#LAST_TRAVEL_MONTH should be calculated using the MAX of the LAST_DAY of the TRAVEL_END_TIME field. 
#Similarly, NOTIFICATION should be calculated with DATE_ADD function to add one week.
select USER_ID, max(LAST_DAY(TRAVEL_END_TIME)) AS LAST_TRAVEL_MONTH, 
max(DATE_ADD(LAST_DAY(TRAVEL_END_TIME), INTERVAL 1 WEEK)) AS NOTIFICATION
from TRAVELS
group by 1;


#The Marketing team of InstantRide wants to know that how many discounts have been offered for each ride. 
#You need to calculate this information for each travel where a discount is applied and return two columns:
#TRAVEL_ID and DISCOUNT_AMOUNT. In addition, you need to return the calculation as a money value using the ROUND function to 2 decimals.
select TRAVEL_ID, ROUND(TRAVEL_PRICE * TRAVEL_DISCOUNT,2) AS DISCOUNT_AMOUNT
from TRAVELS
where TRAVEL_DISCOUNT is NOT NULL;



The InstantRide received some traffic violation tickets from the government. 
#The Legal team of InstantRide requires the travel information of the respective drivers along with corresponding Driving License IDs to proceed further.
#In addition, the team wants to include the drivers without travel information in the system yet for the completion of driver list. Therefore, 
#you need to return DRIVER_FIRST_NAME, DRIVER_LAST_NAME, DRIVER_DRIVING_LICENSE_ID, TRAVEL_START_TIME, 
#TRAVEL_END_TIME information from the DRIVERS and TRAVELS data connected by LEFT JOIN.
select d.DRIVER_FIRST_NAME, d.DRIVER_LAST_NAME, d.DRIVER_DRIVING_LICENSE_ID, t.TRAVEL_START_TIME, t.TRAVEL_END_TIME 
from DRIVERS d left join TRAVELS t on d.DRIVER_ID=t.DRIVER_ID;


#The InstantRide Management team considers setting up a Lost & Found inventory. In order to start the setup, 
#the team requires the detail of users with their travel start and end times. 
#The team wants to track potential list of users who may have forgotten their items on the cars.
#Therefore, you need to return USER_FIRST_NAME, USER_LAST_NAME, TRAVEL_START_TIME, TRAVEL_END_TIME information from the USERS
#and TRAVELS tables connected inside a JOIN statement by the USING function and USER_ID field.
select  USER_FIRST_NAME, USER_LAST_NAME, TRAVEL_START_TIME, TRAVEL_END_TIME
from USERS u join TRAVELS t using(USER_ID);

#The InstantRide Finance team wants to collect the price and discount information with the driver names for each travel in the system.
#You need to return the TRAVEL_ID, DRIVER_FIRST_NAME, DRIVER_LAST_NAME, TRAVEL_PRICE, and TRAVEL_DISCOUNT information 
#from the TRAVELS and DRIVERS tables combined over DRIVER_ID field with the ON keyword.
select t.TRAVEL_ID, d.DRIVER_FIRST_NAME, d.DRIVER_LAST_NAME, t.TRAVEL_PRICE,t.TRAVEL_DISCOUNT
from TRAVELS t join DRIVERS d on d.DRIVER_ID=t.DRIVER_ID;



#The InstantRide Driver Relationship team wants to create groups for drivers according to their ratings such as 3+ or 4+. 
#For instance, a driver with the rating 3.8 will be 3+; whereas a driver with the rating 4.2 will be 4+. You need to return a two column output 
#with DRIVER_ID and DRIVER_RATING which has first FLOOR applied and then CONCAT with + sign for all drivers with a rating greater than 0.
select DRIVER_ID, CONCAT(FLOOR(DRIVER_RATING),'+') AS DRIVER_RATING
FROM DRIVERS
where DRIVER_RATING>0;


#The InstantRide User Satisfaction team are looking forward to creating discounts for the users. 
#However, the team suspects that there could be duplicate users in the system with different emails. 
#Check for the users with their names and surnames for potential duplicates. Therefore, 
#you need to JOIN the USERS table with USERS table and compare for equality of USER_FIRST_NAME and USER_LAST_NAME and inequality in USER_ID fields.
select *
from USERS a join USERS b on a.USER_FIRST_NAME=b.USER_FIRST_NAME and a.USER_LAST_NAME=b.USER_LAST_NAME and a.USER_ID!=b.USER_ID;




