create database databasename 
-- database oluşturur

use databasename

-- database adlı database üzerinde işlem yapacağımı belirtilir bu komut ile

 create table Student(
ID_Student INT PRIMARY KEY NOT NULL,
Name_Student varchar(50),
Surname_Student varchar(50),
Birthdate_Student varchar(10)
)

--Student adlı tablo oluşturuldu ve ıd name surname ve bırthdate adlı kolonlar kuruldu