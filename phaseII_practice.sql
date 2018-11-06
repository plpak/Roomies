
-- Project Phase II
-- Group Name: Roomies
-- Group Members: Paul Pak, Anthony Trang
--This SQL script was tested on Oracle Live SQL. TO run, simply
--load this script file and run.


/*
IDEA:

What if we had a roommate id but it was a communal id.

in the id we can relate communal items like toilet paper, communal groceries,
from there we had also create lists and such that have to do with communal items.


*/

  

CREATE TABLE ROOMMATE ( 
	member_id		INTEGER			NOT NULL, 
	fname			VARCHAR(32)		NOT NULL,
	lname			VARCHAR(32)		NOT NULL,
	num_chores_done	INTEGER			DEFAULT 0,
	CHECK			(num_chores_done > 0),
	PRIMARY KEY (member_id));  
	
	
INSERT INTO ROOMMATE VALUES(1, 'Anthony', 'Trang', 1);
INSERT INTO ROOMMATE VALUES(2, 'Sam', 'Lee', 3);
INSERT INTO ROOMMATE VALUES(3, 'Bob', 'Ross', 2);
INSERT INTO ROOMMATE VALUES(4, 'Smith', 'Adam', 6);
INSERT INTO ROOMMATE VALUES(5, 'John', 'Doe', 2);
INSERT INTO ROOMMATE VALUES(6, 'Mary', 'Brown', 4);
INSERT INTO ROOMMATE VALUES(7, 'Edward', 'Kook', 8);
INSERT INTO ROOMMATE VALUES(8, 'Emily', 'Tran', 4);
INSERT INTO ROOMMATE VALUES(9, 'Steve', 'Williams', 3);
INSERT INTO ROOMMATE VALUES(10, 'Will', 'Smith', 7);
	
	
CREATE TABLE STORAGE ( 
	storage_id		INTEGER			NOT NULL,
	storage_type	VARCHAR(32)		NOT NULL,
	is_owned_by		INTEGER			DEFAULT NULL,
	is_shared		INTEGER			NOT NULL, 
	location		VARCHAR(32)		NOT NULL,

	PRIMARY KEY (storage_id),
	FOREIGN KEY (is_owned_by) REFERENCES ROOMMATE (member_id)
	ON DELETE SET NULL);

INSERT INTO STORAGE VALUES(1, 'Cabinet', 1, 0, 'Kitchen');
INSERT INTO STORAGE VALUES(2, 'Drawer', 3, 1, 'Kitchen');
INSERT INTO STORAGE VALUES(3, 'Drawer', 4, 0, 'Master Bedroom');
INSERT INTO STORAGE VALUES(4, 'Suitcase', 1, 0, 'Basement');
INSERT INTO STORAGE VALUES(5, 'TV Stand', 5, 1, 'Living Room');
INSERT INTO STORAGE VALUES(6, 'Desk', 8, 1, 'Guest Bedroom');
INSERT INTO STORAGE VALUES(7, 'Backpack', 7, 1, 'Living Room');
INSERT INTO STORAGE VALUES(8, 'Chest', 6, 0, 'Family Room');
INSERT INTO STORAGE VALUES(9, 'Closet', 5, 1, 'Main Hallway');
INSERT INTO STORAGE VALUES(10, 'Glass Case', 10, 0, 'Living Room');
	

CREATE TABLE ITEMS (
	item_id				INTEGER			NOT NULL,
	name_of_item		VARCHAR(32)		NOT NULL,
	stored_location		INTEGER			NOT NULL,
	inventory			INTEGER			NOT NULL,
	
	CHECK			(inventory > -1),
	PRIMARY KEY (item_id),
	FOREIGN KEY (stored_location) REFERENCES STORAGE(storage_id)
	ON DELETE CASCADE);

	
INSERT INTO ITEMS VALUES(1, 'Stapler', 1, 1);
INSERT INTO ITEMS VALUES(2, 'Toothpaste', 4, 1);
INSERT INTO ITEMS VALUES(3, 'Sticky Notes', 7, 1);
INSERT INTO ITEMS VALUES(4, 'Figurine', 10, 1);
INSERT INTO ITEMS VALUES(5, 'Socks', 9, 10);
INSERT INTO ITEMS VALUES(6, 'Video games', 5, 1);
INSERT INTO ITEMS VALUES(7, 'Printer Paper', 6, 1);
INSERT INTO ITEMS VALUES(8, 'Plastic Forks', 2, 100);
INSERT INTO ITEMS VALUES(9, 'Lint roller', 8, 2);
INSERT INTO ITEMS VALUES(10, 'Mail key', 3, 1);
	
	
CREATE TABLE CHORES ( 	
	chore_id				INTEGER			NOT NULL, 
	chore_title 			VARCHAR(32)		NOT NULL, 
	chore_descript			VARCHAR(254)	DEFAULT NULL,			
	is_done					INTEGER			DEFAULT 0, 
	in_charge				INTEGER 		DEFAULT NULL, 
	chore_location			VARCHAR(32)		NOT NULL, 
	start_date				DATE 			NOT NULL,
	end_date				DATE			NOT NULL,
	CHECK					(start_date <= end_date),
	PRIMARY KEY (chore_id), 
	FOREIGN KEY (in_charge) REFERENCES ROOMMATE(member_id)
	ON DELETE SET NULL); 
	
	
