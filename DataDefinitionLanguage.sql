create database databasename 
-- database olu�turur

use databasename

-- database adl� database �zerinde i�lem yapaca��m� belirtilir bu komut ile

 create table Student(
ID_Student INT PRIMARY KEY NOT NULL,
Name_Student varchar(50),
Surname_Student varchar(50),
Birthdate_Student varchar(10)
)

--Student adl� tablo olu�turuldu ve �d name surname ve b�rthdate adl� kolonlar kuruldu