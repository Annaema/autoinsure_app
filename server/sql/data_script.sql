SELECT * FROM carSystem.main_table;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
USE carSystem;

ALTER TABLE main_table
MODIFY COLUMN ncb VARCHAR(255);

ALTER TABLE main_table
DROP COLUMN userID;

SELECT * FROM carSystem.main_table;
use carSystem;
ALTER TABLE main_table
ADD COLUMN userID INT PRIMARY KEY NOT NULL AUTO_INCREMENT;

DELETE FROM main_table WHERE userID = 28;

ALTER TABLE main_table
DROP userID;

ALTER TABLE main_table
ADD COLUMN userID INT PRIMARY KEY NOT NULL AUTO_INCREMENT;

ALTER TABLE main_table
MODIFY COLUMN age INT;

ALTER TABLE main_table
MODIFY COLUMN drivingYears INT;

ALTER TABLE main_table
MODIFY COLUMN ncb INT;

ALTER TABLE main_table
ADD CONSTRAINT insuranceGroup
FOREIGN KEY (insuranceGroup) REFERENCES insuranceGroup_table(insuranceGroup);

ALTER TABLE insuranceGroup_table
RENAME COLUMN multiplier TO insuranceGroup_multiplier;

ALTER TABLE main_table
ADD COLUMN result NUMERIC(4,2) AFTER insuranceGroup;

# Join the tables together
# do a multiplication  sum, inside the 'result' column
# extract 'result' value into react (watch the vid) 

# Join the tables together
SELECT m.userID, m.name, m.age, a.age_multiplier, m.drivingYears, dy.drivingYears_multiplier, m.chooseRegion, r.chooseRegion_multiplier, m.driveway, dw.driveway_multiplier, m.ncb, ncb_table.ncb_multiplier, m.insuranceGroup, ig.insuranceGroup_multiplier, a.age_multiplier * dy.drivingYears_multiplier * r.chooseRegion_multiplier * dw.driveway_multiplier * ncb_table.ncb_multiplier * ig.insuranceGroup_multiplier AS result_ FROM age_table a INNER JOIN main_table m ON a.age = m.age INNER JOIN drivingYears_table dy ON m.drivingYears = dy.drivingYears INNER JOIN chooseRegion_table r ON m.chooseRegion = r.chooseRegion INNER JOIN driveway_table dw ON m.driveway = dw.driveway INNER JOIN ncb_table ON m.ncb = ncb_table.ncb INNER JOIN insuranceGroup_table ig ON m.insuranceGroup = ig.insuranceGroup;

SELECT m.userID, m.name, m.age, a.age_multiplier, m.drivingYears, dy.drivingYears_multiplier, m.chooseRegion, r.chooseRegion_multiplier, m.driveway, dw.driveway_multiplier, m.ncb, ncb_table.ncb_multiplier, m.insuranceGroup, ig.insuranceGroup_multiplier, a.age_multiplier * dy.drivingYears_multiplier * r.chooseRegion_multiplier * dw.driveway_multiplier * ncb_table.ncb_multiplier * ig.insuranceGroup_multiplier + 1 AS multiplier FROM age_table a INNER JOIN main_table m ON a.age = m.age INNER JOIN drivingYears_table dy ON m.drivingYears = dy.drivingYears INNER JOIN chooseRegion_table r ON m.chooseRegion = r.chooseRegion INNER JOIN driveway_table dw ON m.driveway = dw.driveway INNER JOIN ncb_table ON m.ncb = ncb_table.ncb INNER JOIN insuranceGroup_table ig ON m.insuranceGroup = ig.insuranceGroup;

