#The InstantRide Management team founded a new team for car maintenance. 
#The new team is responsible for the small maintenance operations for the cars in the InstantRide system. 
#The main idea is to take actions faster and minimize the time spent for the maintenance. 
#Therefore, the Car Maintenance team wants to store MAINTENANCE_TYPE_ID (char(5)) and a MAINTENANCE_TYPE_DESCRIPTION (varchar(30)) in the database. 
#Using MAINTENANCE_TYPE_ID as the PRIMARY KEY, create a new table, MAINTENANCE_TYPES, and send the table description with the column names and types to the Car Maintenance team.
CREATE TABLE MAINTENANCE_TYPES(
  MAINTENANCE_TYPE_ID CHAR(5) PRIMARY KEY NOT NULL,
  MAINTENANCE_TYPE_DESCRIPTION VARCHAR(30) NOT NULL
);



#The Car Maintenance team also wants to store the actual maintenance operations in the database. 
#The team wants to start with a table to store CAR_ID (CHAR(5)), MAINTENANCE_TYPE_ID (CHAR(5)) and MAINTENANCE_DUE (DATE) date for the operation. 
#Create a new table named MAINTENANCES. The PRIMARY_KEY should be the combination of the three fields. 
#The CAR_ID and MAINTENANCE_TYPE_ID should be foreign keys to their original tables. Cascade update and cascade delete the foreign keys.
CREATE TABLE MAINTENANCES(
  CAR_ID CHAR(5) NOT NULL,
  MAINTENANCE_TYPE_ID CHAR(5)  NOT NULL,
  MAINTENANCE_DUE DATE  NOT NULL,
  PRIMARY KEY(CAR_ID,MAINTENANCE_TYPE_ID,MAINTENANCE_DUE),
  FOREIGN KEY(CAR_ID)
      REFERENCES CARS(CAR_ID),
  FOREIGN KEY(MAINTENANCE_TYPE_ID)
      REFERENCES MAINTENANCE_TYPES(MAINTENANCE_TYPE_ID)
);


#The Driver Relationship team wants to create some workshops and increase communication with the active drivers in InstantRide. 
#Therefore, they requested a new database table to store the driver details of the drivers that have had at least one ride in the system. 
#Create a new table, ACTIVE_DRIVERS, from the DRIVERS and TRAVELS tables which contains the following fields:

#DRIVER_ID CHAR(5) (Primary key)
#DRIVER_FIRST_NAME VARCHAR(20)
#DRIVER_LAST_NAME VARCHAR(20)
#DRIVER_DRIVING_LICENSE_ID VARCHAR(10)
#DRIVER_DRIVING_LICENSE_CHECKED BOOL
#DRIVER_RATING DECIMAL(2,1)
CREATE TABLE  ACTIVE_DRIVERS(
  DRIVER_ID CHAR(5) NOT NULL PRIMARY KEY,
  DRIVER_FIRST_NAME VARCHAR(20),
  DRIVER_LAST_NAME VARCHAR(20),
  DRIVER_DRIVING_LICENSE_ID VARCHAR(10),
  DRIVER_DRIVING_LICENSE_CHECKED BOOL DEFAULT TRUE,
  DRIVER_RATING DECIMAL(2,1)
) AS SELECT DISTINCT d.DRIVER_ID,DRIVER_FIRST_NAME,DRIVER_LAST_NAME,
            DRIVER_DRIVING_LICENSE_ID,DRIVER_DRIVING_LICENSE_CHECKED,
            DRIVER_RATING
      FROM DRIVERS d INNER JOIN TRAVELS t ON d.DRIVER_ID=t.DRIVER_ID;
       


#The Driver Relationship team wants to have quick search options for the active drivers. 
#The team specifically mentioned that they are using first name, last name and driving license ID to search the drivers. 
#Create an index called NameSearch on the ACTIVE_DRIVERS table created in task 3.
CREATE INDEX NameSearch 
ON ACTIVE_DRIVERS(DRIVER_FIRST_NAME,DRIVER_LAST_NAME,     DRIVER_DRIVING_LICENSE_ID);


