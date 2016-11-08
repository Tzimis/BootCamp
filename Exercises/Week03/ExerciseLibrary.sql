use master;
IF EXISTS(select * from sys.databases where name='ExerciseLibrary')
	drop database ExerciseLibrary;
go
create database ExerciseLibrary;
go
use ExerciseLibrary;

IF EXISTS(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='Authors')
	drop table Authors;

create table Authors(
	ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name varchar(128) NOT NULL
);

IF EXISTS(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='Books')
	drop table Books;

create table Books (
	ISBN int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Title varchar(128) NOT NULL
);

IF EXISTS(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='BookAuthors')
	drop table BookAuthors;

create table BookAuthors (
	BookISBN int NOT NULL FOREIGN KEY REFERENCES Books(ISBN),
	AuthorID int NOT NULL FOREIGN KEY REFERENCES Authors(ID),
	CONSTRAINT BookAuthorsID PRIMARY KEY (BookISBN, AuthorID)
);

IF EXISTS(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='Libraries')
	drop table Libraries;

create table Libraries (
	ID int NOT NULL IDENTITY(1,1)  PRIMARY KEY,
	Name varchar(128) NOT NULL
);

IF EXISTS(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='LibraryBooks')
	drop table LibraryBooks;

create table LibraryBooks (
	LibraryID int NOT NULL FOREIGN KEY REFERENCES Libraries(ID),
	BookISBN int NOT NULL FOREIGN KEY REFERENCES Books(ISBN),
	PhysicalCopies int NOT NULL DEFAULT 0,	
	AvailableCopies int NOT NULL DEFAULT 0,
	CONSTRAINT LibraryBooksID PRIMARY KEY (LibraryID, BookISBN)
);


IF EXISTS(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='Users')
	drop table Users;

create table Users (
	ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name varchar(128) NOT NULL
);


IF EXISTS(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='LibraryUsers')
	drop table LibraryUsers;

create table LibraryUsers (
	LibraryID int NOT NULL FOREIGN KEY REFERENCES Libraries(ID),
	UserID int NOT NULL FOREIGN KEY REFERENCES Users(ID),
	CONSTRAINT LibraryUsersID PRIMARY KEY (LibraryID, UserID)
);


IF EXISTS(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='Librarians')
	drop table Librarians;

create table Librarians (
	ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name varchar(128) NOT NULL,
	ManagedLibraryID int NOT NULL FOREIGN KEY REFERENCES Libraries(ID)
);


--IF EXISTS(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='Manages')
--	drop database ExerciseLibrary;

--create table LibraryManagement (
--	LibraryID int NOT NULL FOREIGN KEY REFERENCES Libraries(ID),
--	LibrarianID int NOT NULL FOREIGN KEY REFERENCES Librarians(ID),
--	CONSTRAINT LibraryManagementID PRIMARY KEY (LibraryID, LibrarianID)
--);

IF EXISTS(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='Rents')
	drop table Rents;

create table Rents (
	RentID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	UserID int NOT NULL FOREIGN KEY REFERENCES Users(ID),
	BookISBN int NOT NULL FOREIGN KEY REFERENCES Books(ISBN),
	LibraryID int NOT NULL FOREIGN KEY REFERENCES Libraries(ID),
	AuthorizedBy int NOT NULL FOREIGN KEY REFERENCES Librarians(ID),
	RentDate DateTime NOT NULL DEFAULT GETDATE()
);


INSERT INTO Authors (Name) VALUES ('Tom Robbins'),
								  ('Fyodor Dostoyevsky'),
								  ('Leo Tolstoi'),
								  ('Herman Melville'),
								  ('Jack London'),
								  ('Oscar Wilde');


INSERT INTO Books (Title) VALUES ('Even Cowgirls Get the Blues'),
								 ('Half Asleep in Frog Pijamas'),
								 ('Villa Incognito'),
								 ('Crime and Punishment'),
								 ('The Idiot'),
								 ('The Brothers Karamazov'),
								 ('Notes From Underground'),
								 ('War and Peace'),
								 ('Anna Karenina'),
								 ('Moby-Dick'),
								 ('White-Jacket'),
								 ('White Fang'),
								 ('The Call of the Wild'),
								 ('The Picture of Dorian Gray'),
								 ('De Profundis');

INSERT INTO BookAuthors VALUES (1,1), (2,1), (3,1),   -- Tim Robbins
							   (4,2), (5,2), (6,2), (7,2), -- Dostoyevsky
							   (8,3), (9,3), -- Tolstoi
							   (10,4), (11,4), -- Melville
							   (12,5), (13,5), -- London
							   (14,6), (15,6); -- Wilde


INSERT INTO Libraries VALUES ('National Library'); 

INSERT INTO LibraryBooks VALUES (1,1,10,8),
								(1,2,12,10),
								(1,4,5,3),
								(1,5,5,5),
								(1,6,8,8),
								(1,8,10,7),
								(1,9,12,9),
								(1,10,2,1),
								(1,12,4,3);

INSERT INTO Librarians (Name, ManagedLibraryID) VALUES ('Nancy Drew', 1), ('Billy Bobbins', 1);

INSERT INTO Users VALUES ('Rick Grimes'), 
						 ('Tyrion Lannister'),
						 ('Ragnar Lothbrok'),
						 ('Bjorn Irosnide'),
						 ('Jack Kirby'),
						 ('Jessica Jones'),
						 ('Natasha Romanoff'),
						 ('May Parker');

INSERT INTO LibraryUsers VALUES (1,1), (1,3), (1,4), (1,6), (1,7), (1,8);

INSERT INTO Rents VALUES (1,1,1,1, '2008-02-21'),
						 (3,8,1,1, '2008-02-23'),
						 (4,1,1,2, '2008-03-11'),
						 (7,6,1,1, '2008-03-11'),
						 (6,5,1,2, '2008-04-12'),
						 (1,12,1,2,'2008-04-17'),
						 (4,10,1,1,'2008-04-24'),
						 (3,2,1,1, '2008-04-28'),
						 (8,4,1,2, '2008-05-04'),
						 (3,2,1,1, '2008-05-05');

--INSERT INTO LibraryManagement VALUES (1,1), (1,2);

--select * from Authors;
--select * from Books;
--select * from BookAuthors;
--select b.Title, a.Name From BookAuthors ba INNER JOIN Books b on ba.BookISBN = b.ISBN
--INNER JOIN Authors a on ba.AuthorID = a.ID;

select l.Name, b.Title, a.Name, lb.AvailableCopies, lb.PhysicalCopies from LibraryBooks lb 
INNER JOIN Books b on lb.BookISBN = b.ISBN
INNER JOIN Libraries l on l.ID = lb.LibraryID 
INNER JOIN BookAuthors ba on ba.BookISBN = b.ISBN
INNER JOIN Authors a on ba.AuthorID = a.ID;

select u.Name as UserName, b.Title as BookTitle, r.RentDate, ll.Name as AuthorizedBy from Rents r
INNER JOIN Users u on r.UserID = u.ID
INNER JOIN Books b on r.BookISBN = b.ISBN
INNER JOIN Libraries l on r.LibraryID = l.ID
INNER JOIN Librarians ll on r.AuthorizedBy = ll.ID;