CREATE DATABASE name_
-- database oluþturur

USE name_

-- database adlý database üzerinde iþlem yapacaðýmý belirtilir bu komut ile

 CREATE TABLE Student(
ID_Student INT PRIMARY KEY NOT NULL,
Name_Student varchar(50),
Surname_Student varchar(50),
Birthdate_Student varchar(10)
)
GO

CREATE TABLE Lesson(
 ID_lesson INT PRIMARY KEY NOT NULL,
 ID_Student INT FOREIGN KEY REFERENCES Student(ID_Student) NOT NULL,
 Name_Lesson varchar(50),
)

--Student adlý tablo oluþturuldu ve ýd name surname ve býrthdate adlý kolonlar kuruldu