#The Driver Relationship team requested to ensure that there will be no duplicates in the active drivers tables in terms of first name, 
#last name and driving license ID. You need to create a constraint in the ACTIVE_DRIVERS table, called DuplicateCheck, 
#to ensure the first name, last name, and the driving license ID are unique.
ALTER TABLE ACTIVE_DRIVERS
ADD CONSTRAINT DuplicateCheck UNIQUE (DRIVER_FIRST_NAME,DRIVER_LAST_NAME,     DRIVER_DRIVING_LICENSE_ID);


#The Car Maintenance team considered that the available maintenance tasks should also have the price information in the database. 
#Alter the MAINTENANCE_TYPES table to include a new column named MAINTENANCE_PRICE of type DECIMAL(5,2).
ALTER TABLE MAINTENANCE_TYPES
ADD COLUMN MAINTENANCE_PRICE DECIMAL(5,2);


#The Car Maintenance team wanted to ensure that the default price of the maintenance actions should not be empty and 0 instead if not specified. 
#Alter the MAINTENANCE_TYPES table created in Chapter 8, Activity 1 to set the default MAINTENANCE_PRICE to 0.
ALTER TABLE MAINTENANCE_TYPES
ALTER COLUMN MAINTENANCE_PRICE SET DEFAULT 0;


#The Driver Relationship team wants to ensure that the all driving license IDs in the active drivers table have the length of 7. 
#Alter the ACTIVE_DRIVERS table created in Chapter 8, Activity 1 to check the length of the DRIVER_DRIVING_LICENSE_ID.
ALTER TABLE ACTIVE_DRIVERS ADD CHECK(LENGTH(DRIVER_DRIVING_LICENSE_ID)=7);

#The Car Maintenance team wants to insert and store the following maintenance types to the MAINTENANCE_TYPES table:

#ID: 1; Description: Tire Change; Price: 50
#ID: 2; Description; Oil Change; Price: 45
#ID: 3; Description; Full Cleaning; Price: 100
#ID: 4; Description; Gas Pump Change; Price: 145
INSERT INTO MAINTENANCE_TYPES(MAINTENANCE_TYPE_ID,MAINTENANCE_TYPE_DESCRIPTION,
MAINTENANCE_PRICE)
VALUES (1,'Tire Change',50);
INSERT INTO MAINTENANCE_TYPES VALUES (2,'Oil Change',45);
INSERT INTO MAINTENANCE_TYPES VALUES (3,'Full Cleaning',100);
INSERT INTO MAINTENANCE_TYPES VALUES (4,'Gas Pump Change',145);



#The Car Maintenance team wants to add new maintenance tasks into the system. 
#The team has determined that there should be Tire Change (ID: 1) task for every car with the model year 2018 in InstantRide. 
#Due date of this maintenance tasks is 31 December, 2020. Insert the rows into the MAINTENANCES table for every car built in 2018 and send the data back to the team.
INSERT INTO MAINTENANCES(CAR_ID,MAINTENANCE_TYPE_ID,MAINTENANCE_DUE)
SELECT CAR_ID,'1','2022-12-31'
FROM CARS
WHERE CAR_YEAR=2021;


#The Driver Relationship team realized that there is no need for DRIVER_DRIVING_LICENSE_CHECKED field in the active drivers table. 
#Since all the drivers are already active in InstantRide, their driving licenses should be checked regularly. 
#The team wanted you to remove the field from the table.
ALTER TABLE ACTIVE_DRIVERS DROP COLUMN DRIVER_DRIVING_LICENSE_CHECKED;


#The Car Maintenance team wants to update the price of Oil Change to 75. In addition, 
#they will no longer provide or require a Gas Pump Change in the future and there is no need to keep the maintenance item in the database. 
#Update the cost of the oil change and remove the gas pump change option from the MAINTENANCE_TYPES table.
SET SQL_SAFE_UPDATES=0;

UPDATE MAINTENANCE_TYPES
SET 
    MAINTENANCE_PRICE=75
WHERE 
    MAINTENANCE_TYPE_DESCRIPTION='Oil Change';
DELETE FROM MAINTENANCE_TYPES
WHERE 
    MAINTENANCE_TYPE_DESCRIPTION='Gas Pump Change';
SET SQL_SAFE_UPDATES=1;