INSERT INTO CHORES VALUES(1, 'Clean Dishes', 'Clean dishes in the sink', 1, 1, 'Kitchen', to_date('01/01/95','dd/mm/yyyy'), to_date('02/01/95','dd/mm/yyyy'));
INSERT INTO CHORES VALUES(2, 'Take Garbage Out', 'Empty out garbage and recycling outside', 1, 2, 'Kitchen', to_date('01/01/95','dd/mm/yyyy'), to_date('02/01/95','dd/mm/yyyy')); 
INSERT INTO CHORES VALUES(3, 'Vacuum Living Room', 'Vacuum the living room because it is messy', 1, 3, 'Living Room', to_date('01/01/95','dd/mm/yyyy'), to_date('03/01/95','dd/mm/yyyy')); 
INSERT INTO CHORES VALUES(4, 'Clean cat litter', '', 1, 4, 'Living Room', to_date('03/01/95','dd/mm/yyyy'), to_date('03/01/95','dd/mm/yyyy')); 
INSERT INTO CHORES VALUES(5, 'Take dog out', 'Dog needs to poop', 0, 5, 'Outside', to_date('05/01/95','dd/mm/yyyy'), to_date('05/01/95','dd/mm/yyyy')); 
INSERT INTO CHORES VALUES(6, 'Dust living room', 'Dust has been piling up', 0, 6, 'Living room', to_date('07/01/95','dd/mm/yyyy'), to_date('08/01/95','dd/mm/yyyy')); 
INSERT INTO CHORES VALUES(7, 'Clean toilet', 'The toilet has not been cleaned for awhile', 0, 7, 'Bathroom', to_date('09/01/95','dd/mm/yyyy'), to_date('10/01/95','dd/mm/yyyy')); 
INSERT INTO CHORES VALUES(8, 'Mow Lawn', 'Make sure the lawn mower is on the right height setting', 0, 8, 'Outside', to_date('11/01/95','dd/mm/yyyy'), to_date('15/01/95','dd/mm/yyyy')); 
INSERT INTO CHORES VALUES(9, 'Water plants', 'Plants are getting brown', 0, 9, 'Kitchen Windsill', to_date('13/01/95','dd/mm/yyyy'), to_date('16/01/95','dd/mm/yyyy')); 
INSERT INTO CHORES VALUES(10, 'Clean the white clothes', 'All white clothes should be in the laundry basket', 0, 10, 'Laundry Room', to_date('20/01/95','dd/mm/yyyy'), to_date('25/01/95','dd/mm/yyyy')); 



/*
SQL Query 1
Purpose: Return a list of name of people and their respective storages and chores.
Summary: Expected result should be a table that shows each persons name, their chores, and their storages they own.
*/
SELECT member_id,fname,lname,storage_type, chore_title 
FROM ROOMMATE 
JOIN STORAGE 
	ON is_owned_by=member_id 
JOIN CHORES 
	ON in_charge = member_id;


/*
SQL Query 2
Purpose:
Summary:
Group by City is needed since you have multiple cities you’re calculating the sum for. 
Because you have more than 1 Miami, so you’re grouping the Miami’s into 1 record.
Select City,Sum(CarsRented)as CarsR
From CarRentals
Group By City
Order by SUM(CarsRented)  ASC



*/


/*
SQL Query 3
Purpose:
Summary:
*/


/*
SQL Query 4
Purpose: Listing all items and their respective storage location types.
Summary: xpected result should be a table that shows a list of items and their respective storage types.
*/
SELECT name_of_item, storage_type
FROM STORAGE 
FULL OUTER JOIN ITEMS 
ON stored_location=storage_id;

/*
SQL Query 5
Purpose:
Summary:
*/


/*
SQL Query 6
Purpose: Find the person who is repsonsible for cleaning the dishes.
Summary: Expected result should be a table that shows the chore, and the first/last name of the person responsible.
*/
SELECT chore_title, fname, lname 
FROM ROOMMATE, CHORES 
WHERE chore_title = 'Clean Dishes' AND in_charge=member_id; 


/*
SQL Query 7
Purpose: List all chores that are not done.
Summary: Expected result should be a table where it shows all chores that have not been marked done.
*/
SELECT * FROM CHORES WHERE is_done = 0;


/*
SQL Query 8
Purpose: Find the list of people who's done more than 5 chores
Summary: Expected result should be a table that shows the people who's done more than 5 chores by
			their first/last name, and the number of chores they've done.
*/
SELECT num_chores_done, fname, lname 
FROM ROOMMATE 
WHERE num_chores_done > 5;


/*
SQL Query 9
Purpose: Finding all the registered items that are in the living room.
Summary: Expected result should be a table that shows the sorage unit it's in, the name of the item, and the inventory for that item.
*/
SELECT storage_type, name_of_item, inventory 
FROM STORAGE, ITEMS
WHERE location='Living Room' AND storage_id = stored_location;


/*
SQL Query 10
Purpose: Find where the stapler is
Summary: Expected reuslt should be a table that has the name of the item, the storage type it's in, and the location.
*/
SELECT name_of_item, storage_type, location 
FROM ITEMS, STORAGE 
WHERE name_of_item='Stapler' AND stored_location = storage_id;



--END OF SCRIPT (NOV 02, 2018)



