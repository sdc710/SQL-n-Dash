--CUSTOMER TABLE--
CREATE TABLE Customer (
Customer_id INTEGER PRIMARY KEY,
Customer_fname VARCHAR(30) NOT NULL,
Customer_lname VARCHAR(30) NOT NULL,
Customer_email VARCHAR(30) NOT NULL,
Customer_phone VARCHAR(20) NOT NULL,
Customer_address VARCHAR(30) NOT NULL
);
INSERT INTO Customer (Customer_ID, Customer_FName, Customer_LName, Customer_email, 
Customer_Phone,Customer_address)
VALUES
(1359,'Matt', 'Blouin', 'Mblouin09@td.com','438-655-5454', '34 Gouin'),
(1983,'Kaleen','Bryan', 'Kbryan@yahoo.ca','555-465-4644','939 Meadow Lane'),
(8709,'Dani','Hartman' ,'Mrdani@gmail.com','454-554-8776', '99 Milton Avenue'),
(3273,'Izabella','Duncan','Iduncan@gmail.com','543-999-5431', '12 Mill Close'),
(4052,'Myla','Raymond','MylaRaymond32@hotmail.com','434-674-5531','5600 Mulberry Street'),
(1491,'Marshall','Salazar','Masalazar1992@outlook.com','312-754-1234','45 Maple Avenue'),
(1301,'Harriett','Mansell','Mansell.Harriet@rogers.ca','678-874-1231','3000 Rene-Levesque'),
(9309,'Rikki','Knox','Rikki132@yahoo.ca','656-788-2424','5645 Sherbrooke East'),
(1661,'Leanna','Merritt' ,'Leanna.Merritt@hotmail.com','987-354-0863', '333 De La Montagne'),
(5758, 'Dave' ,'Schmidt', 'Daveschmidt@hotmail.com','643-653-5532','132 Durocher');

--DRIVER TABLE--
CREATE TABLE Driver (
Driver_id INTEGER PRIMARY KEY,
Driver_fname VARCHAR(30) NOT NULL,
Driver_lname VARCHAR(30) NOT NULL,
Driver_email VARCHAR(30) NOT NULL,
Driver_phone VARCHAR(20) NOT NULL
);
INSERT INTO Driver (Driver_ID,Driver_FName, Driver_LName, Driver_Email, Driver_Phone)
VALUES
(327420,'Syman','Torrijos', 'storrijos0@live.com','986-881-3200'),
(602469,'Rosabella','Rankmore','rrankmore1@google.com','816-598-4668'),
(732830,'Brier','Churchyard','bchurchyard2@gravatar.com','972-530-1093'),
(806855,'Antonietta','Faireclough','afaireclough3@concordia.ca','868-236-7183'),
(782324,'Terra','Woollett','twoollett4@nsw.ca','244-191-3734'),
(459399,'Neel','Twinborne', 'ntwinborne5@hotmail.com','938-684-6785'),
(464207,'Abigale','Ranklin','aranklin6@wire.com','393-182-6401'),
(590044,'Correna','Kilmister','ckilmister@bloglovin.com','878-411-3770'),
(768766,'Andros','MacKibbon','amackibbon8@delicious.com','149-252-3689'),
(687598,'Garvey','Kimmons','gkimmons9@admin.ch','381-984-7975');

--PAYMENT TABLE--
CREATE TABLE Payment (
Payment_id INTEGER PRIMARY KEY,
Payment_type VARCHAR(10) NOT NULL
);
INSERT INTO Payment (Payment_ID,Payment_Type)
VALUES
(16261030,'Debit'),
(16220712,'Credit'),
(16000811,'Cash');

