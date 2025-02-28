CREATE DATABASE IF NOT EXISTS DB2;
Use DB2;
DROP TABLE IF EXISTS Teacher;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Schools;
CREATE TABLE Schools(
	ID int primary key not null auto_increment,
	Identifier text not null,
	School_Type text not null,
	Name text not null
);
CREATE TABLE Students(
	ID int primary key not null auto_increment,
	Name text not null,
	Year int,
	School_ID int,
	Updated timestamp not null default now(),
	is_deleted boolean default false,
	FOREIGN KEY(School_ID) REFERENCES Schools(ID)
);
CREATE TABLE Teacher(
	ID int primary key not null auto_increment,
	School_ID int,
	Name text not null,
	FOREIGN KEY(School_ID) REFERENCES Schools(ID)
);
CREATE TRIGGER set_Updated BEFORE UPDATE ON Students FOR EACH ROW SET NEW.Updated = now();
CREATE TRIGGER set_SCHOOLID BEFORE INSERT ON Schools FOR EACH ROW SET NEW.Identifier = concat(NEW.School_Type, " ", NEW.Name);
INSERT INTO Schools (Name, School_Type) VALUES
("Paula Modersohn", "Gesamt"),
("Max Eyth", "Abitur"),
("Alt Wuldsorfer", "Grund"),
("BSDGG", "Berufsschule");
INSERT INTO Students (Name, School_ID) VALUES
	("Peter", 1),
	("Jannes", 1),
	("Pia", 3),
	("Lena", 4);
delimiter // 
CREATE PROCEDURE IF NOT EXISTS StudentCount (IN SchoolID INT,  OUT student_count INT)
	BEGIN
		SELECT COUNT(*) INTO student_count FROM Students WHERE Students.School_ID = SchoolID;
	END //
CREATE PROCEDURE IF NOT EXISTS StudentLeaveSchool (IN SchoolID INT)
	BEGIN
		UPDATE Students SET School_ID = NULL WHERE School_ID = SchoolID;
	END //
delimiter ;
CALL StudentCount(1, @sc);
SELECT @sc;
SELECT * FROM Students WHERE School_ID = 1;
CALL StudentLeaveSchool(1);
CALL StudentCount(1, @sc);
SELECT * FROM Students WHERE School_ID = 1;
SELECT @sc;