--ORDERS TABLE--
CREATE TABLE Orders (
Order_id SMALLINT PRIMARY KEY,
Customer_id INTEGER NOT NULL,
Driver_id INTEGER NOT NULL,
Payment_id INTEGER NOT NULL,
Order_date DATE NOT NULL,
FOREIGN KEY (Customer_id) REFERENCES Customer (Customer_id),
FOREIGN KEY (Driver_id) REFERENCES Driver (Driver_id),
FOREIGN KEY (Payment_id) REFERENCES Payment (Payment_id)
);
INSERT INTO Orders (Order_ID,Customer_id,Driver_id,Payment_id ,Order_date)
VALUES 
(10,1983,327420,16261030,'2021-06-15'),
(11,1983,602469,16261030,'2021-06-07'),
(12,1983,732830,16261030,'2021-06-30'),
(13,1359,806855,16220712,'2021-06-15'),
(14,3273,782324,16220712,'2021-06-11'),
(15,1359,459399,16220712,'2021-06-04'),
(16,8709,464207,16220712,'2021-06-02'),
(17,4052,590044,16000811,'2021-06-02'),
(18,1301,768766,16000811,'2021-06-02'),
(19,1491,687598,16220712,'2021-06-04'),
(20,9309,687598,16220712,'2021-06-05'),
(21,5758,687598,16220712,'2021-06-02'),
(22,1661,768766,16000811,'2021-06-29'),
(23,1983,327420,16261030,'2021-06-29'),
(24,1491,687598,16220712,'2021-06-30');

--MENU TABLE--
CREATE TABLE Menu (
Menu_id SMALLINT PRIMARY KEY,
Menu_type VARCHAR (30) NOT NULL
);
INSERT INTO Menu (Menu_Id,Menu_Type)
VALUES
(80,'Korean'),
(81,'Japanese'),
(82,'Chinese'),
(83,'Cambodian'),
(84,'Thai');

--ITEM TABLE--
CREATE TABLE Item (
Item_id INTEGER PRIMARY KEY,
Menu_id INTEGER NOT NULL,
Item_name VARCHAR(30) NOT NULL,
Item_description TEXT NOT NULL,
Item_price NUMERIC NOT NULL,
FOREIGN KEY (Menu_id) REFERENCES Menu (Menu_id)
);
INSERT INTO Item (Item_id, Menu_id, Item_name, Item_description, Item_price)
VALUES
(1001,80,'Bibimbap', 'Korean Rice with Mixed Vegeatables', 12.50),
(1002,80,'Bulgogi', 'Korean BBQ Beef',10.50),
(2001,81,'Onigiri', 'Rice Balls',6),
(2002,81,'Soba', 'Buckwheat Noodles',10),
(3001,82,'Sweet and Sour Chicken', 'Crispy Seasoned Chicken',7.50),
(3002,82,'Wonton Soup', 'Chinese Dumpling in a Soup',6.50),
(4002,83,'Khmer Curry', 'Rich, Flavorful Curry',11),
(4003,83,'Fish Amok', 'Curried Fish Steamed in Banana Leaves',8),
(5002,84,'Pad Thai', 'Stir-Fried Rice Noodles ',8.50),
(5003,84,'Bánh mì', 'Vietnamese Sandwich',7);

--ORDER_ITEM TABLE--
CREATE TABLE Order_item (
Order_id SMALLINT NOT NULL,
Item_id INTEGER NOT NULL,
Order_item_quantity SMALLINT NOT NULL,
Order_item_total NUMERIC NOT NULL,
FOREIGN KEY(Order_id) REFERENCES Orders (Order_id),
FOREIGN KEY(Item_id) REFERENCES Item (Item_id),
PRIMARY KEY(Order_id, Item_id)
);
INSERT INTO Order_Item (Order_id, Item_id, Order_item_quantity, Order_item_total)
VALUES
(10,1001,1,12.50),
(10,1002,2,21),
(11,5003,2, 14),
(12,2001,1, 6),
(12,5002,1, 8.50),
(13,2001,2, 12),
(13,3001,1, 7.50),
(14,4002,1, 11),
(15,4003,1, 8),
(16,3002,3, 19.50),
(17,2002,1, 10),
(18,5003,2, 14),
(18,2002,2, 20),
(19,1001,3, 37.50),
(20,3001,1, 7.50),
(20,3002,1, 6.50),
(20,4002,1, 11),
(21,5002,2, 17),
(22,5003,1, 7),
(23,3002,1, 6.50),
(23,4003,1, 8),
(24,2001,4, 24),
(24,1002,3, 31.50);